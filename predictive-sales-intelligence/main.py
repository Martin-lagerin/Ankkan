"""Kör hela PoC:n: python main.py

Två frågor:
  A) Företagsnivå (lead scoring): får företaget en NY deal inom 6 mån efter ett snittdatum?
  B) Dealnivå (win probability): vinns en stängd deal?
Båda jämförs mot en enkel regelbaserad poäng. Resultat sparas i outputs/.
"""
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import roc_auc_score

from src import config
from src.data_quality import data_quality_report
from src.evaluate import compare, forest_importance, logreg_coefficients, plot_roc
from src.features import COMPANY_FEATURES, DEAL_FEATURES, closed_deals_table, company_snapshot, time_split
from src.load_data import load_all
from src.rule_score import company_rule_score, deal_rule_score
from src.train import train_models


def run_experiment(name, X_tr, y_tr, X_te, y_te, rule_te, slug, lines):
    models = train_models(X_tr, y_tr)
    table, scores = compare(models, X_te, y_te, rule_te)
    block = [
        f"\n=== {name} ===",
        f"träning n={len(y_tr)} (andel positiva {y_tr.mean():.0%}), test n={len(y_te)} (andel positiva {y_te.mean():.0%})",
        table.to_string(),
        "\nLogistisk regression, standardiserade koefficienter:",
        logreg_coefficients(models["Logistisk regression"], X_tr.columns).to_string(),
        "\nRandom forest, permutation importance (hur mycket AUC faller utan featuren):",
        forest_importance(models["Random forest"], X_te, y_te).to_string(),
    ]
    print("\n".join(block))
    lines += block
    table.to_csv(config.OUTPUT_DIR / f"{slug}_jamforelse.csv")
    plot_roc(scores, y_te, name, config.OUTPUT_DIR / f"{slug}_roc.png")
    return models


def main():
    config.OUTPUT_DIR.mkdir(exist_ok=True)
    deals, companies = load_all()
    lines = []

    # A) Företag: ny deal inom 6 mån. Tidsbaserad split: träna på ett tidigt snitt, testa på ett senare.
    X_tr, y_tr = company_snapshot(deals, companies, config.TRAIN_CUTOFF)
    X_te, y_te = company_snapshot(deals, companies, config.TEST_CUTOFF)
    models_a = run_experiment("A) Företag: ny deal inom 6 mån", X_tr, y_tr, X_te, y_te,
                              company_rule_score(X_te), "A_foretag", lines)

    # Poängsätt alla företag på test-snittet (motsvarar "lista att ringa")
    ranked = X_te.assign(
        ml_score=models_a["Random forest"].predict_proba(X_te)[:, 1].round(3),
        rule_score=company_rule_score(X_te),
        faktiskt_ny_deal=y_te,
    ).sort_values("ml_score", ascending=False)
    ranked.to_csv(config.OUTPUT_DIR / "A_foretag_scores.csv")

    # B) Deal: Closed Won vs Closed Lost, tidsbaserad split på Create Date
    closed = closed_deals_table(deals, companies)
    tr, te = time_split(closed, config.DEAL_TRAIN_SHARE)
    run_experiment("B) Deal: Closed Won vs Closed Lost", tr[DEAL_FEATURES], tr["won"],
                   te[DEAL_FEATURES], te["won"], deal_rule_score(te), "B_deal", lines)

    # Läckagedemo: vad händer om man (felaktigt) tar med 'Cancelled at'?
    closed["is_cancelled"] = closed["Cancelled at"].notna().astype(int)
    tr, te = time_split(closed, config.DEAL_TRAIN_SHARE)
    leak = DEAL_FEATURES + ["is_cancelled"]
    rf = RandomForestClassifier(n_estimators=300, min_samples_leaf=10,
                                random_state=config.RANDOM_STATE).fit(tr[leak], tr["won"])
    auc = roc_auc_score(te["won"], rf.predict_proba(te[leak])[:, 1])
    msg = f"\n[Läckagedemo] RF med 'Cancelled at' som feature: AUC={auc:.3f}  <- ser bra ut men är fusk"
    print(msg)
    lines.append(msg)

    lines.append("\n=== Datakvalitet ===")
    for k, v in data_quality_report(deals, companies).items():
        lines.append(f"  {k}: {v}")
    print("\n".join(lines[-8:]))

    (config.OUTPUT_DIR / "resultat.txt").write_text("\n".join(lines), encoding="utf-8")
    print(f"\nKlart. Resultat sparade i {config.OUTPUT_DIR}")


if __name__ == "__main__":
    main()
