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

-- subqueries/ctes  prb 4

--part 1

SELECT skill_id, COUNT(*) as  skill_count
from skills_job_dim
GROUP BY skill_id
ORDER BY skill_count DESC

--main usign  subq

SELECT
    skills_dim.skills,
    top_skills.skill_count
from skills_dim
join
 (SELECT skill_id, COUNT(*) as  skill_count
from skills_job_dim
GROUP BY skill_id
ORDER BY skill_count DESC
limit 5
)
as  top_skills
on skills_dim.skill_id=top_skills.skill_id;











--using  ctes
WITH top_skills AS (
    SELECT skill_id, COUNT(*) as skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    limit 5
)

SELECT 
    skills_dim.skills,top_skills.skill_count
FROM skills_dim
JOIN top_skills
ON  skills_dim.skill_id = top_skills.skill_id;


--ght  code forr  subquery
SELECT 
    skills_dim.skills,
    top_skills.skill_count
FROM skills_dim
LEFT JOIN (
        SELECT 
            skill_id,
            COUNT(*) AS skill_count
        FROM skills_job_dim
        GROUP BY skill_id
) AS top_skills
ON skills_dim.skill_id = top_skills.skill_id;


-- practice  prb 2  from subqueries
select company_id,job_count,
    case  
        when job_count < 10 then 'small'
        when  job_count BETWEEN 10 and  50  then 'md'
        when job_count >50 then 'large'
        end as company_size

from
(SELECT company_id,COUNT(*) as  job_count
from job_postings_fact
GROUP BY company_id
)

as company_jobs;

-- same  prb2   using  ctes
WITH company_job_count AS (
    SELECT company_id, COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)

SELECT 
    name AS company_name,
    total_jobs,
    CASE
        WHEN total_jobs < 10 THEN 'Small'
        WHEN total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size
FROM company_dim
LEFT JOIN company_job_count
ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC;
