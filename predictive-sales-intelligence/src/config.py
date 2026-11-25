"""Gemensamma inställningar. Ändra här i stället för i koden."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = ROOT / "data"
OUTPUT_DIR = ROOT / "outputs"

DEALS_CSV = DATA_DIR / "synthetic_deals.csv"
COMPANIES_CSV = DATA_DIR / "synthetic_companies.csv"

# Företagsstorlek som ordningstal (1 = minst)
SIZE_ORDER = {"1-10": 1, "11-50": 2, "51-200": 3, "201-500": 4, "500+": 5}

# Tidsbaserad split för modell A. Målet tittar 6 mån framåt, så test-snittet
# måste ligga minst 6 mån före sista datumet i datan (deals slutar 2026-10-15).
TRAIN_CUTOFF = "2025-10-01"
TEST_CUTOFF = "2026-04-01"
HORIZON_DAYS = 182  # ca 6 månader

# Andel av de stängda dealsen (sorterade på Create Date) som används för träning i modell B
DEAL_TRAIN_SHARE = 0.7

RANDOM_STATE = 42
TOP_SHARE = 0.2  # lift mäts på topp-20 %
