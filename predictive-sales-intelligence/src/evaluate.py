"""Utvärdering: AUC, lift i topp-20 %, koefficienter och feature importance."""
import numpy as np
import pandas as pd
from sklearn.inspection import permutation_importance
from sklearn.metrics import roc_auc_score, roc_curve

from .config import RANDOM_STATE, TOP_SHARE


def lift_top(y, score, share=TOP_SHARE) -> float:
    """Andel positiva bland de högst rankade `share` delat med basnivån.
    1.0 = inte bättre än slumpen, 2.0 = dubbelt så träffsäker."""
    y, score = np.asarray(y), np.asarray(score, float)
    cut = np.quantile(score, 1 - share)
    return y[score >= cut].mean() / y.mean()


def compare(models: dict, X_test, y_test, rule_scores) -> tuple[pd.DataFrame, dict]:
    """Returnerar en tabell med AUC/lift per metod och alla poäng (för ROC-kurvor)."""
    scores = {"Regelbaserad": np.asarray(rule_scores, float)}
    for name, m in models.items():
        scores[name] = m.predict_proba(X_test)[:, 1]
    rows = [{"metod": k, "AUC": roc_auc_score(y_test, s), f"lift_topp_{int(TOP_SHARE*100)}%": lift_top(y_test, s)}
            for k, s in scores.items()]
    return pd.DataFrame(rows).set_index("metod").round(3), scores


def logreg_coefficients(logreg, feature_names) -> pd.Series:
    coef = logreg[-1].coef_[0]  # sista steget i pipelinen
    return pd.Series(coef, index=feature_names).sort_values(key=abs, ascending=False).round(3)


def forest_importance(forest, X_test, y_test) -> pd.DataFrame:
    pi = permutation_importance(forest, X_test, y_test, scoring="roc_auc",
                                n_repeats=20, random_state=RANDOM_STATE)
    return (pd.DataFrame({"AUC-fall": pi.importances_mean, "std": pi.importances_std}, index=X_test.columns)
              .sort_values("AUC-fall", ascending=False).round(3))


def plot_roc(scores: dict, y_test, title: str, path):
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    fig, ax = plt.subplots(figsize=(5, 5))
    for name, s in scores.items():
        fpr, tpr, _ = roc_curve(y_test, s)
        ax.plot(fpr, tpr, label=f"{name} (AUC {roc_auc_score(y_test, s):.2f})")
    ax.plot([0, 1], [0, 1], "--", color="grey", label="Slump")
    ax.set(xlabel="Falskt positiva", ylabel="Sant positiva", title=title)
    ax.legend(loc="lower right", fontsize=8)
    fig.tight_layout()
    fig.savefig(path, dpi=120)
    plt.close(fig)
