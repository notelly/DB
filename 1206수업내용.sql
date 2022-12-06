--DECODE
SELECT last_name, job_id, salary,
        DECODE(job_id,  'IT_PROG', 1.10*salary,
                        'ST_CLERK', 1.15*salary,
                        'SA_REP', 1.20*salary,
                         salary) REVIED_SALARY
FROM employees;

--연봉에 따른 세금
SELECT last_name, salary,
        DECODE((TRUNC(salary/2000, 0)), 0 , 0.00,
                                       1 , 0.09,
                                       2 , 0.20,
                                       3 , 0.30,
                                       4 , 0.40,
                                       5 , 0.42,
                                       6 , 0.44,
                                           0.45)
                                        TAX_RATE
FROM employees
WHERE department_id = 60;

--그룹 함수(다중 행 함수)
--평균, 합계 최대값, 최소값. <기초>

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees;

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees
WHERE department_id = 60;

SELECT MAX(department_id), MIN(department_id)
FROM departments;


--회원이 새롭게 회원가입 하는 경우
-- id 'yedam'가 존재하는 지 확인
-- 'yedam'은 member table에 없음
--SELECT NVL(count(*),0) >>이걸 사용
--FROM member
--WHERE id = "yedam'


SELECT MAX(last_name), MIN(last_name)
FROM employees;

SELECT MAX(hire_date), MIN(hire_date)
FROM employees;

--COUNT () 가로가 몇개냐 COUNT(DISTINCT department_id) DISTINCT 중복을 제거하고 나서 가로가 몇개
-- 특정 컬럼을 지정해서 COUNT를 사용하면 null을 가린다. null빼고 계산
SELECT COUNT(*), COUNT(NVL(department_id,0)), COUNT(DISTINCT department_id)
FROM employees;

SELECT *
FROM employees;

SELECT AVG(commission_pct), AVG(NVL(commission_pct,0))
FROM employees;

--데이터 그룹화
--SELECT 절에 있는 열 목록에서 그룹 함수에 없는 열을 GROUP BY절에 반드시 지정
--GROUP BY 절에 있는 열 목록은 SELECT 절에 지정하지 않아도 됨
--WHERE 절을 사용하면 그룹별로 구분하기 전에 행을 제한할 수 있음
--GROUP BY 절에는 열 별칭을 사용할 수 없음
--질의 결과는 GROUP BY 목록에 포함된 열의 오름차순으로 정렬.
--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

--오류난다. 그룹함수를 쓴다는 것은 무조건 기준이 있어야한다.
--갯수도 안 맞음 여려행과 한가지 만 조회하는 것들은 같이 쓰지 못한다.
SELECT department_id, SUM(salary), COUNT(*)
FROM employees;

--sum과 count를 쓸때 컬럼을 쓰고 싶으면 그룹화를 시켜주어야한다.
SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id
ORDER BY 1;
--ORDER BY 1 첫번째 행을 기준으로 정렬

SELECT department_id, job_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY 1,2;
--50번 부서 & 직책 별로 분류
--80번 부서이고 & 직책 별로 또 분류한 것에서 연봉 합계와 갯수


--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
--employees 테이블에서 부서번호가 50번보다 같거나 큰 부서에서 직책이 동일한 사람들의
--총 월급 합계, 인원 수를 출력하세요.
SELECT department_id, job_id, SUM(salary), COUNT(*)
FROM employees
WHERE department_id >= 50
GROUP BY department_id, job_id
ORDER BY 1,2;

SELECT department_id, job_id, SUM(salary), COUNT(*)
FROM employees
--WHERE COUNT(*) <> 1 --그룹함수에 where절 쓰면 오류남.
GROUP BY department_id, job_id
HAVING COUNT(*) <> 1
ORDER BY 1,2;

--그럼 최대 값을 가지는 부서 id는 어캐 구함
SELECT MAX(SUM(salary))
FROM employees
GROUP BY department_id;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;

                            

--1. 모든 사원의 급여 최고액, 최저액, 총액 및 평균액을 표시하시오. 열 레이블을 각각 Maximum, Minimum, Sum 
--및 Average로 지정하고 결과를 정수로 반올림하도록 작성하시오.

SELECT MAX(salary) AS Maximum, MIN(salary) AS Minimum, SUM(salary) AS Sum , ROUND(avg(NVL(salary,0))) AS Average
FROM employees;

2. 최고 급여와 최저 급여의 차액을 표시하는 질의를 작성하고 열 레이블을 DIFFERENCE로 지정하시오.
--그룹함수들 간에 연산이 가능하다.
SELECT MAX(salary)-MIN(salary) AS DIFFERENCE
FROM employees;


3. 관리자 번호 및 해당 관리자에 속한 사원의 최저 급여를 표시하시오. 관리자를 알 수 없는 사원 및 최저 급여가
6,000 미만인 그룹은 제외시키고 결과를 급여에 대한 내림차순으로 정렬하시오.

SELECT manager_id, MIN(salary)
FROM employees
WHERE NVL(manager_id,0) <> 0 --AND salary >= 6000 --WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN (salary) >= 6000
ORDER BY MIN(salary) DESC;

--JOIN
SELECT employee_id, last_name, department_name
FROM employees, departments;

SELECT COUNT(*)
FROM employees;

SELECT COUNT(*)
FROM departments;

--EQUI JOIN
SELECT employees.employee_id, employees.department_id, departments.department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id
ORDER BY 1;

SELECT e.employee_id, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
ORDER BY 1;

--NON-EQUI JOIN
SELECT *
FROM job_grades;
--INNER JOIN
-- 1) FROM 절 안에 JOIN 안쓰고 할 경우 -> WHERE
-- 2) FROM 절 안에 JOIN 쓰고 할 경우 -> ON
-- FROM -> ON -> JOIN -> WHERE .....
SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;
--JOIN을 쓰면 WHERE 대신 ON을 써야한다.
--순서상으로 WHERE은 새로운 테이블이 있어야 사용가능 하므로 JOIN 과 함께 사용 불가능.
--결론 WHERE은 나중에 사용할 수 있다.

SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal
WHERE e.salary > 5000
ORDER BY 1;
 
SELECT *
FROM departments;
 
 
-- 문제1) 사원들의 이름, 부서번호, 부서명을 출력하라
SELECT e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- 문제2) 사원이름과 부서명과 월급을 출력하는데 월급이 3000 이상인 사원을 출력하라
SELECT e.first_name, d.department_name, e.salary
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary >= 3000
ORDER BY 3;

--이렇게도 쓰기 가능
SELECT e.first_name, d.department_name, e.salary
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.salary >= 3000;

--OUTTER JOIN
--기준이 되지 않는 테이블에 내용은 한번은 꼭 출연해야한다.
-- 기준 테이블에 없다면 null 찍고 걍 출력된다.
-- 조인 조건을 만족하지 않는 행들도 보기 위해서 Outer join 사용한다.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;
--위와 동일
--부서 CONTRACTING 의 정보를 가진 애들이 없다. null로 처리한다.
--부서 테이블이 기준.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;

--부서에 대한 정보가 없다. 부서번호가 없다. 아직 부서 배정이 되지 않았다.
--사원 테이블이 기준.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);
--위와 동일
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

--FULL OUTER JOIN (LEFT+RIGHT)(중복 제외 => 합집합.) 
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON e.department_id = d.department_id;

--ON은 조인 전에 발생. 조인 할 때 : ON+AND
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON e.department_id = d.department_id
AND e.salary > 5000;

--ON 조건으로 조인을 한 다음에 WHERE 실행. ON -> WHERE
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 5000;
-- ON ~ AND
-- ON ~ WHERE

SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e JOIN employees m
ON e.manager_id = m.employee_id;

SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e LEFT OUTER JOIN employees m
ON e.manager_id = m.employee_id;

--CROSS JOIN (카데시안 프러덕트와 동일 NxM)
SELECT  last_name, department_name
FROM employees CROSS JOIN departments;
--20*8 160개가 나옴

-- Natural Join 알아서 맞는 컬럼을 찾아와서 조인 함.
SELECT department_id, department_name, location_id, city
FROM departments NATURAL JOIN locations;

SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments;

--USING 절
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);
--ON e.department_id = d.department_id 와 동일하다. 사용할 경우 e d 를 설정해 줘야함

--ON 절
SELECT employee_id, last_name, e.department_id, department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id;

--ON 절과 WHERE절
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 9000;
--위와 큰 차이는 없으나, ...?
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
AND e.salary > 9000;

--3Way JOIN
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON(d.location_id = l.location_id);


SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON(d.location_id = l.location_id);

--GROUP 함수와 JOIN 응용
SELECT d.department_name, MIN(e.salary), MAX(e.salary), TRUNC(AVG(e.salary))
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
GROUP BY d.department_name;


