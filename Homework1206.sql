SELECT *
FROM employees;

-- GROUP FUNTION
--1. ��å�� ���� ��, �ִ� �޿�, �ּ� �޿�, ��� �޿�(�Ҽ��� �ڸ� ���ڸ����� ǥ��)�� ��å�̸� ������ ��� �Ͻÿ�.
-- ��å�� ���µ�...?
SELECT job_id, COUNT(job_id), MAX(salary), MIN(salary), ROUND(AVG(salary),1)
FROM employees
GROUP BY job_id
ORDER BY job_id;

--2. �ټӳ���� 15�� �̻��� ����� ���ؼ� �μ����� �󸶳� ���� �޿��� ���޵Ǵ��� �˰� �ʹ�.
--�μ��� �ش� ����� 3�� �̻��� �μ��� �μ���ȣ, �μ��� �޿��հ踦 �޿��հ谡 ���� ������ ����϶�.
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

--1. LOCATIONS �� COUNTRIES ���̺��� ����Ͽ� HR �μ��� ���� ��� �μ��� �ּҸ� �����ϴ� query�� �ۼ��Ͻÿ�.
--��¿� ��ġ ID, �ּ�, ��/��, ��/�� �� ������ ǥ���ϸ�, NATURAL JOIN�� ����Ͽ� ����� �����մϴ�.
SELECT department_name, location_id, state_province, city, country_name
FROM departments NATURAL JOIN locations NATURAL JOIN countries;

--2. ��� ����� ��, �Ҽ� �μ���ȣ �� �μ� �̸��� ǥ���ϴ� query�� �ۼ��Ͻÿ�.
SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

--3. Toronto�� �ٹ��ϴ� ����� ���� ������ �ʿ�� �մϴ�. toronto���� �ٹ��ϴ� ��� ����� ��, ����, �μ�
--��ȣ �� �μ� �̸��� ǥ���Ͻÿ�. (��Ʈ : 3-way join ���)
SELECT e.last_name, e.job_id, d.department_id, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Toronto';


--4. ����� �� �� ��� ��ȣ�� �ش� �������� �� �� ������ ��ȣ�� �Բ� ǥ���ϴ� ������ �ۼ��ϴµ�, �� ���̺���
--���� Employee, Emp#, Manager �� Mgr#���� �����Ͻÿ�.
SELECT emp.last_name, emp.employee_id, Mgr.last_name, Mgr.employee_id
FROM employees Emp, employees Mgr
WHERE Emp.manager_id = Mgr.employee_id;


--5. King�� ���� �ش� �����ڰ� �������� ���� ��� ����� ǥ���ϵ��� 4�� ������ �����մϴ�.
--��� ��ȣ������ ����� �����Ͻÿ�. 

SELECT emp.last_name, emp.employee_id, Mgr.last_name, Mgr.employee_id
FROM employees Emp, employees Mgr
WHERE Emp.manager_id = Mgr.employee_id(+)
ORDER BY emp.employee_id;

--6. ����� ���� �μ� ��ȣ �� �־��� ����� ������ �μ��� �ٹ��ϴ� ��� ����� ǥ���ϴ� ������ �ۼ��Ͻÿ�.
--�� ���� ������ ���̺��� �����Ӱ� ������ ���ϴ�.
SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.department_id = 110;

SELECT last_name, department_id, department_name
FROM employees NATURAL JOIN departments
WHERE department_id = 90;
--KING�� �� �ߴ� ������?

--7. HR �μ����� ���� ��� �� �޿��� ���� ������ �ʿ�� �մϴ�. ���� JOB_GRADES ���̺��� ������ ǥ���� ����
--��� ����� �̸�, ����, �μ� �̸�, �޿� �� ����� ǥ���ϴ� query�� �ۼ��Ͻÿ�.