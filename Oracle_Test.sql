SELECT * FROM employees;

--1.��� ����鿡 ���� �����ȣ�� �̸�, ����, �Ի����� ����ϼ���
SELECT employee_id, last_name, job_id, hire_date
FROM employees;

-- 2. �Ŵ��� ��å�� �ð� �ִ� ����� �����ȣ�� �ߺ����� �ʰ� ����ϼ���.
SELECT DISTINCT NVL(manager_id, 0)
FROM employees
WHERE manager_id > 0;

-- 3. ��� �߿��� �޿��� 7000�̻� 12000�����̸� �̸��� 'H'�� �����ϴ�
--����� �����ȣ, �̸�, �޿�, �μ���ȣ�� ����ϼ���.
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary >= 7000
AND salary <= 12000
AND last_name LIKE 'H%';

-- 4. 2005�� 1�� 1�� ����(2005�� 1�� 1�� ����)�� �Ի��� ����� ���, �̸�, �Ի���, ù ���ں��� 3���ڸ� ��µ� �̸��ϰ���(��Ī: EMAIL)
-- �� �̸��� ������ ���ڼ� (��Ī: EMAIL LENGTH)�� ����ϼ���

SELECT SUBSTR(employee_id, 1,1) || SUBSTR(last_name, 1,1) || SUBSTR(hire_date, 1,1) AS EMAIL,
LENGTH(email)
FROM employees
WHERE hire_date >= '05/01/01';

-- 5. ��� ����� �̸�, �Ի���, �Ի� 6���� ���� ��¥, �Ի� �� ù �ݿ���, �� �ٹ� ����, ù �޿����� ���ʷ� ǥ���Ͻÿ�
-- �� �ٹ������� �Ѵ� �̸��� �����Ͽ� ������ ǥ�� �ǵ��� �ϰ�, ù �޿����� �Ի��� ���� �� 1���̴�.
-- ����� �Ի����� �������� ������������ �����Ͻÿ�.

SELECT last_name, hire_date, hire_date+(6*30) AS afterhire, TO_CHAR(NEXT_DAY(hire_date, '��'), 'YY/MM/DD DY') AS nextfriday,
ROUND((SYSDATE - hire_date)/30) AS TotalWorked, TRUNC(ADD_MONTHS(hire_date, 1),'MON') AS Firstpay
FROM employees
ORDER BY hire_date ;

-- 6. Ŀ�̼��� �޴� ������� ������� �����ȣ, �̸�, �Ի���, ������ ǥ���ϰ��� �Ѵ�.
-- ������ �޿��� Ŀ�̼��� ���Ͽ� ���� �� �ִ�. �Ի����� '24/03/2008 ������'�� �������� ����ϰ�
-- ������ $��ȣ�� õ���� ���б�ȣ �� �Ҽ��� ��°�ڸ����� ǥ���� �� �ֵ��� �Ѵ�. ����� ���翡 ���� ������������ �����Ͻÿ�

SELECT employee_id, last_name, TO_CHAR(hire_date, 'DD/MM/rrrr DAY') AS hiredate, TO_CHAR(NVL(commission_pct,0)*salary, '$99999.99') AS extrapay
FROM employees
WHERE NVL(commission_pct,0) <> 0
ORDER BY extrapay DESC;

-- 7. �μ���ȣ�� 50���� 60�� ���� ��� �޿��� 5000 ���� ���� ������ �����ȣ, �̸�, ����ID, �޿�, �μ���ȣ�� ����ϼ���.
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE department_id >= 50
AND department_id <= 60
AND salary > 5000;

-- 8. �Լ��� �̿��Ͽ� ������̺��� ��ȭ��ȣ�� ������ȣ�� 515�� ����� ���, ����ID, ��ȭ��ȣ, �μ���ȣ�� ����ϼ���.
SELECT employee_id, job_id, department_id,
        CASE WHEN phone_number LIKE '515%' THEN phone_number
        END AS phone
FROM employees
WHERE CASE WHEN phone_number LIKE '515%' THEN phone_number END IS NOT NULL;

-- 9. ��� ���̺��� �����ȣ, ����̸�, ����, �Ի��� ����(�Ի��� �̿�), ������ �޴��� ���θ� ��Ÿ���� ���, �μ���ȣ�� ����ϼ���
--������ �޿��� Ŀ�̼��� ���ؼ� ����ϰ�, ������ �޿��� ������ ���� ���� 12�� ���ؼ� ���Ѵ�.
--���� ���� ���� ���� �ʵ��� �����Ѵ�.
--����� ������ ������ ���ԵǾ����� COMM, ���Ե��� �ʾ����� NOCOMM�� ǥ���Ͻÿ�.
--����� �μ���ȣ �� ������ ���Ͽ� ������������ �����Ͻÿ�

SELECT employee_id, last_name, salary*(1+NVL(commission_pct,0))*12 AS year_salary, TO_CHAR(hire_date, 'RRRR') AS hire_year,
        CASE NVL(commission_pct, 0) WHEN 0 THEN 'NOCOMM'
        ELSE 'COMM'
        END AS COMM,department_id
FROM employees
ORDER BY year_salary, department_id;

-- 10. ��� ���̺��� �����ȣ, ����̸�, �μ���ȣ �� �ٹ������� ǥ���Ͻÿ�.
-- �ٹ������� 20�� �μ��� ����̸� 'CANADA', '80'�� �μ��� �����̸� 'UK'�� ǥ���ϰ� ������ �������� 'USA'�� ǥ���Ͻÿ�
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

SELECT employee_id, last_name, department_id,
        CASE country_id WHEN 'CA' THEN 'CANADA'
                           WHEN 'UK' THEN 'UK'
        ELSE 'USA'
        END AS country
FROM employees NATURAL JOIN departments NATURAL JOIN locations;





