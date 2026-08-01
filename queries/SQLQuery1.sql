Select
*
From PortfolioProfile .. CovidDeaths
where continent is not null
order by 3,4

--Select
--*
--From PortfolioProfile .. Covidvaccination
--order by 3,4


Select Location, date, total_cases_per_million, new_cases, total_deaths, population
From PortfolioProfile .. CovidDeaths
order by 1,2

-- Looking at Total Cases vs Total Deaths

SELECT 
    Location, 
    date, 
    total_cases_per_million, 
    total_deaths
FROM PortfolioProfile..CovidDeaths
where continent is not null
ORDER BY 1,2;


SELECT 
    Location,
    date,
    total_cases_per_million,
    total_deaths,
    (total_deaths * 100.0 / NULLIF(total_cases_per_million, 0)) AS DeathPercentage
FROM PortfolioProfile..CovidDeaths
WHERE location LIKE '%states%'
ORDER BY 1,2;


-- Shows what is the total death per location 
SELECT 
    Location,
    SUM(CAST(total_deaths AS FLOAT)) AS TotalDeaths,
    MAX(CAST(population AS FLOAT)) AS Population
FROM PortfolioProfile..CovidDeaths
GROUP BY Location
ORDER BY TotalDeaths DESC;

Select Location, date, Population, total_deaths, (total_deaths/population)*100 as DeathPercentage
From PortfolioProfile .. CovidDeaths
-- Where location like '%states%'
order by 1,2

-- Looking at Countries with Highest death Rate per Population
SELECT 
    Location,
    MAX(CAST(population AS FLOAT)) AS Population,
    MAX(CAST(total_deaths AS FLOAT)) AS HighestDeathCount,
    MAX(CAST(total_deaths AS FLOAT)) * 100.0 
        / NULLIF(MAX(CAST(population AS FLOAT)), 0) AS PercentPopulationInfected
FROM PortfolioProfile..CovidDeaths
where continent is not null
GROUP BY Location
ORDER BY PercentPopulationInfected DESC;

-- Top 10 Highest death by location 
SELECT 
    Location,
    SUM(CAST(total_deaths AS FLOAT)) AS TotalDeaths
FROM PortfolioProfile..CovidDeaths
where continent is not null
GROUP BY Location
ORDER BY TotalDeaths DESC

-- Showing Countries with Highest Death Count per Population
Select Location, MAX(Total_deaths) as TotalDeathCount
From PortfolioProfile .. CovidDeaths
where continent is not null
Group by Location
order by TotalDeathCount desc
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

--Total death by Continent
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProfile .. CovidDeaths
Where continent is not null
Group by continent
order by TotalDeathCount desc

-- Showing contintents with the highest death count per population

SELECT 
    continent,
    MAX(CAST(total_deaths AS FLOAT)) AS TotalDeathCount
FROM PortfolioProfile..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- GLOBAL NUMBERS
SELECT 
    date,
    SUM(CAST(new_cases AS FLOAT)) AS TotalNewCases,
    SUM(CAST(total_deaths AS FLOAT)) AS TotalDeaths,
    SUM(CAST(total_deaths AS FLOAT)) * 100.0 
        / NULLIF(SUM(CAST(total_cases_per_million AS FLOAT)), 0) AS DeathPercentage
FROM PortfolioProfile..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

--Total cases in the world
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast
(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProfile .. CovidDeaths
where continent is not null
-- Group By date
order by 1,2

Select *
From PortfolioProfile .. CovidVaccination
--Joint
Select
*
From PortfolioProfile .. CovidDeaths dea
Join PortfolioProfile .. CovidVaccination vac
On dea.location = vac.location
and dea.date = vac.date

-- Looking at Total Population vs Vaccinations

Select dea. continent, dea. location, dea. date, dea. population, vac.new_vaccinations
From PortfolioProfile .. CovidDeaths dea
Join PortfolioProfile .. CovidVaccination vac
On dea. location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

Select dea. continent, dea. location, dea. date, dea. population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location, order by dea.location, dea.Date)
From PortfolioProfile .. CovidDeaths dea
Join PortfolioProfile .. CovidVaccination vac
On dea. location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3
-- CTE
WITH PopvsVac (Continent, Location, Date, Population, RollingPeopleVaccinated) AS
(
    SELECT 
        dea.continent,
        dea.location,
        dea.date,
        dea.population,
        SUM(CONVERT(INT, NULLIF(vac.new_vaccinations, ''))) 
            OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) 
            AS RollingPeopleVaccinated
    FROM PortfolioProfile..CovidDeaths dea
    JOIN PortfolioProfile..CovidVaccination vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT *,
       (RollingPeopleVaccinated * 100.0 / NULLIF(Population, 0)) AS PercentVaccinated
FROM PopvsVac;

--Temp Table

Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea. Location Order by dea.location,
dea. Date) as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
From PortfolioProfile .. CovidDeaths dea
Join PortfolioProfile .. CovidVaccination vac
On dea. location = vac.location
and dea.date = vac.date
where dea.continent is not null

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

-- Creating View to store for later Visualzation

USE PortfolioProfile;
GO

USE master;
GO
DROP VIEW dbo.PercentPopulationVaccinated;
GO

CREATE VIEW dbo.PercentPopulationVaccinated AS
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CONVERT(INT, NULLIF(vac.new_vaccinations, '')))
        OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)
        AS RollingPeopleVaccinated
FROM PortfolioProfile..CovidDeaths AS dea
JOIN PortfolioProfile..CovidVaccination AS vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
GO

SELECT *
FROM dbo.PercentPopulationVaccinated;

SELECT 
    v.name AS ViewName,
    s.name AS SchemaName,
    DB_NAME() AS DatabaseName
FROM sys.views v
JOIN sys.schemas s ON v.schema_id = s.schema_id
WHERE v.name = 'PercentPopulationVaccinated';

