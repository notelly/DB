---1. Zlotkey�� ������ �μ��� ���� ��� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. Zlotkey�� �������
--�����Ͻÿ�.
SELECT last_name, hire_date
FROM employees
WHERE department_id = 80
AND last_name <> 'Zlotkey';


--2. �޿��� ��� �޿����� ���� ��� ����� ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� ����� �޿��� ���� ����
--�������� �����Ͻÿ�.
SELECT employee_id, last_name, salary
FROM employees
WHERE salary = (SELECT AVG(salary)
                FROM employees)
ORDER BY salary DESC;

--3. �̸��� u�� ���Ե� ����� ���� �μ����� ���ϴ� ��� ����� ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� ����
--�� �����Ͻÿ�.

--4. �μ� ��ġ ID�� 1700�� ��� ����� �̸�, �μ� ��ȣ �� ���� ID�� ǥ���Ͻÿ�.
SELECT last_name, department_id, job_id
FROM employees NATURAL JOIN departments
WHERE location_id = 1700;

--5. King���� �����ϴ�(manager�� King) ��� ����� �̸��� �޿��� ǥ���Ͻÿ�.
SELECT last_name, salary
FROM employees
WHERE NVL(manager_id, 0) <> 0;

--6. Executive �μ��� ��� ����� ���� �μ� ��ȣ, �̸� �� ���� ID�� ǥ���Ͻÿ�.
SELECT department_id, last_name, job_id
FROM employees NATURAL JOIN departments
WHERE department_name LIKE 'Executive';


--7. ��� �޿����� ���� �޿��� �ް� �̸��� u�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ��� ����� ��� ��ȣ, �̸�
--�� �޿��� ǥ���Ͻÿ�.
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees) 
AND LOWER(last_name) LIKE '%u%';
