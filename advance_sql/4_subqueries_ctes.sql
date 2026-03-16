-- 1 SUBQUERY
SELECT *
from (
    SELECT *
    from job_postings_fact
    where EXTRACT(MONTH FROM job_posted_date) = 1

) as january_jobs;

--2   CTES
WITH  january_jobs as ( -- start  of   definition 
    SELECT * 
    FROM job_postings_fact  
    WHERE EXTRACT(MONTH  FROM job_posted_date)=1
) -- end of  definition 

select *
from  january_jobs;


--3 subquery
SELECT company_id ,name  as company_name
from company_dim
where company_id in (
SELECT company_id
from job_postings_fact
where job_no_degree_mention = TRUE)
ORDER BY company_id;

--4 ctes
with  company_job_count as (
SELECT company_id,count(*) as  total_jobs
from  job_postings_fact
GROUP BY company_id
)

SELECT name  as  company_name,total_jobs
 from company_dim
LEFT JOIN company_job_count
on company_job_count.company_id =company_dim.company_id
ORDER BY total_jobs desc;