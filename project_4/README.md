# 📚 Library Management System — Relational Database & Financial Analytics

![MySQL](https://img.shields.io/badge/MySQL-Database-4479A1?logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![ERD](https://img.shields.io/badge/ERD-Star%20Schema-6C757D)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

> A fully normalised relational database (3NF) and dimensional Star Schema for a Library Management System — designed to address low fine collection efficiency and limited borrowing trend visibility, delivered as an interactive Power BI financial analytics dashboard.

---

## 🎯 Project Objective

The Library Management System (LMS) lacked actionable financial and operational intelligence:
- Fine collection processes were inefficient with no visibility into collection rates
- Transactional data was designed for record-keeping, not analysis
- No time hierarchy existed for trend-based reporting
- Status values were inconsistent across tables

This project designs and implements a complete SQL database, populates it with realistic data, and connects it to Power BI for executive-level KPI reporting.

---

## 🏗️ Project Architecture

```
Database Design (3NF + Star Schema)
        │
        ▼
┌─────────────────────────────────┐
│  MySQL Database                 │
│  ─────────────────────────────  │
│  • 7 interconnected tables      │
│  • Primary & foreign keys       │
│  • Referential integrity        │
│  • 20+ records per dim table    │
│  • 50+ loan transactions        │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│  SQL Analysis (10+ queries)     │
│  ─────────────────────────────  │
│  • DDL + DML                    │
│  • INNER / LEFT / RIGHT JOIN    │
│  • FULL OUTER JOIN (emulated)   │
│  • Subqueries + correlated      │
│  • Aggregations + GROUP BY      │
│  • Star schema fact table query │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│  Power BI Dashboard             │
│  ─────────────────────────────  │
│  • Collection Rate (%) KPI      │
│  • Outstanding Fines KPI        │
│  • Monthly loan trend           │
│  • Genre & member slicers       │
│  • Fine collection analysis     │
└─────────────────────────────────┘
```

---

## 🗂️ Folder Structure

```
project_4_library_management/
│
├── sql/
│   ├── Library-Managment-system.sql    ← V1: Initial schema + seed data
│   └── Library_Managment_system1.sql   ← V2: Final schema + 10 analytical queries
│
├── erd/
│   ├── Capstone01_Noah_Asgodom.mwb     ← MySQL Workbench ERD (final)
│   └── 1EER_Diagram.mwb.bak            ← ERD backup
│
├── dashboard/
│   └── Library_Managment_PowerBI.pbix  ← Power BI file
│
├── docs/
│   ├── Capstone03_Noah_Asgodom.docx    ← Full project report
│   ├── Project_Summary_Report.docx     ← Executive summary
│   ├── Quiriey_Documentation.docx      ← SQL query documentation
│   └── Project_Summary_Rubric.pdf      ← Assessment rubric
│
└── README.md                           ← You are here
```

---

## 🗄️ Database Schema

### Tables (7 total — Star Schema)

| Table | Type | Records | Description |
|-------|------|---------|-------------|
| `Members` | Dimension | 20+ | Member demographics + membership level |
| `Books` | Dimension | 20+ | Book inventory with ISBN, price, shelf location |
| `Authors` | Dimension | 20 | Author name, nationality, status |
| `Genres` | Dimension | 10 | Genre classification + category codes |
| `Staff` | Dimension | 20+ | Staff role, department, hire date |
| `Fines` | Fact | 50+ | Fine amount, paid status, loan reference |
| `Loans` | Fact (Central) | 50+ | Loan date, due date, return date — links all dims |

### Entity Relationships

```
Authors ──(1:N)──► Books ──(1:N)──► Loans ◄──(1:N)── Members
                     │                 │
Genres ──(1:N)───────┘         Fines (1:1)
                                      │
Staff ──(1:N)────────────────────────►┘
```

### Key Design Decisions

- **3NF Normalisation** — eliminates redundancy, ensures data integrity
- **Star Schema** — central `Loans` fact table with 6 surrounding dimension tables optimised for Power BI analytical queries
- **Referential Integrity** — all foreign keys enforced; CASCADE not used to preserve audit trails
- **Date Hierarchy** — separate `Calendar` dimension added to enable time intelligence in Power BI (YoY, MoM trends)

---

## 🗄️ SQL Files

### `Library-Managment-system.sql` — Version 1 (Initial Build)

Initial schema design and data population. Includes:
- `CREATE TABLE` statements for all 7 tables
- `INSERT` statements with 20 authors, 10 genres, 20+ members, 20+ books, 50+ loans, 50+ fines
- `ALTER TABLE` statements for schema evolution
- Basic `SELECT` queries for verification

### `Library_Managment_system1.sql` — Version 2 (Final Production)

Refined schema with analytical query suite. Includes all V1 content plus:

#### SQL Queries (10 Documented)

| # | Query Type | Business Purpose |
|---|-----------|-----------------|
| 1 | Data Quality Check | Detect duplicate ISBN values |
| 2 | DML — DELETE | Remove duplicate book records (keep lowest ID) |
| 3 | LEFT JOIN | Show all members including those with no loans |
| 4 | RIGHT JOIN | Ensure all loan records match a valid member |
| 5 | FULL OUTER JOIN (emulated) | Audit — surface any unmatched records on either side |
| 6 | Aggregate (AVG) | Calculate average fine amount for financial reporting |
| 7 | Correlated Subquery | Identify members who borrowed above the average |
| 8 | Subquery | Find the most frequently borrowed book |
| 9 | Multi-table Star Schema JOIN | Build the Power BI fact table (all 7 tables joined) |
| 10 | ALTER TABLE | Add/modify columns with correct data types |

#### Key Query — Star Schema Fact Table (Query 9)

```sql
SELECT
    L.Id AS LoanKey,       L.LoanDate,          L.ReturnDate,     L.DueDate,
    M.Id AS MemberKey,     M.Name AS MemberName, M.City,          M.MembershipLevel,
    B.Id AS BookKey,       B.Title AS BookTitle,  B.Price,
    A.AuthorName,
    G.Name AS GenreName,
    S.Name AS StaffName,
    F.Amount AS FineAmount,              F.PaidStatus,
    DATEDIFF(L.ReturnDate, L.DueDate)   AS DaysOverdue
FROM Loans L
LEFT JOIN Members M ON L.MemberId = M.Id
LEFT JOIN Books   B ON L.BookId   = B.Id
LEFT JOIN Authors A ON B.AuthorId = A.Id
LEFT JOIN Genres  G ON B.GenreId  = G.Id
LEFT JOIN Staff   S ON L.StaffId  = S.Id
LEFT JOIN Fines   F ON L.Id       = F.LoanId
ORDER BY L.LoanDate DESC;
```

---

## 📊 Power BI Dashboard

**File:** `dashboard/Library_Managment_PowerBI.pbix`

### Connection Method
Power BI connected to MySQL via ODBC. Data imported, cleaned in Power Query, and modelled using relationships aligned to the Star Schema.

### KPI Cards

| KPI | Description |
|-----|-------------|
| **Collection Rate (%)** | % of total fines that have been paid |
| **Outstanding Fines** | Total unpaid fine balance in dollars |
| **Total Loans** | Count of all loan transactions |
| **YoY Loan Change** | Year-over-year % change in borrowing activity |

### Visuals (5+)

| Visual | Type | Insight |
|--------|------|---------|
| Fine collection by month | Area chart | Seasonal collection patterns |
| Outstanding fines by member | Bar chart | Identifies high-risk members |
| Loan volume trend | Line chart | Monthly borrowing trends |
| Genre popularity | Donut chart | Most borrowed genre categories |
| Member tier breakdown | Table | Membership level vs fine rates |

### Slicers
- Date range (year / month)
- Genre
- Membership level
- Staff member
- Fine paid status

### Key Dashboard Insights
- A small subset of members accounts for the majority of outstanding fines — enables targeted collection campaigns
- Loan volume peaks seasonally — supports proactive staffing and inventory purchasing decisions
- Collection Rate KPI provides immediate visibility into fine recovery efficiency

---

## 📈 Key Findings & Recommendations

### Financial Performance
- **Fine collection efficiency** is the primary revenue risk — the dashboard surfaces members with the highest outstanding balances for direct follow-up.
- **Average fine amount** should be benchmarked quarterly — rising averages indicate increasing overdue violations.
- **Collection Rate (%)** should be tracked as the primary KPI for library administration, not raw fine amounts.

### Operational Insights
- **Most borrowed book** can be identified via the correlated subquery — use this for acquisition planning and duplicate purchase decisions.
- **Above-average borrowers** identified by correlated subquery are high-engagement members — target for premium membership upgrades.
- **Inactive members** (identified via LEFT JOIN) represent a re-engagement opportunity.

### Future Enhancements
- Predictive analytics for loan demand forecasting using historical borrowing trends
- Advanced member segmentation using DAX measures in Power BI
- Real-time overdue fine notification integration
- Fine aging analysis to track how long outstanding fines remain uncollected
- Live Power BI connection to MySQL server for real-time dashboard refresh

---

## ⚙️ Setup & How to Run

### Prerequisites
- MySQL 8.0+ or MySQL Workbench
- Power BI Desktop (free — [download](https://powerbi.microsoft.com/desktop/))
- ODBC connector for MySQL

### Step 1 — Run the SQL Script

```sql
-- In MySQL Workbench or any MySQL client:
-- Run the full script:
SOURCE sql/Library_Managment_system1.sql;

-- Verify database created:
SHOW DATABASES;
USE LibraryDB;
SHOW TABLES;
```

### Step 2 — Open the ERD

Open `erd/Capstone01_Noah_Asgodom.mwb` in MySQL Workbench to view the full Entity Relationship Diagram.

### Step 3 — Connect Power BI

1. Open `dashboard/Library_Managment_PowerBI.pbix` in Power BI Desktop
2. Go to **Transform Data → Data Source Settings**
3. Update the ODBC connection to point to your local MySQL `LibraryDB`
4. Click **Refresh**

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| MySQL 8.0 | Relational database engine |
| MySQL Workbench | Schema design, ERD, query execution |
| SQL | DDL, DML, JOINs, subqueries, aggregations |
| Power BI Desktop | Dashboard, KPIs, DAX measures |
| Power Query | Data cleaning and type transformation |
| ODBC Connector | MySQL → Power BI live connection |

---

## 📄 Documentation

| File | Description |
|------|-------------|
| `docs/Capstone03_Noah_Asgodom.docx` | Full project report with ERD, query explanations, and analysis |
| `docs/Project_Summary_Report.docx` | Executive summary of findings and deliverables |
| `docs/Quiriey_Documentation.docx` | Detailed SQL query documentation with business purpose for each query |
| `docs/Project_Summary_Rubric.pdf` | Original assessment rubric |

---

## 👤 Author

**Noah Asgodom** · CIS 203 — Relational Database Capstone
📧 your.email@example.com
🔗 [LinkedIn](https://linkedin.com/in/yourprofile) | [Portfolio](https://github.com/your-username)

---

## 📄 License

[MIT License](LICENSE)
