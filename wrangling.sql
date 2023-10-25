SELECT DISTINCT(department)
FROM staff
ORDER BY department;

/*Reformatting Characters Data */
SELECT DISTINCT(UPPER(department))
FROM staff
ORDER BY 1;

/* Concatetation */
SELECT CONCAT(last_name, '-', job_title) AS name_jobtile 
FROM staff

SELECT last_name, department ||' - '|| strt_date AS department_start_name 
FROM staff

/* Trim */
-- length 33 characters
SELECT
	LENGTH('    Employee Data SQL Project    ');
	
-- trim the phrase	
SELECT
	TRIM('    Employee Data SQL Project    ');

-- length after trimming 25 characters
SELECT
	LENGTH(TRIM('    Employee Data SQL Project    '));

/* How many employees with Manager roles */
SELECT COUNT(*) 
FROM staff 
WHERE LOWER(job_title) LIKE LOWER('%Manager%')

/*What are these manager roles*/
SELECT DISTINCT(job_title) AS Job_title_with_managerial_role
FROM staff 
WHERE LOWER(job_title) LIKE LOWER('%Manager%')

/* let's check which roles are assistant role or not */
SELECT DISTINCT(job_title),
	LOWER(job_title) LIKE LOWER('%Manager%') is_assistant_role
FROM staff
ORDER BY 1;

/*Extracting Strings from Characters */
-- SUBSTRING('string' FROM position FOR how_many)

------ SubString words ------
SELECT 'supercalifragilisticexpialidocious"' AS test_string;

SELECT SUBSTRING('supercalifragilisticexpialidocious"' FROM 10) AS sub_string;

SELECT SUBSTRING('supercalifragilisticexpialidocious"' FROM 10 FOR 11) as sub_string;



/* we want to replace word Assistant with Asst.  */
--update manager to 'Manager' in the table itself--
UPDATE staff
SET job_title = REPLACE(job_title, 'manager', 'Manager')
WHERE job_title LIKE '%manager%';

--replace 'Manager' with 'Man.'--
SELECT REPLACE(job_title, 'Manager', 'Man.') from staff where job_title LIKE '%Manager%'

/* Filtering with Regualar Expressions */
--We want to know job title of Assistant with Level 3 and 4 --
SELECT job_title
FROM staff
WHERE job_title SIMILAR TO '%Assistant%(III|IV)';

/* now we want to know Assistant job titles that start with roman numerial I, follwed by 1 character
it can be II,IV, etc.. as long as it starts with character I 
underscore _ : placeholder for one character */

SELECT DISTINCT(job_title)
FROM staff
WHERE job_title SIMILAR TO '%Assistant I_';

--select job titles with one or more characters after I
SELECT DISTINCT job_title
FROM staff
WHERE job_title ~ '^Assistant I.*';

--alternate method
SELECT DISTINCT job_title
FROM staff
WHERE job_title ~ 'Assistant I[IVXLCDM]+';

--job title starts with either E, P or S character , followed by any characters*/
SELECT job_title
FROM staff
WHERE job_title SIMILAR TO '[EPS]%';

/*Reformatting Numerics Data*/
-- TRUNC() Truncate values Note: trunc just truncate value, not rounding value.
-- CEIL
-- FLOOR
-- ROUND

SELECT 
	department, 
	AVG(salary) AS avg_salary, 
	TRUNC(AVG(salary)) AS truncated_salary,
	TRUNC(AVG(salary), 2) AS truncated_salary_2_decimal,
	ROUND(AVG(salary), 2) AS rounded_salary,
	CEIL(AVG(salary)) AS ceiling_salary,
	FLOOR(AVG(salary)) AS floor_salary
FROM staff
GROUP BY department;