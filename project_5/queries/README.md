# 📂 queries

SQL Server scripts for COVID-19 global data exploration, vaccination analysis, and Tableau dashboard preparation.

**Engine:** SQL Server (SSMS)
**Database:** `PortfolioProject`
**Tables:** `CovidDeaths` · `CovidVaccinations`
**View created:** `PercentPopulationVaccinated`

---

## Files

| File | Queries | Size | Description |
|------|---------|------|-------------|
| `COVID Portfolio Project - Data Exploration.sql` | 12 | 5.1 KB | Fully annotated exploration — recommended starting point |
| `Tableau Portfolio Project SQL Queries.sql` | 7 | 5.3 KB | Full Tableau query suite including extras |
| `SQLQuery1.sql` | 15+ | 6.4 KB | Extended analysis — CTEs, Temp Tables, Views |
| `SQLQuery3.sql` | 4 | 1.8 KB | Tableau dashboard data (4 core queries) |
| `SQLQuery2.sql` | 1 | 260 B | View query — SELECT from `PercentPopulationVaccinated` |

---

## Recommended Run Order

```
1. COVID Portfolio Project - Data Exploration.sql   ← Start here
2. SQLQuery1.sql                                    ← Full analysis + create View
3. SQLQuery2.sql                                    ← Query the created View
4. SQLQuery3.sql                                    ← Tableau prep (4 queries)
   OR
   Tableau Portfolio Project SQL Queries.sql        ← Full Tableau suite
```

---

## `COVID Portfolio Project - Data Exploration.sql`

The primary, fully commented exploration script. Best for portfolio review.

**Header comment in file:**
> *"Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types"*

### Query Breakdown

| # | Query Description | SQL Technique |
|---|------------------|---------------|
| 1 | Select all base columns from CovidDeaths | `SELECT *` + `WHERE continent IS NOT NULL` |
| 2 | Starting data — location, date, cases, deaths | `SELECT` specific columns |
| 3 | Total cases vs total deaths (US) | `(total_deaths/total_cases)*100` — death likelihood |
| 4 | Total cases vs population (all countries) | `(total_cases/population)*100` — infection rate |
| 5 | Countries with highest infection rate | `MAX + GROUP BY + ORDER BY DESC` |
| 6 | Countries with highest death count | `MAX(CAST AS INT) + GROUP BY` |
| 7 | Continents with highest death count | `GROUP BY continent` |
| 8 | Global total numbers (all time) | `SUM(new_cases)`, `SUM(new_deaths)`, death % |
| 9 | Population vs vaccinations with rolling total | `JOIN` + `SUM OVER (PARTITION BY)` |
| 10 | CTE — rolling vaccination % | `WITH PopvsVac AS (...)` |
| 11 | Temp Table — rolling vaccination % | `DROP TABLE IF EXISTS #...` + `CREATE TABLE #...` + `INSERT INTO` |
| 12 | CREATE VIEW for Tableau | `CREATE VIEW PercentPopulationVaccinated AS ...` |

---

## `SQLQuery1.sql` — Extended Analysis

Adds queries not in the original exploration script, plus the full CTE, Temp Table, and View sections adapted for the `PortfolioProfile` database.

**Additional queries:**
- Death percentage for US using `total_cases_per_million`
- Total deaths by location using `SUM(CAST AS FLOAT)`
- Death rate per population using `MAX / NULLIF(MAX, 0)` (division-safe)
- Top 10 highest death countries using `OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY`
- Global daily numbers grouped by date
- Full `DROP VIEW` + `CREATE VIEW` with `USE master; GO` pattern for clean re-creation

---

## `Tableau Portfolio Project SQL Queries.sql` — Full Tableau Suite

7 queries used to generate the four Tableau dashboard views plus three supplementary queries.

### Core Tableau Queries (4)

| # | Output | Dashboard Visual |
|---|--------|-----------------|
| 1 | `total_cases`, `total_deaths`, `DeathPercentage` | Global numbers KPI table |
| 2 | `location`, `TotalDeathCount` by continent (excl. World, EU, International) | Total Death Per Continent bar chart |
| 3 | `Location`, `Population`, `HighestInfectionCount`, `PercentPopulationInfected` | % Population Infected choropleth map |
| 4 | Same as #3 with `date` added | % Population Infected over time line chart |

### Supplementary Queries (excluded from final dashboard)

| # | Query | Notes |
|---|-------|-------|
| 5 | `Location`, `date`, `population`, `total_cases`, `total_deaths` | Raw country data with date |
| 6 | CTE — `PopvsVac` rolling vaccination % | `(RollingPeopleVaccinated/Population)*100` |
| 7 | `Location`, `Population`, `date`, `HighestInfectionCount`, `PercentPopulationInfected` | Duplicate of Query 4 variant |

---

## `SQLQuery3.sql` — Concise Tableau Queries

A cleaner version of the 4 core Tableau queries adapted for the `PortfolioProfile` database — identical business logic, slightly different `CAST` approach using `FLOAT` instead of `INT`.

---

## `SQLQuery2.sql` — View Query

A single SSMS-generated `SELECT TOP 1000` query reading from the `PercentPopulationVaccinated` view created in `SQLQuery1.sql`.

```sql
SELECT TOP (1000)
    [continent], [location], [date],
    [population], [new_vaccinations], [RollingPeopleVaccinated]
FROM [PortfolioProfile].[dbo].[PercentPopulationVaccinated]
```

---

## SQL Skills Demonstrated

| Skill | Where Used |
|-------|-----------|
| `INNER JOIN` | Joining CovidDeaths + CovidVaccinations on location + date |
| `CTE (WITH clause)` | `WITH PopvsVac AS (...)` rolling vaccination % |
| `Temp Tables` | `CREATE TABLE #PercentPopulationVaccinated` → `INSERT INTO` → `SELECT` |
| `Window Functions` | `SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.date)` |
| `Aggregate Functions` | `SUM`, `MAX`, `COUNT` |
| `CAST / CONVERT` | Converting `nvarchar` vaccination values to `INT` for arithmetic |
| `NULLIF` | `NULLIF(SUM(new_cases), 0)` — prevents divide-by-zero |
| `CREATE VIEW` | `CREATE VIEW PercentPopulationVaccinated AS ...` |
| `Conditional WHERE` | `WHERE continent IS NOT NULL` to exclude aggregate rows |
| `LIKE` | `WHERE location LIKE '%states%'` for US filtering |
| `ORDER BY` with `OFFSET FETCH` | Top 10 pagination pattern |

---

## Setup — How to Run

```sql
-- Step 1: Create database
CREATE DATABASE PortfolioProject;

-- Step 2: Import both files using SSMS Import Wizard
--   Tasks → Import Data → Excel source
--   CovidDeaths.xlsx      → table: CovidDeaths
--   covidvaccination.xlsx → table: CovidVaccinations

-- Step 3: Run exploration
-- File: COVID Portfolio Project - Data Exploration.sql

-- Step 4: Run extended analysis + create view
-- File: SQLQuery1.sql

-- Step 5: Verify view was created
-- File: SQLQuery2.sql

-- Step 6: Export data for Tableau
-- File: SQLQuery3.sql  OR  Tableau Portfolio Project SQL Queries.sql
```
