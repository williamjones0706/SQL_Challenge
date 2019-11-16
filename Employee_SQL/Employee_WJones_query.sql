------------------------------------------------------------------------------
-- Query portion
-- Must use "" for referecing tables due to the export function from QuickDBD 
--  Checking the import of the excel

select * from "Employee";

-- List the following details of each employee: employee number, last name, first name, gender, and salary.

CREATE VIEW Employee_Details AS
SELECT emp.emp_no, emp.first_name, emp.last_name, emp.gender, sal.salary
FROM "Employee" AS emp
JOIN "Salaries" AS sal
ON (emp.emp_no = sal.emp_no);
  
-- List employees who were hired in 1986.

CREATE VIEW Employee_1986 AS
SELECT emp.emp_no, emp.first_name, emp.last_name, emp.hire_date
FROM "Employee" AS emp
Where CAST(emp.hire_date AS VARCHAR) LIKE '1986%';

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

CREATE VIEW Department_Manager_Timeframe AS
SELECT dep.dept_no, dep.dept_name, dep_man.emp_no, emp.last_name, emp.first_name, dep_man.from_date, dep_man.to_date
FROM "Departments" AS dep
JOIN "Department_Managers" AS dep_man
ON (dep.dept_no = dep_man.dept_no)
JOIN "Employee" AS emp
ON (dep_man.emp_no = emp.emp_no);

-- List the department of each employee with the following information: employee number, last name, first name, and department name.

CREATE VIEW Employee_Department AS
SELECT emp_dep.emp_no, emp.last_name, emp.first_name,dep.dept_name
FROM "Employee_Departments" AS emp_dep
JOIN "Employee" AS emp
ON (emp.emp_no = emp_dep.emp_no)
JOIN "Departments" AS dep
ON (dep.dept_no = emp_dep.dept_no);

-- List all employees whose first name is "Hercules" and last names begin with "B."

CREATE VIEW Employee_Hercules_B AS
SELECT emp.first_name, emp.last_name
FROM "Employee" AS emp
WHERE emp.first_name like 'Hercules' and emp.last_name like 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.

CREATE VIEW Employee_Sales_Dept AS
SELECT emp.emp_no, emp.last_name, emp.first_name,dep.dept_name
	FROM "Employee" AS emp
	JOIN "Employee_Departments" AS emp_dep
	ON (emp.emp_no = emp_dep.emp_no)
	JOIN "Departments" AS dep
	ON (emp_dep.dept_no = dep.dept_no)
Where dep.dept_name like 'Sales';

-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.

CREATE VIEW Employee_Sales_Dept AS
SELECT emp.emp_no, emp.last_name, emp.first_name,dep.dept_name
	FROM "Employee" AS emp
	JOIN "Employee_Departments" AS emp_dep
	ON (emp.emp_no = emp_dep.emp_no)
	JOIN "Departments" AS dep
	ON (emp_dep.dept_no = dep.dept_no)
Where dep.dept_name like 'Sales' or dep.dept_name like 'Development';

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

CREATE VIEW Employee_LastName_Count AS
SELECT last_name, count(*)
	FROM "Employee"
Group by last_name
Order By last_name Desc;