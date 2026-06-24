# 📂 Processed Data

> This folder contains **cleaned, analysis-ready output files** produced by the Nashville Housing data pipeline.  
> All files here are derived from `data/raw/Nashville Housing Data.xlsx` via `notebooks/01_data_cleaning.ipynb`.

---

## 📄 Files in This Folder

| File | Format | Size (approx.) | Primary Use |
|------|--------|----------------|-------------|
| `nashville_housing_cleaned.parquet` | Parquet (Snappy) | ~1–3 MB | Python EDA, DuckDB queries, downstream modelling |
| `nashville_housing_cleaned.csv` | CSV (UTF-8) | ~8–15 MB | General-purpose, portable analysis |
| `nashville_housing_powerbi.csv` | CSV (UTF-8 BOM) | ~9–16 MB | Direct Power BI Desktop import |

---

## 🗂️ File Descriptions

---

### 1 · `nashville_housing_cleaned.parquet`

The **primary analysis file**. Parquet is the preferred format for all Python and SQL workflows.

**Why Parquet over CSV:**

| Feature | Parquet | CSV |
|---------|---------|-----|
| Column types preserved | ✅ DATE, DOUBLE, INT | ❌ Everything becomes string |
| File size | ~3–5× smaller | Larger |
| Read speed | ~5–10× faster | Slower |
| Null handling | Native | Ambiguous |
| Best for | Pandas, DuckDB, Spark | Sharing, Power BI |

**How to load:**
```python
import pandas as pd
df = pd.read_parquet('data/processed/nashville_housing_cleaned.parquet')
```

```python
# Or directly in DuckDB
import duckdb
con = duckdb.connect()
con.sql("SELECT * FROM read_parquet('data/processed/nashville_housing_cleaned.parquet') LIMIT 5").show()
```

---

### 2 · `nashville_housing_cleaned.csv`

A portable, universal version of the cleaned dataset. Use this when sharing with tools that don't support Parquet (Excel, Tableau Public, Google Sheets, collaborators).

**How to load:**
```python
import pandas as pd
df = pd.read_csv(
    'data/processed/nashville_housing_cleaned.csv',
    parse_dates=['SaleDate']
)
```

---

### 3 · `nashville_housing_powerbi.csv`

Optimised specifically for **Power BI Desktop** import. Contains all cleaned columns plus five pre-engineered features ready for use in DAX measures and slicers — no transformation needed inside Power BI.

**Encoding:** `UTF-8 BOM` (`utf-8-sig`) — ensures Power BI and Excel read special characters without corruption.

**How to connect in Power BI:**
1. Open Power BI Desktop
2. **Get Data → Text/CSV**
3. Navigate to `data/processed/nashville_housing_powerbi.csv`
4. Click **Load**

---

## 📊 Cleaned Dataset Schema

All three files share this column structure (Power BI file adds 5 extra columns — see below).

| Column | Type | Description | Cleaning Applied |
|--------|------|-------------|-----------------|
| `UniqueID` | Integer | Unique row identifier | — |
| `ParcelID` | String | Tax parcel identifier | — |
| `SaleDate` | DATE | Transaction date | Cast from raw string via `TRY_CAST` |
| `SalePrice` | Float | Actual sale price ($) | Cast to DOUBLE |
| `LegalReference` | String | Deed reference number | — |
| `SoldAsVacant` | String | `Yes` or `No` | Standardised from Y/N/Yes/No |
| `PropertyStreet` | String | Property street address | Split from `PropertyAddress` |
| `PropertyCity` | String | Property city | Split from `PropertyAddress` |
| `OwnerName` | String | Registered owner name | — |
| `OwnerStreet` | String | Owner street address | Split from `OwnerAddress` |
| `OwnerCity` | String | Owner city | Split from `OwnerAddress` |
| `OwnerState` | String | Owner state | Split from `OwnerAddress` |
| `Acreage` | Float | Lot size in acres | — |
| `TaxDistrict` | String | Tax jurisdiction | — |
| `LandValue` | Float | Assessed land value ($) | — |
| `BuildingValue` | Float | Assessed building value ($) | — |
| `TotalValue` | Float | Total assessed value ($) | — |
| `YearBuilt` | Integer | Year of original construction | — |
| `Bedrooms` | Integer | Number of bedrooms | — |
| `FullBath` | Integer | Full bathrooms | — |
| `HalfBath` | Integer | Half bathrooms | — |

---

## ➕ Power BI Extra Columns

The `nashville_housing_powerbi.csv` file includes five additional pre-engineered columns:

| Column | Formula | Purpose in Power BI |
|--------|---------|---------------------|
| `PriceToValue_Ratio` | `SalePrice ÷ TotalValue` | Spot over/under-market transactions; use in scatter plots |
| `PropertyAge` | `2024 − YearBuilt` | Age-based price segmentation; use as slicer |
| `SaleYear` | Extracted from `SaleDate` | Year-over-year trend analysis |
| `SaleMonth` | Extracted from `SaleDate` | Seasonality analysis; 1–12 |
| `SaleQuarter` | Extracted from `SaleDate` | Quarterly reporting; Q1–Q4 |

---

## ✅ Data Quality Summary

| Check | Result |
|-------|--------|
| Total rows (after deduplication) | ~56,000 |
| Duplicate rows removed | Identified and dropped via `ROW_NUMBER()` |
| Missing `PropertyAddress` filled | Backfilled via `ParcelID` self-join |
| `SaleDate` parse failures | 0 (validated with `TRY_CAST`) |
| `SoldAsVacant` non-standard values | 0 remaining after `CASE WHEN` standardisation |
| Columns with remaining nulls | `OwnerName`, `YearBuilt`, `Acreage` (reflect true missing data in source) |

---

## 🔄 How These Files Were Generated

All files are produced by running:

```bash
jupyter notebook notebooks/01_data_cleaning.ipynb
```

The final two cells of that notebook execute:

```sql
-- Parquet export
COPY housing_cleaned
TO 'data/processed/nashville_housing_cleaned.parquet'
(FORMAT PARQUET, COMPRESSION SNAPPY);

-- CSV export
COPY housing_cleaned
TO 'data/processed/nashville_housing_cleaned.csv'
(FORMAT CSV, HEADER TRUE, DELIMITER ',');
```

The Power BI CSV is generated in `notebooks/02_eda.ipynb` with Python:

```python
pbi.to_csv('data/processed/nashville_housing_powerbi.csv',
           index=False, encoding='utf-8-sig')
```

---

## 🔗 How These Files Are Used Downstream

```
nashville_housing_cleaned.parquet
        └──► notebooks/02_eda.ipynb          (Python EDA)
        └──► DuckDB ad-hoc queries
        └──► Future ML modelling notebook

nashville_housing_cleaned.csv
        └──► Tableau Public
        └──► Google Sheets / Excel sharing
        └──► General portability

nashville_housing_powerbi.csv
        └──► dashboard/Nashville_Housing_Dashboard.pbix
```

---

## 📁 Folder Contents

```
data/processed/
├── nashville_housing_cleaned.parquet    ← Python & SQL workflows
├── nashville_housing_cleaned.csv        ← Portable sharing
└── nashville_housing_powerbi.csv        ← Power BI import
```

---

## 🔗 Related

- **Cleaning pipeline:** `notebooks/01_data_cleaning.ipynb`
- **EDA notebook:** `notebooks/02_eda.ipynb`
- **Power BI dashboard:** `dashboard/Nashville_Housing_Dashboard.pbix`
- **Raw source data:** `data/raw/README.md`
