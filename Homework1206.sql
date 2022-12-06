SELECT *
FROM employees;
--1202
--2. EMPLOYEES 테이블의 구조를 표시하시오. 사원 번호가 가장 앞에 오고 이어서 각 사원의 이름, 업무 코드, 입사일이 오도록 질의를 작성하시오.
--HIRE_DATE 열에 STARTDATE라는 별칭을 지정하시오. 
DESC employees;

SELECT employee_id, first_name, department_id, hire_date AS STARTDATE
FROM employees;

--3. EMPLOYEES 테이블의 업무 코드를 중복되지 않게 표시하는 질의를 작성하시오.

SELECT DISTINCT department_id
FROM employees;

--5. 업무 ID와 이름을 연결한 다음 쉼표 및 공백으로 구분하여 표시하고 열 이름을 Employee and Title로 지정하시오.
SELECT department_id||', '||first_name AS "Employee and Title"
FROM employees;

--6. 급여가 12,000를 넘는 사원의 이름과 급여를 표시하는 질의를 실행하시오.
SELECT first_name, salary
FROM employees
WHERE salary > 12000;

--7. 사원 번호가 176인 사원의 이름과 부서 번호를 표시하는 질의를 실행하시오.
SELECT first_name, department_id
FROM employees
WHERE employee_id = 176;

--8. 급여가 5,000에서 12,000 사이에 포함되지 않는 모든 사원의 이름과 급여를 표시하도록 질의를 실행하시오.
SELECT first_name, salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;

--1. 커미션을 받는 모든 사원의 이름, 급여 및 커미션을 급여 및 커미션을 기준으로 내림차순으로 정렬하여 표시하시오.

SELECT DISTINCT first_name, salary, commission_pct, salary + salary * NVL(commission_pct,0) AS monthly_sal
FROM employees
WHERE NVL(commission_pct,0) <> 0
ORDER BY monthly_sal DESC;

--2. 업무가 영업 사원 또는 사무원이면서 급여가 2,500, 3,500 또는 7,000이 아닌 모든 사원의 이름, 업무 및 급여를 표시하시오.
SELECT first_name, job_id, salary
FROM employees
WHERE job_id LIKE '%SA%' OR job_id LIKE '%CLERK%'
INTERSECT
SELECT first_name, job_id, salary
FROM employees
WHERE salary NOT IN (2500, 3500, 7000);


--3. 각 사원에 대해 사원 번호, 이름, 급여 및 15% 인상된 급여를 정수로 표시하시오. 인상된 급여 열의 레이블을 New Salary로 지정하시오. 
SELECT employee_id, first_name, salary, salary+salary*0.15 AS New_Salary
FROM employees;


--4. 2번 질의를 수정하여 새 급여에서 이전 급여를 빼는 새 열을 추가하고 레이블을 Increase로 지정하고 수정한 질의를 실행하시오.

SELECT first_name, job_id, salary*0.15 AS Increase
FROM employees
WHERE job_id LIKE '%SA%' OR job_id LIKE '%CLERK%'
INTERSECT
SELECT first_name, job_id, salary*0.15 AS Increase
FROM employees
WHERE salary NOT IN (2500, 3500, 7000);


--5. 이름이 J, A 또는 M으로 시작하는 모든 사원의 이름(대문자 표시) 및 이름 길이를 표시하는 질의를 작성하고 각 열에 적합한 레이블을 지정하시오.
--결과를 사원의 이름에 따라 정렬하시오.

SELECT first_name, LENGTH(first_name)
FROM employees
WHERE (first_name Like 'J%' OR first_name Like 'A%' OR first_name Like 'M%')
ORDER BY first_name;

--6. 각 사원의 이름을 표시하고 근무 달 수(입사일로부터 현재까지의 달 수)를 계산하여 열 레이블을
--MONTHS_WORKED로 지정하시오. 결과는 정수로 반올림하여 표시하고 근무 달 수를 기준으로 정렬하시오.
SELECT first_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS MONTHS_WORKED
FROM employees
ORDER BY MONTHS_WORKED;

--7. 부서 90의 모든 사원에 대해 성(last_name) 및 재직 기간(주 단위)을 표시하도록 query 를 작성하시오.
--주를 나타내는 숫자 열의 레이블로 TENURE를 지정하고 주를 나타내는 숫자 값을 소수점 왼쪽에서 truncate 하시오.
--그리고 직원 재직 기간의 내림차순으로 레코드를 표시합니다.

SELECT last_name, TRUNC((SYSDATE-hire_date)/7, 1) AS TENURE
FROM employees
WHERE department_id = 90
ORDER BY TENURE DESC;

--8. 사원의 이름, 입사일 및 급여 검토일을 표시하시오. 급여 검토일은 여섯 달이 경과한 후 첫번째 월요일입니다.
-- 열 레이블을 REVIEW로 지정하고 날짜는 “2010.03.31 월요일”과 같은 형식으로 표시되도록 지정하시오.

SELECT first_name, hire_date, TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), '월'), 'YYYY.MM.DD DAY') AS REVIEW
FROM employees;

--9. 사원의 이름과 커미션을 표시하는 질의를 작성하시오. 커미션을 받지 않는 사원일 경우 “No Commission”을 표시하시오.
--열 레이블은 COMM으로 지정하시오.
--TO_CHAR를 넣어주어야 오류가 
SELECT first_name, NVL(TO_CHAR(commission_pct), 'No Commission') AS COMM
FROM employees;


--10. CASE 구문을 사용하여 다음 데이터에 따라 JOB_ID 열의 값을 기준으로 모든 사원의 등급을 표시하는 질의를 작성하시오.
--업무 등급
--AD_PRES A
--ST_MAN B
--IT_PROG C
--SA_REP D
--ST_CLERK E
--None of the above 0


SELECT job_id,
       CASE job_id WHEN 'AD_PRES' THEN  'A'
                   WHEN 'ST_MAN' THEN  'B'
                   WHEN 'IT_PROG' THEN  'C'
                   WHEN 'SA_REP' THEN  'D'
                   WHEN 'ST_CLERK' THEN  'E'
                   ELSE 'None of the above 0'
       END
       AS employee_grade
FROM employees;

