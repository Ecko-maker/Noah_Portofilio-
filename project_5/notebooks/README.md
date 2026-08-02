# 📂 notebooks

Python Jupyter notebooks implementing the COVID-19 time-series forecasting pipeline.

> **Run in order: `01_eda.ipynb` → `02_data_cleaning.ipynb` → `03_model_building.ipynb`**

---

## Files

| File | Cells | Input | Output | Description |
|------|-------|-------|--------|-------------|
| `01_eda.ipynb` | 15 | `data/raw/covid.csv` | Charts | 7-section exploratory analysis |
| `02_data_cleaning.ipynb` | 8 | `data/raw/covid.csv` | `featured.csv` | Feature engineering + split |
| `03_model_building.ipynb` | 11 | `data/raw/featured.csv` | Charts + results table | 7 ML models vs 2 baselines |
| `utils.py` | — | — | — | Reusable utility module (imported by all notebooks) |
| `requirements.txt` | — | — | — | Python package dependencies |

---

## `01_eda.ipynb` — Exploratory Data Analysis

**15 cells · 7 sections**

| Section | Content | Key Output |
|---------|---------|------------|
| Intro | Problem statement + dataset description | — |
| 1 | Full time-series plot of `new_cases` (Jan 2020 → Mar 2023) | Line chart — shows 4 major waves |
| 2 | Distribution histogram + `describe()` 5-number summary | Histogram — confirms right skew |
| 3 | Rolling mean overlay (7-day and 14-day windows) | Smoothed trend line |
| 4 | STL seasonal decomposition | Trend + seasonal + residual components |
| 5 | Seasonal profile by day-of-week (`groupby dayofweek`) | Bar chart — weekend dip clearly visible |
| 6 | Autocorrelation Function (ACF) — 40 lags | ACF plot — spikes at lags 1, 2, 3, 7 |
| 7 | Summary of findings | Text — justifies lag and calendar feature choices |

**Key findings:**
- Four distinct pandemic waves visible in the raw series (early 2020, late 2020, mid 2021 Delta, late 2021/early 2022 Omicron)
- Weekend reporting consistently ~30–40% lower than weekday counts — confirms the weekly seasonal signal
- ACF spikes at lags 1, 7, and multiples of 7 — directly motivates `lag_1`, `lag_7`, `rollmean_7`
- STL residual shows the largest unexplained variance during the Omicron wave (Dec 2021 – Feb 2022)

---

## `02_data_cleaning.ipynb` — Feature Engineering & Chronological Split

**8 cells · 3 sections**

| Section | Content | Output |
|---------|---------|--------|
| 1 | Build all features via `utils.build_features(df)` | 15 new columns added to DataFrame |
| 2 | Chronological 80/20 split via `utils.chronological_split(feat)` | Train: ~917 rows · Test: ~226 rows |
| 3 | Save featured dataset | `data/featured.csv` — 1,129 rows × 16 columns |

**Important — why chronological split?**
Shuffling a time series leaks future data into training, artificially inflating all model scores. The split must respect time order: train on the past, predict the future.

- **Training period:** 2020-02-05 → approximately late 2022
- **Test period:** Final 226 days → approximately late 2022 → 2023-03-09

---

## `03_model_building.ipynb` — Model Building & Evaluation

**11 cells · 5 sections**

| Section | Content | Output |
|---------|---------|--------|
| 1 | Run all models via `utils.run_all(feat)` — results table sorted by RMSE | Results DataFrame |
| 2 | RMSE bar chart — baselines shown in grey, ML models in blue | Bar chart |
| 3 | Forecast vs actual plot for the best model (Linear Regression) | Line chart — 226-day test window |
| 4 | Feature importance from Random Forest | Horizontal bar chart |
| 5 | Summary and takeaways | Text conclusion |

**Model results (chronological 80/20 split):**

| Model | MAE | RMSE | MAPE % | R² |
|-------|-----|------|--------|----|
| Linear Regression | 65,059 | 98,967 | 16.10 | 0.8688 |
| Ridge | 65,005 | 99,003 | 16.09 | 0.8687 |
| Random Forest | 74,656 | 101,554 | 21.04 | 0.8618 |
| Seasonal Naive | 74,271 | 111,325 | 18.15 | 0.8339 |
| Naive (last value) | 742,448 | 785,583 | 312.32 | −7.27 |

**Winner: Linear Regression** — R² 0.869, beats seasonal-naive by 11% on RMSE.

---

## `utils.py` — Reusable Utility Module

All three notebooks use `import utils` to access shared functions. This avoids copy-pasting code and makes the pipeline easy to adapt to a different time series by changing only the constants at the top of the file.

### Configuration Constants

```python
DATE_COL        = "date"        # column name for date in raw CSV
VALUE_COL       = "new_cases"   # column name for the target in raw CSV
FREQ            = "D"           # frequency: "D" = daily, "h" = hourly
SEASONAL_PERIOD = 7             # 7 for daily data (weekly cycle)
LAGS            = [1, 2, 3, 7, 14]    # lag steps used as features
ROLL_WINDOWS    = [7, 14]             # rolling window sizes
```

### Function Reference

| Function | Signature | Returns |
|----------|-----------|---------|
| `load_data` | `(filepath="data/covid.csv")` | DataFrame with `date`, `y` |
| `add_calendar_features` | `(df)` | DataFrame + month, day, dayofweek, dayofyear, is_weekend |
| `add_lag_features` | `(df, lags, windows)` | DataFrame + lag_N + rollmean_N + rollstd_N columns |
| `build_features` | `(df)` | Full feature DataFrame, NaN rows dropped |
| `feature_columns` | `(df)` | List of column names (excludes `date` and `y`) |
| `chronological_split` | `(df, test_frac=0.2)` | `(train_df, test_df)` — no shuffling |
| `naive_forecast` | `(train, test)` | Array of last-training-value predictions |
| `seasonal_naive_forecast` | `(full_df, test, period=7)` | Array: `y[t] = y[t-7]` |
| `get_models` | `()` | Dict of 7 named scikit-learn models |
| `evaluate` | `(y_true, y_pred)` | Dict: `{MAE, RMSE, MAPE, R2}` |
| `run_all` | `(feat_df, test_frac=0.2)` | `(results_df, train, test, preds_dict)` |

---

## `requirements.txt`

```
jupyter
pandas
numpy
matplotlib
scikit-learn
statsmodels
```

Install all dependencies:
```bash
pip install -r requirements.txt
```
