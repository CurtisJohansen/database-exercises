USE employees;

#1 - Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

Select de.emp_no, de.to_date, de.from_date, de.dept_no, case when de.to_date > CURDATE() then 1 else 0 end as is_current_employee
FROM dept_emp as de;



#2 - Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT a.first_name, a.last_name, case when a.sub_ln in ('A','B','C','D', 'E','F', 'G', 'H') THEN 'A-H' ELSE case when  a.sub_ln IN ('I','J','K','L','M','N','O','P','Q') THEN 'I-Q' ELSE 'R-Z' END END AS ALPHA_GROUP 
FROM 
	(select e.first_name, e.last_name, substr(e.last_name, 1,1) as sub_ln 
	from employees as e) AS a;



#3 - How many employees (current or previous) were born in each decade?
# decade 	emp_cnt
# 50		182886
# 60		117138

select min(birth_date), max(birth_date) from employees;

SELECT case when birth_date between date_format('1950-01-01', '%Y-%m-%d')  and date_format('1959-12-31', '%Y-%m-%d') then '50' else
								case when birth_date between date_format('1960-01-01', '%Y-%m-%d')  and date_format('1969-12-31', '%Y-%m-%d') then '60' END END 
								as decade,
		count(emp_no) as emp_cnt					
FROM employees
group by 1;


#BONUS
#What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
# Results
# dept_group			avg_salary      
# Customer Service		67285.2302
# Finance & HR			78559.9370
# Human Resources		63921.8998
# Marketing				80058.8488
# Prod & QM				67328.4982
# R&D					67709.2620
# Sales & Marketing		88852.9695

select distinct dept_name from departments;

SELECT 
case when d.dept_name in ('Finance','Humane Resources') then 'Finance & HR' ELSE
	case when d.dept_name in ('Sales','Makreting') then 'Sales & Marketing' ELSE
	case when d.dept_name in ('Production','Quality Management') then 'Prod & QM' else
	case when d.dept_name in ('Research','Development') then 'R&D' ELSE d.dept_name end end end end as dept_group,
    avg(s.salary) as avg_salary

FROM salaries as s
JOIN dept_emp as de on (s.emp_no = de.emp_no)
JOIN departments as d on (de.dept_no = d.dept_no)
WHERE s.to_date > CURDATE()
AND de.to_date > CURDATE()
Group by 1
Order By 1;
