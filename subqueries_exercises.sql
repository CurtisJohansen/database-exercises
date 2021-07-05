USE employees;

# 1- Find all the current employees with the same hire date as employee 101010 using a sub-query.
# Results 55 records

SELECT *
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > CURDATE())
	AND hire_date = (
	SELECT DISTINCT hire_date
		FROM employees
		WHERE emp_no = '101010'
	);

# 2- Find all the titles ever held by all current employees with the first name Aamod.
# Results - Senior Staff, Staff, Engineer, Technique Leader, Senior Engineer, Assistant Engineer

SELECT DISTINCT t.title
FROM titles AS t
WHERE t.emp_no IN (
	SELECT d.emp_no 
	FROM dept_emp AS d 
	WHERE d.to_date > CURDATE() 
	AND d.emp_no IN (
				SELECT e.emp_no 
				FROM employees AS e 
				WHERE e.first_name = 'Aamod'
				)
);

# 3- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
# returned 59900 people

SELECT *
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > CURDATE()
);

# 4- Find all the current department managers that are female. List their names in a comment in your code.
# Results - Isamu Legleitner, Shirish Ossenbruggen, Karsten Sigstam, Krassimir Wegerle, Rosine Cools, Leon DasSarma, Peternela Onuegbe, Rutger Hofmeyr, Sanjoy Quadeer, Hilary Kambil, Tonny Butterworth, Marjo Giarratana, Xiaobin Spinelli

SELECT first_name, last_name
FROM employees
WHERE gender = 'f'
AND emp_no IN (
	SELECT DISTINCT emp_no
	FROM dept_manager
	WHERE to_date > CURDATE()
	IN (SELECT emp_no
	FROM dept_manager
	WHERE to_date > CURDATE()
)
);

# 5- Find all the employees who currently have a higher salary than the companies overall, historical average salary.
# Results - 154543 records

SELECT s2.emp_no, s2.salary
FROM salaries AS s2
WHERE s2.to_date > CURDATE() 
	AND s2.salary >= (
	SELECT AVG(s1.salary)
	FROM salaries AS s1
	);

# 6- How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
# Result part 1 -- 83 part 2 - 0.0346

SELECT COUNT(*)
FROM salaries
WHERE salaries.to_date > CURDATE()
	AND salary > (
	SELECT MAX(salary)
	FROM salaries
	WHERE salaries.to_date > CURDATE()) - (
	SELECT STD(salary)
	FROM salaries 
	WHERE salaries.to_date > CURDATE()
	);
	
	SELECT (SELECT COUNT(*) FROM salaries
        WHERE salaries.to_date > CURDATE()
        AND salary > (SELECT MAX(salary) - STD(salary) FROM salaries WHERE salaries.to_date > CURDATE())
     ) / (SELECT COUNT(*) FROM salaries WHERE salaries.to_date > CURDATE())
   	 * 100 as "Percentage within 1 Standard Deviation of Max Salary";
    
# BONUS
# 1- Find all the department names that currently have female managers.
# Results - Finance, Human Resources, Development, Research

Select m.emp_no, d.dept_name, p.gender 
from departments as d
		 join dept_manager as m on (d.dept_no = m.dept_no) 
		join dept_emp as e on (m.emp_no = e.emp_no) 
		join employees as p on (m.emp_no = p.emp_no)
WHERE m.TO_DATE > CURDATE()
AND e.to_date > CURDATE()
AND p.gender = 'F';

# 2- Find the first and last name of the employee with the highest salary.
# Result - Tokuyasu Pesch

SELECT s2.emp_no, s2.salary, s2.from_date, s2.to_date, e.first_name, e.last_name
from salaries as s2 
	JOIN employees as e on (s2.emp_no = e.emp_no)
where s2.salary = (SELECT max(s.salary) max_sal FROM salaries as s WHERE s.to_date > CURDATE());

# 3- Find the department name that the employee with the highest salary works in.
# Result - Sales

SELECT s2.emp_no, s2.salary, e.first_name, e.last_name, t.dept_no, r.dept_name
from salaries as s2 
	JOIN employees as e on (s2.emp_no = e.emp_no)
	JOIN dept_emp as t on (e.emp_no = t.emp_no)
	JOIN departments as r on (t.dept_no = r.dept_no)
where s2.salary = (SELECT max(s.salary) max_sal FROM salaries as s WHERE s.to_date > CURDATE());