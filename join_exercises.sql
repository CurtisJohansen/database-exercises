# 1. Use the join_example_db. Select all the records from both the users and roles tables.

USE join_example_db;

SELECT * FROM users;

SELECT * FROM roles;

SELECT * FROM roles, users;

# 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

SELECT * 
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

# 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT roles.id, roles.name AS 'Role', COUNT(users.role_id) AS 'Users'
FROM users
RIGHT JOIN roles ON users.role_id = roles.id
GROUP BY roles.id;

# 1. Use the employees database.

USE employees;

# 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT departments.dept_name AS 'Department Name', concat(first_name, ' ', last_name) AS 'Department Manager'
FROM dept_manager
JOIN employees ON dept_manager.emp_no = employees.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE to_date > curdate();

# 3. Find the name of all departments currently managed by women.

SELECT departments.dept_name AS 'Department Name', concat(first_name, ' ', last_name) AS 'Manager Name'
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
WHERE to_date > curdate() AND employees.gender = 'f';


# 4. Find the current titles of employees currently working in the Customer Service department.

SELECT titles.title AS 'Title', count(*) AS 'Count'
FROM titles
JOIN dept_emp ON dept_emp.emp_no = titles.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE titles.to_date > curdate()
AND dept_emp.to_date > curdate()
AND departments.dept_name = 'Customer Service'
GROUP BY titles.title;

# 5. Find the current salary of all current managers.

SELECT departments.dept_name AS 'Department Name', concat(first_name, ' ', last_name) AS 'Department Manager', salaries.salary AS 'Salary'
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE dept_manager.to_date > curdate()
AND salaries.to_date > curdate()
ORDER BY departments.dept_name;

# 6. Find the number of current employees in each department.

SELECT departments.dept_no, departments.dept_name, count(*) AS 'num_employees'
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
WHERE to_date > curdate()
GROUP BY dept_emp.dept_no
ORDER BY departments.dept_no;

# 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT dept_name, AVG(salary) AS average_salary
FROM salaries
JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > NOW()
AND salaries.to_date > NOW()
GROUP BY departments.dept_name
ORDER BY average_salary DESC
LIMIT 1;

# 8. Who is the highest paid employee in the Marketing department?

SELECT employees.first_name, employees.last_name, salaries.salary
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN salaries ON salaries.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Marketing'
AND salaries.to_date > NOW()
AND dept_emp.to_date > NOW()
ORDER BY salaries.salary DESC
LIMIT 1;

# 9. Which current department manager has the highest salary?

SELECT departments.dept_name, employees.first_name, employees.last_name, salaries.salary
FROM salaries
JOIN dept_manager ON salaries.emp_no = dept_manager.emp_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE salaries.to_date > NOW()
AND dept_manager.to_date > NOW()
ORDER BY salary DESC
LIMIT 1;

# 10. Bonus Find the names of all current employees, their department name, and their current manager's name.


# 11. Bonus Who is the highest paid employee within each department.
