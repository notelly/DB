SELECT *
FROM employees;

-- GROUP FUNTION
--1. 직책별 직원 수, 최대 급여, 최소 급여, 평균 급여(소숫점 자리 한자리까지 표현)을 직책이름 순으로 출력 하시오.
-- 직책이 없는데...?
SELECT job_id, COUNT(job_id), MAX(salary), MIN(salary), ROUND(AVG(salary),1)
FROM employees
GROUP BY job_id
ORDER BY job_id;

--2. 근속년수가 15년 이상인 사원에 대해서 부서별로 얼마나 많은 급여가 지급되는지 알고 싶다.
--부서별 해당 사원이 3명 이상인 부서만 부서번호, 부서별 급여합계를 급여합계가 높은 순으로 출력하라.
SELECT department_id, SUM(department_id)
FROM employees
GROUP BY department_id
HAVING COUNT(department_id) >=3
ORDER BY department_id DESC;

--JOIN

SELECT *
FROM locations;

SELECT *
FROM departments;

SELECT *
FROM employees
ORDER BY department_id;

--1. LOCATIONS 및 COUNTRIES 테이블을 사용하여 HR 부서를 위해 모든 부서의 주소를 생성하는 query를 작성하시오.
--출력에 위치 ID, 주소, 구/군, 시/도 및 국가를 표시하며, NATURAL JOIN을 사용하여 결과를 생성합니다.
SELECT department_name, location_id, state_province, city, country_name
FROM departments NATURAL JOIN locations NATURAL JOIN countries;

--2. 모든 사원의 성, 소속 부서번호 및 부서 이름을 표시하는 query를 작성하시오.
SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

--3. Toronto에 근무하는 사원에 대한 보고서를 필요로 합니다. toronto에서 근무하는 모든 사원의 성, 직무, 부서
--번호 및 부서 이름을 표시하시오. (힌트 : 3-way join 사용)
SELECT e.last_name, e.job_id, d.department_id, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Toronto';


--4. 사원의 성 및 사원 번호를 해당 관리자의 성 및 관리자 번호와 함께 표시하는 보고서를 작성하는데, 열 레이블을
--각각 Employee, Emp#, Manager 및 Mgr#으로 지정하시오.
SELECT emp.last_name, emp.employee_id, Mgr.last_name, Mgr.employee_id
FROM employees Emp, employees Mgr
WHERE Emp.manager_id = Mgr.employee_id;


--5. King과 같이 해당 관리자가 지정되지 않은 모든 사원을 표시하도록 4번 문장을 수정합니다.
--사원 번호순으로 결과를 정렬하시오. 

SELECT emp.last_name, emp.employee_id, Mgr.last_name, Mgr.employee_id
FROM employees Emp, employees Mgr
WHERE Emp.manager_id = Mgr.employee_id(+)
ORDER BY emp.employee_id;

--6. 사원의 성과 부서 번호 및 주어진 사원과 동일한 부서에 근무하는 모든 사원을 표시하는 보고서를 작성하시오.
--각 열에 적절한 레이블을 자유롭게 지정해 봅니다.
SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.department_id = 110;

SELECT last_name, department_id, department_name
FROM employees NATURAL JOIN departments
WHERE department_id = 90;
--KING이 안 뜨는 이유는?

--7. HR 부서에서 직무 등급 및 급여에 대한 보고서를 필요로 합니다. 먼저 JOB_GRADES 테이블의 구조를 표시한 다음
--모든 사원의 이름, 직무, 부서 이름, 급여 및 등급을 표시하는 query를 작성하시오.