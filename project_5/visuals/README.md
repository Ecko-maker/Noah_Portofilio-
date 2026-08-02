# 📂 visuals

Tableau dashboard files and exported images for the COVID-19 project.

---

## Files

| File | Size | Format | Description |
|------|------|--------|-------------|
| `Covid Dashboard.twbx` | 592 KB | Tableau Packaged Workbook | Interactive dashboard — data embedded inside |
| `Dashboard 1.png` | 218 KB | PNG screenshot | Dashboard preview for GitHub README |
| `Dashboard 1.svg` | 1.9 MB | SVG vector | High-resolution scalable export |

---

## `Covid Dashboard.twbx` — Tableau Dashboard

A `.twbx` (packaged workbook) includes the data inside the file itself. No external database connection is needed to view or interact with it.

### Dashboard Visuals

| Visual | Type | Data Source | Insight Delivered |
|--------|------|-------------|------------------|
| **Global Numbers** | Text/KPI table | `SQLQuery3.sql` — Query 1 | Death % = 2.11%, Total Cases = 150,574,977 |
| **Total Death Per Continent** | Horizontal bar chart | `SQLQuery3.sql` — Query 2 | Europe ~1M, North America ~850K, South America ~700K |
| **% Population Infected Per Country** | World choropleth map | `SQLQuery3.sql` — Query 3 | Colour intensity = infection rate (0 → 0.008653) |
| **% Population Infected Over Time** | Multi-line time-series | `SQLQuery3.sql` — Query 4 | India peak 0.9516, UK sustained at 0.0258 |

### Filters / Slicers Available

- **Location** — filter by country (multi-select)
- **Continent** — filter by continent (Europe, North America, South America, Asia, Africa, Oceania)
- **Date** — filter by week of date on the time-series chart

### Key Findings from the Dashboard

- **Global death percentage: 2.11%** across 150,574,977 confirmed cases
- **Europe recorded the highest total deaths** (~1 million), exceeding North America despite comparable case numbers — driven by an older average population age
- **India** showed the highest peak average percentage population infected on the time-series chart (0.9516 during the Delta wave)
- **United Kingdom** maintained a persistently elevated infection percentage (0.0258) across multiple waves, reflecting high testing rates and reporting thoroughness
- **Africa and Oceania** have the lowest reported totals — likely reflects testing infrastructure and under-reporting rather than true low burden
- The **choropleth map** colour scale (0.000000 → 0.008653) reveals that very few countries exceeded 0.5% total population infected in the data window — most of Europe sits in the 0.001–0.003 range

---

## How to Open the Tableau File

**Option A — Tableau Desktop (paid)**
```
File → Open → visuals/Covid Dashboard.twbx
```

**Option B — Tableau Public (free)**
```
1. Download Tableau Public: https://public.tableau.com/app/discover
2. File → Open → visuals/Covid Dashboard.twbx
3. Optional: publish to your Tableau Public profile for a shareable URL
```

---

## Python Chart Exports (Add Here)

Save all Python notebook charts to this folder using:

```python
plt.savefig('../visuals/chart_name.png', bbox_inches='tight', dpi=130)
```

| Suggested Filename | Notebook | Section |
|-------------------|----------|---------|
| `eda_01_timeseries.png` | `01_eda.ipynb` | Section 1 |
| `eda_02_distribution.png` | `01_eda.ipynb` | Section 2 |
| `eda_03_rolling_mean.png` | `01_eda.ipynb` | Section 3 |
| `eda_04_stl_decomposition.png` | `01_eda.ipynb` | Section 4 |
| `eda_05_seasonal_profile.png` | `01_eda.ipynb` | Section 5 |
| `eda_06_acf.png` | `01_eda.ipynb` | Section 6 |
| `model_rmse_comparison.png` | `03_model_building.ipynb` | Section 2 |
| `model_forecast_vs_actual.png` | `03_model_building.ipynb` | Section 3 |
| `model_feature_importance.png` | `03_model_building.ipynb` | Section 4 |
