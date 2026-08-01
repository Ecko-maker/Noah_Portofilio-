# 📂 sql

SQL scripts for the Library Management System database.

---

## Files

| File | Version | Description |
|------|---------|-------------|
| `Library-Managment-system.sql` | V1 — Initial | First schema build + seed data insertion |
| `Library_Managment_system1.sql` | V2 — Final | Refined schema + 10 analytical queries |

---

## V1 — `Library-Managment-system.sql`

The original schema creation script. Includes:

- `CREATE DATABASE LibraryDB`
- `CREATE TABLE` for: Authors, Genre, Books, Members, Staff, Loans, Fines
- `ALTER TABLE` to add columns (e.g. `Nationality` to Authors)
- `INSERT` sample data: 20 authors, 10 genres, 20 members, 20 books, 50+ loans

**Use this file to:** Understand the initial design decisions and data model evolution.

---

## V2 — `Library_Managment_system1.sql`

The production-ready script with a refined schema and full analytical query suite.

### Schema Improvements Over V1

| Change | Reason |
|--------|--------|
| Renamed table `Genre` → `Genres` | Consistency with plural naming convention |
| Added `City` column to `Members` | Enables geographic analysis in Power BI |
| Added `Price` column to `Books` | Required for financial KPI calculations |
| Added `StaffId` FK to `Loans` | Links staff to loan transactions for accountability |
| Standardised all column names | Consistent casing and naming across all tables |

### Queries Included (10)

```sql
-- Query 1: Detect duplicate ISBNs
SELECT Isbn, COUNT(*) AS DuplicateCount
FROM Books GROUP BY Isbn HAVING COUNT(*) > 1;

-- Query 2: Remove duplicate books (keep lowest ID)
DELETE b1 FROM Books b1
JOIN Books b2 ON b1.Isbn = b2.Isbn AND b1.Id > b2.Id;

-- Query 3: LEFT JOIN — all members + borrowing activity
SELECT M.Name, M.MembershipDate, L.LoanDate, L.ReturnDate
FROM Members M LEFT JOIN Loans L ON M.Id = L.MemberId;

-- Query 4: RIGHT JOIN — all loans matched to members
SELECT M.Name, L.Id AS LoanID, L.BookId
FROM Members M RIGHT JOIN Loans L ON M.Id = L.MemberId;

-- Query 5: FULL OUTER JOIN (emulated with UNION)
-- Returns every record from both Members and Loans

-- Query 6: Average fine amount
SELECT AVG(f.Amount) AS AverageFine FROM Fines f;

-- Query 7: Members with above-average borrowing (correlated subquery)
-- Identifies high-engagement members for re-engagement campaigns

-- Query 8: Most frequently borrowed book (subquery)
SELECT b.Id, b.Title FROM Books b
WHERE b.Id = (SELECT l.BookId FROM Loans l
              GROUP BY l.BookId ORDER BY COUNT(l.Id) DESC LIMIT 1);

-- Query 9: Star schema fact table — powers the Power BI dashboard
-- Joins all 7 tables into one analytical output row per loan

-- Query 10: ALTER TABLE — add/modify columns with correct data types
```

---

## How to Run

```bash
# In MySQL Workbench — run the full V2 script:
SOURCE Library_Managment_system1.sql;

# Verify:
SHOW TABLES;
SELECT COUNT(*) FROM Loans;
SELECT COUNT(*) FROM Members;
```
