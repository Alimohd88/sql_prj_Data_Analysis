-- date fn
SELECT 
job_title_short  as title,
job_location as loc,
job_posted_date::DATE as date 

FROM
job_postings_fact


--2 at time zone
SELECT 
job_title_short  as title,
job_location as loc,
job_posted_date AT TIME ZONE 'utc' AT TIME ZONE 'est' as date_time

FROM
job_postings_fact

--3 extract  for  date  and  month 


SELECT 
job_title_short  as title,
job_location as loc,
job_posted_date::DATE as date,
extract(MONTH FROM job_posted_date) as date_month
FROM
job_postings_fact


SELECT 
job_title_short  as title,
job_location as loc,
job_posted_date::DATE as date,
extract(YEAR FROM job_posted_date) as date_month
FROM
job_postings_fact



-- TREND  ANALYSIS  FOR JOB  POSTED
SELECT 
    COUNT(job_id) AS  JOB_POSTED_COUNT,
    EXTRACT(MONTH FROM job_posted_date) AS MONTH
FROM job_postings_fact
WHERE
    job_title_short ='Data Analyst'
GROUP BY MONTH
ORDER BY JOB_POSTED_COUNT DESC;