"""Enkel regelbaserad poäng att jämföra modellerna mot.

GISSNING: reglerna nedan efterliknar ungefär segmenten High Intent /
New Decision Makers / Baseline. Byt till era riktiga HubSpot-regler när ni har dem.
"""
import pandas as pd


def company_rule_score(X: pd.DataFrame) -> pd.Series:
    return (2 * (X["n_deals_last_180d"] > 0)      # nylig aktivitet ~ High Intent
            + 1 * (X["n_deals_before"] >= 2)       # återkommande kund
            + 1 * (X["size_ord"] >= 4)             # stort företag (201+ anställda)
            + 1 * X["has_owner"]).astype(float)    # har ansvarig säljare


def deal_rule_score(X: pd.DataFrame) -> pd.Series:
    return (1 * (X["size_ord"] >= 4)
            + 1 * X["has_owner"]
            + 1 * (X["prior_deals"] >= 1)).astype(float)
