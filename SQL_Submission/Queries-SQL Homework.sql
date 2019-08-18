-- (1) Listing employee details
SELECT dept_emp.emp_num, employees.last_name, employees.first_name, employees.gender, salaries.salary 
	FROM dept_emp 
	INNER JOIN employees ON (dept_emp.emp_num = employees.emp_num)
	INNER JOIN salaries ON (salaries.emp_num = dept_emp.emp_num);

-- (2) Employees hired in 1986
SELECT * FROM employees
	WHERE EXTRACT(year FROM "hire_date") = 1986;
	
-- (3) Manager information
/*ALTER TABLE dept_manager 
	ALTER COLUMN emp_num TYPE INT USING emp_num::integer;*/
SELECT 
	dept_manager.dept_num, 
	departments.dept_name,
	dept_manager.emp_num, 
	employees.last_name, 
	employees.first_name, 
	dept_manager.from_date, 
	dept_manager.to_date
FROM dept_manager
INNER JOIN departments on dept_manager.dept_num = departments.dept_num
INNER JOIN employees on dept_manager.emp_num = employees.emp_num;
	
	
-- (4) List the deparment of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT 
	employees.emp_num,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM employees
INNER JOIN dept_emp ON (employees.emp_num = dept_emp.emp_num)
INNER JOIN departments ON (departments.dept_num = dept_emp.dept_num);


-- (5) Employees with the name "Hercules" and last name starts with "B"
SELECT * from employees
	WHERE (first_name = 'Hercules' AND last_name LIKE 'B%');


-- (6) Employees in the Sales department; employee number, last name, first name, and department name.
SELECT 
	employees.emp_num,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM employees, departments
WHERE 
	departments.dept_num =(SELECT dept_num FROM departments
		WHERE dept_name = 'Sales')
	
	
-- (7) employees in the Sales and Development departments; 
-- employee number, last name, first name, and department name.
SELECT 
	employees.emp_num,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM employees, departments
WHERE 
	departments.dept_num IN (
		SELECT dept_num FROM departments
		WHERE (dept_name = 'Development' OR dept_name = 'Sales')
ORDER BY departments.dept_name DESC);


-- (8) In descending order, list the frequency count of employee last names
SELECT last_name, COUNT(last_name) FROM employees
	GROUP BY last_name
	ORDER BY last_name DESC;


