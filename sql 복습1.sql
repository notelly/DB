--1. ���� �� ��Ȯ�ϰ� ã�� ��
select *
from employees
where upper(job_id) = 'ST_CLERK' and to_char(hire_date, 'YYYY') > '2002';

--2. Ŀ�̼� �޴� ���
select last_name, job_id, salary, commission_pct
from employees
where commission_pct is not null;


--3.Ŀ�̼��� ���� �ʴ� ����� �޿�
--�׻� �ݺ��Ǵ� �Ÿ� ��Ʈ�� ��¼����� �ϴµ� �װŸ� ��������� ��Ǯ ������ ||
select 'the salary of ' || last_name || ' after a 10% raise is ' || round(salary*1.1) "new salary"
from employees
where commission_pct is null;

--4. ��� ����� �̸� �ٹ��ѳ�� �� �ٹ��� ���� �� �ݿø� ǥ��
select last_name, round((sysdate-hire_date)/365) as year,
round((sysdate-hire_date)/12) as months
from employees;

--���� 
select last_name,
    trunc(months_between(sysdate, hire_date)/12) years,
    trunc(mod(months_between(sysdate, hire_date), 12)) months
from employees
order by 2 desc, 3 desc;


--5. �̸� j k m l ����
--<����> ������� ǰ
select last_name
from employees
where last_name like 'K%' or last_name like 'J%' or last_name like 'M%' or last_name like 'L%';

--����
select last_name
from employees
where substr(last_name, 1, 1) in('J', 'K', 'M', 'L');

-- 6.��� ����� Ŀ�̼� ���ɿ��θ� ǥ���Ͻÿ� //�� Ʋ����
--�̰� ����Ŭ������ ��
select last_name, salary, nvl2(to_char(commission_pct), 'YES', 'NO') as com
from employees;
--COALESCE(commission_pct, 0)
--������
select last_name, salary, decode(commission_pct, null, 'NO', 'YES') as com
from employees;
--�Ƚ�ǥ�� �ش� <����>
select last_name, salary,
       case when commission_pct is null then 'NO'
       else 'yes'
       end as com
from employees;

--7. 1800 �̶�� ��ġ���� �ٹ��ϴ� ����� �μ��̸� �̸� �޿� ������ ǥ���ϼ���
select d.department_name, e.last_name, e.salary, e.job_id 
from departments d, employees e
where d.department_id = e.department_id
AND d.location_id = 1800;
--�Ƚ� ����
select d.department_name, d.location_id, e.last_name,  e.job_id, e.salary 
from departments d join employees e
on d.department_id = e.department_id
where d.location_id = 1800;

--8. �̸��� n���� ������ ��� ��� �ΰ������
select count(*)
from employees
where lower(last_name) like '%n';

-- 8-2
select count(*)
from employees
where lower(substr(last_name, -1)) = 'n';


--9. ��� �μ��� �̸� ��ġ �� �μ��� �ٹ��ϴ� ����� ���� ǥ���ϼ���
select d.department_id, d.department_name, d.location_id,
       count(e.employee_id)
from employees e, departments d
on d.department_id = e.department_id(+)
group by d.department_id, d.department_name, d.location_id;
--�����͸� �����ִ� ���� ��ٸ� �������� ���� ���� group by �� �־��־�� �Ѵ�.

select d.department_id, d.department_name, d.location_id,
       count(e.employee_id)
from employees e right outer join departments d
on d.department_id = e.department_id
group by d.department_id, d.department_name, d.location_id;

--����� ���� �μ��� �Բ� ǥ���Ͻʽÿ�
--left of right outter join ���� ����Ѵ�.
--�����Ͱ� ���� �͵� �����ض� �Ƚ� ������ full�� �ȴٴ� �� ��������

--10. �μ� 10�� 20���� � ����
select DISTINCT job_id
from employees
where department_id = 10 or department_id = 20;
-- where department_id in (10,20)

--11. �μ��� � ���� �ش� ���� �����
select e.job_id, count(e.job_id) as frequency
from employees e, departments d
where lower(d.department_name) in ('administration', 'executive')
group by e.job_id
order by frequency desc;

--12 �ſ� ��ݱ⿡ �Ի��� ����� ��� ǥ���ϼ���
-- ��¥ ǥ���� �� ������ �Ҳ��� ����ϱ�
select last_name, hire_date
from employees
where day(hire_date) < '16';
--������
select last_name, hire_date
from employees
where to_char(hire_date, 'DD') < '16';


--13 �� �ڸ���
select last_name, salary, trunc(salary, -3)/1000 as thousands
from employees;
--���� �߸� ������
select last_name, salary, substr(salary, -4, 2) as thousands
from employees;

--14 ������ �޿� $15000 ���������ϰ� job_grades �ѹ��� ����
select e.last_name, m.last_name as manager, m.salary, j.grade_level
from employees e join employees m
on e.manager_id = m.employee_id
join job_grades j
on (m.salary between j.lowest_sal and j.highest_sal)
where e.manager_id
in (select m.employee_id
    from employees m
    where m.salary > 15000);

--������
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

--15. ��ձ޿��� ���� ���� �μ��� �μ���ȣ �ش�μ��� �����޿�
--group �Լ��� �ι����� ��ø�����ϴ�. �׷��Լ��� ��ø�Ҷ��� select���� � �÷��� ���� �ȵȴ�.
--group �Լ� ���� having
select department_id, min(salary)
from employees
group by department_id
having avg(salary) =(select max(avg(salary))
                    from employees
                    group by department_id);

