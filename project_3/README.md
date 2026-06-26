
```markdown
# Cereal Rating Analysis | Project 3

**Exploratory Data Analysis & Interactive Power BI Dashboard**

![Dashboard Preview](Screenshots/dashboard_full.png)

---

## 📋 Project Overview

This project analyzes a dataset of **77 breakfast cereals** to uncover the key nutritional factors that influence their health ratings. The analysis combines rigorous data cleaning, statistical testing, visualization, and predictive modeling, complemented by an interactive **Power BI dashboard**.

**Objective**: Identify what makes a cereal "healthy" according to its rating and provide actionable insights for product development and manufacturers.

---

## 🗂️ Repository Structure

```bash
Cereal-Rating-Analysis/
├── Notebook/                          # Jupyter Notebook Analysis
│   ├── CerealRatingAnalysis.ipynb
│   └── requirements.txt
│
├── Dashboard/                         # Power BI Dashboard
│   ├── Cereal_Rating_Dashboard.pbix
│   └── README.md
│
├── Data/
│   └── Raw/
│       └── Cereals.xlsx
│
├── Screenshots/                       # Visual documentation
│   ├── dashboard_full.png
│   ├── sugars_vs_rating.png
│   └── manufacturer_analysis.png
│
└── README.md                          # This file
```

---

## 🔍 Key Insights (Final Report Summary)

### 1. Data Quality & Preprocessing
- Missing values (`-1`) were replaced with column means.
- Outliers were treated using the IQR method and replaced with medians.
- Data is now realistic and ready for analysis.

### 2. Nutritional Drivers of Cereal Rating
| Nutrient     | Correlation with Rating | Impact          |
|--------------|-------------------------|-----------------|
| Sugars       | **-0.77**               | Very Strong Negative |
| Protein      | **+0.47**               | Moderate Positive |
| Fat          | **-0.42**               | Moderate Negative |
| Fiber        | **+0.34**               | Positive        |

### 3. Other Important Findings
- **Calories** show a clear negative relationship with rating.
- Significant differences exist between **manufacturers** (ANOVA F-statistic = 5.89).
- Shelf position has a weak association with calorie content.

### 4. Predictive Model
- **Model**: Linear Regression
- **Features**: `protein`, `fat`, `sugars`
- **Performance**: **R² = 0.789** (78.9% of variance explained)
- Conclusion: These three nutrients alone are strong predictors of cereal health rating.

---

## 📊 Power BI Dashboard

An interactive dashboard was built to make insights accessible to non-technical stakeholders.

**Dashboard Highlights**:
- KPI summary cards
- Interactive scatter plots (Sugars, Protein, Calories vs Rating)
- Manufacturer performance comparison
- Nutrient correlation heatmap
- Shelf position analysis

→ See full dashboard in the [`Dashboard/`](Dashboard/) folder.

---

## 💡 Final Recommendations

1. **Prioritize Sugar Reduction** — The most effective way to boost cereal ratings.
2. **Increase Protein Content** — Strong positive driver of higher ratings.
3. **Balance Calories and Fiber** — Lower calorie + higher fiber cereals perform better.
4. **Manufacturer Strategy** — Brands with lower average ratings should reformulate high-sugar products.
5. **Use the Model** — Predict potential ratings for new cereal formulations before launch.

---

## 🛠️ Technologies Used

- **Python**: Pandas, NumPy, Seaborn, Matplotlib, SciPy, scikit-learn
- **Power BI**: Interactive visualizations and dashboard
- **Statistical Tests**: Chi-square, ANOVA, Pearson Correlation

---

## 🚀 How to Explore This Project

1. **Notebook Analysis**: Open `Notebook/CerealRatingAnalysis.ipynb`
2. **Interactive Dashboard**: Open `Dashboard/Cereal_Rating_Dashboard.pbix` in Power BI Desktop
3. **Quick View**: Check the `Screenshots/` folder

---

## ✍️ Author

**Noah Asgodom**  
Data Analyst | Aspiring Data Scientist

- **LinkedIn**: [Your Profile](https://linkedin.com/in/yourprofile)
- **Portfolio**: [Your Website](https://yourportfolio.com)

---

⭐ **If you found this project useful, please star the repository!**

---
