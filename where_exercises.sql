USE employees;

DESCRIBE employees;

SELECT first_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');
# Returned 709 rows

SELECT first_name FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
# Returned 709 rows

SELECT first_name, gender FROM employees WHERE gender = 'M' AND (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya');
# Returned 441 rows

SELECT last_name FROM employees WHERE last_name LIKE 'E%';
# Returned 7330 rows

SELECT last_name FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%e';
# Returned 30723 rows

SELECT last_name FROM employees WHERE last_name LIKE '%e' AND last_name NOT LIKE 'E%';
# Returned 23393 rows

SELECT last_name FROM employees WHERE last_name LIKE 'E%e';
# Returned 899 rows

SELECT last_name FROM employees WHERE last_name LIKE '%e';
# Returned 24292 rows

SELECT hire_date FROM employees WHERE hire_date LIKE '199%';
# Returned 135214 rows

SELECT birth_date FROM employees WHERE birth_date LIKE '%-12-25';
# Returned 842 rows

SELECT hire_date, birth_date FROM employees WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25';
# Returned 362 rows

SELECT last_name FROM employees WHERE last_name LIKE '%q%';
# Returned 1873 rows

SELECT last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
# Returned 547 rows

