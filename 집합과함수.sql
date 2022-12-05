--Null ���� ���� IN�� NOT IN ����
--IN ��ȸ�ϴ� �÷� = 'aaa' or null
--NOT IN ��ȸ�ϴ� �÷� <> 'aaa' and null
SELECT employee_id, last_name, job_id, manager_id
From employees
WHERE manager_id IN (100, 101, NULL);


SELECT *
FROM employees
ORDER By 6;

--1�� �� ������ ����
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY last_name; --a~Z���� �������� // ASC ����
--��������
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY hire_date; -- 97~10�⵵����

SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY salary DESC;

SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY department_id DESC, salary DESC; --�μ��� ��������.

--��Ī
SELECT employee_id, last_name, hire_date, salary*12 annsal
FROM employees
ORDER BY annsal DESC;

--��ġ���� ���� ORDER BY
SELECT employee_id, last_name, hire_date, salary*12 annsal
FROM employees
ORDER BY 4, 3 DESC;

--ġȯ����
show verify
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = &dept_no; --���� �Է��� ���� &dept_no�� ġȯ�Ǵ� ��.
show verify on --��

show verify
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = &dept_no; --���� �Է��� ���� &dept_no�� ġȯ�Ǵ� ��.
show verify off --��

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE job_id = UPPER('&job_title'); --�� �빮�ڷ� �������� //DB�� ��ҹ��� �� ������.

SELECT employee_id, last_name, job_id, department_id, &column_name
FROM employees
ORDER BY &column_name; --�ҷ��� �����͸� ����

SELECT employee_id, last_name, job_id, department_id, &&column_name
--&&column_name �� �������� ������ column_name�� ������ ó���� �Է��� �긦 ���
FROM employees
ORDER BY &column_name;


define column_name;
undefine column_name; --ġȯ���� �ʱ�ȭ

--���� ������
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '08%'--'10%' �Ի����� 08���� �����ϴ� ����
UNION ALL
SELECT salary, first_name
FROM employees
WHERE hire_date LIKE '08%';

--minus
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '08%'
OR salary > 5000
MINUS
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '08%';

--INTERSECT
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '08%'
OR salary > 5000
INTERSECT
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '08%';

--���� �Լ�
SELECT UPPER('Oracle DataBase'), LOWER('Oracle DataBase'),
        INITCAP('oracle database')
FROM dual;

SELECT employee_id, last_name, UPPER(last_name),
        job_id, INITCAP(job_id)
FROM employees;

SELECT employee_id, last_name, job_id
FROM employees
WHERE LOWER(last_name) = 'king'; -- �� �ҹ��� ����.

SELECT employee_id, last_name, job_id
FROM employees
WHERE last_name = INITCAP('king'); --�Է��� ����� �����͸� �ٲٴ� ��

--���ڿ� ��ġ��
SELECT CONCAT('Hello', 'World')
FROM dual;

SELECT UPPER(CONCAT(CONCAT ('Hello', ' '), 'World'))
FROM dual;

SELECT employee_id, CONCAT(CONCAT(first_name, ' '), last_name) AS full_name,
        job_id, email
FROM employees;

--���ڿ� �ڸ���
SELECT SUBSTR ('HelloWorld', 1,5), SUBSTR('HelloWorld', 6),
       SUBSTR ('HelloWorld', -5,5), SUBSTR('HelloWorld', -5, -3)
FROM dual;

--�� �̸��� �� ���� ���ڸ��� n�� ���� ����϶�
SELECT *
FROM employees
WHERE SUBSTR(last_name, -1, 1) = 'n'; --like '%n';

--���� ����
SELECT LENGTH('Oracle Database'), LENGTH('����Ŭ �����ͺ��̽�')
FROM dual;

SELECT *
FROM employees
WHERE LENGTH(last_name) > 6;

--���ڿ� ã��
SELECT INSTR('HelloWorld', 'l')
FROM dual;

SELECT INSTR('HelloWorld', 'l', 1, 2)
FROM dual;

SELECT INSTR(last_name, 'a'), last_name
FROM employees
WHERE INSTR (last_name, 'a') <> 0; --a�� ���ԵǾ� �ִ� ����� ã�°�
--���� ������
SELECT *
FROM employees
WHERE last_name LIKE '%a%';

--LPAD RPAD
SELECT employee_id, RPAD(last_name, 15, '*') AS last_name,
       LPAD(salary, 10, '*') AS salary
FROM employees;

--REPLACE
SELECT REPLACE('Jack and Jue', 'J', 'BL')
FROM dual;

SELECT employee_id, last_name,
        REPLACE(last_name, SUBSTR(last_name, 2, 2), '**') AS result
FROM employees;

--TRIM ��������+ �糡�� ���� �߶󳻱�//�ȿ��� ���X
SELECT TRIM('      HelloWorld       ')
FROM dual;

SELECT TRIM('w' FROM 'window'), TRIM(LEADING 'w' FROM 'window'),
        TRIM(TRAILING 'w' FROM 'window')
FROM dual;

SELECT TRIM(0 FROM 000012345670), TRIM(LEADING 0 FROM 000012345670)
FROM dual;

--�ȵǴ� ���̽�
--SELECT TRIM('xy' FROM 'xyxyxykkkkxy')
--FROM dual;

--�����Լ�����

--1. yedam, Database �� �ܾ ���� yedamDatabase�� ����Ͻÿ�.
SELECT CONCAT('yedam', 'Database')
FROM dual;

SELECT first_name, last_name, job_id
FROM employees;


--2. lower �Լ��� Ȱ���Ͽ� it_prog(�ҹ���) ��å�� ���� ��� �������� ����Ͻÿ�.
SELECT first_name, last_name, job_id
FROM employees
WHERE LOWER(job_id) = 'it_prog'; --���� �����غ���

--3. WelcomeToCodingWorld ���ڿ�����
--1)To 2) World 3) WelcomeToCodingWorl �� ����Ͻÿ�.
SELECT SUBSTR('WelcomeToCodingWorld', INSTR('WelcomeToCodingWorld', 'T'),2),
        --8��� INSTR('WelcomeToCodingWorld', 'T')�̰� ���൵ ��
        SUBSTR('WelcomeToCodingWorld', -5,5),
        TRIM(TRAILING 'd' FROM 'WelcomTOCodingWorld'),
        SUBSTR('WelcomeToCodingWorld', 1, LENGTH('WelcomTOCodingWorld')-1) 
        -- 19��ſ�  LENGTH('WelcomTOCodingWorld')-1)�� �ᵵ ��.
        --�������� ��ȭ�ϴ� �Ŀ����� LENGTH�� ���� ���� ����
FROM dual;

--4. employees ���̺��� last_name�� ���̰� 5 �� ���� �� ��� 3�ڸ��� * ǥ���Ͽ�
--employee_id, last_name, ����� last_name�� ��ȸ�Ͻÿ�
--����( yedam -> y***m )

SELECT employee_id, last_name, REPLACE(last_name, SUBSTR(last_name, LENGTH(last_name)/2, 3), '***')
--��� 3�ڸ� 2��ſ� LENGTH(last_name)/2 ���൵ ��. ¦���� ��� ���� ����.
FROM employees
WHERE LENGTH(last_name) = 5;

--5. LPAD�� RPAD�� ������ Ȱ���Ͽ� last_name�� 10�ڸ� �� ���� ���� ������ * �߰��Ͽ� ���,
--first_name�� 10�ڸ��� ������ ������ #�� �߰��Ͽ� ��ȸ�Ͻÿ�.
SELECT RPAD(first_name, 10, '#'), LPAD(last_name, 10, '*')
FROM employees;

--6. ����� ���� �̸��� ������ �̸�, ��å, �̸��� ����, �̸� �� a�� �� ��° ���� �Ǿ� �ִ���
--��å�� REP�� ���� �� ����� ������ ��ȸ �Ͻÿ�
--��, ��å�� REP�� ���� �� ����� ã������ LIKE�� ���� �ʴ´�.
--alias �� ���� Ȱ���Ͽ� ������� �������� �Ѵ�.

SELECT employee_id, CONCAT(first_name, last_name) AS name, job_id,
        LENGTH(last_name) as name_length,
        INSTR(last_name, 'a') "contain_'a'?"
FROM employees
WHERE INSTR(job_id, 'REP') <> 0;
-- SUBSTR(job_id, 4) = 'REP'; �� ������.

--ceil�ø� floor ����

--�ݿø�
SELECT ROUND(345.678) AS round1, 
       ROUND(345.678, 0) AS round2,
       ROUND(345.678, 1) AS round3,
       ROUND(345.678, -1) AS round4
FROM dual;
--����
SELECT TRUNC(345.678) AS trunc1,
       TRUNC(345.678, 0) AS trunc2,
       TRUNC(345.678, 1) AS trunc3,
       TRUNC(345.678, -1) AS trunc4
FROM dual;

--�ش������� ������ 1000���� ������ �� ���� ������
SELECT last_name, salary, MOD(salary, 1000)
FROM employees;

--���� �ð� ��ȸ //ȸ�������Ҷ� ����ϸ� ����.
SELECT sysdate
FROM dual;

SELECT sysdate, sysdate+1, sysdate-1, to_char(sysdate+1/24*60*60, 'yyyy/mm/dd hh:mm:ss')
FROM dual;
--1/24 1�ð��� ���Ѵ�. 1/24*60 1��  1/24*60*60 1��

DESC employees;

SELECT hire_date, hire_date+(1*365)
FROM employees;

SELECT last_name, (SYSDATE - hire_date)/30 AS WEEKS
FROM employees;
-- ���� �ǹ̴� ���̸� ���� �ٸ� ���� �Ѵ��� 30 or 31���̱� ������ �׷���.
SELECT last_name, MONTHS_BETWEEN(SYSDATE, hire_date)
FROM employees;

SELECT last_name, hire_date, ADD_MONTHS(hire_date, 6)
FROM employees;

SELECT employee_id, hire_date, NEXT_DAY(hire_date, '�ݿ���'), LAST_DAY(sysdate)
FROM employees;


-- �˻� ��� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = korean;

--��¥ ��� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI'; --HH24 �� 24�ð� 2��->14��

--��¥ �Լ��� round, trunc
SELECT sysdate,
        ROUND(SYSDATE) round1, --�ݿø�
        ROUND(SYSDATE, 'DD') round2, --���� �ݿø�
        ROUND(SYSDATE, 'DAY') round3, --
        ROUND(SYSDATE, 'MON') round4, -- 15�� ���� ���� 1�� �ø� 31��
        ROUND(SYSDATE, 'YEAR') round5 -- ���� �ݿø� 12��
FROM dual;

--����.
SELECT sysdate,
        TRUNC(SYSDATE) round1, --����
        TRUNC(SYSDATE, 'DD') round2, --���� �ݿø�
        TRUNC(SYSDATE, 'DAY') round3, -- 15�� ���� ���� 1�� �ø� 31��
        TRUNC(SYSDATE, 'MON') round4, -- 6�����,
        TRUNC(SYSDATE, 'YEAR') round5
FROM dual;

ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD';
--����

SELECT employee_id, last_name, salary, hire_date, TO_CHAR(hire_date, 'yyyy/mm/dd HH24:MI')
FROM employees;

SELECT TO_CHAR(hire_date, 'fm yyyy "��" Ddspth Month hh:mi:ss AM')
FROM employees;



SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd day')AS hire_date,
        TO_CHAR(hire_date, 'q') AS �б�,
        TO_CHAR(hire_date, 'w') || '����' AS �ּ�
FROM employees;

SELECT  TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss') as one, --����ð�
        TO_CHAR(sysdate+3/24, 'yyyy/mm/dd hh24:mi:ss')as two, --�Ϸ� 24�ð��� 3�ð��� ����
        TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss') as three --�ð�*60�� => 40���� ����.
FROM dual;

--���ڿ� TO_CHAR �Լ� ���
SELECT employee_id, last_name, salary, TO_CHAR(salary, '$999,999')
FROM employees;

SELECT employee_id, last_name, salary, TO_CHAR(salary, '$999,999,999'),
        TO_CHAR(salary, '$099,99.99') AS sal --�տ� ������ 0�� �߰� �Ҽ��� 2°�ڸ����� ǥ��
FROM employees;

SELECT employee_id, last_name, salary,
        TO_CHAR(salary, 'L999,999')
FROM employees;

ALTER session SET nls_territory = korea;

SELECT employee_id, last_name, salary,
        TO_CHAR(salary, 'L999,999')
FROM employees;

--TO_NUMDER
SELECT employee_id, last_name, TO_NUMBER('$3,400', '$99,999')
FROM employees;

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > TO_NUMBER('$8,000', '$9,999');


SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('1999/12/31', 'yy/mm/dd');
--�ڿ� �� ���� �߰�����

CREATE TABLE test(
id number(3),
name varchar2(10),
hiredate date);

INSERT INTO test VALUES (1, 'yedam', '95/03/01');
INSERT INTO test VALUES (2, 'yedam', '10/03/01');
SELECT *
FROM test
WHERE hiredate = '95/03/01';

ALTER SESSION SET nls_date_format = 'YYYY-MM-DD';

SELECT *
FROM test;

ALTER SESSION SET nls_date_format = 'yy/mm/dd';
INSERT INTO test VALUES (3, 'yedam', '95/03/01');
INSERT INTO test VALUES (4, 'yedam', '10/03/01');

SELECT *
FROM test;

--�Ϲ��Լ��� ��ø�Լ�
SELECT last_name, upper(CONCAT(SUBSTR(last_name, 1,8), '_US'))
FROM employees
WHERE department_id = 60;

SELECT*
FROM employees;

--commission_pct �� �÷��� �����ϴٰ� null�� ������ 0���� �ٲٶ�� �ǹ�
SELECT employee_id, last_name, salary, NVL(commission_pct,0)
FROM employees;

SELECT employee_id, last_name, +salary salary * commission_pct as monthly_sal --NVL(commission_pct,0)
FROM employees;
--null�� �� ������ ����ϱ�
SELECT employee_id, last_name, salary + salary * NVL(commission_pct,0) as monthly_sal
FROM employees;

--null�̸� �μ�Ƽ�긦 ������ ����. N null�̾ƴϸ� Ŀ�̼��̶�� ���̺� ���� �����Ѵ�. �μ�Ƽ�� �޴´� ��
--�󿩱��� ���� �� �ִ��� ������.
SELECT employee_id, last_name, salary+salary*NVL(commission_pct,0) as monthly_sal,
        NVL2(commission_pct, 'Y', 'N') AS comm_get
FROM employees;

--������ � ���·� �������� 
--�󿩱��� null �󿩱�X ���޸� �޴´� �󿩱� null�� X  ����+�󿩱�
SELECT last_name, salary, commission_pct,
        NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM employees
WHERE department_id IN (50, 80); --�μ��� 50���̰� �μ��� 80���� ����� ���ؼ�.
--�����ͺ��̽��� �����Ͱ� �����ϳ� ���θ� �����ϴµ� �̰��� ���⵵ �Ѵ�.
--EX) ���̵�. ���̵� ������ null�� �ν��Ѵ�. null  -> 0�� ���ƿ��� ���̵� ��������
--�ߺ��� ������ ��Ƴ� �� �ִ�.

--nullif

SELECT employee_id, last_name, salary+salary*NVL(commission_pct,0) as monthly_sal,
        NVL2(commission_pct, 'Y', 'N') AS comm_get,
        NULLIF(salary, salary+salary*NVL(commission_pct,0)) AS result
FROM employees;
--�󿩱��� �޴� ����� salary <> salary+salary*NVL(commission_pct,0) => ���� ��µ�
--�󿩱��� ���� �ʴ� ����� salary = salary+salary*NVL(commission_pct,0) => null ���

SELECT  first_name, LENGTH(first_name) "exrp1",
        last_name, LENGTH(last_name) "exrp2",
        NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM employees;

SELECT employee_id, commission_pct, manager_id,
        COALESCE(TO_CHAR(commission_pct), TO_CHAR(manager_id),
                'No Commission and No manager')
FROM employees;

--RR and YY ��
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('99/12/31', 'yy/mm/dd');
--2099/12/31
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('99/12/31', 'rr/mm/dd');
--1999/12/31

--CASE ǥ����
SELECT last_name, job_id, salary,
        CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
                    WHEN 'ST_CLERK' THEN 1.15*salary
                    WHEN 'SA_REP' THEN 1.20*salary
                    ELSE salary
                    END "REVISED_SALARY"
FROM employees;

SELECT last_name, job_id, salary,
        CASE WHEN salary < 5000 THEN 'L'
             WHEN salary BETWEEN 5000 AND 9000 THEN 'M'
             ELSE 'H'
             END AS salary_grade
FROM employees;
--�Ѵ� �����ϴ�.
SELECT employee_id, last_name,
        salary+salary*NVL(commission_pct, 0) AS monthly_sal,
        CASE WHEN commission_pct IS NOT NULL THEN 'Y'
        ELSE 'N'
        END AS comm_get
FROM employees;

