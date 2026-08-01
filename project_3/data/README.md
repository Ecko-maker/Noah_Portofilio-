# Cereals Dataset

**Dataset Name:** `Cereals.xlsx`  
**Version:** 1.0  
**Last Updated:** January 28, 2025

---

## 📋 Dataset Overview

This dataset contains nutritional information and health ratings for **77 popular breakfast cereals** available in the U.S. market. It is commonly used for exploratory data analysis, data cleaning practice, and predictive modeling.

### Key Details
- **Number of Rows:** 77
- **Number of Columns:** 16
- **File Format:** Microsoft Excel (`.xlsx`)
- **License:** Open for educational and portfolio use

---

## 📊 Data Dictionary

| Column Name   | Description                                                                 | Data Type    | Example Value |
|---------------|-----------------------------------------------------------------------------|--------------|---------------|
| `name`        | Name of the cereal                                                          | String       | 100%_Natural_Bran |
| `mfr`         | Manufacturer (A=American Home, G=General Mills, K=Kelloggs, N=Nabisco, P=Post, Q=Quaker Oats, R=Ralston Purina) | Categorical  | K |
| `type`        | Type of cereal (C = Cold, H = Hot)                                          | Categorical  | C |
| `calories`    | Calories per serving                                                        | Integer      | 110 |
| `protein`     | Protein (grams) per serving                                                 | Integer      | 2 |
| `fat`         | Fat (grams) per serving                                                     | Integer      | 2 |
| `sodium`      | Sodium (mg) per serving                                                     | Integer      | 180 |
| `fiber`       | Dietary fiber (grams) per serving                                           | Float        | 1.5 |
| `carbo`       | Complex carbohydrates (grams) per serving                                   | Float        | 10.5 |
| `sugars`      | Sugars (grams) per serving                                                  | Integer      | 10 |
| `potass`      | Potassium (mg) per serving                                                  | Integer      | 70 |
| `vitamins`    | Vitamins & minerals (0 = none, 25 = 25% FDA, 100 = 100% FDA)               | Integer      | 25 |
| `shelf`       | Display shelf (1, 2, or 3 - counting from the floor)                        | Integer      | 1 |
| `weight`      | Weight of one serving (ounces)                                              | Float        | 1.0 |
| `cups`        | Cups per serving                                                            | Float        | 0.75 |
| `rating`      | **Health rating** of the cereal (out of 100) - **Target Variable**         | Float        | 29.509541 |

---

## 🔍 Notes on Data Quality

- Missing values were originally coded as **`-1`** in `carbo`, `sugars`, and `potass`.
- Some outliers exist in nutrient columns (especially `fiber`, `potass`, `vitamins`).
- The `rating` variable is a composite health score based on nutritional content.

---

## 📁 Usage Recommendations

This dataset is excellent for practicing:
- Data cleaning and preprocessing
- Exploratory Data Analysis (EDA)
- Statistical hypothesis testing
- Correlation analysis
- Regression modeling
- Building interactive dashboards (Power BI / Tableau)

---

## 🔗 Related Projects

- [Jupyter Notebook Analysis](../Notebook/CerealRatingAnalysis.ipynb)
- [Power BI Dashboard](../Dashboard/Cereal_Rating_Dashboard.pbix)

---

## 📝 Author

**Noah Asgodom**  
Data Analyst Portfolio Project

---

