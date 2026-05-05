-- Delete employees whose first name ends with even
DELETE FROM employees WHERE first_name LIKE "%even";

-- Three Minimum salary
SELECT DISTINCT salary from employees ORDER BY salary ASC LIMIT 3;

-- Remove employees Table
DROP TABLE employees;

-- Copy employees table then delete original table 
CREATE TABLE Employee AS SELECT * FROM employees;
DELETE FROM employees;

-- Remove column age 
ALTER TABLE employees DROP COLUMN age;

-- Employees joined before 2000 
SELECT CONCAT(first_name, ' ',last_name) AS full_name,email,YEAR(hire_date) as hire_year FROM employees WHERE YEAR(hire_date) < 2000;

-- Employees start year between 1990-1999
SELECT employee_id, job_id FROM job_history WHERE YEAR(start_date) BETWEEN 1990 AND 1999;

-- First occurrence of letter A in email 
SELECT employee_id, email, LOCATE('A', email) as position FROM employees;

--Full name length < 12
SELECT employee_id, CONCAT(first_name, ' ', last_name) as full_name, email FROM employees WHERE LENGTH(CONCAT(first_name, last_name)) < 12;

-- Unique Id for each employee
SELECT employee_id, CONCAT(first_name,'-',last_name,'-',email) AS UNQ_ID FROM employees;

-- Alter the email length 
ALTER TABLE employees MODIFY email VARCHAR(30);

-- Update location where first name is Diana
UPDATE locations SET city = "London" WHERE location_id IN( SELECT location_id FROM department WHERE department_id = (SELECT departmentId FROM employees WHERE first_name="Diana"));
----------------------------------------
SELECT DISTINCT salary from employees ORDER BY salary DESC LIMIT 1 OFFSET 1;
SELECT DISTINCT salary from employees ORDER BY salary DESC LIMIT 1 OFFSET 2;
SELECT MAX(salary) FROM employees WHERE salary < (SELECT MAX(salary) FROM employees);
-----------------------------------------
-- Top 3 highest paid in shipping & IT
SELECT * FROM employees WHERE department_id IN(SELECT department_id FROM departments WHERE department_name IN("Shipping", 'IT'))ORDER BY salary DESC LIMIT 3;

-- Employee jobs (current + history)
SELECT employee_id, job_id FROM employees UNION SELECT employee_id, job_id FROM job_history;

-- Hire date 
SELECT employeeId, DATE_FORMAT(hire_date, "%W, %M, %D, %Y") as date_joined FROM employees;

-- Average salary between 1996-01-08 and 2000-01-01
SELECT ROUND(AVG(salary), 3) as average_salary FROM employees WHERE hire_date > '1996-01-08' AND hire_date < '2000-01-01';


-------------------------------------
SELECT SUM(e.salary) FROM employees e 
JOIN departments d USING(department_id)
JOIN locations l USING(location_id)
WHERE l.city = 'Tokyo'
AND e.first_name != 'Nancy';
-------------------------------------

-- Salary stats grouped
SELECT department_id, job_id, MAX(salary), MIN(salary), ROUND(AVG(salary),3) FROM employees GROUP BY department_id, job_id ORDER BY department_id, MAX(salary);

-- Total salary in US excluding Nancy
SELECT SUM(salary) as total_salary from employees e JOIN departments d USING(department_id) JOIN locations l USING(location_id) WHERE country_id = "US" AND first_name != 'Nancy';

-- Salary stats multi-role employees
SELECT department_id, job_id, MAX(salary), MIN(salary), AVG(salary) FROM employees GROUP BY department_id, job_id HAVING COUNT(DISTINCT job_id) > 1;


