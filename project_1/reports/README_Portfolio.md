# 🏠 Nashville Housing Market — End-to-End Data Analytics Project

![Python](https://img.shields.io/badge/Python-3.10+-blue?logo=python&logoColor=white)
![DuckDB](https://img.shields.io/badge/DuckDB-SQL%20Engine-FFF000?logo=duckdb&logoColor=black)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Wrangling-150458?logo=pandas&logoColor=white)
![Seaborn](https://img.shields.io/badge/Seaborn-Visualization-4C72B0)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626?logo=jupyter&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

> A full-stack data analytics project covering SQL-based data cleaning, Python exploratory analysis, and an interactive Power BI dashboard — applied to 56,000+ Nashville residential housing transactions.

---

## 🎯 Project Objective

The Nashville housing market is one of the fastest-growing residential markets in the United States. This project builds a complete analytics pipeline — from raw Excel data to a published Power BI dashboard — to answer five core business questions:

1. What does the **distribution and trend of sale prices** look like across Nashville?
2. Which **cities and neighbourhoods** command premium prices?
3. How closely does **assessed value predict actual sale price** — and where do they diverge?
4. Do **property age and bedroom count** significantly influence pricing?
5. What share of properties were sold **vacant vs occupied**, and what does that signal?

---

## 🏗️ Project Architecture

```
Raw Excel Dataset
      │
      ▼
┌─────────────────────────────┐
│  Stage 1 · SQL Cleaning     │  DuckDB + Jupyter Notebook
│  ─────────────────────────  │
│  • Date standardisation     │
│  • Address backfill         │
│  • Column splitting         │
│  • Deduplication            │
│  • Vacancy standardisation  │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│  Stage 2 · Python EDA       │  Pandas · Matplotlib · Seaborn
│  ─────────────────────────  │
│  • Distribution analysis    │
│  • Geographic pricing       │
│  • Correlation heatmap      │
│  • Feature relationships    │
│  • Power BI CSV export      │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│  Stage 3 · Power BI         │  Dashboard · DAX · Maps
│  ─────────────────────────  │
│  • KPI cards                │
│  • Price trend (2013–2019)  │
│  • City-level comparisons   │
│  • Vacancy breakdown        │
│  • Geographic map           │
└─────────────────────────────┘
```

---

## 📁 Repository Structure

```
nashville-housing-analytics/
│
├── data/
│   ├── raw/                                     # Original Excel (gitignored)
│   └── processed/
│       ├── nashville_housing_cleaned.parquet    # Analysis-ready (typed)
│       ├── nashville_housing_cleaned.csv        # Analysis-ready (portable)
│       └── nashville_housing_powerbi.csv        # Power BI import file
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb                  # DuckDB SQL pipeline
│   └── 02_eda.ipynb                            # Python EDA
│
├── dashboard/
│   └── Nashville_Housing_Dashboard.pbix        # Power BI file
│
├── visuals/
│   ├── dashboard_preview.png
│   ├── 01_saleprice_distribution.png
│   ├── 02_saleprice_by_city.png
│   ├── 03_totalvalue_vs_saleprice.png
│   ├── 04_yearbuilt_vs_saleprice.png
│   ├── 05_bedrooms_vs_saleprice.png
│   └── 06_correlation_heatmap.png
│
├── .gitignore
├── requirements.txt
└── README.md
```

---

## 🧹 Stage 1 — SQL Data Cleaning Pipeline

**Notebook:** `notebooks/01_data_cleaning.ipynb`  
**Engine:** DuckDB (in-process SQL inside Jupyter)

The raw Nashville Housing Excel file required significant cleaning before analysis. All transformations were written as SQL queries executed via `duckdb.sql()` — making the logic auditable, version-controlled, and reproducible.

| Step | Transformation | SQL Technique |
|------|---------------|---------------|
| 1 | Load Excel into DuckDB | `pandas.read_excel()` → `con.register()` |
| 2 | Standardise `SaleDate` | `TRY_CAST(SaleDate AS DATE)` |
| 3 | Fill missing `PropertyAddress` | Self-join on `ParcelID` + `COALESCE` |
| 4 | Split `PropertyAddress` | `SPLIT_PART(..., ',', 1/2)` |
| 5 | Split `OwnerAddress` | `SPLIT_PART(..., ',', 1/2/3)` |
| 6 | Standardise `SoldAsVacant` | `CASE WHEN UPPER(TRIM(...)) IN ('Y','YES')` |
| 7 | Remove duplicates | `ROW_NUMBER() OVER (PARTITION BY ...)` |
| 8 | Final column selection | `CREATE TABLE housing_cleaned AS SELECT ...` |
| 9 | Export | `COPY TO ... (FORMAT PARQUET, COMPRESSION SNAPPY)` |

**Key SQL patterns used:**
- `TRY_CAST` over `CAST` — returns `NULL` on parse failure instead of breaking the pipeline
- `NULLIF(TRIM(...), '')` — catches both `NULL` and empty-string nulls common in Excel exports
- `SELECT * EXCLUDE (rn)` — DuckDB-native syntax to cleanly drop helper columns
- `COPY TO ... FORMAT PARQUET` — typed, compressed output preserving DATE and DOUBLE precision

---

## 📊 Stage 2 — Python Exploratory Data Analysis

**Notebook:** `notebooks/02_eda.ipynb`  
**Libraries:** Pandas · NumPy · Matplotlib · Seaborn

### Visual 1 · SalePrice Distribution

![SalePrice Distribution](visuals/01_saleprice_distribution.png)

Sale prices are **right-skewed** with a long upper tail driven by luxury properties. The median ($205K) sits well below the mean ($327K), confirming that average price overstates the typical buyer's experience. The log-transformed histogram shows the bulk of transactions follow a near-normal distribution — a prerequisite check before any regression modelling.

---

### Visual 2 · Average SalePrice by City

![SalePrice by City](visuals/02_saleprice_by_city.png)

**Nashville** and **Brentwood** lead on average price, reflecting urban-core and high-income suburban premiums. **Nolensville** and **Mount Juliet** emerge as growth-opportunity markets — lower entry prices with rising suburban demand driven by Nashville's urban sprawl. The bubble chart reveals that several high-price cities have low transaction volumes, reducing their statistical reliability for modelling purposes.

---

### Visual 3 · Total Assessed Value vs Sale Price

![TotalValue vs SalePrice](visuals/03_totalvalue_vs_saleprice.png)

Pearson r > 0.75 confirms a strong linear relationship between assessed value and sale price. Properties above the parity line (sale > assessed) indicate hot sub-markets where demand outpaces tax assessment cycles. Properties below the line often reflect distressed sales, foreclosures, or outdated assessments — all investable signals for deal-sourcing.

---

### Visual 4 · Year Built vs Sale Price

![YearBuilt vs SalePrice](visuals/04_yearbuilt_vs_saleprice.png)

A **dual premium** pattern emerges: post-2000 new builds command higher prices due to modern amenities, while pre-1940 properties carry a historic premium in select in-demand neighbourhoods. Mid-century builds (1950–1980) show the lowest median prices — reflecting both age and lower construction standards of that era.

---

### Visual 5 · Bedrooms vs Sale Price

![Bedrooms vs SalePrice](visuals/05_bedrooms_vs_saleprice.png)

Price scales predictably from 1 to 4 bedrooms, after which **diminishing returns** set in. The 3-bedroom segment dominates transaction volume — it is the most liquid, comparable, and investor-relevant inventory class in Nashville. 5+ bedroom homes show high variance, ranging from investor-grade flips to true luxury estates.

---

### Visual 6 · Correlation Heatmap

![Correlation Heatmap](visuals/06_correlation_heatmap.png)

`TotalValue`, `LandValue`, and `BuildingValue` are the strongest predictors of `SalePrice` but are **highly inter-correlated** — a multicollinearity risk for regression models. Recommendation: use `TotalValue` alone or apply VIF analysis before feature selection. `Bedrooms` and `YearBuilt` contribute moderate independent signal.

---

## 📊 Stage 3 — Power BI Dashboard

**File:** `dashboard/Nashville_Housing_Dashboard.pbix`  
**Data source:** `data/processed/nashville_housing_powerbi.csv`

![Nashville Housing Dashboard](visuals/dashboard_preview.png)

### KPI Cards

| Metric | Value | Interpretation |
|--------|-------|----------------|
| Total Properties | **56K** | Full dataset scope |
| Average Sale Price | **$327.52K** | Skewed upward by luxury tail |
| Median Sale Price | **$205.70K** | True market benchmark |

> The $121K gap between average and median is the single most important number on this dashboard — it immediately tells analysts not to use mean as a price benchmark.

### Sale Price Trend Over Time (2013–2019)

Nashville prices peaked sharply around **2016** then corrected through 2019. This reflects the Metro area's rapid development cycle — rising demand pulled prices up steeply, followed by a supply response as new construction came online. The trend provides a baseline for forecasting the next price cycle.

### Sold As Vacant Distribution

| Status | Count | Share |
|--------|-------|-------|
| Occupied (No) | 51.7K | **91.72%** |
| Vacant (Yes) | 4.67K | **8.28%** |

A 91.72% occupied rate indicates a **healthy, owner-occupier-dominated market** with minimal distressed inventory. A vacancy rate above 15% would signal systemic oversupply risk — Nashville is well below that threshold.

### Total Value vs Sale Price by City

The scatter plot (filtered to Antioch and Bellevue) shows both cities clustering **below the parity line** — sale prices are lower than assessed values. This reveals neighbourhoods where **market demand has softened relative to assessment cycles**, creating potential acquisition opportunities for value investors.

### Average Sale Price by City

Nashville leads, followed by Brentwood and Goodlettsville. Mid-table cities — Nolensville, Antioch, Mount Juliet — represent the most accessible entry points into the market without sacrificing proximity to Nashville's job centres.

### Total Properties by City

Nashville accounts for nearly **50K of 56K transactions** — it is by far the most liquid sub-market. Suburban city data should be interpreted carefully: small samples inflate price volatility and reduce comparability.

### Properties by City Map

The geographic view confirms Davidson County as the transaction core, with suburban spread into Williamson, Rutherford, and Wilson counties. Vacant-sold properties (yellow markers) are distributed evenly — vacancy is driven by property condition, not neighbourhood-level decline.

---

## 🧮 DAX Measures

```dax
-- Median Sale Price
Median Sale Price = MEDIAN(nashville_housing_powerbi[SalePrice])

-- Average Sale Price
Average Sale Price = AVERAGE(nashville_housing_powerbi[SalePrice])

-- Total Properties
Total Properties = COUNTROWS(nashville_housing_powerbi)

-- Vacant Rate %
Vacant Rate % =
DIVIDE(
    COUNTROWS(
        FILTER(nashville_housing_powerbi,
               nashville_housing_powerbi[SoldAsVacant] = "Yes")
    ),
    COUNTROWS(nashville_housing_powerbi)
)

-- Price to Value Ratio
Avg Price-to-Value Ratio =
AVERAGE(nashville_housing_powerbi[PriceToValue_Ratio])
```

---

## 🔑 Derived Feature Engineering (Power BI CSV)

| Column | Logic | Purpose |
|--------|-------|---------|
| `PriceToValue_Ratio` | `SalePrice / TotalValue` | Flag over/under-market transactions |
| `PropertyAge` | `2024 − YearBuilt` | Age-based price segmentation |
| `SaleYear` | Extracted from `SaleDate` | YoY trend analysis |
| `SaleMonth` | Extracted from `SaleDate` | Seasonality analysis |
| `SaleQuarter` | Extracted from `SaleDate` | Quarterly reporting |

---

## 🚀 Final Recommendations

### For Investors
- **Target Nolensville and Mount Juliet** — below-average entry prices with strong suburban growth trajectory driven by Nashville's urban expansion.
- Focus on **3-bedroom properties** as the most liquid segment: fastest days-on-market, highest comparable sales density, most predictable exit pricing.
- Screen for properties where `PriceToValue_Ratio < 0.85` — these represent below-assessed-value acquisitions worth investigating for distress or assessment lag.

### For Market Analysts
- Use **median sale price** as the headline KPI — not average. The $121K spread makes mean a misleading benchmark for policy and reporting.
- Monitor **vacancy rate** as an early-warning indicator. The current 8.28% rate is healthy; a rise above 12–15% in any sub-market would flag oversupply risk.
- Nashville follows an observable **4–6 year price cycle** (2013 trough → 2016 peak → 2018–19 correction). The next upswing phase warrants monitoring from 2020–2021 onward.

### For Data Stakeholders
- Enrich the dataset with **school district ratings** and **walkability scores** to explain residual SalePrice variance not captured by assessed value alone.
- Add a **rolling 12-month average** and **MoM % change** page to the Power BI report for executive-level monitoring.
- Build a **predictive model** using `TotalValue`, `PropertyAge`, `Bedrooms`, and encoded `PropertyCity` — these four features provide the strongest independent signal for SalePrice.
- Publish the dashboard to **Power BI Service** for live browser access and scheduled data refresh.

---

## ⚙️ Setup & Reproduction

### Prerequisites
- Python 3.10+
- Power BI Desktop (free — [download here](https://powerbi.microsoft.com/desktop/))

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/nashville-housing-analytics.git
cd nashville-housing-analytics

# Create and activate virtual environment
python -m venv venv
source venv/bin/activate        # Mac/Linux
venv\Scripts\activate           # Windows

# Install Python dependencies
pip install -r requirements.txt

# Run notebooks in order
jupyter notebook
# → Open 01_data_cleaning.ipynb first, then 02_eda.ipynb
```

### Open Power BI Dashboard

1. Open `dashboard/Nashville_Housing_Dashboard.pbix` in Power BI Desktop
2. Go to **Transform Data → Data Source Settings**
3. Update the path to `data/processed/nashville_housing_powerbi.csv`
4. Click **Refresh**

**requirements.txt**
```
pandas>=2.0.0
numpy>=1.24.0
matplotlib>=3.7.0
seaborn>=0.12.0
openpyxl>=3.1.0
pyarrow>=12.0.0
duckdb>=0.10.0
jupyter>=1.0.0
```

**.gitignore**
```
data/raw/
*.xlsx
*.pbix
venv/
__pycache__/
.ipynb_checkpoints/
```

---

## 🛠️ Full Tech Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| Data ingestion | Python · Pandas | Read Excel into DataFrame |
| SQL cleaning | DuckDB · Jupyter | Transform, deduplicate, standardise |
| EDA | Pandas · Matplotlib · Seaborn | Statistical analysis + charts |
| BI Dashboard | Power BI Desktop | Interactive reporting + DAX measures |
| Storage | Parquet (Snappy) + CSV | Typed storage + portable export |
| Version control | Git · GitHub | Reproducibility + portfolio publishing |

---

## 🧠 Skills Demonstrated

- **SQL engineering** — window functions, self-joins, conditional logic, DDL/DML in DuckDB
- **Python data wrangling** — Pandas pipelines, outlier handling, feature engineering
- **Statistical analysis** — distribution profiling, correlation analysis, skewness interpretation
- **Data visualisation** — dual-panel chart design, multi-axis plots, heatmaps in Seaborn/Matplotlib
- **Business intelligence** — DAX measures, KPI design, interactive filtering in Power BI
- **Data storytelling** — translating technical findings into market-facing recommendations
- **End-to-end pipeline design** — raw Excel to analysis-ready Parquet to published dashboard

---

## 👤 Author

**Your Name**  
📧 your.email@example.com  
🔗 [LinkedIn](https://linkedin.com/in/yourprofile) | [Portfolio](https://yourwebsite.com)

---

## 📄 License

[MIT License](LICENSE) — dataset sourced from public Nashville open data records.
