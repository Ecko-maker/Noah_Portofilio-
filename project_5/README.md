# 📂 reports

Written summary reports for the COVID-19 Analysis & Forecasting project.

---

## Purpose

This folder holds narrative deliverables — executive summaries, findings write-ups, and methodology notes — that make the project accessible to non-technical stakeholders alongside the notebooks and dashboard.

---

## Suggested Files to Add

| File | Audience | Content |
|------|---------|---------|
| `executive_summary.md` | Non-technical | 1-page findings summary with key numbers |
| `sql_findings.md` | Analysts | Summary of every SQL query's key output |
| `forecasting_report.md` | Technical | Model selection rationale and performance comparison |

---

## Key Numbers to Include in Any Report

### SQL Track
- Global case fatality rate: **2.11%**
- Global total confirmed cases: **150,574,977**
- Highest death continent: **Europe (~1,000,000 deaths)**
- Highest infection rate country: varies by wave — see Tableau dashboard
- Vaccination view created: `dbo.PercentPopulationVaccinated`

### Python Track
- Dataset: **1,143 days** of global daily new cases (Jan 2020 – Mar 2023)
- Train set: **~917 days** · Test set: **226 days** (chronological 80/20 split)
- Best model: **Linear Regression** — R² = 0.869, RMSE = 98,967, MAPE = 16.1%
- Seasonal-naive baseline: R² = 0.834, RMSE = 111,325
- Naive baseline: R² = −7.27 (collapses — cannot handle wave surges)
- Dominant signal: **weekly reporting cycle** captured by `lag_7` and `dayofweek`
- Top features: `lag_1`, `lag_7`, `rollmean_7`, `dayofweek`
