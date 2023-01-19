--1. 조금 더 명확하게 찾을 것
select *
from employees
where upper(job_id) = 'ST_CLERK' and to_char(hire_date, 'YYYY') > '2002';

--2. 커미션 받는 사원
select last_name, job_id, salary, commission_pct
from employees
where commission_pct is not null;


--3.커미션을 받지 않는 사원의 급여
--항상 반복되는 거를 니트럴 어쩌구라고 하는데 그거를 적어줘야함 딱풀 연산자 ||
select 'the salary of ' || last_name || ' after a 10% raise is ' || round(salary*1.1) "new salary"
from employees
where commission_pct is null;

--4. 모든 사원의 이름 근무한년수 및 근무한 개월 수 반올림 표시
select last_name, round((sysdate-hire_date)/365) as year,
round((sysdate-hire_date)/12) as months
from employees;

--정답 
select last_name,
    trunc(months_between(sysdate, hire_date)/12) years,
    trunc(mod(months_between(sysdate, hire_date), 12)) months
from employees
order by 2 desc, 3 desc;


--5. 이름 j k m l 시작
--<비추> 방법으로 품
select last_name
from employees
where last_name like 'K%' or last_name like 'J%' or last_name like 'M%' or last_name like 'L%';

--정답
select last_name
from employees
where substr(last_name, 1, 1) in('J', 'K', 'M', 'L');

-- 6.모든 사원의 커미션 수령여부를 표현하시오 //걍 틀린듯
--이건 오라클에서만 됨
select last_name, salary, nvl2(to_char(commission_pct), 'YES', 'NO') as com
from employees;
--COALESCE(commission_pct, 0)
--교수님
select last_name, salary, decode(commission_pct, null, 'NO', 'YES') as com
from employees;
--안시표준 왠댄 <권장>
select last_name, salary,
       case when commission_pct is null then 'NO'
       else 'yes'
       end as com
from employees;

--7. 1800 이라는 위치에서 근무하는 사원의 부서이름 이름 급여 업무를 표시하세요
select d.department_name, e.last_name, e.salary, e.job_id 
from departments d, employees e
where d.department_id = e.department_id
AND d.location_id = 1800;
--안시 조인
select d.department_name, d.location_id, e.last_name,  e.job_id, e.salary 
from departments d join employees e
on d.department_id = e.department_id
where d.location_id = 1800;

--8. 이름이 n으로 끝나는 사람 몇명 두가지방법
select count(*)
from employees
where lower(last_name) like '%n';

-- 8-2
select count(*)
from employees
where lower(substr(last_name, -1)) = 'n';


--9. 모든 부서의 이름 위치 각 부서에 근무하는 사원의 수를 표시하세요
select d.department_id, d.department_name, d.location_id,
       count(e.employee_id)
from employees e, departments d
on d.department_id = e.department_id(+)
group by d.department_id, d.department_name, d.location_id;
--데이터를 묶어주는 것을 썼다면 묶어주지 않은 것은 group by 에 넣어주어야 한다.

select d.department_id, d.department_name, d.location_id,
       count(e.employee_id)
from employees e right outer join departments d
on d.department_id = e.department_id
group by d.department_id, d.department_name, d.location_id;

--사원이 없는 부서도 함께 표시하십시오
--left of right outter join 으로 써야한다.
--데이터가 없는 것도 연결해라 안시 조인은 full도 된다는 것 잊지말기

--10. 부서 10과 20에는 어떤 업무
select DISTINCT job_id
from employees
where department_id = 10 or department_id = 20;
-- where department_id in (10,20)

--11. 부서에 어떤 업무 해당 업무 사원수
select e.job_id, count(e.job_id) as frequency
from employees e, departments d
where lower(d.department_name) in ('administration', 'executive')
group by e.job_id
order by frequency desc;

--12 매월 상반기에 입사한 사원을 모두 표시하세요
-- 날짜 표시할 때 저렇게 할꺼임 기억하기
select last_name, hire_date
from employees
where day(hire_date) < '16';
--교수님
select last_name, hire_date
from employees
where to_char(hire_date, 'DD') < '16';


--13 돈 자르기
select last_name, salary, trunc(salary, -3)/1000 as thousands
from employees;
--문제 잘못 이해함
select last_name, salary, substr(salary, -4, 2) as thousands
from employees;

--14 관리자 급여 $15000 셀프조인하고 job_grades 한번더 조인
select e.last_name, m.last_name as manager, m.salary, j.grade_level
from employees e join employees m
on e.manager_id = m.employee_id
join job_grades j
on (m.salary between j.lowest_sal and j.highest_sal)
where e.manager_id
in (select m.employee_id
    from employees m
    where m.salary > 15000);

--교수님
select e.last_name, m.last_name as manager, m.salary, j.grade_level
from employees e , employees m, job_grades j
where e.manager_id = m.employee_id
and m.salary between j.lowest_sal and j.highest_sal
and m.salary > 15000;

select e.last_name, m.last_name as manager, m.salary, j.grade_level
from employees e join employees m
on e.manager_id = m.employee_id
join job_grades j
on (m.salary between j.lowest_sal and j.highest_sal)
where m.salary > 15000;

--15. 평균급여가 가장 높은 부서의 부서번호 해당부서의 최저급여
--group 함수는 두번까지 중첩가능하다. 그룹함수는 중첩할때는 select절에 어떤 컬럼도 오면 안된다.
--group 함수 제어 having
select department_id, min(salary)
from employees
group by department_id
having avg(salary) =(select max(avg(salary))
                    from employees
                    group by department_id);

