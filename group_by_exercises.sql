USE employees;

DESCRIBE employees;

DESCRIBE titles;

# E2 - 7 titles
SELECT DISTINCT title FROM titles;

# E3 -
SELECT last_name FROM employees WHERE last_name LIKE 'e%e' GROUP BY last_name;

# E4 - 
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'e%e' GROUP BY first_name,last_name;

# E5 - Chleq, Lindqvist, Qiwen
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

# E6 - 
SELECT last_name, COUNT(last_name) FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_name;

# E7 - 
SELECT first_name, gender, COUNT(*) FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') GROUP BY first_name, gender;

# E8 -
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1),SUBSTR(last_name, 1, 4),'_',SUBSTR(birth_date, 6, 2),SUBSTR(birth_date, 3, 2))) AS user_name,COUNT(*) AS duplicates FROM employees GROUP BY user_name;

# E8 Bonus
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1),SUBSTR(last_name, 1, 4),'_',SUBSTR(birth_date, 6, 2),SUBSTR(birth_date, 3, 2))) AS user_name,COUNT(*) AS duplicates FROM employees GROUP BY user_name HAVING duplicates > 1;
