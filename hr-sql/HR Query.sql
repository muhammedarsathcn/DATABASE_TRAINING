-- 1.Write a SQL query to remove the details of an employee whose first name ends in ‘even’
DELETE FROM employees WHERE first_name LIKE "%even";

-- 2. Write a query in SQL to show the three minimum values of the salary from the table.
SELECT salary FROM employees ORDER BY ASC LIMIT 3;

-- 3. Write a SQL query to remove the employees table from the database
DROP TABLE employees;

-- 4. Write a SQL query to copy the details of this table into a new table with table name as Employee table and to delete the records in employees table
CREATE TABLE Employee AS SELECT * FROM employees;
DELETE FROM employees;

-- 5. Write a SQL query to remove the column Age from the table
ALTER TABLE employees DROP COLUMN age;

-- 6. Obtain the list of employees (their full name, email, hire_year) where they have joined the firm before 2000
SELECT CONCAT(first_name," ",last_name) AS full_name, email, YEAR(hire_year) AS hire_year FROM employees WHERE YEAR(hire_date) < 2000

-- 7. Fetch the employee_id and job_id of those employees whose start year lies in the range of 1990 and 1999
SELECT employee_id, job_id FROM job_history WHERE YEAR(start_date) BETWEEN 1990 AND 1999;

-- 8. Find the first occurrence of the letter 'A' in each employees Email ID
SELECT employeeId, email, LOCATE('A',email) AS letter_a_position FROM employees;

-- 9. Fetch the list of employees(Employee_id, full name, email) whose full name holds characters less than 12
select employee_id, concat(full_name," ",last_name) as full_name, email from employees where length(concat(full_name,last_name) < 12);

-- 10. Create a unique string by hyphenating the first name, last name , and email of the employees to obtain a new field named UNQ_ID
select employee_id, concat(first_name,"-",last_name,"-",email) as UNQ_ID from employees;

-- 11. Write a SQL query to update the size of email column to 30
alter table employees modify email varchar(30);

-- 12. Write a SQL query to change the location of Diana to London
update locations set = "London" where location_id = (
    select location_id from departments where department_id = (
        select department_id from employees where first_name = "Diana"
    )
)

-- 13. Write a SQL query to find the employee with second and third maximum salary with and without using top/limit keyword

--with limit
select distinct salary as second_maximum from employees order by salary desc limit 1 offset 1;
select distinct salary as third_maximum from employees order by salary desc limit 1 offset 2;

--without limit
select  MAX(salary) as second_maximum from employees where salary < (
    select MAX(salary) from employees
);
select  MAX(salary) as third_maximum from employees where salary < (
    select MAX(salary) from employees where salary < (
        select MAX(salary) from employees
    )
);

-- 14. Fetch all details of top 3 highly paid employees who are in department Shipping and IT
select * from employees where department_id in (
    select department_id from departments where department_name in ("Shipping","IT")
)

-- 15. Display employee id and the positions(jobs) held by that employee (including the current position)
select employee_id, job_id from employees union select employee_id, job_id from job_history;

-- 16. Display Employee first name and date joined as WeekDay, Month Day, Year
select first_name, DATEFORMAT(hire_date,'%W',"%M %D","Y") as date_joined from employees;

-- 17. Find the average salary of all the employees who got hired after 8th January 1996 but before 1st January 2000 and round the result to 3 decimals
select ROUND(AVG(salary),3) as average_salary from employees where hire_date > '1996-01-08' and hire_date < '2000-01-01';

-- 18. Write a SQL query to find the total salaries of employees in Tokyo, excluding those whose first name is Nancy
select sum(e.salary) as total_salary from employees e 
join departments d on
e.employee_id = d.department_id 
join locations l on
d.location_id = l.location_id
where l.city = "Tokyo" and e.first_name != "Nancy";

-- 19. Fetch all details of employees who has salary more than the avg salary by each department
select * from employees e where salary > (
    select AVG(salary) from employees where department_id = e.department_id
)

-- 20. Write a SQL query to find the number of employees and its location whose salary is greater than or equal to 70000 and less than 100000
select l.city, count(*) as employee_count from employees e
join departments d 
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
WHERE e.salary >= 70000
AND e.salary < 100000
group by l.city