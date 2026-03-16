 /* Find the count of the number of remote job postings per skill
- Display the top 5 skills by their demand in remote jobs
- Include skill ID, name, and count of postings requiring the skill */

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

--  union  prb  1
-- Jobs WITH skills
SELECT 
    j.job_id,
    s.skills,
    s.type
FROM job_postings_fact j
JOIN skills_job_dim sj
    ON j.job_id = sj.job_id
JOIN skills_dim s
    ON sj.skill_id = s.skill_id
WHERE j.salary_year_avg > 70000
AND EXTRACT(QUARTER FROM j.job_posted_date) = 1

UNION

-- Jobs WITHOUT skills
SELECT 
    j.job_id,
    NULL AS skills,
    NULL AS type
FROM job_postings_fact j
LEFT JOIN skills_job_dim sj
    ON j.job_id = sj.job_id
WHERE sj.skill_id IS NULL
AND j.salary_year_avg > 70000
AND EXTRACT(QUARTER FROM j.job_posted_date) = 1;