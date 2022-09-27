--Homework_9--Module_9--
-----------------------------------
--1. Data Modeling--
-----------------------------------

-----------------------------------
--2. Data Engineering--
-----------------------------------
--import the csv
DROP TABLE departments;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE titles;

--drop the table if exists
-- Create a new table {departments} --
CREATE TABLE departments(
	dept_no VARCHAR(10) NOT Null,
	dept_name VARCHAR(25) NOT Null,
	PRIMARY KEY (dept_no)
	);

-- Create a new table {titles} --
CREATE TABLE titles(
	title_id VARCHAR(5) NOT NULL,
	title VARCHAR(20) NOT NULL,
	PRIMARY KEY(title_id)
	);
	
-- Create a new table {employees} --
CREATE TABLE employees(
	emp_no INT NOT NULL,
	emp_title_id VARCHAR(5) NOT NULL,
	birth_date DATE,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	sex VARCHAR(5),	
	hire_date Date,
	PRIMARY KEY(emp_no),
	FOREIGN KEY(emp_title_id) REFERENCES titles(title_id)
	);
	
-- Create a new table {dept_emp} --
CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(5) NOT NULL,
	Foreign KEY(emp_no) REFERENCES employees(emp_no),
	Foreign KEY(dept_no) REFERENCES departments(dept_no)
	);

-- Create a new table {dept_manager} --
CREATE TABLE dept_manager(
	dept_no VARCHAR(5) NOT NULL,
	emp_no INT NOT NULL,
	Foreign KEY(dept_no) REFERENCES departments(dept_no),
	Foreign KEY(emp_no) REFERENCES employees(emp_no)
	);

-- Create a new table {salaries} --
CREATE TABLE salaries(
	 emp_no INT NOT NULL,
	 salary INT NOT NULL,
	 Foreign KEY (emp_no) REFERENCES employees(emp_no)	
	);	
	
--Populate/Insert/Import data--
Insert into departments Values(
	(d001,Marketing),
	(d002,Finance),
	(d003,Human_Resources),
	(d004,Production),
	(d005,Development),
	(d006,Quality_Management),
	(d007,Sales),
	(d008,Research),
	(d009,Customer_Service));

-- Read All Data --
Select * FROM departments;
Select * FROM dept_emp;
Select * FROM dept_manager;
Select * FROM employees;
Select * FROM salaries;
Select * FROM titles;

-----------------------------------
--3. Data Analysis--
-----------------------------------

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
select employees.emp_no, employees.first_name, employees.last_name, employees.sex, salaries.salary
from employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date
from employees
WHERE extract(year from employees.hire_date) = 1986;

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dm.dept_no, d.dept_name,  dm.emp_no, e.last_name, e.first_name
FROM Dept_manager AS dm 
JOIN Employees AS e ON e.emp_no = dm.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no; 

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
Create View employee_and_emp AS
Select
	dm.dept_no,
	dm.emp_no,
	em.last_name,
	em.first_name
From dept_emp as "dm"
Left Join employees as "em"
Using(emp_no);

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex FROM Employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN Employees AS e ON de.emp_no = e.emp_no
JOIN departments as d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
; 
--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN Employees AS e ON de.emp_no = e.emp_no
JOIN departments as d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
; 

--8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT last_name, COUNT(last_name) AS Frequency_count
FROM employees
GROUP BY last_name
ORDER BY Frequency_count DESC;
