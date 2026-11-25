"""Bygger features och mål (labels) utan läckage.

Grundregel: en feature får bara använda information som fanns FÖRE snittdatumet.
Följande kolumner används medvetet INTE som features:
  * Cancelled at       – finns bara på Closed Lost-deals (avslöjar svaret)
  * Last Activity Date – ögonblicksbild från idag, inte från snittdatumet
  * Deal Stage         – är själva utfallet / nuvarande läge
"""
import numpy as np
import pandas as pd

from .config import HORIZON_DAYS

COMPANY_FEATURES = [
    "size_ord", "has_owner", "n_deals_before",
    "amount_sum_before", "days_since_last_deal", "n_deals_last_180d",
]
DEAL_FEATURES = ["log_amount", "size_ord", "has_owner", "prior_deals"]


def company_snapshot(deals: pd.DataFrame, companies: pd.DataFrame, cutoff, horizon_days=HORIZON_DAYS):
    """Modell A: en rad per företag vid ett snittdatum.

    Mål (y) = 1 om företaget får minst en NY deal inom `horizon_days` efter snittet.
    """
    cutoff = pd.Timestamp(cutoff)
    past = deals[deals["Create Date"] < cutoff]
    future = deals[(deals["Create Date"] >= cutoff)
                   & (deals["Create Date"] < cutoff + pd.Timedelta(days=horizon_days))]

    g = past.groupby("Associated Company")
    recent = past[past["Create Date"] >= cutoff - pd.Timedelta(days=180)]
    f = pd.DataFrame({
        "n_deals_before": g.size(),
        "amount_sum_before": g["Amount in company currency"].sum(),
        "days_since_last_deal": (cutoff - g["Create Date"].max()).dt.days,
        "n_deals_last_180d": recent.groupby("Associated Company").size(),
    })

    X = companies.set_index("Record ID")[["size_ord", "has_owner"]].join(f)
    X["n_deals_before"] = X["n_deals_before"].fillna(0)
    X["n_deals_last_180d"] = X["n_deals_last_180d"].fillna(0)
    X["amount_sum_before"] = np.log1p(X["amount_sum_before"].fillna(0))
    X["days_since_last_deal"] = X["days_since_last_deal"].fillna(999)  # 999 = aldrig haft deal
    y = pd.Series(X.index.isin(future["Associated Company"]).astype(int), index=X.index, name="new_deal_6m")
    return X[COMPANY_FEATURES], y


def closed_deals_table(deals: pd.DataFrame, companies: pd.DataFrame) -> pd.DataFrame:
    """Modell B: en rad per stängd deal, mål = vunnen (1) eller förlorad (0)."""
    m = (deals.merge(companies, left_on="Associated Company", right_on="Record ID", suffixes=("", "_c"))
              .sort_values("Create Date"))
    m["prior_deals"] = m.groupby("Associated Company").cumcount()  # deals skapade innan denna
    m["log_amount"] = np.log1p(m["Amount in company currency"])
    m["log_amount"] = m["log_amount"].fillna(m["log_amount"].median())
    closed = m[m["Deal Stage"].isin(["Closed Won", "Closed Lost"])].copy()
    closed["won"] = (closed["Deal Stage"] == "Closed Won").astype(int)
    return closed


def time_split(df: pd.DataFrame, share: float, date_col="Create Date"):
    """Äldsta `share` av raderna = träning, resten = test (aldrig slumpmässigt)."""
    split = df[date_col].quantile(share)
    return df[df[date_col] < split], df[df[date_col] >= split]
