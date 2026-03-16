/*

Question: What are the most in-demand skills for data analysts?

- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
  providing insights into the most valuable skills for job seekers.

*/ 


with  remote_job_skills as(
SELECT 
    skill_id,
    count(*) as  skill_count
from skills_job_dim as skills_to_job
INNER JOIN job_postings_fact as  job_postings
on job_postings.job_id = skills_to_job.job_id
where job_postings.job_work_from_home = true
    AND
        job_postings.job_title_short ='Data Analyst'
GROUP BY skill_id)

SELECT skills.skill_id,skills as skill_name,skill_count
from remote_job_skills
inner JOIN skills_dim as skills 
ON skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5;



--SECOND  APPRAOCH 

SELECT 
    skills,
    count(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim
ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst'
     and job_work_from_home = true
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5
