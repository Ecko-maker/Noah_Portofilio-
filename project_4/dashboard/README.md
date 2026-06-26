# 📂 dashboard

Power BI dashboard file for the Library Management System.

---

## File

| File | Description |
|------|-------------|
| `Library_Managment_PowerBI.pbix` | Power BI Desktop file — fully functional dashboard |

---

## How to Open

1. Download [Power BI Desktop](https://powerbi.microsoft.com/desktop/) (free)
2. Open `Library_Managment_PowerBI.pbix`
3. Go to **Transform Data → Data Source Settings**
4. Update the ODBC connection to point to your local MySQL `LibraryDB`
5. Click **Refresh**

---

## Dashboard Pages

### Page 1 — Financial Performance

| Visual | Type | Metric |
|--------|------|--------|
| Collection Rate % | KPI Card | % of fines paid |
| Outstanding Fines | KPI Card | Total unpaid balance |
| Fine collection by month | Area chart | Monthly trend |
| Top members with outstanding fines | Bar chart | Individual balances |

### Page 2 — Operational Trends

| Visual | Type | Metric |
|--------|------|--------|
| Total Loans | KPI Card | Loan count |
| YoY Loan Change | KPI Card | % change vs prior year |
| Monthly loan volume | Line chart | Borrowing trend |
| Genre popularity | Donut chart | Most borrowed genres |

### Slicers Available
- Date range (year / month)
- Genre category
- Membership level (Standard / Premium / Student)
- Staff member
- Fine paid status (Paid / Unpaid)

---

## DAX Measures Used

```dax
-- Collection Rate
Collection Rate % =
DIVIDE(
    SUMX(Fines, IF(Fines[PaidStatus] = "Paid", Fines[Amount], 0)),
    SUM(Fines[Amount])
) * 100

-- Outstanding Fines
Outstanding Fines =
SUMX(Fines, IF(Fines[PaidStatus] = "Unpaid", Fines[Amount], 0))

-- Days Overdue Average
Avg Days Overdue =
AVERAGE(FactLoans[DaysOverdue])
```
