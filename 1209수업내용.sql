SELECT *
FROM employees;

--VIEW
CREATE VIEW empvu80
AS SELECT employee_id, last_name, salary
FROM employees
WHERE department_id = 80;
--권한이 없어서 실행이 안됨
--관리자 한테 가서 GRANT create view to hr; 입력하기

--view의 내용을 가지고 만들어짐.
SELECT *
FROM empvu80;

CREATE VIEW salvu50
AS
    SELECT employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY
    FROM employees
    WHERE department_id = 50;

SELECT *
FROM salvu50;


DESC empvu80;
DESC salvu50; --별칭을 붙였을 때 그 이름으로 컬럼명이 바뀐다는 것을 볼 수 있다.

SELECT *
FROM empvu80;
--수정 (emp 데이터를 수정하면 view의 정보도 수정됨 : view가 emp를 계속 바라보고 있다.)
UPDATE employees
SET salary = salary * 1.1;
--얘도 바뀌었음.
SELECT *
FROM salvu50;
--View 수정
--대체하다.
CREATE OR REPLACE VIEW salvu50
AS
    SELECT employee_id "사번", last_name "이름", salary*12 "연봉", hire_date "입사일"
    FROM employees
    WHERE department_id = 50;

--유저가 가진 뷰를 싹다 보여줌.
--쿼리문도 보여줌.
SELECT view_name, text
FROM user_views;

--교수님이 했을 때 안됐는데 별칭 붙이니까 됨. 왜지
--그룹함수? 할때는 별칭 붙여줘야함
CREATE OR REPLACE VIEW empvu80
AS SELECT MAX(salary) "최대값"
FROM employees
WHERE department_id = 80;

--순서를 정하고 싶을 때 ROWNUM
SELECT ROWNUM, employee_id, salary
FROM employees;

--view를 통해서도 업데이트가 가능하다.
UPDATE emempvu80
SET salary = salary * 1.1;

--complex view//복잡한 뷰 (JOIN을 사용해 여러 테이블을 사용함) 생성
--테이블을 2개이상 사용

CREATE OR REPLACE VIEW dept_sum_vu
(name, minsalm, maxsal, avgsal) --view에서 별칭 붙이는 새로운 방법. //뒤에다가 적어줘도 됨.
AS
    SELECT d.department_name, MIN(salary),
           MAX(e.salary), TRUNC(AVG(e.salary))
    FROM employees e JOIN departments d
    ON (e.department_id = d.department_id)
    GROUP BY d.department_name;

SELECT *
FROM dept_sum_vu;

--view 제약조건을 걸 수 있음.
--WITH CHECK OPTION 미사용
--안 -> 안
CREATE OR REPLACE VIEW empvu80
AS
    SELECT employee_id, last_name, salary, department_id
    FROM employees
    WHERE department_id = 80;

SELECT *
FROM employees
WHERE department_id = 80;

UPDATE empvu80
SET salary = 9800
WHERE employee_id = 176;
--id가 176인 사람의 급여가 9800로 바뀌는 것을 확인 할 수 있다.
SELECT *
FROM employees
WHERE employee_id = 176;
--view로도 정보를 수정할 수 있다는 사실을 알 수 있다.

ROLLBACK;

UPDATE empvu80
SET department_id = 80
WHERE employee_id = 176;

SELECT *
FROM empvu80;

--뷰의 컬럼이 아닌 애들은 수정이 불가능하다.
--안 -> 밖
CREATE OR REPLACE VIEW empvu80
AS
    SELECT employee_id, last_name, salary, department_id
    FROM employees
    WHERE department_id = 80
    WITH CHECK OPTION;

--실행이 안됨. >> 뷰가 조회하는 내용에서 밖으로 나가면 안됨
UPDATE empvu80
SET department_id = 60
WHERE employee_id = 176;

UPDATE empvu80
SET salary = 9800
WHERE employee_id = 176;

ROLLBACK;

CREATE OR REPLACE VIEW empvu80
AS
    SELECT employee_id, last_name, salary, department_id
    FROM employees
    WHERE department_id = 80
    WITH READ ONLY;
-- READ ONLY이기 때문에 실행이 안됨.
UPDATE empvu80
SET salary = 9800
WHERE employee_id = 174;


--뷰 삭제
SELECT view_name, text
FROM user_views;

DROP VIEW empvu80;
SELECT *
FROM empvu80;

--인덱스 자동생성
--primary key or unique
--인덱스 조회
SELECT *
FROM ALL_IND_COLUMNS
WHERE table_name = 'EMPLOYEES';

--인덱스 자동생성
CREATE TABLE yedam(
std_no number(10) CONSTRAINT std_no_pk primary key,
std_name varchar2(10));

SELECT *
FROM ALL_IND_COLUMNS
WHERE table_name = 'YEDAM';

--인덱스 수동 생성
CREATE INDEX yedam_sname_idx ON yedam(std_name);

--인덱스 확인
SELECT table_name, index_name
FROM user_indexs
WHERE table_name = 'YEDAM';

--제약조건 확인
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'YEDAM';


--수동 인덱스 삭제
DROP INDEX YEDAM_SNAME_IDX;
--자동 인텍스 삭제
DROP INDEX STD_NO_PK; --오류남 불가
DROP TABLE yedam;
--테이블을 지움으로써 인덱스도 함께 지워진다.

--시퀀스
CREATE SEQUENCE dept_deptid_seq
                INCREMENT BY 10
                START WITH 200
                MAXVALUE 9999
                NOCYCLE
                NOCACHE;
--↑이걸 어떻게 쓰냐↓
INSERT INTO departments (department_id, department_name, location_id)
VALUES(dept_deptid_seq.NEXTVAL, 'Support', 2500); -- 실행하면 NEXTVAL 다음 값을 가지고 와라
--210 -> 220                pk
INSERT INTO departments (department_id, department_name, location_id)
VALUES(dept_deptid_seq.CURRVAL, 'Support', 2500);
--      department_id는 이미 210을 가지고 있다. 그래서 못 가지고 옴

--시퀀스 수정
ALTER SEQUENCE dept_deptid_seq
                INCREMENT BY 20
                MAXVALUE 9999
                NOCYCLE
                NOCACHE;
--dept_deptid_seq = 210 -> 230
INSERT INTO departments (department_id, department_name, location_id)
VALUES(dept_deptid_seq.NEXTVAL, 'Support', 2500);
--정상적으로 입력, 값이 수정되었음을 알 수 있음.
--user에 있는 시퀀스 조회
SELECT*
FROM user_sequences;
--시퀀스 삭제.
DROP sequence dept_deptid_seq;

--동의어
SELECT *
FROM dept_sum_vu;
--권한이 없으면 GRANT CREATE SYNONYM to hr; 이거 관리자에서 적어주기
CREATE SYNONYM d_sum
FOR dept_sum_vu;

SELECT *
FROM d_sum;

SELECT synonym_name, table_owner, table_name
FROM user_synonyms;
--동의어 삭제
DROP SYNONYM d_sum;

DROP TABLE emp;


--시스템 권한 부여

GRANT select
ON hr.employees
TO demo;

GRANT update (department_id, location_id)
ON departments
TO demo;

SELECT *
FROM departments;

GRANT select
ON departments
TO demo;


--업데이트 권한 뺏어옴
REVOKE update
ON departments
FROM demo;
--조회 권한 뺏기
REVOKE select
ON employees
FROM demo;


--고급 sql 대신 많이 쓰는 함수 소개

--ROWNUM
--임의의 데이터에 순위를 메길 때 쓰는 것
SELECT *
FROM employees;

SELECT ROWNUM, employee_id
FROM employees;
--왜 아스타 하면 안되지

--RANK() OVER
--ORDER BY 같은 경우 순차적으로 내려올 때, 랭킹을 매기는 것
SELECT RANK() OVER(ORDER BY salary DESC) AS "급여 순위", salary
FROM employees;
--동점인 경우 공동 n등을 시켜주는게 이거다. <회사 전체에서 급여 랭킹을 매김>
--<부서별 랭킹을 매겨줌> 내가 어떤애 기준으로 랭킹을 매기겠다. PARTITION BY
--탭안에서 파티션으로 나누고 오더바이를 하겠다.
SELECT RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS "급여 순위",
    salary
FROM employees;

--WITH
--가상의 테이블을 만들어서 사용하겠다.
--일회성으로 한번 가지고 올때
WITH example 
AS (
    SELECT *
    FROM departments
    )
SELECT *
FROM example;
--인라인뷰를 쓸때 너무 복잡하면 서브쿼리 대신에 위드를 쓸때도 있다.







