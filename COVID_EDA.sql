USE PROJECT1;

select * from cov_deaths;
select * from cov_vaccine;



select location ,DATE,population,total_cases,total_deaths
from cov_deaths
order by DATE;



-- data for total cases vs total deaths

select location ,DATE,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_perc
from cov_deaths
order by 1,2;

--data for total cases vs total deaths for country india
--death_perc shows likelihood of dying if you contact covid
select location ,DATE,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_perc
from cov_deaths
where location = 'india'
order by 1,2;


-- data for total cases vs population
--covid_perc shows % of population who got covid
select location ,DATE,total_cases,population,(total_cases/population)*100 as covid_perc
from cov_deaths
where location = 'india'
order by 1,2;

--countries having highest infection rate

select location ,population,max(total_cases)as highest_infected,(max(total_cases/population))*100 as perc_infected
from cov_deaths
group by location,population
order by perc_infected desc;

--countries with highest deaths
--altering nvarchar d-type into int for toatal_death
alter table cov_deaths
alter column total_deaths int;


select location ,MAX(total_deaths) as death_counts
from cov_deaths
where continent is not null
group by location
order by death_counts desc;

--continent vise deaths
select continent ,MAX(total_deaths) as death_counts
from cov_deaths
where continent is not null
group by continent
order by death_counts desc;


--Fetching details globally on each date
select DATE,sum(new_cases) as total_cases,sum(cast(new_deaths as int))as total_deaths,sum(cast(new_deaths as int))/sum(new_cases)*100 as death_perc
from cov_deaths
where continent is not null
group by DATE
order by 1,2;


--global death percentage
--casting nvarchar d-type into int for total deaths
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From cov_deaths
where continent is not null 
order by 1,2



--joinning covid_death and covid_vaccine table

select *
from cov_deaths as dea
join  cov_vaccine as vac
on dea.location = vac.location
and dea.date=vac.date;


--Looking for total vaccinated people

select dea.continent,dea.location,dea.date,dea.population,vac.total_tests,vac.people_vaccinated
--SUM(convert(int,vac.new_vaccinations)) over(partition by dea.location order by dea.location , dea.date)
from cov_deaths as dea
join  cov_vaccine as vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null
order by 1,2;








-- Using CTE to perform Calculation on Partition By in previous query


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From cov_deaths dea
Join cov_vaccine vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

