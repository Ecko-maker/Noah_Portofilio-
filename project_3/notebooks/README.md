# Cereal Rating Analysis - Jupyter Notebook

**Project 3**  
**Author:** Noah Asgodom  
**Last Updated:** January 28, 2025

## 📋 Project Overview

This Jupyter Notebook contains a complete **Exploratory Data Analysis (EDA)** and **Predictive Modeling** on the Cereals dataset. The goal is to understand nutritional factors that influence cereal health ratings and build a machine learning model to predict ratings.

---

## 🗂️ Dataset Information

- **File**: `Cereals.xlsx`
- **Records**: 77 cereals
- **Features**: 16 columns

### Key Variables
- **Target**: `rating` (health rating out of 100)
- **Nutrition**: `calories`, `protein`, `fat`, `sodium`, `fiber`, `carbo`, `sugars`, `potass`, `vitamins`
- **Categorical**: `mfr` (manufacturer), `type` (cold/hot), `shelf`
- **Others**: `name`, `weight`, `cups`

---

## 🔧 Methodology

### Data Preprocessing
- Replaced missing values (`-1`) with column means
- Detected and treated outliers using **IQR method** (replaced with median)

### Analysis Performed
- 5-number summary before & after cleaning
- Correlation analysis
- Hypothesis testing:
  - Chi-square test (Shelf vs Calories)
  - ANOVA test (Manufacturer vs Rating)
- Linear Regression model using top 3 predictors (`protein`, `fat`, `sugars`)

---

## 📊 Key Insights

- **Sugars** has the strongest negative correlation with rating (**-0.77**)
- **Protein** shows moderate positive correlation (**+0.47**)
- Higher calories are associated with lower ratings
- Significant differences exist in ratings across manufacturers (ANOVA F = 5.89)
- Linear Regression model achieved **R² = 0.789** (78.9% variance explained)

---

## 🛠️ How to Run

```bash
# Clone the repository
git clone <your-repo-url>

# Install dependencies
pip install -r requirements.txt

# Launch Jupyter Notebook
jupyter notebook CerealRatingAnalysis.ipynb
