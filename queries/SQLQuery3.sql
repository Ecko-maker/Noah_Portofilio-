-- 1.
SELECT 
    SUM(CAST(new_cases AS FLOAT)) AS total_cases,
    SUM(CAST(new_deaths AS FLOAT)) AS total_deaths,
    SUM(CAST(new_deaths AS FLOAT)) * 100.0 
        / NULLIF(SUM(CAST(new_cases AS FLOAT)), 0) AS DeathPercentage
FROM PortfolioProfile..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY total_cases, total_deaths;

d -- Just a double check based off the data provided
-- numbers are extremely close so we will keep them - The Second includes "International" Location

I

-- Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as
DeathPercentage
-- From PortfolioProject .. CovidDeaths
---- Where location like '%states%'
-- where location = 'World'
---- Group By date
-- order by 1,2

-- 2.

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

SELECT 
    location, 
    SUM(CAST(new_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProfile..CovidDeaths
WHERE continent IS NULL
  AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- 3.

SELECT 
    Location,
    Population,
    MAX(CAST(new_cases AS FLOAT)) AS HighestInfectionCount,
    MAX(CAST(new_cases AS FLOAT)) 
        / NULLIF(Population, 0) AS PercentPopulationInfected
FROM PortfolioProfile..CovidDeaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC;

 -- 4
 Select Location, Population, date, MAX(new_cases) as HighestInfectionCount, Max((new_cases/population))*100 as PercentPopulationInfected
From PortfolioProfile..CovidDeaths
-- Where location like '%states'
Group by Location, Population, date
order by PercentPopulationInfected desc;