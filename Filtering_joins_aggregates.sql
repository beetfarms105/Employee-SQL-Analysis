/* Filtering, Joins and Aggregration */

/* we want to know a person's salary compared to his/her department average salary */
SELECT last_name, department , salary, 
(SELECT ROUND(AVG(salary),2) AS avg_dept_salary FROM staff s2 WHERE s.department = s2.department) 
FROM staff s

/* how many people are earning above/below the average salary of his/her department ? */
CREATE VIEW vw_salary_comparision_by_department
AS
	SELECT 
	s.department,
	(
		s.salary > (SELECT ROUND(AVG(s2.salary),2)
					 FROM staff s2
					 WHERE s2.department = s.department)
	)AS is_higher_than_dept_avg_salary
	FROM staff s
	ORDER BY s.department;
	
--SELECT * FROM vw_salary_comparision_by_department;
SELECT department, is_higher_than_dept_avg_salary, COUNT(*) AS total_employees
FROM vw_salary_comparision_by_department
GROUP BY 1,2;