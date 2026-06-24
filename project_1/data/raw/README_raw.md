# 📂 Raw Data

> This folder contains the **original, unmodified source data** for the Nashville Housing Market Analytics project.

---

## ⚠️ Important Notice

```
This folder is intentionally excluded from version control via .gitignore.
Do NOT commit raw data files to GitHub.
```

Raw files are excluded for three reasons:

- **File size** — Excel files exceed GitHub's recommended 50MB file limit
- **Data integrity** — the raw file must remain unmodified as the single source of truth
- **Reproducibility** — all transformations are captured in the cleaning notebook, not the file itself

---

## 📄 Expected File

| File | Format | Size (approx.) | Description |
|------|--------|----------------|-------------|
| `Nashville Housing Data.xlsx` | Excel (.xlsx) | ~5–15 MB | Original Nashville housing transactions dataset |

---

## 📥 How to Obtain the Raw File

The dataset is sourced from publicly available Nashville open data records.

**Option 1 — Direct download:**
Download `Nashville Housing Data.xlsx` from the project data source and place it in this folder at:
```
data/raw/Nashville Housing Data.xlsx
```

**Option 2 — From Kaggle:**
Search for `Nashville Housing Data` on [Kaggle Datasets](https://www.kaggle.com/datasets) and download the Excel file.

**Option 3 — From the project maintainer:**
Contact [your.email@example.com](mailto:your.email@example.com) to request access to the original file.

---

## 📋 Raw Dataset Overview

| Field | Details |
|-------|---------|
| **Source** | Nashville Open Data / Public Records |
| **Format** | Microsoft Excel (.xlsx) |
| **Rows** | ~56,000 property transactions |
| **Time Range** | 2013 – 2019 |
| **Geographic Scope** | Davidson County and surrounding Nashville metro area |
| **License** | Public Domain |

---

## 📊 Raw Columns Reference

| Column Name | Data Type (raw) | Description |
|-------------|----------------|-------------|
| `UniqueID` | Integer | Unique row identifier |
| `ParcelID` | String | Tax parcel identifier (links to property records) |
| `LandUse` | String | Property use classification |
| `PropertyAddress` | String | Full address — contains nulls requiring backfill |
| `SaleDate` | String / DateTime | Date of sale — requires standardisation to DATE |
| `SalePrice` | Integer | Actual transaction sale price |
| `LegalReference` | String | Deed reference number |
| `SoldAsVacant` | String | Y / N / Yes / No — requires standardisation |
| `OwnerName` | String | Registered owner name |
| `OwnerAddress` | String | Full owner address — requires splitting |
| `Acreage` | Float | Lot size in acres |
| `TaxDistrict` | String | Tax jurisdiction |
| `LandValue` | Integer | Assessed land value |
| `BuildingValue` | Integer | Assessed building value |
| `TotalValue` | Integer | Total assessed value (Land + Building) |
| `YearBuilt` | Integer | Year of original construction |
| `Bedrooms` | Integer | Number of bedrooms |
| `FullBath` | Integer | Number of full bathrooms |
| `HalfBath` | Integer | Number of half bathrooms |

---

## 🔍 Known Data Quality Issues

These issues are fully resolved in the cleaning pipeline (`notebooks/01_data_cleaning.ipynb`):

| Issue | Column(s) Affected | Resolution |
|-------|--------------------|------------|
| Missing values | `PropertyAddress` | Backfilled via `ParcelID` self-join |
| Inconsistent date formats | `SaleDate` | `TRY_CAST(SaleDate AS DATE)` |
| Mixed Yes/No/Y/N values | `SoldAsVacant` | Standardised with `CASE WHEN` |
| Concatenated address fields | `PropertyAddress`, `OwnerAddress` | Split with `SPLIT_PART()` |
| Duplicate rows | All columns | Removed with `ROW_NUMBER() OVER (PARTITION BY ...)` |
| Empty string nulls | Multiple | Caught with `NULLIF(TRIM(...), '')` |

---

## 🔗 Next Step

Once the raw file is in place, run the cleaning pipeline:

```bash
jupyter notebook notebooks/01_data_cleaning.ipynb
```

This produces the cleaned output files in `data/processed/`.

---

## 📁 Folder Contents After Setup

```
data/raw/
└── Nashville Housing Data.xlsx     ← place file here (gitignored)
```
