"""Tränar logistisk regression och random forest."""
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler

from .config import RANDOM_STATE


def train_models(X_train, y_train) -> dict:
    logreg = make_pipeline(StandardScaler(),
                           LogisticRegression(max_iter=1000, class_weight="balanced"))
    forest = RandomForestClassifier(n_estimators=300, min_samples_leaf=10,
                                    class_weight="balanced", random_state=RANDOM_STATE)
    logreg.fit(X_train, y_train)
    forest.fit(X_train, y_train)
    return {"Logistisk regression": logreg, "Random forest": forest}
