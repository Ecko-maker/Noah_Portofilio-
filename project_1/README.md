# 🏡 Nashville Housing Data Project (SQL)

## 🚀 Overview
This project focuses on cleaning and transforming the Nashville Housing dataset using SQL Server Management Studio (SSMS). The goal was to take a raw, inconsistent dataset and convert it into a clean, analysis‑ready table using professional SQL techniques.

This project demonstrates real-world data cleaning skills used in analytics and data engineering roles.

---

## 🧠 Skills Demonstrated
- SQL data cleaning and transformation
- Working with SSMS (SQL Server Management Studio)
- Converting data types (DATE, VARCHAR)
- String manipulation (SUBSTRING, CHARINDEX, PARSENAME)
- Standardizing categorical values
- Splitting combined address fields
- Handling NULL values
- Removing duplicates using CTE + ROW_NUMBER()
- Writing clean, readable SQL scripts

---

## 🗂️ Project Structure

---

## ⚙️ Tech Stack
- SQL Server Management Studio (SSMS)
- T‑SQL
- Window functions
- CTEs
- String functions

---

## 📊 Key Cleaning Steps
### 1. Standardized Date Formats
Converted `SaleDate` into a proper `DATE` data type.

### 2. Split Property Address
Separated `PropertyAddress` into:
- Street Address  
- City  

### 3. Split Owner Address
Used `PARSENAME` to extract:
- Owner Street Address  
- Owner City  
- Owner State  

### 4. Standardized SoldAsVacant Values
Converted:
- `Y` → `Yes`
- `N` → `No`

### 5. Removed Duplicate Records
Used a CTE with `ROW_NUMBER()` to identify and delete duplicates.

---

## 📝 How to Run the SQL Script
1. Open SSMS  
2. Load the `cleaning_script.sql` file  
3. Connect to your database  
4. Run the script step-by-step or all at once  

---
## 📈 Results
- Clean, analysis-ready dataset  
- Standardized address fields  
- Consistent date formats  
- No duplicate records  
- Improved data quality for reporting or dashboards  

Nashville Housing Market Dashboard — Created by Noah Asgodom | Data Source: Nashville Open Data”

---

## 📚 Future Improvements
- Add a Power BI dashboard  
- Automate cleaning using Python  
- Build a stored procedure for repeated cleaning  
- Add data validation checks  

---

## 🙌 Acknowledgments
Dataset: Nashville Housing Data (public dataset)
