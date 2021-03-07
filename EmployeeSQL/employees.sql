------------- SQL CHALLENGE -----------------------
-------- Create tables

-- Drop table if exists
DROP TABLE departments;

-- Create a new table departments
CREATE TABLE departments (
  dept_no VARCHAR(40) NOT NULL,
  dept_name VARCHAR(40) NOT NULL
);
SELECT * FROM  departments

-- Drop table if exists
DROP TABLE dept_emp;

-- Create a new table dept_emp
CREATE TABLE dept_emp (
  emp_no VARCHAR(10) NOT NULL,
  dept_no VARCHAR(10) NOT NULL
);

SELECT * FROM  dept_emp

-- Drop table if exists
DROP TABLE dept_manager;

-- Create a new table dept_manager
CREATE TABLE dept_manager (
  dept_no VARCHAR(10) NOT NULL,
  emp_no VARCHAR(10) NOT NULL
);

SELECT * FROM  dept_manager

-- Drop table if exists
DROP TABLE employees;

-- Create a new table employees
CREATE TABLE employees (
  emp_no VARCHAR(30) NOT NULL,
  emp_title_id VARCHAR(30) NOT NULL,
  birth_date VARCHAR(10) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  sex VARCHAR(5) NOT NULL,
  hire_date VARCHAR(10) NOT NULL
);

SELECT * FROM  employees

-- Drop table if exists
DROP TABLE salaries;

-- Create a new table salaries
CREATE TABLE salaries (
  emp_no VARCHAR(30) NOT NULL,
  salary VARCHAR(30) NOT NULL
);

SELECT * FROM  salaries

-- Drop table if exists
DROP TABLE titles;

-- Create a new table titles
CREATE TABLE titles (
  title_id VARCHAR(30) NOT NULL,
  title VARCHAR(30) NOT NULL
);
SELECT * FROM  titles

-------------- Data Analysis

-- 1. List the following details of each employee: employee number, last name, 
-- first name, sex, and salary.

-- Perform an INNER JOIN on the two tables
SELECT employees.emp_no, employees.first_name, employees.last_name, 
	employees.sex, salaries.emp_no, salaries.salary
FROM salaries
INNER JOIN employees ON
employees.emp_no=salaries.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.

-- Filter year and change column hire_date to date format
SELECT first_name, last_name, hire_date
FROM employees
WHERE CAST(EXTRACT(YEAR FROM TO_DATE(hire_date,'MM/DD/YYYY')) AS int)=1986;

--3. List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name.
-- Query departments, dept_manager and employees data

SELECT departments.dept_no, departments.dept_name, 
	dept_manager.dept_no, dept_manager.emp_no , 
	employees.emp_no, employees.first_name, employees.last_name
FROM departments
INNER JOIN dept_manager 
ON departments.dept_no=dept_manager.dept_no
INNER JOIN employees 
ON dept_manager.emp_no=employees.emp_no;

--4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
-- Query departments, dept_emp and employees data

SELECT departments.dept_no, departments.dept_name, 
	dept_emp.dept_no, dept_emp.emp_no , 
	employees.emp_no, employees.first_name, employees.last_name
FROM departments
INNER JOIN dept_emp 
ON departments.dept_no=dept_emp.dept_no
INNER JOIN employees 
ON dept_emp.emp_no=employees.emp_no;

--5. List first name, last name, and sex for employees whose 
-- first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their 
-- employee number, last name, first name, and department name

SELECT departments.dept_no, departments.dept_name, 
	dept_emp.dept_no, dept_emp.emp_no , 
	employees.emp_no, employees.first_name, employees.last_name
FROM departments
LEFT JOIN dept_emp 
ON departments.dept_no=dept_emp.dept_no
LEFT JOIN employees 
ON dept_emp.emp_no=employees.emp_no
WHERE dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT departments.dept_no, departments.dept_name, 
	dept_emp.dept_no, dept_emp.emp_no , 
	employees.emp_no, employees.first_name, employees.last_name
FROM departments
LEFT JOIN dept_emp 
ON departments.dept_no=dept_emp.dept_no
LEFT JOIN employees 
ON dept_emp.emp_no=employees.emp_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--8. In descending order, list the frequency count of employee 
--last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "COUNT_NAME"
FROM employees
GROUP BY last_name
ORDER BY "COUNT_NAME" DESC;