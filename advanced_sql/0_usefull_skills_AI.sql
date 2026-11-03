-- Most useful job skills for Data Analyst / Data Analytics roles
WITH filtered_jobs AS (
    SELECT
        jp.job_id,
        jp.job_title
    FROM job_postings_fact AS jp
    WHERE LOWER(jp.job_title) LIKE '%data analyst%'
       OR LOWER(jp.job_title) LIKE '%data analytics%'
       OR LOWER(jp.job_title) LIKE '%analyst%'
       OR LOWER(jp.job_title) LIKE '%analytics%'
),
skill_counts AS (
    SELECT
        js.skill_name,
        COUNT(*) AS job_count
    FROM job_skills AS js
    INNER JOIN filtered_jobs AS fj
        ON fj.job_id = js.job_id
    GROUP BY js.skill_name
)
SELECT
    skill_name,
    job_count,
    ROUND((job_count * 100.0) / NULLIF((SELECT COUNT(*) FROM filtered_jobs), 0), 2) AS pct_of_jobs
FROM skill_counts
ORDER BY job_count DESC, skill_name ASC;
