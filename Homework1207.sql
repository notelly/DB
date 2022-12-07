---1. Zlotkey와 동일한 부서에 속한 모든 사원의 이름과 입사일을 표시하는 질의를 작성하시오. Zlotkey는 결과에서
--제외하시오.
SELECT last_name, hire_date
FROM employees
WHERE department_id = 80
AND last_name <> 'Zlotkey';


--2. 급여가 평균 급여보다 많은 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 결과를 급여에 대해 오름
--차순으로 정렬하시오.
SELECT employee_id, last_name, salary
FROM employees
WHERE salary = (SELECT AVG(salary)
                FROM employees)
ORDER BY salary DESC;

--3. 이름에 u가 포함된 사원과 같은 부서에서 일하는 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 질의
--를 실행하시오.

--4. 부서 위치 ID가 1700인 모든 사원의 이름, 부서 번호 및 업무 ID를 표시하시오.
SELECT last_name, department_id, job_id
FROM employees NATURAL JOIN departments
WHERE location_id = 1700;

--5. King에게 보고하는(manager가 King) 모든 사원의 이름과 급여를 표시하시오.
SELECT last_name, salary
FROM employees
WHERE NVL(manager_id, 0) <> 0;

--6. Executive 부서의 모든 사원에 대한 부서 번호, 이름 및 업무 ID를 표시하시오.
SELECT department_id, last_name, job_id
FROM employees NATURAL JOIN departments
WHERE department_name LIKE 'Executive';


--7. 평균 급여보다 많은 급여를 받고 이름에 u가 포함된 사원과 같은 부서에서 근무하는 모든 사원의 사원 번호, 이름
--및 급여를 표시하시오.
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees) 
AND LOWER(last_name) LIKE '%u%';
