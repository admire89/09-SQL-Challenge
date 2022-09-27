---------------------------------------
--2. Data Engineering-- Table Schemata
---------------------------------------
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