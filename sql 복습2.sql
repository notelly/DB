create table department(
depid number(10) primary key,
deptname varchar2(10),
location varchar2(10),
tel varchar2(15)
);

create table employee(
empid number(10) primary key,
empname  varchar2(10),
hiredate date,
addr varchar2(12),
tel varchar2(15),
depid number(10)
);

insert into department
values (1001, '총무팀', '본101호', '053-777-8777');

insert into department
values (1002, '회계팀', '본102호', '053-888-9999');

insert into department
values (1003, '영업팀', '본103호', '053-222-3333');

insert into employee
values (20121945, '박민수', '20120302', '대구', '010-1111-1234', 1001);

insert into employee
values (20101817, '박준식', '20100901', '경산', '010-2222-1234', 1003);
insert into employee
values (20122245, '선아라', '20120302', '대구', '010-3333-1222', 1002);
insert into employee
values (20121729, '이범수', '20110302', '서울', '010-3333-4444', 1001);
insert into employee
values (20121646, '이융희', '20120901', '부산', '010-1234-2222', 1003);

--6.depid 외래키 걸기
alter table employee
add constraint FK_emp_depid foreign key (depid) references department (depid);
--7. 직원테이블에 birthday 컬럼추가
alter table employee add birthday date;
--8. 조회
select *
from department;
select *
from employee;

--9. 직원 테이블의 직원명 컬럼에서 not null 제약조건 추가
alter table employee
modify empname not null;

--10. 총무팀 직원
select e.empname, e.hiredate, d.deptname
from employee e inner join department d
on d.depid = e.depid
where e.depid = 1001;

--11. 대구 직원 삭제
delete from employee
where addr = '대구';

--12. 영업팀 직원 모두 회계팀으로
--이해를 잘못함
update employee
set depid = (select depid
             from department
             where deptname = '회계팀')
where depid = (select depid
               from department
               where deptname = '영업팀');

--13. 직원번호 20121729 입사일 보다 늦게 입사한 직원 정보
select e.empid, e.empname, e.birthday, d.deptname
from department d inner JOIN employee e
on e.depid = d.depid
where e.hiredate > (select hiredate from employee where empid = 20121729);

--14. 총무팀 근무 직원 이름, 주소, 부서명 view 생성
create view ga
as
select e.empname, e.addr, d.deptname
from employee e inner join department d
on e.depid = d.depid
where d.depatname = '총무팀';

select *
from ga
