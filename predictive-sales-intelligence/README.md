# Predictive Sales Intelligence – PoC för prediktiv lead scoring

Proof of concept från min LIA på Columbia Road. Idén: i stället för att bara
segmentera leads med fasta regler (High Intent, New Decision Makers, Baseline)
låter vi en modell lära sig vilka företag som sannolikt får en ny affär, och
jämför den mot den regelbaserade poängen.

> **Endast syntetisk data.** `data/` innehåller påhittade CSV-filer, inga riktiga
> kund- eller företagsuppgifter.

## Frågor som modellerna besvarar

| | Fråga | Mål (label) | Split |
|---|---|---|---|
| **A** | Får företaget en **ny deal inom 6 månader**? (lead scoring) | 1 om minst en deal skapas inom 182 dagar efter snittdatumet | Träna på snitt 2025-10-01, testa på 2026-04-01 |
| **B** | **Vinns** en stängd deal? (win probability) | 1 = Closed Won, 0 = Closed Lost | Äldsta 70 % av dealsen tränar, nyaste 30 % testar |

Varje fråga körs med tre metoder: **regelbaserad poäng**, **logistisk regression**
och **random forest**. De jämförs med AUC och lift i topp-20 %.

## Projektstruktur

```
predictive-sales-intelligence/
├── data/                     syntetiska CSV:er (companies, deals)
├── src/
│   ├── config.py             sökvägar, snittdatum, inställningar
│   ├── load_data.py          läser CSV:erna
│   ├── features.py           features + mål, utan läckage
│   ├── rule_score.py         regelbaserad jämförelsepoäng
│   ├── train.py              logistisk regression + random forest
│   ├── evaluate.py           AUC, lift, koefficienter, ROC-kurvor
│   └── data_quality.py       datakvalitetskontroller
├── notebooks/utforskning.ipynb   samma steg, cell för cell
├── sql/bqml_lead_scoring.sql     samma upplägg i BigQuery ML
├── outputs/                  skapas när du kör (resultat, grafer, scores)
├── main.py                   kör allt
└── requirements.txt
```

## Kom igång på Windows

Kräver Python 3.10 eller senare ([python.org](https://www.python.org/downloads/),
kryssa i *Add python.exe to PATH* vid installationen) och VS Code med
tillägget **Python** (Microsoft). Tillägget **Jupyter** behövs för notebooken.

1. Öppna mappen i VS Code: *File → Open Folder…* → `predictive-sales-intelligence`.
2. Öppna en terminal: *Terminal → New Terminal* (PowerShell).
3. Skapa och aktivera en virtuell miljö:
   ```powershell
   python -m venv .venv
   .\.venv\Scripts\Activate.ps1
   ```
   Får du felet *"running scripts is disabled on this system"*, kör en gång:
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
   ```
   och försök igen. (I cmd i stället för PowerShell: `.venv\Scripts\activate.bat`.)
4. Installera paketen:
   ```powershell
   python -m pip install --upgrade pip
   pip install -r requirements.txt
   ```
5. Kör PoC:n:
   ```powershell
   python main.py
   ```
6. Välj tolk i VS Code om den inte väljs automatiskt: `Ctrl+Shift+P` →
   *Python: Select Interpreter* → `.venv`. För notebooken: öppna
   `notebooks/utforskning.ipynb` och välj kerneln `.venv` uppe till höger.

## Vad som hamnar i `outputs/`

- `resultat.txt` – hela utskriften (tabeller, koefficienter, läckagedemo, datakvalitet)
- `A_foretag_jamforelse.csv`, `B_deal_jamforelse.csv` – AUC och lift per metod
- `A_foretag_roc.png`, `B_deal_roc.png` – ROC-kurvor
- `A_foretag_scores.csv` – alla företag rankade efter ML-poäng, med regelpoäng och faktiskt utfall bredvid

## Resultat på den syntetiska datan

| Metod | A: AUC | A: lift topp-20 % | B: AUC | B: lift topp-20 % |
|---|---|---|---|---|
| Regelbaserad | 0,50 | 0,92x | 0,51 | 1,03x |
| Logistisk regression | 0,48 | 0,90x | 0,52 | 1,03x |
| Random forest | 0,41 | 0,74x | 0,51 | 0,97x |

**AUC ≈ 0,5 = ingen metod slår slumpen.** Det är väntat, eftersom datan är
slumpgenererad och inte innehåller några verkliga mönster. Värdet i PoC:n är
att *metoden* är på plats: tidsbaserad split, inget läckage och en ärlig
jämförelse mot reglerna. På riktig data är det samma kod som körs.

Läckagedemon visar varför detta spelar roll: tar man med `Cancelled at` som
feature stiger AUC till **0,71**, men bara för att fältet bara finns på
förlorade deals, så modellen "fuskar".

## Läckage – vad som medvetet *inte* används

- **Cancelled at** – finns bara på Closed Lost-deals, avslöjar svaret.
- **Last Activity Date** – ögonblicksbild från idag, inte från snittdatumet.
- **Deal Stage** – är själva utfallet.
- **Company owner** används (`has_owner`), men är också en ögonblicksbild:
  mild läckagerisk som bör kontrolleras med historikdata.

## Datakvalitet (syntetisk data)

- 10 deals har `Cancelled at` före `Create Date`.
- 90 deals saknar belopp (alla är *Passive Opportunities*).
- 479 av 500 företag saknar owner, 105 företag har inga deals.
- `Current Customer` är `True` för alla företag och används därför inte.

## BigQuery ML

`sql/bqml_lead_scoring.sql` gör samma sak som modell A direkt i BigQuery:
bygger träningsdata med ett snittdatum per månad, tränar `LOGISTIC_REG` och
`BOOSTED_TREE_CLASSIFIER`, utvärderar, jämför lift mot regelpoängen och
poängsätter alla företag idag (tabell som kan synkas till HubSpot eller LEO).

## Gissningar att bekräfta (markerade i koden)

- **Målet** "ny deal inom 6 månader" är ett förslag, inte bestämt med teamet.
- **Regelpoängen** i `src/rule_score.py` efterliknar segmenten ungefär. Byt till de riktiga HubSpot-reglerna.
- **Snittdatumen** i `src/config.py` är valda för den syntetiska datan (deals 2024-10 till 2026-10).
- **SQL:en** använder `projekt.dataset` och CSV-kolumnnamn (`Record ID`, `Create Date` …).
  I BigQuery heter kolumnerna troligen `record_id`, `create_date` osv.

## Nästa steg

1. Byt regelpoängen mot de riktiga segmentreglerna.
2. Lägg till features från `All_contacts` (antal kontakter, beslutsfattare, e-postöppningar, formulär) per snittdatum.
3. Kör SQL:en mot riktiga tabeller i BigQuery och jämför lift mot segmenten.
4. Om modellen slår reglerna: skriv poängen till en HubSpot-egenskap eller in i LEO.
