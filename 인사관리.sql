DESC employees;
--주석쓰기
SELECT first_name, last_name, job_id
FROM employees;

DESC departments;

SELECT *
FROM departments;

SELECT  salary, salary+300, salary-300, salary*300, salary-300
FROM employees;

SELECT last_name, salary, salary*12 
FROM employees;

SELECT last_name, salary, 12*(salary+100) 
FROM employees;

SELECT salary+null
FROM employees;

SELECT *
FROM employees;

SELECT last_name AS "이름", salary*12*commission_pct AS "상여금"
FROM employees;

SELECT first_name, last_name, first_name || ' ' || last_name as full_name
FROM employees;

SELECT employee_id || '-' || last_name || '''s Salay : ' || salary
FROM employees;
-- q'[/////]' /으로 적어 놓은 부분을 그대로 출력해주세요.
SELECT employee_id || '-' || last_name ||q'[' Salay : ]' || salary
FROM employees;

SELECT department_id
FROM employees;

SELECT DISTINCT department_id
FROM employees;

SELECT employee_id, job_id, department_id
FROM employees
WHERE department_id = 60;
--WHERE 조건

SELECT last_name, job_id, department_id
FROM employees
WHERE last_name = 'king';

SELECT *
FROM employees;

SELECT last_name, job_id, department_id
FROM employees
WHERE last_name = 'King';

SELECT last_name, hire_date
FROM employees
WHERE hire_date = '99/09/21';

SELECT last_name, hire_date
FROM employees
WHERE hire_date = '1999-09-21';

SELECT last_name, hire_date
FROM employees
WHERE hire_date = '21/09/99';

SELECT employee_id, salary, last_name
FROM employees
WHERE department_id > 60;

SELECT last_name, salary
FROM employees
WHERE salary <= 5000;

SELECT last_name, hire_date
FROM employees
WHERE hire_date < '00/01/01';

SELECT last_name, hire_date
FROM employees
WHERE last_name < 'KING';

SELECT employee_id, salary, department_id
FROM employees
WHERE department_id <> 90;

SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 6000 AND 9000;

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE department_id IN (50,60,80);

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE job_id IN ('IT_PROG', 'SA_REP');

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE last_name  LIKE 'A%';

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE last_name LIKE '%a%';

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE last_name LIKE '_a%';

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE last_name LIKE '___';

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE last_name LIKE '%s';

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE job_id LIKE '%SAa_%' ESCAPE 'a'; --SA_

SELECT employee_id, last_name, job_id, manager_id
FROM employees
WHERE manager_id IS NULL;

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id LIKE 'IT%'
OR salary > 8000;

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id LIKE 'IT%'
AND salary > 8000;

SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 6000 AND 9000;

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE department_id NOT IN (50,60,80);
--WHERE department_id IN (50,60,80);
-- department_id = 50 or department_id = 60 or department_id = 80
--WHERE department_id NOT IN (50,60,80);
-- department_id <> 50 AND department_id <> 60 or department_id <> 80

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE last_name NOT Like '%a%';

