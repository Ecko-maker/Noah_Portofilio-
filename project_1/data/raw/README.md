# Folder: raw
🏡 Nashville Housing Dataset — Raw Data Documentation
📘 Overview
This folder contains the raw, unmodified Nashville Housing dataset, consisting of 56,477 rows and 19 columns. The dataset includes property sales, ownership details, land use classifications, assessed values, and structural characteristics for residential properties in Nashville, Tennessee.

This raw dataset serves as the foundation for the Nashville Housing Data Cleaning Project, where it undergoes extensive transformation using SQL.

📂 File Information
Format: .xlsx
Rows: 56,477
Columns: 19

Source: Public Nashville housing/property assessment data (commonly distributed via Kaggle mirrors)

🧱 Column Definitions
| Column Name | Description |
| --- | --- |
| **UniqueID** | Internal unique identifier for each record |
| **ParcelID** | Unique property parcel identifier |
| **LandUse** | Classification of property type (e.g., SINGLE FAMILY) |
| **PropertyAddress** | Full address of the property sold |
| **SaleDate** | Date the property was sold |
| **SalePrice** | Final sale price of the property |
| **LegalReference** | Deed or legal transaction reference |
| **SoldAsVacant** | Indicates whether the property was sold as vacant (Yes/No) |
| **OwnerName** | Name of the property owner |
| **OwnerAddress** | Owner’s mailing address |
| **Acreage** | Lot size in acres |
| **TaxDistrict** | Tax district classification |
| **LandValue** | Assessed land value |
| **BuildingValue** | Assessed building value |
| **TotalValue** | Combined assessed value |
| **YearBuilt** | Year the structure was built |
| **Bedrooms** | Number of bedrooms |
| **FullBath** | Number of full bathrooms |
| **HalfBath** | Number of half bathrooms |

⚠️ Data Quality Issues (Raw Dataset)
The raw dataset contains several issues that require cleaning before analysis.

1. Missing Values
Significant missing data across multiple fields:

OwnerName: 31,216 missing

OwnerAddress: 30,462 missing

Acreage: 30,462 missing

LandValue, BuildingValue, TotalValue: 30,462 missing

YearBuilt: 32,314 missing

Bedrooms: 32,320 missing

FullBath: 32,202 missing

HalfBath: 32,333 missing

These missing values affect property characteristics and assessed values.

2. Inconsistent Address Formatting
PropertyAddress and OwnerAddress contain combined fields (street, city, state).

Some addresses include extra spaces or inconsistent formatting.

Address parsing is required for normalization.

3. Mixed Data Types
ParcelID stored as text with embedded spaces.

YearBuilt, Bedrooms, FullBath, HalfBath stored as floats due to missing values.

SaleDate requires conversion to a proper DATE type.

4. Duplicate Records
Some properties appear more than once.

Requires deduplication using SQL window functions such as ROW_NUMBER().

5. Categorical Inconsistencies
SoldAsVacant contains values like "Y", "N", "Yes", "No".

Needs standardization to a consistent format.

🎯 Purpose of This Dataset
This raw dataset is used to demonstrate:
-SQL data cleaning and transformation
-Real‑world ETL (Extract, Transform, Load) workflows
-Handling messy property and real estate data
-Preparing data for analytics or dashboarding

Best practices in data documentation and reproducibility

📌 How This Raw Data Is Used in the Project
The raw dataset feeds into:
-sql/cleaning_script.sql — full SQL cleaning pipeline
-screenshots/ — before/after comparisons
-Cleaned dataset (optional output)
-Future Power BI or Python analysis

The raw file is intentionally left untouched to preserve data integrity.

🔒 License & Usage Notes
This dataset is publicly available for educational and analytical purposes.
No personally sensitive information is included.
