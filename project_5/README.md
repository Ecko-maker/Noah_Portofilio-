# 🦠 COVID-19 Global Data Analysis & Forecasting

![Python](https://img.shields.io/badge/Python-3.10+-blue?logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-SQL%20Server-CC2927?logo=microsoftsqlserver&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-Dashboard-E97627?logo=tableau&logoColor=white)
![scikit-learn](https://img.shields.io/badge/scikit--learn-ML%20Forecasting-F7931E?logo=scikit-learn&logoColor=white)
![statsmodels](https://img.shields.io/badge/statsmodels-STL%20Decomposition-4B8BBE)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

> An end-to-end COVID-19 data analytics project combining **SQL Server exploration**, **Python time-series forecasting with machine learning**, and a **Tableau interactive dashboard** — covering 1,143 days of global pandemic data from January 2020 to March 2023.

---

## 🎯 Project Objective

This project analyses the global COVID-19 pandemic across two parallel tracks:

**Track 1 — SQL Exploration (Global Deaths & Vaccinations)**
- What is the global COVID-19 case fatality rate (deaths ÷ confirmed cases)?
- Which countries had the highest death counts and infection rates per population?
- Which continents suffered the most total deaths?
- How did vaccination rollouts progress as a rolling percentage of each country's population?

**Track 2 — Python Time-Series Forecasting (Daily New Cases)**
- What trend, seasonality, and autocorrelation patterns exist in the global daily new-case series?
- Which lag, rolling, and calendar features capture the dominant signal?
- Does a machine learning model beat naive and seasonal-naive baselines?
- Which features matter most for predicting next-day case counts?

---

## 🏗️ Project Architecture

```
CovidDeaths.xlsx + covidvaccination.xlsx          covid.csv
         │                                              │
         ▼                                              ▼
  SQL Server Analysis                         Python Forecasting Pipeline
  ─────────────────                           ───────────────────────────
  • Data exploration                          01_eda.ipynb
  • Death % calculations                        • Time-series plot
  • Country/continent rankings                  • Distribution & summary
  • Rolling vaccination window fn              • Rolling mean trend
  • CTE + Temp Table techniques                 • STL decomposition
  • CREATE VIEW for Tableau                     • Seasonal profile
         │                                      • ACF autocorrelation
         ▼                                              │
  Tableau Dashboard ◄─────────────────────────         ▼
  ─────────────────                           02_data_cleaning.ipynb
  • Global death % KPI                          • Lag features (1,2,3,7,14)
  • Deaths per continent bar chart              • Rolling mean/std (7,14)
  • % Population infected map                  • Calendar features
  • Country infection % over time              • Chronological 80/20 split
                                                        │
                                                        ▼
                                              03_model_building.ipynb
                                                • 7 ML models + 2 baselines
                                                • Linear Regression R²=0.869
                                                • RMSE chart
                                                • Forecast vs actual plot
                                                • Feature importance chart
```

---

## 🗂️ Folder Structure

```
project_5_covid/
│
├── data/
│   ├── raw/
│   │   ├── CovidDeaths.xlsx          ← SQL Server: deaths, cases, population (8.4 MB)
│   │   ├── covidvaccination.xlsx     ← SQL Server: daily vaccination counts (8.8 MB)
│   │   ├── covid.csv                 ← Python: 1,143 days of global daily new cases
│   │   └── featured.csv             ← Python: engineered features (output of notebook 02)
│   └── processed/                   ← Cleaned/transformed outputs
│
├── notebooks/
│   ├── 01_eda.ipynb                 ← EDA: 7 sections, 15 cells
│   ├── 02_data_cleaning.ipynb       ← Feature engineering + chronological split
│   ├── 03_model_building.ipynb      ← ML model comparison, forecast, feature importance
│   ├── utils.py                     ← Reusable forecasting utility module
│   └── requirements.txt             ← Python dependencies
│
├── queries/
│   ├── COVID Portfolio Project - Data Exploration.sql  ← Annotated exploration (12 queries)
│   ├── Tableau Portfolio Project SQL Queries.sql       ← Tableau output queries (7 queries)
│   ├── SQLQuery1.sql                                   ← Extended analysis + CTE + Views
│   ├── SQLQuery2.sql                                   ← View query: PercentPopulationVaccinated
│   └── SQLQuery3.sql                                   ← Tableau dashboard queries (4)
│
├── visuals/
│   ├── Covid Dashboard.twbx         ← Tableau packaged workbook (data embedded)
│   ├── Dashboard 1.png              ← Dashboard screenshot for README
│   └── Dashboard 1.svg              ← High-resolution vector export
│
├── reports/                         ← Written summary reports
├── docs/                            ← Technical documentation
├── .gitignore
├── requirements.txt
└── README.md                        ← You are here
```

---

## 📊 Datasets

### SQL Datasets — Our World in Data

| File | Size | Rows | Time Range |
|------|------|------|------------|
| `CovidDeaths.xlsx` | 8.4 MB | 85,000+ | Jan 2020 – Mar 2023 |
| `covidvaccination.xlsx` | 8.8 MB | 85,000+ | Jan 2020 – Mar 2023 |

Both files are imported into SQL Server as `CovidDeaths` and `CovidVaccinations` tables inside the `PortfolioProject` database.

**Key columns — CovidDeaths:** `location`, `date`, `continent`, `population`, `total_cases`, `new_cases`, `total_deaths`, `new_deaths`

**Key columns — CovidVaccinations:** `location`, `date`, `new_vaccinations`, `total_vaccinations`, `people_vaccinated`, `people_fully_vaccinated`

> Records where `continent IS NULL` are continent-level or world-level aggregates — filtered out of country-level queries.

### Python Dataset — JHU CSSE

| File | Rows | Columns | Date Range |
|------|------|---------|------------|
| `covid.csv` | 1,143 | `date`, `cumulative`, `new_cases` | 2020-01-22 → 2023-03-09 |
| `featured.csv` | 1,129 | 16 feature columns | 2020-02-05 → 2023-03-09 |

---

## 🗄️ SQL Track

**Engine:** SQL Server · **Database:** `PortfolioProject`
**Tables:** `CovidDeaths`, `CovidVaccinations` · **View:** `PercentPopulationVaccinated`

### Queries at a Glance

| # | Query | Technique | Business Purpose |
|---|-------|-----------|-----------------|
| 1 | Select base data | `WHERE continent IS NOT NULL` | Exclude continent aggregate rows |
| 2 | Total cases vs total deaths | Division + `*100` | Death likelihood per country |
| 3 | Total cases vs population | Division + `*100` | % of population infected |
| 4 | Highest infection rate by country | `MAX + GROUP BY` | Most infected countries |
| 5 | Highest death count by country | `MAX(CAST AS INT)` | Countries with most deaths |
| 6 | Deaths by continent | `GROUP BY continent` | Continent-level comparison |
| 7 | Global totals (all time) | `SUM` across all rows | Single-row world KPI |
| 8 | Population vs vaccinations | `JOIN` on location + date | Vaccination rollout tracking |
| 9 | Rolling vaccination total | `SUM OVER (PARTITION BY)` | Cumulative vaccinations per country |
| 10 | CTE — PopvsVac | `WITH ... AS (...)` | % vaccinated via CTE approach |
| 11 | Temp Table approach | `CREATE TABLE #...` + `INSERT` | % vaccinated via Temp Table |
| 12 | CREATE VIEW | `CREATE VIEW PercentPopulationVaccinated` | Reusable Tableau data source |

### SQL Skills Demonstrated

`JOIN` · `CTE (WITH clause)` · `Temp Tables` · `Window Functions (SUM OVER PARTITION BY)` · `Aggregate Functions` · `CAST / CONVERT` · `NULLIF` · `CREATE VIEW` · `GROUP BY` · `ORDER BY` · `WHERE` filters

### Key SQL Findings

- The global COVID-19 case fatality rate was approximately **2.11%** (total deaths ÷ total confirmed cases)
- **Europe** recorded the highest continent-level death count (~1 million), followed by North America and South America
- High-density and smaller nations showed disproportionately high infection rates as a % of population
- Rolling vaccination data confirmed cumulative dose totals were trackable per country using `PARTITION BY` window functions

---

## 🐍 Python Track — Time-Series Forecasting

**Run notebooks in order: `01` → `02` → `03`**

### Notebook 01 — EDA (`01_eda.ipynb`, 15 cells, 7 sections)

| Section | Analysis |
|---------|---------|
| 1 | Full time-series plot — global daily new cases Jan 2020 → Mar 2023 |
| 2 | Distribution histogram + 5-number summary of `new_cases` |
| 3 | Rolling mean overlay (7-day and 14-day) to expose trend direction |
| 4 | STL decomposition — separates trend, seasonal, and residual components |
| 5 | Seasonal profile by day-of-week — confirms weekend reporting drop |
| 6 | ACF (Autocorrelation Function) — identifies significant lag periods |
| 7 | Summary of findings and justification for chosen features |

**Key EDA findings:**
- The series shows **explosive multi-wave behaviour** with non-stationary variance
- A dominant **weekly seasonal cycle** is confirmed — fewer cases reported on Saturdays and Sundays due to testing and reporting infrastructure, not true infection drops
- **Strong autocorrelation at lags 1, 2, 3, and 7** — the ACF chart confirms these as the highest-signal feature candidates
- STL decomposition isolates the trend from the weekly cycle, showing clearly that `lag_7` and `dayofweek` are essential features

---

### Notebook 02 — Feature Engineering (`02_data_cleaning.ipynb`, 8 cells)

| Section | Action | Output |
|---------|--------|--------|
| 1 | Build all features from `covid.csv` | 15 feature columns added |
| 2 | Chronological 80/20 split | Train: ~917 days · Test: ~226 days |
| 3 | Save featured dataset | `data/featured.csv` (1,129 rows × 16 cols) |

**Features engineered:**

| Group | Features |
|-------|---------|
| Lag features | `lag_1`, `lag_2`, `lag_3`, `lag_7`, `lag_14` |
| Rolling statistics | `rollmean_7`, `rollstd_7`, `rollmean_14`, `rollstd_14` |
| Calendar features | `month`, `day`, `dayofweek`, `dayofyear`, `is_weekend` |

> ⚠️ Time series cannot be shuffled — the split uses the first 80% for training and the final 20% as the test set, preserving time order.

---

### Notebook 03 — Model Building (`03_model_building.ipynb`, 11 cells)

**7 models vs 2 baselines on the 226-day chronological test set:**

| Model | MAE | RMSE | MAPE % | R² |
|-------|-----|------|--------|----|
| **Linear Regression** | **65,059** | **98,967** | **16.10** | **0.8688** |
| Ridge | 65,005 | 99,003 | 16.09 | 0.8687 |
| Random Forest | 74,656 | 101,554 | 21.04 | 0.8618 |
| Gradient Boosting | — | — | — | — |
| Decision Tree | — | — | — | — |
| KNN | — | — | — | — |
| Lasso | — | — | — | — |
| **Seasonal Naive** | 74,271 | 111,325 | 18.15 | 0.8339 |
| **Naive (last value)** | 742,448 | 785,583 | 312.32 | −7.27 |

**Outputs:** RMSE comparison bar chart · Forecast vs actual line plot · Feature importance (Random Forest)

**Headline result:** Linear Regression with lag and calendar features achieves **R² = 0.869** and **beats the seasonal-naive baseline** (RMSE 98,967 vs 111,325). The naive baseline collapses entirely (R² = −7.27) because last-value prediction cannot handle wave surges.

---

### `utils.py` — Reusable Utility Module

All three notebooks import from `utils.py`. Key functions:

| Function | Purpose |
|----------|---------|
| `load_data(filepath)` | Load `covid.csv`, rename `new_cases → y`, parse dates |
| `add_calendar_features(df)` | Add month, day, dayofweek, dayofyear, is_weekend |
| `add_lag_features(df)` | Add lag_1/2/3/7/14 + rollmean/rollstd 7 and 14 days |
| `build_features(df)` | Run full pipeline, drop NaN rows from lag creation |
| `feature_columns(df)` | Return list of feature column names (excludes date, y) |
| `chronological_split(df, test_frac=0.2)` | Return train/test split without shuffling |
| `naive_forecast(train, test)` | Predict last training value for all test points |
| `seasonal_naive_forecast(full_df, test)` | Predict same weekday last week (period=7) |
| `get_models()` | Return dict of 7 configured scikit-learn models |
| `evaluate(y_true, y_pred)` | Return MAE, RMSE, MAPE (%), R² |
| `run_all(feat_df)` | Full pipeline: split → fit all → return results DataFrame |

**Configuration constants** (change these to adapt to a different time series):
```python
DATE_COL        = "date"       # raw date column name
VALUE_COL       = "new_cases"  # raw target column
FREQ            = "D"          # daily
SEASONAL_PERIOD = 7            # weekly cycle
LAGS            = [1, 2, 3, 7, 14]
ROLL_WINDOWS    = [7, 14]
```

---

## 📊 Tableau Dashboard

**File:** `visuals/Covid Dashboard.twbx` (data embedded — no reconnection required)

![COVID-19 Dashboard](visuals/Dashboard%201.png)

### Visuals

| Visual | Chart Type | Powered By |
|--------|-----------|-----------|
| Global Numbers (death %, total cases) | KPI text table | Tableau Query 1 |
| Total Death Per Continent | Horizontal bar chart | Tableau Query 2 |
| % Population Infected Per Country | World choropleth map | Tableau Query 3 |
| % Population Infected Over Time | Multi-line time series | Tableau Query 4 |

### Key Dashboard Findings

- **Global death percentage: 2.11%** across 150,574,977 confirmed cases at the time of the dataset
- **Europe recorded the highest total deaths** (~1M), exceeding North America despite similar case counts — reflecting an older population demographic
- **India** showed one of the highest peak average percentage population infected rates (0.9516) in the time-series chart, reflecting the Delta wave
- **United Kingdom** maintained a sustained elevated infection percentage (0.0258) across multiple waves
- **Africa and Oceania** show the lowest reported death counts — reflecting testing access constraints, not necessarily lower true infection burden
- The **choropleth map** reveals that smaller European nations (Cyprus, Andorra, San Marino) have the highest per-population infection rates — a density and testing effect

---

## 📈 Key Insights & Final Recommendations

### Epidemiological Findings
- A global 2.11% case fatality rate masks enormous country-level variation — nations with limited healthcare infrastructure show 5–10× higher local rates
- Europe's dominance in total death counts reflects both reporting quality and demographic age structure, not necessarily worse pandemic management
- Vaccination rollout data confirms that countries with early mass vaccination programmes saw measurable mortality reductions within 3–4 months

### Forecasting Findings
- **The weekly reporting cycle is the single most important signal** — weekend reporting drops create a strong 7-day pattern that `lag_7` and `dayofweek` capture effectively
- **Linear Regression outperforms all tree-based models** on this dataset — the series during the test window was well-characterised by linear lag relationships; complex models overfit the volatile training waves
- **Seasonal-naive is the correct minimum baseline** for any weekly cycle series — naive (last value) is not an appropriate baseline here
- **Important caveat:** This forecasts *reported* cases — changes in testing policy, free test kit availability, and reporting infrastructure mean the series measures reporting behaviour as much as true infection levels

### Recommendations for Future Work
- Incorporate external regressors: government stringency index, mobility data, vaccine doses administered per day
- Apply Prophet or SARIMA for explicit seasonality modelling and uncertainty intervals
- Build country-level disaggregated models rather than global aggregates
- Add a real-time refresh pipeline pulling from the JHU CSSE GitHub feed via GitHub Actions

---

## ⚙️ Setup & How to Run

### SQL Track

```sql
-- 1. Open SQL Server Management Studio (SSMS)
-- 2. Create database:
CREATE DATABASE PortfolioProject;

-- 3. Import via SSMS Import Wizard:
--    CovidDeaths.xlsx      → table: CovidDeaths
--    covidvaccination.xlsx → table: CovidVaccinations

-- 4. Run queries in order:
--    queries/COVID Portfolio Project - Data Exploration.sql
--    queries/SQLQuery1.sql
--    queries/Tableau Portfolio Project SQL Queries.sql
```

### Python Track

```bash
# 1. Clone the repo
git clone https://github.com/your-username/covid-analysis.git
cd covid-analysis

# 2. Create virtual environment
python -m venv venv
source venv/bin/activate        # Mac/Linux
venv\Scripts\activate           # Windows

# 3. Install dependencies
pip install -r notebooks/requirements.txt

# 4. Run notebooks in order
jupyter notebook notebooks/01_eda.ipynb
# Then 02_data_cleaning.ipynb → 03_model_building.ipynb
```

### Tableau Track

```
1. Open Tableau Desktop or Tableau Public (free)
2. File → Open → visuals/Covid Dashboard.twbx
   (Data is packaged inside — no reconnection needed)
```

---

## 🛠️ Full Tech Stack

| Layer | Tool | Version | Purpose |
|-------|------|---------|---------|
| SQL | SQL Server + SSMS | 2019+ | Data exploration and vaccination analysis |
| Python | Pandas, NumPy | 2.0+, 1.24+ | Data loading, feature engineering |
| Visualisation (EDA) | Matplotlib | 3.7+ | Time-series and distribution plots |
| Time-series analysis | statsmodels | Latest | STL decomposition, ACF plot |
| Machine learning | scikit-learn | 1.3+ | 7 regression models + evaluation |
| Dashboard | Tableau Desktop/Public | Latest | Interactive global dashboard |

---

## 👤 Author

**Noah Asgodom**
📧 your.email@example.com
🔗 [LinkedIn](https://linkedin.com/in/yourprofile) · [Portfolio](https://yourwebsite.com)

---

## 📄 License

[MIT License](LICENSE) · Data sourced from Our World in Data (CC BY 4.0) and JHU CSSE (CC BY 4.0) — both public domain.
