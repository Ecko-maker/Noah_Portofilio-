# 📊 Nashville Housing Market — Power BI Dashboard

![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![Data Source](https://img.shields.io/badge/Data-Nashville%20Housing-0078D4)
![Python Pipeline](https://img.shields.io/badge/Pipeline-Python%20%2B%20DuckDB-3776AB?logo=python&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

> An interactive Power BI dashboard analysing 56,000+ Nashville housing transactions — surfacing sale price trends, geographic distribution, vacancy patterns, and assessed value relationships across the metro area.

---

## 📌 Project Overview

This dashboard transforms a cleaned Nashville Housing dataset (processed via a Python + DuckDB pipeline) into an interactive business intelligence report for real estate market analysis.

**Business questions answered:**

- How has the **average sale price trended** year-over-year across Nashville?
- Which **cities drive the most transactions** and the highest average prices?
- What share of properties were **sold as vacant** vs occupied?
- How does **assessed total value** relate to actual sale price by city?
- Where are properties **geographically concentrated** across the metro area?

---

## 🖥️ Dashboard Preview

![Nashville Housing Market Dashboard](visuals/dashboard_preview.png)

---

## 📐 Dashboard Layout & Visuals

### KPI Cards — Market Snapshot

| Metric | Value | Description |
|--------|-------|-------------|
| **Total Properties** | 56K | Total unique property transactions in the dataset |
| **Average Sale Price** | $327.52K | Mean sale price across all transactions |
| **Median Sale Price** | $205.70K | Median — less affected by luxury outliers |

> **Insight:** The gap between average ($327K) and median ($205K) confirms significant right-skew in the Nashville market — a small number of high-value luxury transactions pull the mean substantially above the typical sale. Analysts and buyers should use **median as the primary benchmark**, not average.

---

### 📈 Sale Price Trend Over Time

A line chart showing **average sale price by year** from 2013 to 2019.

> **Insight:** Nashville experienced a pronounced price peak around **2016**, followed by a correction through 2018–2019. This aligns with broader Mid-South real estate cycle patterns and rapid urban development in the metro core. The dip post-2016 likely reflects supply catching up with demand as new construction accelerated. YoY trend analysis is critical for timing investment decisions.

---

### 🥧 Sold As Vacant Distribution

A donut chart showing the split between properties sold as vacant vs occupied.

| Category | Count | Share |
|----------|-------|-------|
| **No** (Occupied) | 51.7K | **91.72%** |
| **Yes** (Vacant) | 4.67K | 8.28% |

> **Insight:** Over 91% of Nashville transactions involved **occupied properties**, indicating a healthy owner-occupier market with relatively low vacancy-driven distressed sales. The 8.28% vacant share is worth monitoring — vacancy rate spikes often precede price corrections in overbuilt sub-markets.

---

### 🔵 Total Value vs Sale Price (Scatter — by City)

A scatter plot comparing **assessed total value (x-axis) vs actual sale price (y-axis)**, colour-coded by city, filtered to Antioch and Bellevue in the preview.

> **Insight:** Both Antioch and Bellevue show properties clustering **below the parity line** — sale prices tend to be lower than assessed values in these areas, suggesting either assessment lag, declining sub-market demand, or higher distressed-sale volume. This ratio (`PriceToValue_Ratio`) is a powerful signal for investors identifying undervalued neighbourhoods.

---

### 🏙️ Average Sale Price by City (Horizontal Bar)

Top cities ranked by average sale price — Nashville, Brentwood, and Goodlettsville lead.

> **Insight:** **Nashville** holds the highest average sale price, reflecting its urban core premium, followed by **Brentwood** — a known high-income suburb. Notably, cities like **Nolensville** and **Mount Juliet** appear mid-table, positioning them as **growth opportunity markets**: lower entry prices with strong suburban demand trends driven by Nashville's urban sprawl.

---

### 📊 Total Properties by City (Bar Chart)

Transaction volume per city — Nashville dominates at nearly 50K transactions.

> **Insight:** Nashville accounts for the vast majority of transaction volume, making it the most **liquid and comparable** market segment. Suburbs like Antioch, Brentwood, and Madison have meaningful but much smaller volumes — price signals there carry more statistical uncertainty and should be interpreted with caution when fewer than 500 transactions exist per year.

---

### 🗺️ Properties by City (Map Visual)

A geographic map showing **property distribution** across the Nashville metro footprint, with `SoldAsVacant` breakdown as a legend overlay.

> **Insight:** The map confirms that Nashville properties are **geographically concentrated** in Davidson County with suburban spread into Williamson, Rutherford, and Wilson counties. Vacant-sold properties (yellow dots) do not cluster in a single area — they are distributed across the metro, suggesting vacancy is driven by property condition rather than neighbourhood-level decline.

---

## 🔗 Data Pipeline

This dashboard is powered by a **two-stage Python pipeline**:

```
Excel (raw) ──► DuckDB SQL Cleaning ──► Python EDA ──► Power BI CSV
```

| Stage | Tool | Output |
|-------|------|--------|
| Raw ingestion | Pandas `read_excel()` | DataFrame |
| SQL cleaning | DuckDB (Jupyter) | `nashville_housing_cleaned.parquet` |
| EDA & feature engineering | Python · Pandas · Seaborn | Charts + `nashville_housing_powerbi.csv` |
| Dashboard | Power BI Desktop | `.pbix` report |

---

## 🧮 DAX Measures Used

```dax
-- Median Sale Price
Median Sale Price = MEDIAN(nashville_housing_powerbi[SalePrice])

-- Average Sale Price
Average Sale Price = AVERAGE(nashville_housing_powerbi[SalePrice])

-- Total Properties
Total Properties = COUNTROWS(nashville_housing_powerbi)

-- Price to Value Ratio
Avg Price-to-Value = AVERAGE(nashville_housing_powerbi[PriceToValue_Ratio])

-- Vacant Rate %
Vacant Rate % =
DIVIDE(
    COUNTROWS(FILTER(nashville_housing_powerbi, nashville_housing_powerbi[SoldAsVacant] = "Yes")),
    COUNTROWS(nashville_housing_powerbi)
)
```

---

## 📁 Repository Structure

```
nashville-housing-powerbi/
│
├── data/
│   └── processed/
│       └── nashville_housing_powerbi.csv   ← Power BI data source
│
├── dashboard/
│   └── Nashville_Housing_Dashboard.pbix    ← Power BI file
│
├── visuals/
│   └── dashboard_preview.png              ← Dashboard screenshot
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   └── 02_eda.ipynb
│
└── README.md
```

---

## ⚙️ How to Open the Dashboard

1. Download [Power BI Desktop](https://powerbi.microsoft.com/desktop/) (free)
2. Clone this repository
3. Open `dashboard/Nashville_Housing_Dashboard.pbix`
4. If the data source path has changed, go to **Transform Data → Data Source Settings** and update the path to `data/processed/nashville_housing_powerbi.csv`
5. Click **Refresh** to reload data

---

## 🚀 Final Recommendations & Insights

### For Real Estate Investors
- **Nolensville and Mount Juliet** offer the strongest value opportunity — mid-table average prices with growing suburban demand as Nashville's urban core prices out buyers.
- Properties with `PriceToValue_Ratio < 0.85` represent potential below-market acquisitions worth investigating.
- **3-bedroom homes** dominate transaction volume — the most liquid inventory for buy-and-hold strategies.

### For Market Analysts
- Use **median, not mean**, as the headline price metric — the $121K gap between them reflects luxury distortion, not the typical buyer's experience.
- The 2016 price peak followed by correction suggests Nashville follows a **4–6 year price cycle**. The next upswing phase warrants monitoring from 2020 onward.
- Vacant property share (8.28%) remains healthy — a rate above 15% would signal systemic oversupply risk.

### For Data Stakeholders
- Enrich the dataset with **school district ratings** and **walkability scores** to explain residual price variance not captured by assessed value.
- Add a **time-intelligence page** in Power BI (rolling 12-month average, MoM % change) for executive reporting.
- Consider publishing the dashboard to **Power BI Service** for live refresh and shared access via browser.

---

## 🔗 Related Repositories

| Project | Description | Link |
|---------|-------------|------|
| Data Cleaning Pipeline | DuckDB + SQL in Jupyter | [nashville-housing-cleaning](https://github.com/your-username/nashville-housing-cleaning) |
| Python EDA | Pandas + Seaborn analysis | [nashville-housing-eda](https://github.com/your-username/nashville-housing-eda) |
| Power BI Dashboard | This repo | — |

---

## 👤 Author

**Your Name**
📧 your.email@example.com
🔗 [LinkedIn](https://linkedin.com/in/yourprofile) | [Portfolio](https://yourwebsite.com)

---

## 📄 License

[MIT License](LICENSE) — dataset sourced from public Nashville open data records.
