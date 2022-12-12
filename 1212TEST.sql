--1,3번 문제
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e ,departments d
WHERE e.department_id = d.department_id(+);

SELECT *
FROM departments;

--2번 문제
SELECT department_id, department_name, city
FROM departments NATURAL JOIN locations;

--4번 문제
SELECT employee_id, last_name, job_id
FROM employees
WHERE department_id =
                    (SELECT department_id
                    FROM departments
                    WHERE department_name = 'IT');

--5번문제
CREATE TABLE prof (
profNO number(4) primary key,
name varchar2(15) CONSTRAINT prof_name_nn NOT NULL CONSTRAINT prof_name_uk UNIQUE,
ID varchar2(15) not null,
hiredate date,
pay number(4),
deptNO number(4));  

DESC PROF;


SELECT *
FROM user_CONSTRAINTs
WHERE table_name = 'PROF';

--6번 문제
ALTER TABLE prof
MODIFY (deptNO number(4) CONSTRAINT prof_deptno_fk REFERENCES departments(department_id));

--7번 문제 데이터 딕셔너리 어캐 보더라


--8번 문제
--(1)
INSERT INTO prof
VALUES(1001, '차은우', 'c1001', '17/03/01', 800, 10);

INSERT INTO prof
VALUES(1002, '김제니', 'k1002', '20/11/28', 750, 20);

INSERT INTO prof
VALUES(1003, '손담비', 's1002', '21/03/02', null, null);


SELECT *
FROM prof;

--(2)
UPDATE prof
SET pay = 1100
WHERE profNo = 1001;

--(3)
commit;

--9번 문제
--(1)
CREATE INDEX prof_id_ix ON prof(ID);
--(2)
SELECT *
FROM ALL_IND_COLUMNS
WHERE table_name = 'PROF';
--(3) 3개

--(10)
--(1)
ALTER TABLE prof
ADD (gender char(3));
--(2)
ALTER TABLE prof
MODIFY (name varchar2(20));


--뒷장 7번문제
--(1)
CREATE VIEW prof_list_vu 
AS SELECT profNO AS "교수번호", name AS "교수이름", ID
    FROM prof;
    
SELECT *
FROM prof_list_vu;

--(2)
CREATE SYNONYM p_vu
FOR prof_list_vu;
SELECT *
FROM p_vu;

--(3)
CREATE SEQUENCE prof_no_seq
        INCREMENT BY 1
        START WITH 1005;

--11번문제
--(1)
CREATE OR REPLACE VIEW prof_list_vu
AS SELECT profNO AS "교수번호", name AS "교수이름", ID, hiredate
FROM prof;

--(2)
ALTER SEQUENCE prof_no_seq
        INCREMENT BY 2;

SELECT*
FROM user_sequences;

--12번문제
--(1)
CREATE USER test
IDENTIFIED BY t2460;

CREATE ROLE test_demo;

CONN system/t2460; 
--(2)

--(3)
GRANT CREATE view, CREATE synonym TO test_demo;
--(4)
GRANT select on hr.prof_list_vu to test_demo;


--13번문제
--(1)
DROP TABLE prof Purge;

--(2) 전부 사라지거나 오류남.
SELECT *
FROM p_vu;
SELECT *
FROM prof_list_vu;
SELECT *
FROM ALL_IND_COLUMNS
WHERE table_name = 'PROF';