/* How many total employees in this company */
SELECT COUNT(last_name) FROM staff;

/* What is the gender distribution? */
SELECT gender, COUNT(gender) AS total_employees
FROM staff
GROUP BY gender;

/* How many employees in each department */
SELECT department, COUNT(last_name) AS total_employee
FROM staff
GROUP BY department
ORDER BY total_employee, department;

/* What is the highest and lowest salary of employees? */
SELECT MAX(salary) AS Maximum_salary, MIN(salary) AS Minimum_salary FROM staff;

/* what about salary distribution by gender group? */
/* Data Interpretation: It seems like the average between male and female group is pretty close, with slighly higher average salary for Female group*/
SELECT ROUND(AVG(salary), 2) AS Average_salary, gender FROM staff GROUP BY (gender);

/* How much company is spending on total salary each year? */
SELECT SUM(salary)
FROM staff;

/* want to know distribution of min, max average salary by department */
/* Data Interpretation: It seems like Outdoors department has the highest average salary paid  and Jewelery department with lowest */ 
SELECT department, 
ROUND(AVG(salary),2) AS Average_salary, 
MIN(salary) AS Min_salary, 
MAX(salary) AS Max_salary 
FROM staff 
GROUP BY department
ORDER BY AVG(salary) DESC

/* how spread out those salary are around the average salary in each department ? */
/* Data Interpretation: Although average salary for Outdoors is highest among deparment, it seems like data points
are pretty close to average salary compared to other departments. */
SELECT 
	department, 
	MIN(salary) As Min_Salary, 
	MAX(salary) AS Max_Salary, 
	AVG(salary) AS Average_Salary,
	VAR_POP(salary) AS Variance_Salary,
	STDDEV_POP(salary) AS StandardDev_Salary,
	COUNT(*) AS total_employees
FROM staff
GROUP BY department
ORDER BY STDDEV_POP(salary) DESC;

/* which department has the highest salary spread out ? */
/* health has max deviation*/
SELECT 
	department, 
	ROUND(STDDEV_POP(salary), 2)
FROM staff 
GROUP BY department 
ORDER BY 2 
DESC LIMIT 1

/* Let's see Computers department salary */
SELECT department, salary
FROM staff 
WHERE department ='Computers'
ORDER BY 2 DESC

/* We will make 3 buckets to see the salary earning status for Computers Department */

SELECT
    CASE
        WHEN salary < 50000 THEN 'Low_Salary'
        WHEN salary >= 50000 AND salary < 100000 THEN 'Medium'
        ELSE 'High'
    END as salary_range,
COUNT (* )
FROM staff
WHERE department= 'Computers'
GROUP BY salary_range

/* Let's see Health department salary */
SELECT department, salary
FROM staff
WHERE department LIKE 'Health'
ORDER BY 2 ASC;

/* we will make 3 buckets to see the salary earning status for Health Department */
CREATE VIEW health_dept_earning_status
AS 
	SELECT 
		CASE
			WHEN salary >= 100000 THEN 'high earner'
			WHEN salary >= 50000 AND salary < 100000 THEN 'middle earner'
			ELSE 'low earner'
		END AS earning_status
	FROM staff
	WHERE department LIKE 'Health';


/* we can see that there are 24 high earners, 14 middle earners and 8 low earners */
SELECT earning_status, COUNT(*)
FROM health_dept_earning_status
GROUP BY 1;


/* Let's find out about Outdoors department salary */
SELECT department, salary
FROM staff
WHERE department LIKE 'Outdoors'
ORDER BY 2 ASC;


CREATE VIEW outdoors_dept_earning_status
AS 
	SELECT 
		CASE
			WHEN salary >= 100000 THEN 'high earner'
			WHEN salary >= 50000 AND salary < 100000 THEN 'middle earner'
			ELSE 'low earner'
		END AS earning_status
	FROM staff
	WHERE department LIKE 'Outdoors';
	
/* we can see that there are 34 high earners, 12 middle earners and 2 low earners */
SELECT earning_status, COUNT(*)
FROM outdoors_dept_earning_status
GROUP BY 1;


/* 
After comparing to Health department with Outdoors department, there are higher numbers of middle 
and low earners buckets in Health than Outdoors. So from those salary earners point of view, the average salary
for Outdoors deparment is higher than Health deparment because it has less high earners.
That's why salary standard deviation value of Health is highest among all departments.
*/


-- drop the unused views
DROP VIEW health_dept_earning_status;
DROP VIEW outdoors_dept_earning_status;

/* What are the deparment start with B */
SELECT
	DISTINCT(department)
FROM staff
WHERE department LIKE 'B%';
