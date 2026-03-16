SELECT
    job_title_short,
    company_id,
    job_location
from
    january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
from
    february_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
from
    march_jobs
    
