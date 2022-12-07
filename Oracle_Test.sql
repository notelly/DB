SELECT * FROM employees;

--1.모든 사원들에 대해 사원번호와 이름, 업무, 입사일을 출력하세요
SELECT employee_id, last_name, job_id, hire_date
FROM employees;

-- 2. 매니저 직책을 맡고 있는 사원의 사원번호를 중복되지 않게 출력하세요.
SELECT DISTINCT NVL(manager_id, 0)
FROM employees
WHERE manager_id > 0;

-- 3. 사원 중에서 급여가 7000이상 12000이하이며 이름이 'H'로 시작하는
--사원의 사원번호, 이름, 급여, 부서번호를 출력하세요.
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary >= 7000
AND salary <= 12000
AND last_name LIKE 'H%';

-- 4. 2005년 1월 1일 이후(2005년 1월 1일 포함)에 입사한 사원이 사번, 이름, 입사일, 첫 문자부터 3문자만 출력된 이메일계정(별칭: EMAIL)
-- 및 이메일 계정의 글자수 (별칭: EMAIL LENGTH)를 출력하세요

SELECT SUBSTR(employee_id, 1,1) || SUBSTR(last_name, 1,1) || SUBSTR(hire_date, 1,1) AS EMAIL,
LENGTH(email)
FROM employees
WHERE hire_date >= '05/01/01';

-- 5. 모든 사원의 이름, 입사일, 입사 6개월 후의 날짜, 입사 후 첫 금요일, 총 근무 개월, 첫 급여일을 차례로 표시하시오
-- 총 근무개월은 한달 미만은 절삭하여 정수로 표시 되도록 하고, 첫 급여일은 입사한 다음 달 1일이다.
-- 결과는 입사일을 기준으로 오름차순으로 정렬하시오.

SELECT last_name, hire_date, hire_date+(6*30) AS afterhire, TO_CHAR(NEXT_DAY(hire_date, '금'), 'YY/MM/DD DY') AS nextfriday,
ROUND((SYSDATE - hire_date)/30) AS TotalWorked, TRUNC(ADD_MONTHS(hire_date, 1),'MON') AS Firstpay
FROM employees
ORDER BY hire_date ;

-- 6. 커미션을 받는 사원들을 대상으로 사원번호, 이름, 입사일, 수당을 표시하고자 한다.
-- 수당은 급여와 커미션을 곱하여 구할 수 있다. 입사일을 '24/03/2008 월요일'의 형식으로 출력하고
-- 수당은 $기호와 천단위 구분기호 및 소수점 둘째자리까지 표시할 수 있도록 한다. 결과를 수당에 대해 내림차순으로 정렬하시오

SELECT employee_id, last_name, TO_CHAR(hire_date, 'DD/MM/rrrr DAY') AS hiredate, TO_CHAR(NVL(commission_pct,0)*salary, '$99999.99') AS extrapay
FROM employees
WHERE NVL(commission_pct,0) <> 0
ORDER BY extrapay DESC;

-- 7. 부서번호가 50번과 60번 직원 가운데 급여가 5000 보다 많은 직원의 사원번호, 이름, 업무ID, 급여, 부서번호를 출력하세요.
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE department_id >= 50
AND department_id <= 60
AND salary > 5000;

-- 8. 함수를 이용하여 사원테이블에서 전화번호의 지역번호가 515인 사원의 사번, 업무ID, 전화번호, 부서번호를 출력하세요.
SELECT employee_id, job_id, department_id,
        CASE WHEN phone_number LIKE '515%' THEN phone_number
        END AS phone
FROM employees
WHERE CASE WHEN phone_number LIKE '515%' THEN phone_number END IS NOT NULL;

-- 9. 사원 테이블에서 사원번호, 사원이름, 연봉, 입사한 연도(입사일 이용), 수당을 받는지 여부를 나타내는 비고, 부서번호를 출력하세요
--수당은 급여와 커미션을 곱해서 계산하고, 연봉은 급여와 수당을 더한 값에 12를 곱해서 구한다.
--연봉 값은 녈이 되지 않도록 주의한다.
--비고열은 연봉에 수당이 포함되었으면 COMM, 포함되지 않았으면 NOCOMM을 표시하시오.
--결과는 부서번호 및 연봉에 대하여 오름차순으로 정의하시오

SELECT employee_id, last_name, salary*(1+NVL(commission_pct,0))*12 AS year_salary, TO_CHAR(hire_date, 'RRRR') AS hire_year,
        CASE NVL(commission_pct, 0) WHEN 0 THEN 'NOCOMM'
        ELSE 'COMM'
        END AS COMM,department_id
FROM employees
ORDER BY year_salary, department_id;

-- 10. 사원 테이블에서 사원번호, 사원이름, 부서번호 및 근무지역을 표시하시오.
-- 근무지역은 20번 부서의 사원이면 'CANADA', '80'번 부서의 직원이면 'UK'를 표시하고 나머지 직원들은 'USA'로 표시하시오
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

SELECT employee_id, last_name, department_id,
        CASE country_id WHEN 'CA' THEN 'CANADA'
                           WHEN 'UK' THEN 'UK'
        ELSE 'USA'
        END AS country
FROM employees NATURAL JOIN departments NATURAL JOIN locations;





