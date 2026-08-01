## 📊 Charts & Visualizations Explained

### Jupyter Notebook (EDA)

- **Summary Statistics Tables**: Compared data before and after handling missing values and outliers.
- **Calories vs Rating Scatter Plot**: Demonstrates a clear negative trend — higher calories = lower ratings.
- **Shelf vs Calories Heatmap**: Shows how calorie content varies across shelf positions.
- **Correlation Analysis**: Identified `sugars` (-0.77), `protein` (+0.47), and `fat` (-0.42) as the strongest predictors.
- **Statistical Tests**: Chi-square (Shelf vs Calories) and ANOVA (Manufacturer vs Rating).
- **Linear Regression Model**: Achieved R² = 0.789 using protein, fat, and sugars.

### Power BI Interactive Dashboard

The dashboard provides business-friendly visuals including:
- KPI summary cards
- Interactive scatter plots for key nutrients vs rating
- Manufacturer performance comparison
- Full correlation heatmap
- Shelf position insights

# 📂 visuals

Exported chart PNGs from the Cereal Rating Analysis notebook.

---

## Files

| File | Section | Description |
|------|---------|-------------|
| `boxplot_type_vs_rating.png` | Q8 | Side-by-side boxplot — Cold vs Hot cereal ratings |
| `heatmap_nutrient_correlation.png` | Q9 | Pearson correlation heatmap — sugars, calories, carbo, fat |
| `pairplot_sugars_calories_carbo_fat.png` | Q9 | Pairplot of four nutrient relationships |
| `scatterplot_calories_vs_rating.png` | Q11 | Mean rating per calorie level — negative trend |
| `heatmap_shelf_vs_calories.png` | Q12 | Chi-Square contingency heatmap — shelf × calories |

---

## How to Export from Notebook

After running each visualisation cell in `CerealRatingAnalysis.ipynb`, save with:

```python
plt.savefig('../visuals/chart_name.png', bbox_inches='tight', dpi=130)
```

---

## Usage

These PNGs are referenced directly in the main README and can be embedded in GitHub as portfolio screenshots.
