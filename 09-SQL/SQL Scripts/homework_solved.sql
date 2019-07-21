/* List the following details of each employee: employee number, last name, first name, gender, and salary */

SELECT employees.emp_no as "employee number"
	, last_name as "last name"
	, first_name as "first name"
	, gender
	, salary
FROM public.employees
	left join public.salaries
		on employees.emp_no = salaries.emp_no
order by employees.emp_no;

/* List employees who were hired in 1986.*/

select * 
from employees
where date_part('year', hire_date) = 1986
order by employees.emp_no;

/* List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates. */

/* TA - this question has no answer for end employment date  */
/*  Using 110022 as an example  */
/*      -employee table only has start date  */
/*      -salary table ends in 1986    */
/*      -department manager table ends in 1991  */
/*      -dept_emp end in 9999   */
/*   did he work for 5 years without a salary? - guess that's why he quit :)  */
/*  using dept_managers to_date for end date just to have an output   */

select
	departments.dept_no as "department number"
	, dept_name as "department_name"
	, dept_manager.emp_no as "department manager employee number"
	, last_name as "last name"
	, first_name as "first name"
	, hire_date as "hire date"
	, dept_emp.to_date "termination date"
from departments
inner join dept_manager
	on departments.dept_no = dept_manager.dept_no
	inner join employees
		on dept_manager.emp_no = employees.emp_no
	inner join dept_emp
		on departments.dept_no = dept_emp.dept_no
			and employees.emp_no = dept_emp.emp_no
order by departments.dept_no, dept_manager.emp_no;


/* List the department of each employee with the following information: employee number, last name, first name, and department name. */

select
	employees.emp_no as "employee number"
	, last_name as "last name"
	, first_name as "first name"
	, departments.dept_name "department name"
from employees
	inner join dept_emp
		on employees.emp_no = dept_emp.emp_no
	inner join departments
		on dept_emp.dept_no = departments.dept_no
order by dept_name, last_name, first_name;


/*List all employees whose first name is "Hercules" and last names begin with "B." */

select
	*
from employees
where first_name = 'Hercules'
	and last_name like 'B%'
order by emp_no;


/*List all employees in the Sales department, including their employee number, last name, first name, and department name. */

select
	dept_emp.emp_no as "employee number"
	, last_name as "last name"
	, first_name as "first name"
	, dept_name as "department name"
from departments
	inner join dept_emp
		on departments.dept_no = dept_emp.dept_no
	inner join employees
		on dept_emp.emp_no = employees.emp_no
where dept_name = 'Sales'
order by dept_emp.emp_no; 


/*List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.*/


select
	dept_emp.emp_no as "employee number"
	, last_name as "last name"
	, first_name as "first name"
	, dept_name as "department name"
from departments
	inner join dept_emp
		on departments.dept_no = dept_emp.dept_no
	inner join employees
		on dept_emp.emp_no = employees.emp_no
where dept_name in ('Sales', 'Development')
order by dept_name, dept_emp.emp_no; 


/* In descending order, list the frequency count of employee last names, i.e., how many employees share each last name. */

select
	last_name
	, count(*)
from employees
group by last_name
order by count(*) desc;


