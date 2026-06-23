# 🏠 Nashville Housing Market — Exploratory Data Analysis (EDA)

![Python](https://img.shields.io/badge/Python-3.10+-blue?logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-2.0+-150458?logo=pandas&logoColor=white)
![Seaborn](https://img.shields.io/badge/Seaborn-Visualization-4C72B0)
![Matplotlib](https://img.shields.io/badge/Matplotlib-Charts-11557C)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626?logo=jupyter&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

> End-to-end exploratory analysis of the Nashville Housing dataset — uncovering pricing patterns, geographic trends, and feature relationships through structured Python visualisations.

---

## 📌 Project Overview

This notebook performs a full EDA on a cleaned Nashville housing dataset to answer key market questions:

- What does the **distribution of sale prices** look like — and how skewed is it?
- Which **cities command premium prices** vs affordable pockets?
- How closely does **assessed value predict actual sale price**?
- Does the **year a property was built** affect its value?
- How does **bedroom count** influence pricing?
- Which features are most **correlated with SalePrice** — and which are redundant?

All findings feed into a Power BI dashboard and lay the groundwork for a predictive pricing model.

---

## 📊 Visualisations & Key Insights

### 1 · SalePrice Distribution
![SalePrice Distribution](visuals/01_saleprice_distribution.png)

> **Insight:** Sale prices are **right-skewed** — the mean sits noticeably above the median due to a long upper tail of luxury properties. The log-transformed view confirms the bulk of Nashville sales follow a near-normal distribution, which is typical in residential markets. This skew is important: raw SalePrice should not be used directly in linear regression without a log transformation.

---

### 2 · Average SalePrice by City
![SalePrice by City](visuals/02_saleprice_by_city.png)

> **Insight:** Nashville, Brentwood, and Belle Meade consistently rank as the highest-priced markets. Cities like Antioch and Goodlettsville represent more affordable suburban pockets. The bubble chart reveals that **high-price cities are not always high-volume** — some are niche luxury micro-markets with fewer than 100 annual transactions, which limits statistical reliability for neighbourhood-level modelling.

---

### 3 · Total Assessed Value vs Sale Price
![TotalValue vs SalePrice](visuals/03_totalvalue_vs_saleprice.png)

> **Insight:** Pearson r > 0.75 confirms a **strong positive correlation** between assessed value and sale price. Properties above the parity line (sale price > assessed value) indicate hot neighbourhoods where market demand exceeds tax assessments — common in rapidly gentrifying areas. Properties below the line may reflect distressed sales, foreclosures, or outdated assessments.

---

### 4 · Year Built vs Sale Price
![YearBuilt vs SalePrice](visuals/04_yearbuilt_vs_saleprice.png)

> **Insight:** The decade chart reveals a **dual premium** pattern — modern builds (post-2000) command higher prices due to updated amenities, while pre-1940s properties carry a historic premium in certain in-demand neighbourhoods. Mid-century builds (1950–1980) typically show the lowest median prices, reflecting both age and lower construction standards of that era.

---

### 5 · Bedrooms vs Sale Price
![Bedrooms vs SalePrice](visuals/05_bedrooms_vs_saleprice.png)

> **Insight:** Price scales predictably up to 4 bedrooms, after which **diminishing returns** set in — 5+ bedroom homes show high variance, suggesting they range from investor-grade flips to true luxury estates. The dual-axis chart confirms that **3-bedroom homes dominate transaction volume**, making them the most liquid and comparable segment of the Nashville market.

---

### 6 · Correlation Heatmap
![Correlation Heatmap](visuals/06_correlation_heatmap.png)

> **Insight:** `TotalValue`, `LandValue`, and `BuildingValue` are the strongest predictors of `SalePrice` — but they are also **highly correlated with each other** (multicollinearity). Including all three in a regression model would inflate standard errors. Recommendation: use `TotalValue` alone, or apply PCA/VIF analysis before modelling. `Bedrooms` and `YearBuilt` show moderate independent correlation and add useful signal.

---

## 🛠️ Tools & Tech Stack

| Category | Tools |
|----------|-------|
| Language | Python 3.10+ |
| Data Wrangling | Pandas, NumPy |
| Visualisation | Matplotlib, Seaborn |
| Environment | Jupyter Notebook |
| Data Source | Cleaned Nashville Housing CSV / Parquet |
| Export | Power BI–ready CSV with derived columns |

---

## 📁 Project Structure

```
nashville-housing-eda/
│
├── data/
│   ├── raw/                          # Original Excel file (gitignored)
│   └── processed/
│       ├── nashville_housing_cleaned.parquet
│       ├── nashville_housing_cleaned.csv
│       └── nashville_housing_powerbi.csv   ← Power BI import file
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   └── 02_eda.ipynb                  ← This notebook
│
├── visuals/                          # All exported chart PNGs
│   ├── 01_saleprice_distribution.png
│   ├── 02_saleprice_by_city.png
│   ├── 03_totalvalue_vs_saleprice.png
│   ├── 04_yearbuilt_vs_saleprice.png
│   ├── 05_bedrooms_vs_saleprice.png
│   └── 06_correlation_heatmap.png
│
├── requirements.txt
└── README.md
```

**requirements.txt**
```
pandas>=2.0.0
numpy>=1.24.0
matplotlib>=3.7.0
seaborn>=0.12.0
openpyxl>=3.1.0
pyarrow>=12.0.0
jupyter>=1.0.0
```

---

## 🔁 Derived Columns Added for Power BI

| Column | Formula | Use Case |
|--------|---------|----------|
| `PriceToValue_Ratio` | `SalePrice / TotalValue` | Flag over/under-market sales |
| `PropertyAge` | `2024 - YearBuilt` | Age-based price segmentation |
| `SaleYear` | Extracted from SaleDate | YoY trend analysis |
| `SaleMonth` | Extracted from SaleDate | Seasonality analysis |
| `SaleQuarter` | Extracted from SaleDate | Quarterly reporting |

---

## 🚀 Recommendations & Next Steps

1. **Predictive Model** — Use `TotalValue`, `PropertyAge`, `Bedrooms`, and `PropertyCity` (encoded) as features in a gradient-boosted regression model to predict SalePrice.
2. **Geospatial Layer** — Enrich with zip-code latitude/longitude to build a choropleth map of median price by area.
3. **Seasonal Analysis** — Investigate whether SaleMonth affects final price (spring markets often see premium pricing).
4. **Automated Pipeline** — Schedule data refresh with Apache Airflow or GitHub Actions to keep the dataset current.

---

## 👤 Author

**Noah Asgodom**
📧 noahasgodom104@gmail.com
🔗 [LinkedIn](https://linkedin.com/in/yourprofile) | [Portfolio](https://yourwebsite.com) | [Power BI Dashboard](https://github.com/your-username/nashville-housing-powerbi)

---

## 📄 License

[MIT License](LICENSE) — dataset sourced from public Nashville open data records.
