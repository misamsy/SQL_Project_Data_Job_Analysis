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
- Include postings with either an annual or hourly average salary.
- For each salary type, set the low limit at half its average; standard covers the range up to the average, and high is above it.
- Use the categories to identify which job postings are worth reviewing.
- Focus only on data analyst roles.
- Order results from highest to lowest salary.

Bucketing is a common practice in data analysis for grouping values into categories.
*/

WITH data_analyst_salaries AS (
    SELECT
        salary_year_avg,
        salary_hour_avg
    FROM job_postings_fact
    WHERE
        job_title_short = 'Data Analyst' AND
        (salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL)
), salary_averages AS (
    SELECT
        AVG(salary_year_avg) AS average_yearly_salary,
        AVG(salary_hour_avg) AS average_hourly_salary
    FROM data_analyst_salaries
)
SELECT
    salary_year_avg,
    salary_hour_avg,
    CASE
        WHEN salary_year_avg IS NOT NULL THEN
            CASE
                WHEN salary_year_avg <= average_yearly_salary / 2 THEN 'low'
                WHEN salary_year_avg <= average_yearly_salary THEN 'standard'
                ELSE 'high'
            END
        WHEN salary_hour_avg <= average_hourly_salary / 2 THEN 'low'
        WHEN salary_hour_avg <= average_hourly_salary THEN 'standard'
        ELSE 'high'
    END AS salary_buckets
FROM data_analyst_salaries
CROSS JOIN salary_averages
ORDER BY COALESCE(salary_year_avg, salary_hour_avg) DESC;
