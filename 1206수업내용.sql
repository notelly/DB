--DECODE
SELECT last_name, job_id, salary,
        DECODE(job_id,  'IT_PROG', 1.10*salary,
                        'ST_CLERK', 1.15*salary,
                        'SA_REP', 1.20*salary,
                         salary) REVIED_SALARY
FROM employees;

--������ ���� ����
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

--�׷� �Լ�(���� �� �Լ�)
--���, �հ� �ִ밪, �ּҰ�. <����>

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees;

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees
WHERE department_id = 60;

SELECT MAX(department_id), MIN(department_id)
FROM departments;


--ȸ���� ���Ӱ� ȸ������ �ϴ� ���
-- id 'yedam'�� �����ϴ� �� Ȯ��
-- 'yedam'�� member table�� ����
--SELECT NVL(count(*),0) >>�̰� ���
--FROM member
--WHERE id = "yedam'


SELECT MAX(last_name), MIN(last_name)
FROM employees;

SELECT MAX(hire_date), MIN(hire_date)
FROM employees;

--COUNT () ���ΰ� ��� COUNT(DISTINCT department_id) DISTINCT �ߺ��� �����ϰ� ���� ���ΰ� �
-- Ư�� �÷��� �����ؼ� COUNT�� ����ϸ� null�� ������. null���� ���
SELECT COUNT(*), COUNT(NVL(department_id,0)), COUNT(DISTINCT department_id)
FROM employees;

SELECT *
FROM employees;

SELECT AVG(commission_pct), AVG(NVL(commission_pct,0))
FROM employees;

--������ �׷�ȭ
--SELECT ���� �ִ� �� ��Ͽ��� �׷� �Լ��� ���� ���� GROUP BY���� �ݵ�� ����
--GROUP BY ���� �ִ� �� ����� SELECT ���� �������� �ʾƵ� ��
--WHERE ���� ����ϸ� �׷캰�� �����ϱ� ���� ���� ������ �� ����
--GROUP BY ������ �� ��Ī�� ����� �� ����
--���� ����� GROUP BY ��Ͽ� ���Ե� ���� ������������ ����.
--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

--��������. �׷��Լ��� ���ٴ� ���� ������ ������ �־���Ѵ�.
--������ �� ���� ������� �Ѱ��� �� ��ȸ�ϴ� �͵��� ���� ���� ���Ѵ�.
SELECT department_id, SUM(salary), COUNT(*)
FROM employees;

--sum�� count�� ���� �÷��� ���� ������ �׷�ȭ�� �����־���Ѵ�.
SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id
ORDER BY 1;
--ORDER BY 1 ù��° ���� �������� ����

SELECT department_id, job_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY 1,2;
--50�� �μ� & ��å ���� �з�
--80�� �μ��̰� & ��å ���� �� �з��� �Ϳ��� ���� �հ�� ����


--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
--employees ���̺��� �μ���ȣ�� 50������ ���ų� ū �μ����� ��å�� ������ �������
--�� ���� �հ�, �ο� ���� ����ϼ���.
SELECT department_id, job_id, SUM(salary), COUNT(*)
FROM employees
WHERE department_id >= 50
GROUP BY department_id, job_id
ORDER BY 1,2;

SELECT department_id, job_id, SUM(salary), COUNT(*)
FROM employees
--WHERE COUNT(*) <> 1 --�׷��Լ��� where�� ���� ������.
GROUP BY department_id, job_id
HAVING COUNT(*) <> 1
ORDER BY 1,2;

--�׷� �ִ� ���� ������ �μ� id�� ��ĳ ����
SELECT MAX(SUM(salary))
FROM employees
GROUP BY department_id;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;

                            

--1. ��� ����� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ǥ���Ͻÿ�. �� ���̺��� ���� Maximum, Minimum, Sum 
--�� Average�� �����ϰ� ����� ������ �ݿø��ϵ��� �ۼ��Ͻÿ�.

SELECT MAX(salary) AS Maximum, MIN(salary) AS Minimum, SUM(salary) AS Sum , ROUND(avg(NVL(salary,0))) AS Average
FROM employees;

2. �ְ� �޿��� ���� �޿��� ������ ǥ���ϴ� ���Ǹ� �ۼ��ϰ� �� ���̺��� DIFFERENCE�� �����Ͻÿ�.
--�׷��Լ��� ���� ������ �����ϴ�.
SELECT MAX(salary)-MIN(salary) AS DIFFERENCE
FROM employees;


3. ������ ��ȣ �� �ش� �����ڿ� ���� ����� ���� �޿��� ǥ���Ͻÿ�. �����ڸ� �� �� ���� ��� �� ���� �޿���
6,000 �̸��� �׷��� ���ܽ�Ű�� ����� �޿��� ���� ������������ �����Ͻÿ�.

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
-- 1) FROM �� �ȿ� JOIN �Ⱦ��� �� ��� -> WHERE
-- 2) FROM �� �ȿ� JOIN ���� �� ��� -> ON
-- FROM -> ON -> JOIN -> WHERE .....
SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;
--JOIN�� ���� WHERE ��� ON�� ����Ѵ�.
--���������� WHERE�� ���ο� ���̺��� �־�� ��밡�� �ϹǷ� JOIN �� �Բ� ��� �Ұ���.
--��� WHERE�� ���߿� ����� �� �ִ�.

SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal
WHERE e.salary > 5000
ORDER BY 1;
 
SELECT *
FROM departments;
 
 
-- ����1) ������� �̸�, �μ���ȣ, �μ����� ����϶�
SELECT e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- ����2) ����̸��� �μ���� ������ ����ϴµ� ������ 3000 �̻��� ����� ����϶�
SELECT e.first_name, d.department_name, e.salary
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary >= 3000
ORDER BY 3;

--�̷��Ե� ���� ����
SELECT e.first_name, d.department_name, e.salary
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.salary >= 3000;

--OUTTER JOIN
--������ ���� �ʴ� ���̺� ������ �ѹ��� �� �⿬�ؾ��Ѵ�.
-- ���� ���̺� ���ٸ� null ��� �� ��µȴ�.
-- ���� ������ �������� �ʴ� ��鵵 ���� ���ؼ� Outer join ����Ѵ�.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;
--���� ����
--�μ� CONTRACTING �� ������ ���� �ֵ��� ����. null�� ó���Ѵ�.
--�μ� ���̺��� ����.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;

--�μ��� ���� ������ ����. �μ���ȣ�� ����. ���� �μ� ������ ���� �ʾҴ�.
--��� ���̺��� ����.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);
--���� ����
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

--FULL OUTER JOIN (LEFT+RIGHT)(�ߺ� ���� => ������.) 
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON e.department_id = d.department_id;

--ON�� ���� ���� �߻�. ���� �� �� : ON+AND
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON e.department_id = d.department_id
AND e.salary > 5000;

--ON �������� ������ �� ������ WHERE ����. ON -> WHERE
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

--CROSS JOIN (ī���þ� ������Ʈ�� ���� NxM)
SELECT  last_name, department_name
FROM employees CROSS JOIN departments;
--20*8 160���� ����

-- Natural Join �˾Ƽ� �´� �÷��� ã�ƿͼ� ���� ��.
SELECT department_id, department_name, location_id, city
FROM departments NATURAL JOIN locations;

SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments;

--USING ��
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);
--ON e.department_id = d.department_id �� �����ϴ�. ����� ��� e d �� ������ �����

--ON ��
SELECT employee_id, last_name, e.department_id, department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id;

--ON ���� WHERE��
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 9000;
--���� ū ���̴� ������, ...?
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

--GROUP �Լ��� JOIN ����
SELECT d.department_name, MIN(e.salary), MAX(e.salary), TRUNC(AVG(e.salary))
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
GROUP BY d.department_name;


