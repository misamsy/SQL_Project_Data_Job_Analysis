/*
CASE expression syntax:
CASE
	WHEN condition THEN result
	ELSE result
END (AS)

Practice Problem 1
Question:
Categorize salaries for each job posting to see whether they fit my desired salary range.

- Put salaries into different buckets.
- Define high, standard, and low salary ranges using our own conditions.
- Use the categories to identify which job postings are worth reviewing.
- Focus only on data analyst roles.
- Order results from highest to lowest salary.

Bucketing is a common practice in data analysis for grouping values into categories.
*/

SELECT
    salary_year_avg,
    CASE
        WHEN salary_year_avg BETWEEN 0 AND 61634 THEN 'low'
        WHEN salary_year_avg BETWEEN 61634 AND 123268 THEN 'standard'
        ELSE 'high'
    END AS salary_buckets
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
