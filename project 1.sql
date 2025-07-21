CREATE DATABASE SC10;
SELECT*FROM sc10.salaries;
describe sc10.salaries;

-- 1. pengecekan table apakah ada yang kosong 
select*from salaries 
where work_year is null 
or experience_level is null 
or employment_type is null 
or job_title is null 
or salary is null
or salary_currency is null 
or salary_in_usd is null 
or employee_residence is null 
or remote_ratio is null 
or company_location is null 
or company_size is null;

-- 2. melihat ada job tilte apa saja 
select
	distinct job_title 
 from salaries;

-- 3. jobtitle yang berkaitan dengan data analyst 
select 
	distinct job_title 
from salaries 
where 
	job_title like '%data analyst%'
order by 
	job_title;

-- 4. rata rata gaji 
select 
	(avg(salary_in_usd)*16223)/12 as avg_salary_rp_monthly 
from salaries;

-- 4.1 rata rata gaji data analyst 
select 
	distinct job_title,  
	avg(salary_in_usd)*16223/12 as avg_salary_rp_monthly 
from salaries 
where 
	job_title like '%data analyst%'
group by 
	job_title; 

-- 5. negara dengan gaji yang menarik untuk data analyst , full time 
SELECT 
    company_location, 
    AVG(salary_in_usd) * 16223 / 12 AS avg_salary_rp_monthly 
FROM 
    salaries
WHERE 
    job_title LIKE '%data analyst%' 
    AND employment_type = 'FT'
    AND experience_level IN ('MI', 'EN')
GROUP BY 
    company_location 
ORDER BY 
	avg_salary_rp_monthly DESC;

    
-- 6. Di tahun berapa, kenaikan gaji dari mid ke senior itu memiliki kenaikan yang tertinggi? 
-- (untuk pekerjaan yang berkaitan dengan data analyst yang penuh waktu
WITH SC10_1 AS (
    SELECT
        work_year,
        AVG(salary_in_usd) AS sal_in_usd_ex
    FROM
        salaries
    WHERE
        employment_type = 'FT'
        AND experience_level = 'EX'
        AND job_title LIKE '%data analyst%'
    GROUP BY
        work_year
), 
SC10_2 AS (
    SELECT
        work_year,
        AVG(salary_in_usd) AS sal_in_usd_mi
    FROM
        salaries
    WHERE
        employment_type = 'FT'
        AND experience_level = 'MI'
        AND job_title LIKE '%data analyst%'
    GROUP BY
        work_year
),
t_year AS (
    SELECT DISTINCT work_year FROM salaries
)

SELECT
    t_year.work_year,
    SC10_1.sal_in_usd_ex,
    SC10_2.sal_in_usd_mi,
    SC10_1.sal_in_usd_ex - SC10_2.sal_in_usd_mi AS differences
FROM
    t_year
LEFT JOIN SC10_1 ON SC10_1.work_year = t_year.work_year
LEFT JOIN SC10_2 ON SC10_2.work_year = t_year.work_year;

