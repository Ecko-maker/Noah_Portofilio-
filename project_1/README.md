# 🏠 Nashville Housing Market — End-to-End Data Analytics Project

![Python](https://img.shields.io/badge/Python-3.10+-blue?logo=python&logoColor=white)
![DuckDB](https://img.shields.io/badge/DuckDB-SQL%20Engine-FFF000?logo=duckdb&logoColor=black)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Wrangling-150458?logo=pandas&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

> A full-stack data analytics project covering SQL-based data cleaning (via DuckDB), Python exploratory analysis, and an interactive Power BI dashboard — applied to 56,000+ Nashville residential housing transactions.

---

## 🚀 Overview

This project takes the raw, inconsistent Nashville Housing dataset and turns it into a clean, analysis-ready dataset and dashboard using a three-stage pipeline:

1. **SQL cleaning** — standardizing dates, splitting address fields, removing duplicates, and normalizing categorical values, all written as SQL and executed via DuckDB inside a Jupyter notebook.
2. **Python EDA** — visualizing pricing patterns, geographic trends, and feature relationships.
3. **Power BI dashboard** — an interactive report for exploring the cleaned data.

See [`reports/README_Portfolio.md`](reports/README_Portfolio.md) for the full write-up (architecture diagram, all visuals, DAX measures, and business recommendations).

---

## 🧠 Skills Demonstrated

- SQL data cleaning and transformation (DuckDB / T-SQL style syntax)
- String manipulation (`SPLIT_PART`, `SUBSTRING`, `CHARINDEX`, `PARSENAME`)
- Standardizing categorical values and handling NULLs
- Removing duplicates using window functions (`ROW_NUMBER()`)
- Exploratory data analysis with Pandas, Matplotlib, and Seaborn
- Power BI dashboarding and DAX measures

---

## 🗂️ Project Structure

```
project_1/
├── data/
│   ├── raw/            # Original Excel source file
│   └── processed/       # Cleaned CSV / Parquet / Power BI exports
├── notebooks/
│   ├── 01_data_cleaning.ipynb   # DuckDB SQL cleaning pipeline
│   ├── 02_eda.ipynb              # Python exploratory data analysis
│   └── Data Info.ipynb           # Quick raw-file inspection scratchpad
├── dashboard/
│   └── Nashville_Housing_Dashboard.pbix
├── visuals/              # Exported chart PNGs
└── reports/
    └── README_Portfolio.md       # Full project write-up
```

---

## 📊 Key Cleaning Steps

1. **Standardized Date Formats** — converted `SaleDate` into a proper `DATE` type.
2. **Split Property Address** — separated `PropertyAddress` into street and city.
3. **Split Owner Address** — extracted owner street, city, and state.
4. **Standardized `SoldAsVacant`** — converted `Y`/`N` to `Yes`/`No`.
5. **Removed Duplicate Records** — via `ROW_NUMBER()` over key fields.

---

## 📝 How to Run

```bash
pip install duckdb pandas openpyxl matplotlib seaborn pyarrow jupyter

jupyter notebook
# 1. Open notebooks/01_data_cleaning.ipynb  → produces data/processed/*
# 2. Open notebooks/02_eda.ipynb            → EDA + Power BI export
```

Then open `dashboard/Nashville_Housing_Dashboard.pbix` in Power BI Desktop and point its data source at `data/processed/nashville_housing_powerbi.csv`.

---

## 📈 Results

- Clean, analysis-ready dataset (56K+ rows)
- Standardized address fields and date formats
- No duplicate records
- Interactive Power BI dashboard with KPI cards, trend lines, and a geographic map

---

## 📚 Future Improvements

- Predictive pricing model using `TotalValue`, `PropertyAge`, and `Bedrooms`
- Geospatial enrichment (school district ratings, walkability scores)
- Automated data refresh pipeline

---

## 🙌 Acknowledgments

Dataset: Nashville Housing Data (public dataset)

## 👤 Author

**Noah Asgodom**
📧 noahasgodom104@gmail.com
🔗 [LinkedIn](http://linkedin.com/noah-asgodom/)
