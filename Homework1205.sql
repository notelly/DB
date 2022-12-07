SELECT *
FROM employees;
--1202
--2. EMPLOYEES ���̺��� ������ ǥ���Ͻÿ�. ��� ��ȣ�� ���� �տ� ���� �̾ �� ����� �̸�, ���� �ڵ�, �Ի����� ������ ���Ǹ� �ۼ��Ͻÿ�.
--HIRE_DATE ���� STARTDATE��� ��Ī�� �����Ͻÿ�. 
DESC employees;

SELECT employee_id, first_name, department_id, hire_date AS STARTDATE
FROM employees;

--3. EMPLOYEES ���̺��� ���� �ڵ带 �ߺ����� �ʰ� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.

SELECT DISTINCT department_id
FROM employees;

--5. ���� ID�� �̸��� ������ ���� ��ǥ �� �������� �����Ͽ� ǥ���ϰ� �� �̸��� Employee and Title�� �����Ͻÿ�.
SELECT department_id||', '||first_name AS "Employee and Title"
FROM employees;

--6. �޿��� 12,000�� �Ѵ� ����� �̸��� �޿��� ǥ���ϴ� ���Ǹ� �����Ͻÿ�.
SELECT first_name, salary
FROM employees
WHERE salary > 12000;

--7. ��� ��ȣ�� 176�� ����� �̸��� �μ� ��ȣ�� ǥ���ϴ� ���Ǹ� �����Ͻÿ�.
SELECT first_name, department_id
FROM employees
WHERE department_id = 176;

--8. �޿��� 5,000���� 12,000 ���̿� ���Ե��� �ʴ� ��� ����� �̸��� �޿��� ǥ���ϵ��� ���Ǹ� �����Ͻÿ�.
SELECT first_name, salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;

--1. Ŀ�̼��� �޴� ��� ����� �̸�, �޿� �� Ŀ�̼��� �޿� �� Ŀ�̼��� �������� ������������ �����Ͽ� ǥ���Ͻÿ�.

SELECT DISTINCT first_name, salary, commission_pct, salary + salary * NVL(commission_pct,0) AS monthly_sal
FROM employees
WHERE NVL(commission_pct,0) <> 0
ORDER BY monthly_sal DESC;

--2. ������ ���� ��� �Ǵ� �繫���̸鼭 �޿��� 2,500, 3,500 �Ǵ� 7,000�� �ƴ� ��� ����� �̸�, ���� �� �޿��� ǥ���Ͻÿ�.
SELECT first_name, job_id, salary
FROM employees
WHERE job_id LIKE '%SA%' OR job_id LIKE '%CLERK%'
INTERSECT
SELECT first_name, job_id, salary
FROM employees
WHERE salary NOT IN (2500, 3500, 7000);


--3. �� ����� ���� ��� ��ȣ, �̸�, �޿� �� 15% �λ�� �޿��� ������ ǥ���Ͻÿ�. �λ�� �޿� ���� ���̺��� New Salary�� �����Ͻÿ�. 
SELECT employee_id, first_name, salary, salary+salary*0.15 AS New_Salary
FROM employees;


--4. 2�� ���Ǹ� �����Ͽ� �� �޿����� ���� �޿��� ���� �� ���� �߰��ϰ� ���̺��� Increase�� �����ϰ� ������ ���Ǹ� �����Ͻÿ�.

SELECT first_name, job_id, salary*0.15 AS Increase
FROM employees
WHERE job_id LIKE '%SA%' OR job_id LIKE '%CLERK%'
INTERSECT
SELECT first_name, job_id, salary*0.15 AS Increase
FROM employees
WHERE salary NOT IN (2500, 3500, 7000);


--5. �̸��� J, A �Ǵ� M���� �����ϴ� ��� ����� �̸�(�빮�� ǥ��) �� �̸� ���̸� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� �� ���� ������ ���̺��� �����Ͻÿ�.
--����� ����� �̸��� ���� �����Ͻÿ�.

SELECT first_name, LENGTH(first_name)
FROM employees
WHERE (first_name Like 'J%' OR first_name Like 'A%' OR first_name Like 'M%')
ORDER BY first_name;

--6. �� ����� �̸��� ǥ���ϰ� �ٹ� �� ��(�Ի��Ϸκ��� ��������� �� ��)�� ����Ͽ� �� ���̺���
--MONTHS_WORKED�� �����Ͻÿ�. ����� ������ �ݿø��Ͽ� ǥ���ϰ� �ٹ� �� ���� �������� �����Ͻÿ�.
SELECT first_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS MONTHS_WORKED
FROM employees
ORDER BY MONTHS_WORKED;

--7. �μ� 90�� ��� ����� ���� ��(last_name) �� ���� �Ⱓ(�� ����)�� ǥ���ϵ��� query �� �ۼ��Ͻÿ�.
--�ָ� ��Ÿ���� ���� ���� ���̺�� TENURE�� �����ϰ� �ָ� ��Ÿ���� ���� ���� �Ҽ��� ���ʿ��� truncate �Ͻÿ�.
--�׸��� ���� ���� �Ⱓ�� ������������ ���ڵ带 ǥ���մϴ�.

SELECT last_name, TRUNC((SYSDATE-hire_date)/7, 1) AS TENURE
FROM employees
WHERE department_id = 90
ORDER BY TENURE DESC;

--8. ����� �̸�, �Ի��� �� �޿� �������� ǥ���Ͻÿ�. �޿� �������� ���� ���� ����� �� ù��° �������Դϴ�.
-- �� ���̺��� REVIEW�� �����ϰ� ��¥�� ��2010.03.31 �����ϡ��� ���� �������� ǥ�õǵ��� �����Ͻÿ�.

SELECT first_name, hire_date, TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), '��'), 'YYYY.MM.DD DAY') AS REVIEW
FROM employees;

--9. ����� �̸��� Ŀ�̼��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. Ŀ�̼��� ���� �ʴ� ����� ��� ��No Commission���� ǥ���Ͻÿ�.
--�� ���̺��� COMM���� �����Ͻÿ�.

SELECT first_name, commission_pct,
        CASE WHEN NVL(commission_pct,0) <> 0 THEN commission_pct
             WHEN NVL(commission_pct,0) = 0 THEN "No Commission"
        END
FROM employees;


--10. CASE ������ ����Ͽ� ���� �����Ϳ� ���� JOB_ID ���� ���� �������� ��� ����� ����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--���� ���
--AD_PRES A
--ST_MAN B
--IT_PROG C
--SA_REP D
--ST_CLERK E
--None of the above 0