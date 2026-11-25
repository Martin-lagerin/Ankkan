-- =====================================================================
-- Prediktiv lead scoring i BigQuery ML
-- Mål: får företaget en NY deal inom 6 månader efter ett snittdatum?
--
-- GISSNINGAR att justera innan körning:
--   * `projekt.dataset` -> ert riktiga projekt/dataset
--   * Kolumnnamn antas följa CSV-exporten (Record ID, Create Date osv.).
--     I BigQuery heter de troligen record_id, create_date, ... -> byt namn.
--   * Lägg gärna till features från All_contacts (antal kontakter,
--     antal beslutsfattare, senaste e-postöppning/formulär) per snittdatum.
-- REGLER mot läckage:
--   * Alla features räknas ENDAST på data före snittdatum.
--   * Använd inte Last Activity Date / Deal Stage / Cancelled at som de ser
--     ut idag för historiska snitt (de är ögonblicksbilder).
--     Behövs stage-features: använd closedate och historik-tabell.
-- =====================================================================

-- 1) Träningsdata: flera snittdatum (ett per månad) staplade
CREATE OR REPLACE TABLE `projekt.dataset.ls_training` AS
WITH cutoffs AS (
  SELECT cutoff
  FROM UNNEST(GENERATE_DATE_ARRAY('2025-01-01', DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH), INTERVAL 1 MONTH)) AS cutoff
),
feat AS (
  SELECT
    c.`Record ID`                                   AS company_id,
    k.cutoff,
    c.`Company size`                                AS company_size,   -- kategorisk, BQML one-hot:ar själv
    IF(c.`Company owner` IS NULL, 0, 1)             AS has_owner,       -- obs: ögonblicksbild, mild läckagerisk
    COUNTIF(DATE(d.`Create Date`) < k.cutoff)       AS n_deals_before,
    COUNTIF(DATE(d.`Create Date`) <  k.cutoff
        AND DATE(d.`Create Date`) >= DATE_SUB(k.cutoff, INTERVAL 180 DAY)) AS n_deals_last_180d,
    LN(1 + IFNULL(SUM(IF(DATE(d.`Create Date`) < k.cutoff, d.`Amount in company currency`, 0)), 0)) AS log_amount_before,
    IFNULL(DATE_DIFF(k.cutoff, MAX(IF(DATE(d.`Create Date`) < k.cutoff, DATE(d.`Create Date`), NULL)), DAY), 999) AS days_since_last_deal,
    -- MÅL: ny deal inom 6 mån efter snittet
    IF(COUNTIF(DATE(d.`Create Date`) >= k.cutoff
           AND DATE(d.`Create Date`) <  DATE_ADD(k.cutoff, INTERVAL 6 MONTH)) > 0, 1, 0) AS label
  FROM `projekt.dataset.All_companies` c
  CROSS JOIN cutoffs k
  LEFT JOIN `projekt.dataset.All_deals` d
    ON d.`Associated Company` = c.`Record ID`
  GROUP BY company_id, k.cutoff, company_size, has_owner
)
SELECT *,
  -- Tidsbaserad split: senaste 6 snitten = utvärdering
  IF(cutoff >= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH), INTERVAL 6 MONTH), 'EVAL', 'TRAIN') AS split_col
FROM feat;

-- 2a) Logistisk regression
CREATE OR REPLACE MODEL `projekt.dataset.ls_logreg`
OPTIONS (
  model_type = 'LOGISTIC_REG',
  input_label_cols = ['label'],
  auto_class_weights = TRUE,
  data_split_method = 'CUSTOM',
  data_split_col = 'is_eval'
) AS
SELECT * EXCEPT (company_id, cutoff, split_col), split_col = 'EVAL' AS is_eval
FROM `projekt.dataset.ls_training`;

-- 2b) Trädmodell (gradient boosting)
CREATE OR REPLACE MODEL `projekt.dataset.ls_boosted`
OPTIONS (
  model_type = 'BOOSTED_TREE_CLASSIFIER',
  input_label_cols = ['label'],
  auto_class_weights = TRUE,
  max_iterations = 50,
  data_split_method = 'CUSTOM',
  data_split_col = 'is_eval',
  enable_global_explain = TRUE
) AS
SELECT * EXCEPT (company_id, cutoff, split_col), split_col = 'EVAL' AS is_eval
FROM `projekt.dataset.ls_training`;

-- 3) Utvärdering (roc_auc, precision, recall) på EVAL-delen
SELECT 'logreg' AS model, * FROM ML.EVALUATE(MODEL `projekt.dataset.ls_logreg`)
UNION ALL
SELECT 'boosted', * FROM ML.EVALUATE(MODEL `projekt.dataset.ls_boosted`);

-- 4) Jämför mot regelbaserad poäng (byt till era riktiga segmentregler)
--    Lift = andel positiva i topp-20 % / basnivå
WITH scored AS (
  SELECT t.label,
    p.prob AS ml_score,
    2 * IF(t.n_deals_last_180d > 0, 1, 0) + IF(t.n_deals_before >= 2, 1, 0)
      + IF(t.company_size IN ('201-500', '500+'), 1, 0) + t.has_owner AS rule_score
  FROM ML.PREDICT(MODEL `projekt.dataset.ls_boosted`,
         (SELECT * FROM `projekt.dataset.ls_training` WHERE split_col = 'EVAL')) t,
       UNNEST(t.predicted_label_probs) p
  WHERE p.label = 1
),
ranked AS (
  SELECT *, PERCENT_RANK() OVER (ORDER BY ml_score DESC)   AS ml_rank,
            PERCENT_RANK() OVER (ORDER BY rule_score DESC) AS rule_rank
  FROM scored
)
SELECT
  AVG(label)                                    AS base_rate,
  AVG(IF(ml_rank   <= 0.2, label, NULL)) / AVG(label) AS lift_top20_ml,
  AVG(IF(rule_rank <= 0.2, label, NULL)) / AVG(label) AS lift_top20_rule
FROM ranked;

-- 5) Viktigaste features
SELECT * FROM ML.GLOBAL_EXPLAIN(MODEL `projekt.dataset.ls_boosted`);
SELECT * FROM ML.WEIGHTS(MODEL `projekt.dataset.ls_logreg`) ORDER BY ABS(weight) DESC;

-- 6) Scora alla företag IDAG -> kan synkas till HubSpot-egenskap / LEO
CREATE OR REPLACE TABLE `projekt.dataset.ls_scores_today` AS
WITH today AS (
  SELECT
    c.`Record ID` AS company_id,
    c.`Company size` AS company_size,
    IF(c.`Company owner` IS NULL, 0, 1) AS has_owner,
    COUNT(d.`Record ID`) AS n_deals_before,
    COUNTIF(DATE(d.`Create Date`) >= DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY)) AS n_deals_last_180d,
    LN(1 + IFNULL(SUM(d.`Amount in company currency`), 0)) AS log_amount_before,
    IFNULL(DATE_DIFF(CURRENT_DATE(), MAX(DATE(d.`Create Date`)), DAY), 999) AS days_since_last_deal
  FROM `projekt.dataset.All_companies` c
  LEFT JOIN `projekt.dataset.All_deals` d ON d.`Associated Company` = c.`Record ID`
  GROUP BY company_id, company_size, has_owner
)
SELECT company_id, p.prob AS predictive_score
FROM ML.PREDICT(MODEL `projekt.dataset.ls_boosted`, (SELECT * FROM today)) t,
     UNNEST(t.predicted_label_probs) p
WHERE p.label = 1
ORDER BY predictive_score DESC;
