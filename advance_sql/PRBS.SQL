--1
SELECT job_schedule_type, AVG(salary_year_avg) AS AVG_SAL,
AVG(salary_hour_avg) AS  HR_SAL
FROM job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY job_schedule_type;

--2
SELECT
    EXTRACT(MONTH FROM job_posted_date 
            AT TIME ZONE 'UTC' 
            AT TIME ZONE 'America/New_York') AS month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY month
ORDER BY month;

--3  using  case 

SELECT
    salary_year_avg,
    job_title_short,
    CASE 
        when salary_year_avg > 100000 then 'high'
        when salary_year_avg BETWEEN 60000 and 100000 then 'medium'
        else  'very  low'
    end as salary_category
from 
    job_postings_fact
WHERE job_title_short = 'Data Analyst'
ORDER BY salary_year_avg desc;