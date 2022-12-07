--부서 번호가 60번인 곳에서 직책이 'IT_PROG'인 사람//
--사람의 급여보다 더 많은 급여를 가진 사람을 구하시오. 2개의 조건.
--Subquery

--1.이름이 Abel인 사람의 급여 2.보다 더 많이 받는 근무자 리스트를 출력
--1. 서브쿼리 작성
SELECT salary 
FROM employees
WHERE last_name = 'Abel';
--출력값 : 11000
--2. 서브쿼리로 나온 데이터를 가지고 메인 쿼리를 만듦.
SELECT *
FROM employees
WHERE salary > 11000;
--메인 쿼리와 서브 쿼리를 합체, 정상적으로 2번 질의문과 똑같이 나오는지 확인

SELECT *
FROM employees
WHERE salary > (SELECT salary 
                FROM employees
                WHERE last_name = 'Abel');
-- 서브쿼리의 값이 하나만 나옴 = 단일 행 서브쿼리
--이름이 'Matos'인 사람과 직책이 같고 급여가 많은 사람의 이름과 직책, 급여를 출력하세요.
--1. 이름이 'Matos'인 사람과 직책이 같고 (&)
--2. 급여가 많은 사람의 이름과 직책, 급여를 출력하세요.

--1.서브쿼리 (한 쿼리에 서브쿼리가 여러개 들어가는 예제)
--ST_CLERK
SELECT job_id
FROM employees
WHERE last_name = 'Matos';
--2600
SELECT salary
FROM employees
WHERE last_name = 'Matos';

--2.메인 쿼리에 데이터를 넣어서 조회
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = 'ST_CLERK'
AND salary > 2600;

--3. 메인쿼리와 서브쿼리 합치기
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE last_name = 'Matos')
AND salary > (SELECT salary
              FROM employees
              WHERE last_name = 'Matos');


--최고 연봉을 받는 사람의 이름과 직책 급여를 조회
SELECT last_name, job_id, salary, MAX(salary)
FROM employees
GROUP BY last_name, job_id, salary;
--원하는 값이 나오지 않음.
--문법에 맞지는 않지만, 이런 식으로 구하는 것이 가장 이상적 -> 서브쿼리를 쓰는 이유
--SELECT last_name, job_id, salary, MAX(salary)
--FROM employees
--WHERE salary = MAX(salary);

--1. 서브 쿼리 작성
SELECT MAX(salary)
FROM employees;

--2. 메인 쿼리 작성
SELECT last_name, job_id, salary
FROM employees
WHERE salary = 24000;

--3. 합치기
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MAX(salary)
                FROM employees);


--부서번호가  20번인 부서의 직원 수 보다 많은 부서 번호를 출력하세요.
--cOUNT() 사용,
--1. (부서번호가  20번인 부서의 직원 수) 서브 쿼리
SELECT COUNT(*)
FROM employees
WHERE department_id = 20;

--2. 부서별로 직원 수를 구하고 나서 조건(HAVING)을 건다.
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2;

--3.합치기
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > (SELECT COUNT(*)
                 FROM employees
                 WHERE department_id = 20);

--부서 번호가 60번인 부서에서 최고 급여 받는 사람과 회사 내에서 똑같은 급여를 받는 사람을 조회
--1. 서브 쿼리
SELECT MAX(salary)
FROM employees
WHERE department_id = 60;

--2.메인 쿼리
SELECT *
FROM employees
WHERE salary = 9000;

--3. 합치기
SELECT *
FROM employees
WHERE salary = (SELECT MAX(salary)
                FROM employees
                WHERE department_id = 60);


--FROM 서브쿼리
--저장되어 있는 데이터 -> 가상의 데이터 리스트로 변경
-- ->> 가상의 데이터 리스트를 통해 데이터를 조회
SELECT *
FROM(SELECT *
     FROM employees
     WHERE department_id = 60)
WHERE salary > 6000;

--다중 행 서브쿼리
--1. 부서별 최대 급여와 2. 같은 사람의 정보를 출력.
--서브쿼리
SELECT MAX(salary)
FROM employees
GROUP BY department_id;

--메인쿼리 (부서별 최대급여를 받는 사람의 정보를 가지고 옴)
SELECT *
FROM employees
WHERE salary IN (7000,24000,13000,12000,5800,11000,9000,4400);--=7000 OR salary = 24000.....

--합치기
SELECT *
FROM employees
WHERE salary IN (SELECT MAX(salary) -- IN 대신 = 쓰면 오류남.
                 FROM employees
                 GROUP BY department_id);

--ANY

--부서 번호가 60번인 부서의 급여 리스트보다 큰 사원의 정보를 출력하세요.
--서브쿼리
SELECT salary
FROM employees
WHERE department_id = 60;
--메인쿼리
SELECT *
FROM employees
WHERE salary > 9000 OR salary > 6000 OR salary > 4200
ORDER BY 1;
--합치기
SELECT *
FROM employees
WHERE salary >ANY (SELECT salary
                FROM employees
                WHERE department_id = 60)
ORDER BY 1;

--부서 번호가 60번인 부서의 급여 리스트보다 작은 사원의 정보를 출력하세요.
--서브쿼리
SELECT salary
FROM employees
WHERE department_id = 60;
--메인쿼리
SELECT *
FROM employees
WHERE (salary < 9000 OR salary < 6000 OR salary < 4200)
AND department_id <> 60 --60이 그대로 뜸 왜지? >> 연산 우선순위 때문에 ()괄호로 정리 필요
ORDER BY 1;

select salary
FROM employees;


SELECT *
FROM employees
WHERE salary <ANY (SELECT salary
                FROM employees
                WHERE department_id = 60)
AND department_id <> 60
ORDER BY 1;        
                 
--부서 번호가 60번인 부서의 급여 리스트와 같은 사원의 정보를 출력하세요.              
SELECT salary
FROM employees
WHERE department_id = 60;
--메인쿼리 (IN과 동일)
SELECT *
FROM employees
WHERE (salary = 9000 OR salary = 6000 OR salary = 4200)
AND department_id <> 60
ORDER BY 1;
-- 합치기 ∴ =ANY는 IN과 동일
SELECT *
FROM employees
WHERE salary =ANY (SELECT salary
                   FROM employees
                   WHERE department_id = 60)
AND department_id <> 60
ORDER BY 1;  

--*ALL예제

--**부서 번호가 60번인 부서의 급여 리스트보다 큰 사원의 정보를 출력하세요.
--ANY
--최소값보다 큰 애들.
--메인쿼리
SELECT *
FROM employees
WHERE salary > 9000 OR salary > 6000 OR salary > 4200
ORDER BY 1;
SELECT *
FROM employees
WHERE salary >ANY (SELECT salary
                FROM employees
                WHERE department_id = 60)
ORDER BY 1;

--ANY와 ALL 비교

--ALL
--최대값보다 큰 애들.
--메인쿼리
SELECT *
FROM employees
WHERE salary > 9000 AND salary > 6000 AND salary > 4200
ORDER BY 1;
SELECT *
FROM employees
WHERE salary >ALL (SELECT salary
                FROM employees
                WHERE department_id = 60)
ORDER BY 1;


--**부서 번호가 60번인 부서의 급여 리스트보다 작은 사원의 정보를 출력하세요.
--ANY
--최대값보다 작은 애들.
--메인쿼리
SELECT *
FROM employees
WHERE salary < 9000 OR salary < 6000 OR salary < 4200
ORDER BY 1;
SELECT *
FROM employees
WHERE salary <ANY (SELECT salary
                FROM employees
                WHERE department_id = 60)
ORDER BY 1;

--ANY와 ALL 비교
--ALL
--최소값보다 작은 애들.
--메인쿼리
SELECT *
FROM employees
WHERE salary < 9000 AND salary < 6000 AND salary < 4200
ORDER BY 1;
SELECT *
FROM employees
WHERE salary <ALL (SELECT salary
                FROM employees
                WHERE department_id = 60)
ORDER BY 1;


--쌍비교 (교집합)
--first_name이 Bruce 인 사람의 직장상사와/ 직책(job_id)이 같은 사원의 정보를 출력하세요.
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE (manager_id, job_id) IN (SELECT manager_id, job_id
                               FROM employees
                               WHERE first_name = 'Bruce')
AND first_name <> 'Bruce';

--비쌍비교 (합집합)
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE manager_id IN (SELECT manager_id
                     FROM employees
                     WHERE first_name = 'Bruce')
AND job_id IN (SELECT job_id
               FROM employees
               WHERE first_name = 'Bruce')
AND first_name <> 'Bruce';

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--INSERT
INSERT INTO departments
VALUES (70, 'Public Relations', 100,1700);

DESC departments;

SELECT * FROM departments;

INSERT INTO departments (department_id, department_name)
VALUES (30, 'Purchasing');

INSERT INTO departments
VALUES (100, 'Finance', null, null);

INSERT INTO departments
VALUES (120, 'HR', '','');


DESC departments;

CREATE TABLE temp(
DEPARTMENT_ID NUMBER(4),
DEPARTMENT_NAME VARCHAR2(30),
MANAGER_ID NUMBER(6),    
LOCATION_ID NUMBER(4));

INSERT INTO temp
SELECT department_id, department_name, manager_id, location_id
FROM departments;

SELECT *
FROM temp;

--DELETE
DELETE FROM temp
WHERE department_id =10;

DELETE FROM temp
WHERE location_id = 1700;
--조건에 맞는 애들 전부 다 지워짐

DELETE temp;
--한번에 다 삭제.

--DELETE 에서 서브쿼리 사용
DELETE FROM temp
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE department_name = 'HR');

--뭘 지울지 콕 찝어줌
DELETE FROM temp
WHERE location_id = 1700
AND department_id = 70;

SELECT *
FROM temp;

UPDATE temp
SET department_id = 200
WHERE department_id = 100;

UPDATE temp
SET location_id = 1700;

UPDATE temp
SET manager_id = 100
WHERE department_id >= 190;

UPDATE temp
SET manager_id = (
                    SELECT department_id
                    FROM temp
                    WHERE department_name = 'Finance'
                    )
WHERE department_id =(
                        SELECT manager_id
                        FROM departments
                        WHERE department_name = 'IT'
                    );
--다른 디벨로퍼에서 temp를 조회할 수 있도록 완료 알림을 보내는 것.
commit;

DROP TABLE temp;


--데이터만 지운다.
DELETE FROM temp;
ROLLBACK;
--데이터와 데이터가 들어가는 공간까지 지운다.
TRUNCATE TABLE temp;

SELECT *
FROM temp;

--SAVEPOINT
INSERT INTO departments (department_id, department_name)
VALUES (250, 'Purchasing');

SELECT * FROM departments;
SAVEPOINT sp1;

DELETE FROM departments
WHERE department_id =250;

ROLLBACK to sp1;









