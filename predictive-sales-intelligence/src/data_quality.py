"""Snabba datakvalitetskontroller."""
import pandas as pd


def data_quality_report(deals: pd.DataFrame, companies: pd.DataFrame) -> dict:
    return {
        "Antal deals": len(deals),
        "Antal företag": len(companies),
        "Cancelled at före Create Date": int((deals["Cancelled at"] < deals["Create Date"]).sum()),
        "Deals med saknat belopp": int(deals["Amount in company currency"].isna().sum()),
        "Företag utan owner": int(companies["Company owner"].isna().sum()),
        "Företag utan deals": int((~companies["Record ID"].isin(deals["Associated Company"])).sum()),
        "Current Customer = True för alla": bool(companies["Current Customer"].all()),
    }
