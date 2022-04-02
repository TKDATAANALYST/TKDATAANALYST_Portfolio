--For this project, I used Bank Marketing Dataset from Kaggle:
--https://www.kaggle.com/datasets/janiobachmann/bank-marketing-dataset
--It has one table only. I inserted the table into a database in SSMS and started working.

select *
from [Bank Marketing Dataset]

--Questions that I want to answer during this data exploration project:
--1. Percentage of people who are having loans right now, among bank customers. 0 false 1 true.
--2. Percentage of marital statuses among bank customers.
--3. Percentage of people and their job description.
--4. Finding the oldest bank customers.
--5. Percentage of people who are owning a house among bank customers.
--6. Finding the customers with the highest balance among bank customers.
--7. Finding if the overall balance of all bank customers is positive or negative, and how much it is.
--8. Finding the best month for getting new bank customers.
--9. Finding the average age among bank customers.

--First, I'll write code for all these then I'll gather further insights from the dataset.

--1. Percentage of people who are having loans right now, among bank customers.
select
(select count(loan) from [Bank Marketing Dataset] where loan=1) as HavingLoans,
(select count(*) from [Bank Marketing Dataset]) as TotalBankCustomers,
cast((select count(loan) from [Bank Marketing Dataset] where loan=1) as decimal(7,2))/(select count(*) from [Bank Marketing Dataset])*100 as LoanPercentage

--2. Percentage of marital statuses among bank customers.
select distinct marital from [Bank Marketing Dataset]
--After I found that there are 3 types of marital statuses - single, married and divorced, the required is the following:
select
(select count(marital) from [Bank Marketing Dataset] where marital='single') as TotalSingles,
cast((select count(marital) from [Bank Marketing Dataset] where marital='single') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as SinglesPercentage,
(select count(marital) from [Bank Marketing Dataset] where marital='divorced') as TotalDivorced,
cast((select count(marital) from [Bank Marketing Dataset] where marital='divorced') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as DivorcedPercentage,
(select count(marital) from [Bank Marketing Dataset] where marital='married') as TotalMarried,
cast((select count(marital) from [Bank Marketing Dataset] where marital='married') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as MarriedPercentage

--3. Percentage of people and their job description.
select distinct job from [Bank Marketing Dataset]
--12 types of jobs: technician, services, housemaid, retired, blue-collar, unknown,
--self-employed, student, unemployed, entrepreneur, admin and management.
--After I found that, the required is the following:
select
(select count(job) from [Bank Marketing Dataset] where job='technician') as TotalTechnician,
cast((select count(marital) from [Bank Marketing Dataset] where job='technician') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as TechnicianPercentage,
(select count(job) from [Bank Marketing Dataset] where job='services') as TotalServices,
cast((select count(marital) from [Bank Marketing Dataset] where job='services') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as ServicesPercentage,
(select count(job) from [Bank Marketing Dataset] where job='housemaid') as TotalHousemaid,
cast((select count(marital) from [Bank Marketing Dataset] where job='housemaid') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as HousemaidPercentage,
(select count(job) from [Bank Marketing Dataset] where job='retired') as TotalRetired,
cast((select count(marital) from [Bank Marketing Dataset] where job='retired') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as RetiredPercentage,
(select count(job) from [Bank Marketing Dataset] where job='blue-collar') as TotalBlueCollar,
cast((select count(marital) from [Bank Marketing Dataset] where job='blue-collar') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as BlueCollarPercentage,
(select count(job) from [Bank Marketing Dataset] where job='self-employed') as TotalSelfEmployed,
cast((select count(marital) from [Bank Marketing Dataset] where job='self-employed') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as SelfEmployedPercentage,
(select count(job) from [Bank Marketing Dataset] where job='student') as TotalStudents,
cast((select count(marital) from [Bank Marketing Dataset] where job='student') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as StudentPercentage,
(select count(job) from [Bank Marketing Dataset] where job='unemployed') as TotalUnemployed,
cast((select count(marital) from [Bank Marketing Dataset] where job='unemployed') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as UnemployedPercentage,
(select count(job) from [Bank Marketing Dataset] where job='entrepreneur') as TotalEntrepreneurs,
cast((select count(marital) from [Bank Marketing Dataset] where job='entrepreneur') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as EntrepreneurPercentage,
(select count(job) from [Bank Marketing Dataset] where job='admin.') as TotalAdmins,
cast((select count(marital) from [Bank Marketing Dataset] where job='admin.') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as AdminPercentage,
(select count(job) from [Bank Marketing Dataset] where job='management') as TotalManagement,
cast((select count(marital) from [Bank Marketing Dataset] where job='management') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as ManagementPercentage,
(select count(job) from [Bank Marketing Dataset] where job='unknown') as TotalUnknown,
cast((select count(marital) from [Bank Marketing Dataset] where job='unknown') as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as UnknownPercentage

--4. Finding the oldest bank customers.
-- I want to show all details, therefore putting all columns.
select age, job, marital, education, balance, housing, loan, contact, day, month, duration, campaign, pdays, previous, poutcome, deposit
from [Bank Marketing Dataset]
order by age desc

--5. Percentage of people who are owning a house among bank customers.
select
(select count(housing) from [Bank Marketing Dataset] where housing=1) as OwningHouse,
(select count(*) from [Bank Marketing Dataset]) as TotalBankCustomers,
cast((select count(housing) from [Bank Marketing Dataset] where housing=1) as decimal(7,2))/
(select count(*) from [Bank Marketing Dataset])*100 as OwningHousePercentage

--6. Finding the customers with the highest balance among bank customers.
-- I want to show all details, therefore putting all columns.
select age, job, marital, education, balance, housing, loan, contact, day, month, duration, campaign, pdays, previous, poutcome, deposit
from [Bank Marketing Dataset]
order by balance desc

--7. Finding if the overall balance of all bank customers is positive or negative, and how much it is.
select sum(balance)
from [Bank Marketing Dataset]

--8. Finding the best month for getting new bank customers.
select
(select count(month)
from [Bank Marketing Dataset]
where month='jan') as January,
(select count(month)
from [Bank Marketing Dataset]
where month='feb') as February,
(select count(month)
from [Bank Marketing Dataset]
where month='mar') as March,
(select count(month)
from [Bank Marketing Dataset]
where month='apr') as April,
(select count(month)
from [Bank Marketing Dataset]
where month='may') as May,
(select count(month)
from [Bank Marketing Dataset]
where month='jun') as June,
(select count(month)
from [Bank Marketing Dataset]
where month='jul') as July,
(select count(month)
from [Bank Marketing Dataset]
where month='aug') as August,
(select count(month)
from [Bank Marketing Dataset]
where month='sep') as September,
(select count(month)
from [Bank Marketing Dataset]
where month='oct') as October,
(select count(month)
from [Bank Marketing Dataset]
where month='nov') as November,
(select count(month)
from [Bank Marketing Dataset]
where month='dec') as December

--9. Finding the average age among bank customers.
select avg(age)
from [Bank Marketing Dataset]