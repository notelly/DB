--Null 값에 대한 IN과 NOT IN 연산
--IN 조회하는 컬럼 = 'aaa' or null
--NOT IN 조회하는 컬럼 <> 'aaa' and null
SELECT employee_id, last_name, job_id, manager_id
From employees
WHERE manager_id IN (100, 101, NULL);


SELECT *
FROM employees
ORDER By 6;

--1개 열 기준의 정렬
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY last_name; --a~Z까지 오름차순 // ASC 생략
--오름차순
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY hire_date; -- 97~10년도까지

SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY salary DESC;

SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY department_id DESC, salary DESC; --부서별 월급정렬.

--별칭
SELECT employee_id, last_name, hire_date, salary*12 annsal
FROM employees
ORDER BY annsal DESC;

--위치값에 따른 ORDER BY
SELECT employee_id, last_name, hire_date, salary*12 annsal
FROM employees
ORDER BY 4, 3 DESC;

--치환변수
show verify
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = &dept_no; --내가 입력한 값이 &dept_no가 치환되는 것.
show verify on --켰

show verify
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = &dept_no; --내가 입력한 값이 &dept_no가 치환되는 것.
show verify off --껏

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE job_id = UPPER('&job_title'); --다 대문자로 만들어버림 //DB는 대소문자 다 가린다.

SELECT employee_id, last_name, job_id, department_id, &column_name
FROM employees
ORDER BY &column_name; --불러온 데이터를 정렬

SELECT employee_id, last_name, job_id, department_id, &&column_name
--&&column_name 은 이페이지 내에서 column_name은 무조건 처음에 입력한 얘를 써라
FROM employees
ORDER BY &column_name;


define column_name;
undefine column_name; --치환변수 초기화

--집합 연산자
SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '08%'--'10%' 입사일이 08으로 시작하는 정보
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

--문자 함수
SELECT UPPER('Oracle DataBase'), LOWER('Oracle DataBase'),
        INITCAP('oracle database')
FROM dual;

SELECT employee_id, last_name, UPPER(last_name),
        job_id, INITCAP(job_id)
FROM employees;

SELECT employee_id, last_name, job_id
FROM employees
WHERE LOWER(last_name) = 'king'; -- 다 소문자 만듦.

SELECT employee_id, last_name, job_id
FROM employees
WHERE last_name = INITCAP('king'); --입력한 사람의 데이터를 바꾸는 것

--문자열 합치기
SELECT CONCAT('Hello', 'World')
FROM dual;

SELECT UPPER(CONCAT(CONCAT ('Hello', ' '), 'World'))
FROM dual;

SELECT employee_id, CONCAT(CONCAT(first_name, ' '), last_name) AS full_name,
        job_id, email
FROM employees;

--문자열 자르기
SELECT SUBSTR ('HelloWorld', 1,5), SUBSTR('HelloWorld', 6),
       SUBSTR ('HelloWorld', -5,5), SUBSTR('HelloWorld', -5, -3)
FROM dual;

--내 이름의 맨 끝에 한자리가 n인 값을 출력하라
SELECT *
FROM employees
WHERE SUBSTR(last_name, -1, 1) = 'n'; --like '%n';

--문자 길이
SELECT LENGTH('Oracle Database'), LENGTH('오라클 데이터베이스')
FROM dual;

SELECT *
FROM employees
WHERE LENGTH(last_name) > 6;

--문자열 찾기
SELECT INSTR('HelloWorld', 'l')
FROM dual;

SELECT INSTR('HelloWorld', 'l', 1, 2)
FROM dual;

SELECT INSTR(last_name, 'a'), last_name
FROM employees
WHERE INSTR (last_name, 'a') <> 0; --a가 포함되어 있는 사람을 찾는거
--위와 동일함
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

--TRIM 공백제거+ 양끝에 글자 잘라내기//안에는 상관X
SELECT TRIM('      HelloWorld       ')
FROM dual;

SELECT TRIM('w' FROM 'window'), TRIM(LEADING 'w' FROM 'window'),
        TRIM(TRAILING 'w' FROM 'window')
FROM dual;

SELECT TRIM(0 FROM 000012345670), TRIM(LEADING 0 FROM 000012345670)
FROM dual;

--안되는 케이스
--SELECT TRIM('xy' FROM 'xyxyxykkkkxy')
--FROM dual;

--문자함수문제

--1. yedam, Database 두 단어를 합쳐 yedamDatabase로 출력하시오.
SELECT CONCAT('yedam', 'Database')
FROM dual;

SELECT first_name, last_name, job_id
FROM employees;


--2. lower 함수를 활용하여 it_prog(소문자) 직책을 가진 모든 직원들을 출력하시오.
SELECT first_name, last_name, job_id
FROM employees
WHERE LOWER(job_id) = 'it_prog'; --좀더 생각해보기

--3. WelcomeToCodingWorld 문자열에서
--1)To 2) World 3) WelcomeToCodingWorl 를 출력하시오.
SELECT SUBSTR('WelcomeToCodingWorld', INSTR('WelcomeToCodingWorld', 'T'),2),
        --8대신 INSTR('WelcomeToCodingWorld', 'T')이걸 써줘도 됨
        SUBSTR('WelcomeToCodingWorld', -5,5),
        TRIM(TRAILING 'd' FROM 'WelcomTOCodingWorld'),
        SUBSTR('WelcomeToCodingWorld', 1, LENGTH('WelcomTOCodingWorld')-1) 
        -- 19대신에  LENGTH('WelcomTOCodingWorld')-1)을 써도 됨.
        --동적으로 변화하는 식에서는 LENGTH를 쓰는 것이 맞음
FROM dual;

--4. employees 테이블에서 last_name의 길이가 5 인 직원 중 가운데 3자리를 * 표시하여
--employee_id, last_name, 변경된 last_name를 조회하시오
--예시( yedam -> y***m )

SELECT employee_id, last_name, REPLACE(last_name, SUBSTR(last_name, LENGTH(last_name)/2, 3), '***')
--가운데 3자리 2대신에 LENGTH(last_name)/2 써줘도 됨. 짝수는 가운데 따위 없음.
FROM employees
WHERE LENGTH(last_name) = 5;

--5. LPAD와 RPAD를 적절히 활용하여 last_name은 10자리 중 왼쪽 남는 공간에 * 추가하여 출력,
--first_name은 10자리중 오른쪽 공간에 #을 추가하여 조회하시오.
SELECT RPAD(first_name, 10, '#'), LPAD(last_name, 10, '*')
FROM employees;

--6. 사번과 성과 이름이 합쳐진 이름, 직책, 이름의 길이, 이름 중 a가 몇 번째 포함 되어 있는지
--직책이 REP가 포함 된 사람의 정보를 조회 하시오
--단, 직책이 REP가 포함 된 사람을 찾을때엔 LIKE를 쓰지 않는다.
--alias 도 적극 활용하여 결과물을 만들어보도록 한다.

SELECT employee_id, CONCAT(first_name, last_name) AS name, job_id,
        LENGTH(last_name) as name_length,
        INSTR(last_name, 'a') "contain_'a'?"
FROM employees
WHERE INSTR(job_id, 'REP') <> 0;
-- SUBSTR(job_id, 4) = 'REP'; 도 가능함.

--ceil올림 floor 내림

--반올림
SELECT ROUND(345.678) AS round1, 
       ROUND(345.678, 0) AS round2,
       ROUND(345.678, 1) AS round3,
       ROUND(345.678, -1) AS round4
FROM dual;
--내림
SELECT TRUNC(345.678) AS trunc1,
       TRUNC(345.678, 0) AS trunc2,
       TRUNC(345.678, 1) AS trunc3,
       TRUNC(345.678, -1) AS trunc4
FROM dual;

--해당직원의 연봉을 1000으로 나누는 그 값의 나머지
SELECT last_name, salary, MOD(salary, 1000)
FROM employees;

--현재 시간 조회 //회원가입할때 사용하면 좋다.
SELECT sysdate
FROM dual;

SELECT sysdate, sysdate+1, sysdate-1, to_char(sysdate+1/24*60*60, 'yyyy/mm/dd hh:mm:ss')
FROM dual;
--1/24 1시간을 더한다. 1/24*60 1분  1/24*60*60 1초

DESC employees;

SELECT hire_date, hire_date+(1*365)
FROM employees;

SELECT last_name, (SYSDATE - hire_date)/30 AS WEEKS
FROM employees;
-- 둘이 의미는 같이만 값이 다른 이유 한달이 30 or 31일이기 때문에 그렇다.
SELECT last_name, MONTHS_BETWEEN(SYSDATE, hire_date)
FROM employees;

SELECT last_name, hire_date, ADD_MONTHS(hire_date, 6)
FROM employees;

SELECT employee_id, hire_date, NEXT_DAY(hire_date, '금요일'), LAST_DAY(sysdate)
FROM employees;


-- 검색 언어 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = korean;

--날짜 출력 형태 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI'; --HH24 총 24시간 2시->14시

--날짜 함수에 round, trunc
SELECT sysdate,
        ROUND(SYSDATE) round1, --반올림
        ROUND(SYSDATE, 'DD') round2, --일을 반올림
        ROUND(SYSDATE, 'DAY') round3, --
        ROUND(SYSDATE, 'MON') round4, -- 15일 기준 내림 1일 올림 31일
        ROUND(SYSDATE, 'YEAR') round5 -- 올해 반올림 12월
FROM dual;

--내림.
SELECT sysdate,
        TRUNC(SYSDATE) round1, --내림
        TRUNC(SYSDATE, 'DD') round2, --일을 반올림
        TRUNC(SYSDATE, 'DAY') round3, -- 15일 기준 내림 1일 올림 31일
        TRUNC(SYSDATE, 'MON') round4, -- 6울기준,
        TRUNC(SYSDATE, 'YEAR') round5
FROM dual;

ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD';
--복원

SELECT employee_id, last_name, salary, hire_date, TO_CHAR(hire_date, 'yyyy/mm/dd HH24:MI')
FROM employees;

SELECT TO_CHAR(hire_date, 'fm yyyy "년" Ddspth Month hh:mi:ss AM')
FROM employees;



SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd day')AS hire_date,
        TO_CHAR(hire_date, 'q') AS 분기,
        TO_CHAR(hire_date, 'w') || '주차' AS 주수
FROM employees;

SELECT  TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss') as one, --현재시간
        TO_CHAR(sysdate+3/24, 'yyyy/mm/dd hh24:mi:ss')as two, --하루 24시간중 3시간을 더함
        TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss') as three --시간*60분 => 40분을 더함.
FROM dual;

--숫자에 TO_CHAR 함수 사용
SELECT employee_id, last_name, salary, TO_CHAR(salary, '$999,999')
FROM employees;

SELECT employee_id, last_name, salary, TO_CHAR(salary, '$999,999,999'),
        TO_CHAR(salary, '$099,99.99') AS sal --앞에 무조건 0이 추가 소수점 2째자리까지 표시
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
--뒤에 더 배우고 추가설명

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

--일반함수와 중첩함수
SELECT last_name, upper(CONCAT(SUBSTR(last_name, 1,8), '_US'))
FROM employees
WHERE department_id = 60;

SELECT*
FROM employees;

--commission_pct 이 컬럼을 조사하다가 null을 만나면 0으로 바꾸라는 의미
SELECT employee_id, last_name, salary, NVL(commission_pct,0)
FROM employees;

SELECT employee_id, last_name, +salary salary * commission_pct as monthly_sal --NVL(commission_pct,0)
FROM employees;
--null로 안 나오게 계산하기
SELECT employee_id, last_name, salary + salary * NVL(commission_pct,0) as monthly_sal
FROM employees;

--null이면 인센티브를 받을리 없다. N null이아니면 커미션이라는 테이블에 값이 존재한다. 인센티브 받는다 ㅛ
--상여금을 받을 수 있는지 없는지.
SELECT employee_id, last_name, salary+salary*NVL(commission_pct,0) as monthly_sal,
        NVL2(commission_pct, 'Y', 'N') AS comm_get
FROM employees;

--월급이 어떤 형태로 들어오는지 
--상여금이 null 상여금X 월급만 받는다 상여금 null이 X  월급+상여금
SELECT last_name, salary, commission_pct,
        NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM employees
WHERE department_id IN (50, 80); --부서가 50번이고 부서가 80번인 사람에 한해서.
--데이터베이스에 데이터가 존재하냐 여부를 조사하는데 이것을 쓰기도 한다.
--EX) 아이디. 아이디가 없으면 null로 인식한다. null  -> 0이 돌아오면 아이디 생성가능
--중복된 정보를 잡아낼 수 있다.

--nullif

SELECT employee_id, last_name, salary+salary*NVL(commission_pct,0) as monthly_sal,
        NVL2(commission_pct, 'Y', 'N') AS comm_get,
        NULLIF(salary, salary+salary*NVL(commission_pct,0)) AS result
FROM employees;
--상여금을 받는 사람은 salary <> salary+salary*NVL(commission_pct,0) => 값이 출력됨
--상여금을 받지 않는 사람은 salary = salary+salary*NVL(commission_pct,0) => null 출력

SELECT  first_name, LENGTH(first_name) "exrp1",
        last_name, LENGTH(last_name) "exrp2",
        NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM employees;

SELECT employee_id, commission_pct, manager_id,
        COALESCE(TO_CHAR(commission_pct), TO_CHAR(manager_id),
                'No Commission and No manager')
FROM employees;

--RR and YY 비교
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('99/12/31', 'yy/mm/dd');
--2099/12/31
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('99/12/31', 'rr/mm/dd');
--1999/12/31

--CASE 표현식
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
--둘다 가능하다.
SELECT employee_id, last_name,
        salary+salary*NVL(commission_pct, 0) AS monthly_sal,
        CASE WHEN commission_pct IS NOT NULL THEN 'Y'
        ELSE 'N'
        END AS comm_get
FROM employees;

