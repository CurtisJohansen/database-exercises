USE employees;

DESCRIBE employees;

SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name;
# Irena Reutenauer, Vidya Simmen

SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name, last_name;
# Irena Acton, Vidya Zweizig

SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name, first_name;
#Irena Acton, Maya Zyda

SELECT emp_no, first_name, last_name FROM employees WHERE last_name LIKE 'E%e' ORDER BY emp_no;
# Returned 899 rows, 10021 Ramzi Erde, 499648 Tadahiro Erde

SELECT hire_date, first_name, last_name FROM employees WHERE last_name LIKE 'E%e' ORDER BY hire_date DESC;
# Returned 899 rows, Teiji Eldridge, Sergi Erde

SELECT hire_date, birth_date, first_name, last_name FROM employees WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25' ORDER BY birth_date ASC, hire_date ASC;
# Returned 362 rows, Tremaine Eugenio, Gudjon Vakili

# Other possible way due to interpretation of question with differnt results
SELECT hire_date, first_name, last_name, birth_date
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER BY  hire_date DESC, birth_date ASC;
# Khun Bernini, Alselm Cappello