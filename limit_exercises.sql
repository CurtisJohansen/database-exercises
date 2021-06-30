USE employees;

DESCRIBE employees;

SELECT hire_date, birth_date, first_name, Last_name FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25' ORDER BY hire_date ASC LIMIT 5;
# Alselm Cappello, Utz Mandell, Bouchung Schreiter, Boacai Kushner, Petter Stroustrup

SELECT hire_date, birth_date, first_name, Last_name FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25' ORDER BY hire_date ASC LIMIT 5 OFFSET 50;
