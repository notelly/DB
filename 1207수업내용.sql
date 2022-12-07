--�μ� ��ȣ�� 60���� ������ ��å�� 'IT_PROG'�� ���//
--����� �޿����� �� ���� �޿��� ���� ����� ���Ͻÿ�. 2���� ����.
--Subquery

--1.�̸��� Abel�� ����� �޿� 2.���� �� ���� �޴� �ٹ��� ����Ʈ�� ���
--1. �������� �ۼ�
SELECT salary 
FROM employees
WHERE last_name = 'Abel';
--��°� : 11000
--2. ���������� ���� �����͸� ������ ���� ������ ����.
SELECT *
FROM employees
WHERE salary > 11000;
--���� ������ ���� ������ ��ü, ���������� 2�� ���ǹ��� �Ȱ��� �������� Ȯ��

SELECT *
FROM employees
WHERE salary > (SELECT salary 
                FROM employees
                WHERE last_name = 'Abel');
-- ���������� ���� �ϳ��� ���� = ���� �� ��������
--�̸��� 'Matos'�� ����� ��å�� ���� �޿��� ���� ����� �̸��� ��å, �޿��� ����ϼ���.
--1. �̸��� 'Matos'�� ����� ��å�� ���� (&)
--2. �޿��� ���� ����� �̸��� ��å, �޿��� ����ϼ���.

--1.�������� (�� ������ ���������� ������ ���� ����)
--ST_CLERK
SELECT job_id
FROM employees
WHERE last_name = 'Matos';
--2600
SELECT salary
FROM employees
WHERE last_name = 'Matos';

--2.���� ������ �����͸� �־ ��ȸ
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = 'ST_CLERK'
AND salary > 2600;

--3. ���������� �������� ��ġ��
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE last_name = 'Matos')
AND salary > (SELECT salary
              FROM employees
              WHERE last_name = 'Matos');


--�ְ� ������ �޴� ����� �̸��� ��å �޿��� ��ȸ
SELECT last_name, job_id, salary, MAX(salary)
FROM employees
GROUP BY last_name, job_id, salary;
--���ϴ� ���� ������ ����.
--������ ������ ������, �̷� ������ ���ϴ� ���� ���� �̻��� -> ���������� ���� ����
--SELECT last_name, job_id, salary, MAX(salary)
--FROM employees
--WHERE salary = MAX(salary);

--1. ���� ���� �ۼ�
SELECT MAX(salary)
FROM employees;

--2. ���� ���� �ۼ�
SELECT last_name, job_id, salary
FROM employees
WHERE salary = 24000;

--3. ��ġ��
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MAX(salary)
                FROM employees);


--�μ���ȣ��  20���� �μ��� ���� �� ���� ���� �μ� ��ȣ�� ����ϼ���.
--cOUNT() ���,
--1. (�μ���ȣ��  20���� �μ��� ���� ��) ���� ����
SELECT COUNT(*)
FROM employees
WHERE department_id = 20;

--2. �μ����� ���� ���� ���ϰ� ���� ����(HAVING)�� �Ǵ�.
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2;

--3.��ġ��
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > (SELECT COUNT(*)
                 FROM employees
                 WHERE department_id = 20);

--�μ� ��ȣ�� 60���� �μ����� �ְ� �޿� �޴� ����� ȸ�� ������ �Ȱ��� �޿��� �޴� ����� ��ȸ
--1. ���� ����
SELECT MAX(salary)
FROM employees
WHERE department_id = 60;

--2.���� ����
SELECT *
FROM employees
WHERE salary = 9000;

--3. ��ġ��
SELECT *
FROM employees
WHERE salary = (SELECT MAX(salary)
                FROM employees
                WHERE department_id = 60);


--FROM ��������
--����Ǿ� �ִ� ������ -> ������ ������ ����Ʈ�� ����
-- ->> ������ ������ ����Ʈ�� ���� �����͸� ��ȸ
SELECT *
FROM(SELECT *
     FROM employees
     WHERE department_id = 60)
WHERE salary > 6000;

--���� �� ��������
--1. �μ��� �ִ� �޿��� 2. ���� ����� ������ ���.
--��������
SELECT MAX(salary)
FROM employees
GROUP BY department_id;

--�������� (�μ��� �ִ�޿��� �޴� ����� ������ ������ ��)
SELECT *
FROM employees
WHERE salary IN (7000,24000,13000,12000,5800,11000,9000,4400);--=7000 OR salary = 24000.....

--��ġ��
SELECT *
FROM employees
WHERE salary IN (SELECT MAX(salary) -- IN ��� = ���� ������.
                 FROM employees
                 GROUP BY department_id);

--ANY

--�μ� ��ȣ�� 60���� �μ��� �޿� ����Ʈ���� ū ����� ������ ����ϼ���.
--��������
SELECT salary
FROM employees
WHERE department_id = 60;
--��������
SELECT *
FROM employees
WHERE salary > 9000 OR salary > 6000 OR salary > 4200
ORDER BY 1;
--��ġ��
SELECT *
FROM employees
WHERE salary >ANY (SELECT salary
                FROM employees
                WHERE department_id = 60)
ORDER BY 1;

--�μ� ��ȣ�� 60���� �μ��� �޿� ����Ʈ���� ���� ����� ������ ����ϼ���.
--��������
SELECT salary
FROM employees
WHERE department_id = 60;
--��������
SELECT *
FROM employees
WHERE (salary < 9000 OR salary < 6000 OR salary < 4200)
AND department_id <> 60 --60�� �״�� �� ����? >> ���� �켱���� ������ ()��ȣ�� ���� �ʿ�
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
                 
--�μ� ��ȣ�� 60���� �μ��� �޿� ����Ʈ�� ���� ����� ������ ����ϼ���.              
SELECT salary
FROM employees
WHERE department_id = 60;
--�������� (IN�� ����)
SELECT *
FROM employees
WHERE (salary = 9000 OR salary = 6000 OR salary = 4200)
AND department_id <> 60
ORDER BY 1;
-- ��ġ�� �� =ANY�� IN�� ����
SELECT *
FROM employees
WHERE salary =ANY (SELECT salary
                   FROM employees
                   WHERE department_id = 60)
AND department_id <> 60
ORDER BY 1;  

--*ALL����

--**�μ� ��ȣ�� 60���� �μ��� �޿� ����Ʈ���� ū ����� ������ ����ϼ���.
--ANY
--�ּҰ����� ū �ֵ�.
--��������
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

--ANY�� ALL ��

--ALL
--�ִ밪���� ū �ֵ�.
--��������
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


--**�μ� ��ȣ�� 60���� �μ��� �޿� ����Ʈ���� ���� ����� ������ ����ϼ���.
--ANY
--�ִ밪���� ���� �ֵ�.
--��������
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

--ANY�� ALL ��
--ALL
--�ּҰ����� ���� �ֵ�.
--��������
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


--�ֺ� (������)
--first_name�� Bruce �� ����� �������/ ��å(job_id)�� ���� ����� ������ ����ϼ���.
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE (manager_id, job_id) IN (SELECT manager_id, job_id
                               FROM employees
                               WHERE first_name = 'Bruce')
AND first_name <> 'Bruce';

--��ֺ� (������)
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
--���ǿ� �´� �ֵ� ���� �� ������

DELETE temp;
--�ѹ��� �� ����.

--DELETE ���� �������� ���
DELETE FROM temp
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE department_name = 'HR');

--�� ������ �� �����
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
--�ٸ� �𺧷��ۿ��� temp�� ��ȸ�� �� �ֵ��� �Ϸ� �˸��� ������ ��.
commit;

DROP TABLE temp;


--�����͸� �����.
DELETE FROM temp;
ROLLBACK;
--�����Ϳ� �����Ͱ� ���� �������� �����.
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









