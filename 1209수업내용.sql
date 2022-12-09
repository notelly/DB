SELECT *
FROM employees;

--VIEW
CREATE VIEW empvu80
AS SELECT employee_id, last_name, salary
FROM employees
WHERE department_id = 80;
--������ ��� ������ �ȵ�
--������ ���� ���� GRANT create view to hr; �Է��ϱ�

--view�� ������ ������ �������.
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
DESC salvu50; --��Ī�� �ٿ��� �� �� �̸����� �÷����� �ٲ�ٴ� ���� �� �� �ִ�.

SELECT *
FROM empvu80;
--���� (emp �����͸� �����ϸ� view�� ������ ������ : view�� emp�� ��� �ٶ󺸰� �ִ�.)
UPDATE employees
SET salary = salary * 1.1;
--�굵 �ٲ����.
SELECT *
FROM salvu50;
--View ����
--��ü�ϴ�.
CREATE OR REPLACE VIEW salvu50
AS
    SELECT employee_id "���", last_name "�̸�", salary*12 "����", hire_date "�Ի���"
    FROM employees
    WHERE department_id = 50;

--������ ���� �並 �ϴ� ������.
--�������� ������.
SELECT view_name, text
FROM user_views;

--�������� ���� �� �ȵƴµ� ��Ī ���̴ϱ� ��. ����
--�׷��Լ�? �Ҷ��� ��Ī �ٿ������
CREATE OR REPLACE VIEW empvu80
AS SELECT MAX(salary) "�ִ밪"
FROM employees
WHERE department_id = 80;

--������ ���ϰ� ���� �� ROWNUM
SELECT ROWNUM, employee_id, salary
FROM employees;

--view�� ���ؼ��� ������Ʈ�� �����ϴ�.
UPDATE emempvu80
SET salary = salary * 1.1;

--complex view//������ �� (JOIN�� ����� ���� ���̺��� �����) ����
--���̺��� 2���̻� ���

CREATE OR REPLACE VIEW dept_sum_vu
(name, minsalm, maxsal, avgsal) --view���� ��Ī ���̴� ���ο� ���. //�ڿ��ٰ� �����൵ ��.
AS
    SELECT d.department_name, MIN(salary),
           MAX(e.salary), TRUNC(AVG(e.salary))
    FROM employees e JOIN departments d
    ON (e.department_id = d.department_id)
    GROUP BY d.department_name;

SELECT *
FROM dept_sum_vu;

--view ���������� �� �� ����.
--WITH CHECK OPTION �̻��
--�� -> ��
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
--id�� 176�� ����� �޿��� 9800�� �ٲ�� ���� Ȯ�� �� �� �ִ�.
SELECT *
FROM employees
WHERE employee_id = 176;
--view�ε� ������ ������ �� �ִٴ� ����� �� �� �ִ�.

ROLLBACK;

UPDATE empvu80
SET department_id = 80
WHERE employee_id = 176;

SELECT *
FROM empvu80;

--���� �÷��� �ƴ� �ֵ��� ������ �Ұ����ϴ�.
--�� -> ��
CREATE OR REPLACE VIEW empvu80
AS
    SELECT employee_id, last_name, salary, department_id
    FROM employees
    WHERE department_id = 80
    WITH CHECK OPTION;

--������ �ȵ�. >> �䰡 ��ȸ�ϴ� ���뿡�� ������ ������ �ȵ�
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
-- READ ONLY�̱� ������ ������ �ȵ�.
UPDATE empvu80
SET salary = 9800
WHERE employee_id = 174;


--�� ����
SELECT view_name, text
FROM user_views;

DROP VIEW empvu80;
SELECT *
FROM empvu80;

--�ε��� �ڵ�����
--primary key or unique
--�ε��� ��ȸ
SELECT *
FROM ALL_IND_COLUMNS
WHERE table_name = 'EMPLOYEES';

--�ε��� �ڵ�����
CREATE TABLE yedam(
std_no number(10) CONSTRAINT std_no_pk primary key,
std_name varchar2(10));

SELECT *
FROM ALL_IND_COLUMNS
WHERE table_name = 'YEDAM';

--�ε��� ���� ����
CREATE INDEX yedam_sname_idx ON yedam(std_name);

--�ε��� Ȯ��
SELECT table_name, index_name
FROM user_indexs
WHERE table_name = 'YEDAM';

--�������� Ȯ��
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'YEDAM';


--���� �ε��� ����
DROP INDEX YEDAM_SNAME_IDX;
--�ڵ� ���ؽ� ����
DROP INDEX STD_NO_PK; --������ �Ұ�
DROP TABLE yedam;
--���̺��� �������ν� �ε����� �Բ� ��������.

--������
CREATE SEQUENCE dept_deptid_seq
                INCREMENT BY 10
                START WITH 200
                MAXVALUE 9999
                NOCYCLE
                NOCACHE;
--���̰� ��� ���ġ�
INSERT INTO departments (department_id, department_name, location_id)
VALUES(dept_deptid_seq.NEXTVAL, 'Support', 2500); -- �����ϸ� NEXTVAL ���� ���� ������ �Ͷ�
--210 -> 220                pk
INSERT INTO departments (department_id, department_name, location_id)
VALUES(dept_deptid_seq.CURRVAL, 'Support', 2500);
--      department_id�� �̹� 210�� ������ �ִ�. �׷��� �� ������ ��

--������ ����
ALTER SEQUENCE dept_deptid_seq
                INCREMENT BY 20
                MAXVALUE 9999
                NOCYCLE
                NOCACHE;
--dept_deptid_seq = 210 -> 230
INSERT INTO departments (department_id, department_name, location_id)
VALUES(dept_deptid_seq.NEXTVAL, 'Support', 2500);
--���������� �Է�, ���� �����Ǿ����� �� �� ����.
--user�� �ִ� ������ ��ȸ
SELECT*
FROM user_sequences;
--������ ����.
DROP sequence dept_deptid_seq;

--���Ǿ�
SELECT *
FROM dept_sum_vu;
--������ ������ GRANT CREATE SYNONYM to hr; �̰� �����ڿ��� �����ֱ�
CREATE SYNONYM d_sum
FOR dept_sum_vu;

SELECT *
FROM d_sum;

SELECT synonym_name, table_owner, table_name
FROM user_synonyms;
--���Ǿ� ����
DROP SYNONYM d_sum;

DROP TABLE emp;


--�ý��� ���� �ο�

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


--������Ʈ ���� �����
REVOKE update
ON departments
FROM demo;
--��ȸ ���� ����
REVOKE select
ON employees
FROM demo;


--��� sql ��� ���� ���� �Լ� �Ұ�

--ROWNUM
--������ �����Ϳ� ������ �ޱ� �� ���� ��
SELECT *
FROM employees;

SELECT ROWNUM, employee_id
FROM employees;
--�� �ƽ�Ÿ �ϸ� �ȵ���

--RANK() OVER
--ORDER BY ���� ��� ���������� ������ ��, ��ŷ�� �ű�� ��
SELECT RANK() OVER(ORDER BY salary DESC) AS "�޿� ����", salary
FROM employees;
--������ ��� ���� n���� �����ִ°� �̰Ŵ�. <ȸ�� ��ü���� �޿� ��ŷ�� �ű�>
--<�μ��� ��ŷ�� �Ű���> ���� ��� �������� ��ŷ�� �ű�ڴ�. PARTITION BY
--�Ǿȿ��� ��Ƽ������ ������ �������̸� �ϰڴ�.
SELECT RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS "�޿� ����",
    salary
FROM employees;

--WITH
--������ ���̺��� ���� ����ϰڴ�.
--��ȸ������ �ѹ� ������ �ö�
WITH example 
AS (
    SELECT *
    FROM departments
    )
SELECT *
FROM example;
--�ζ��κ並 ���� �ʹ� �����ϸ� �������� ��ſ� ���带 ������ �ִ�.







