USE employees;

# 1- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.

CREATE TEMPORARY TABLE germain_1476.employees_with_departments AS
	SELECT first_name, last_name, dept_name
	FROM employees
	JOIN dept_emp USING(emp_no)
	JOIN departments USING(dept_no)
	WHERE to_date > CURDATE();
	
USE germain_1476;
	
select *
from employees_with_departments;	

# a.  Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

SELECT MAX(CHAR_LENGTH(first_name))  AS 'fn_len', MAX(CHAR_LENGTH(last_name)) AS 'ln_len'
FROM employees_with_departments;
# results 14 and 16 = 30, adding 1 for space between names.

ALTER TABLE employees_with_departments ADD full_name VARCHAR(31);

# b.  Update the table so that full name column contains the correct data

UPDATE employees_with_departments
SET full_name = CONCAT(first_name,' ', last_name);

select *
from employees_with_departments;

# c.  Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

select *
from employees_with_departments;

# d.  What is another way you could have ended up with this same table?
	# When making the original query.
	

# 2- Create a temporary table based on the payment table from the sakila database.
# Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

USE sakila;

CREATE TEMPORARY TABLE germain_1476.payment AS
	SELECT payment_id, customer_id, staff_id, rental_id, amount * 100 AS payment_in_cents, payment_date, last_update
	FROM payment;
	
USE germain_1476;

SELECT *
FROM payment;

DESCRIBE payment;

# Changed from decimal to integer. Also could have used CAST(amount as INT) 

ALTER TABLE payment MODIFY payment_in_cents INT NOT NULL;

DESCRIBE payment;

SELECT *
FROM payment;

# 3- Find out how the current average pay in each department compares to the overall, historical average pay. 
#	In order to make the comparison easier, you should use the Z-score for salaries. 
#	In terms of salary, what is the best department right now to work for? The worst?

USE germain_1476;

# Historic salaries for departments and std dev

select avg(salary), std(salary) from employees.salaries;

CREATE TEMPORARY TABLE hist_sal AS
	SELECT AVG(salary) AS h_avg_salary, std(salary) AS h_std_salary
    FROM employees.salaries;

SELECT * FROM hist_sal;

 # Current average salaries for departments

CREATE TEMPORARY TABLE cur_sal AS
    SELECT dept_name, AVG(salary) AS cur_dept_avg
    FROM employees.salaries
    JOIN employees.dept_emp USING(emp_no)
    JOIN employees.departments USING(dept_no)
    WHERE employees.dept_emp.to_date > CURDATE()
    AND employees.salaries.to_date > CURDATE()
    GROUP BY dept_name;
    
SELECT * FROM cur_sal;   
    
# Add colums to table for calculations
    
ALTER TABLE cur_sal ADD historic_avg FLOAT(10,2);
ALTER TABLE cur_sal ADD historic_std FLOAT(10,2);
ALTER TABLE cur_sal ADD zscore FLOAT(10,2);

SELECT * FROM cur_sal;  
    
 # Set the historic avg and std salaries
 
UPDATE cur_sal SET historic_avg = (SELECT h_avg_salary from hist_sal);
UPDATE cur_sal SET historic_std = (SELECT h_std_salary from hist_sal);   
    
SELECT * FROM cur_sal; 

# Update zscore table
# zscore = (x - avg(x)) / std(x)

UPDATE cur_sal
SET zscore = (cur_dept_avg - historic_avg) / historic_std;

# Show results

select * from cur_sal
order by zscore desc;

    
    