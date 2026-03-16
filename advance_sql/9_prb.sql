/*
Find job postings from the first quarter that have a salary greater than $70K
- Combine job posting tables from the first quarter of 2023 (Jan–Mar)
- Gets job postings with an average yearly salary > $70,000
*/

SELECT quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::date,
    quarter1_job_postings.salary_year_avg
from(
    select * FROM january_jobs
    UNION ALL
    SELECT * from february_jobs
    UNION ALL
    SELECT * from march_jobs
) as quarter1_job_postings

where  quarter1_job_postings.salary_year_avg > 70000 
  AND
    quarter1_job_postings.job_title_short ='Data Analyst'
ORDER BY quarter1_job_postings.salary_year_avg DESC