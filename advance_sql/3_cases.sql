--prb 6
create  table january_jobs as
SELECT *
from  job_postings_fact
where EXTRACT(month  from  job_posted_date)=1

CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


-- case

SELECT
    COUNT(job_id) as number_of_jobs,
   
    CASE
        when job_location = 'Anywhere' then 'Remote'
        when job_location = 'New York, NY' then 'local'
        else 'Onsite'
    end as location_category

from  job_postings_fact   
where job_title_short = 'Data Analyst' 
GROUP BY location_category;
