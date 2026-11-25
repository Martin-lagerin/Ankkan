"""Läser in CSV-filerna och lägger till enkla hjälpkolumner."""
import pandas as pd

from .config import COMPANIES_CSV, DEALS_CSV, SIZE_ORDER


def load_deals(path=DEALS_CSV) -> pd.DataFrame:
    return pd.read_csv(path, parse_dates=["Create Date", "Cancelled at"])


def load_companies(path=COMPANIES_CSV) -> pd.DataFrame:
    c = pd.read_csv(path, parse_dates=["Last Activity Date"])
    c["size_ord"] = c["Company size"].map(SIZE_ORDER)
    # OBS: Company owner är en ögonblicksbild från idag -> mild läckagerisk i historiska snitt
    c["has_owner"] = c["Company owner"].notna().astype(int)
    return c


def load_all():
    return load_deals(), load_companies()
