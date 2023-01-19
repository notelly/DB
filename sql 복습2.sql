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
values (1001, '�ѹ���', '��101ȣ', '053-777-8777');

insert into department
values (1002, 'ȸ����', '��102ȣ', '053-888-9999');

insert into department
values (1003, '������', '��103ȣ', '053-222-3333');

insert into employee
values (20121945, '�ڹμ�', '20120302', '�뱸', '010-1111-1234', 1001);

insert into employee
values (20101817, '���ؽ�', '20100901', '���', '010-2222-1234', 1003);
insert into employee
values (20122245, '���ƶ�', '20120302', '�뱸', '010-3333-1222', 1002);
insert into employee
values (20121729, '�̹���', '20110302', '����', '010-3333-4444', 1001);
insert into employee
values (20121646, '������', '20120901', '�λ�', '010-1234-2222', 1003);

--6.depid �ܷ�Ű �ɱ�
alter table employee
add constraint FK_emp_depid foreign key (depid) references department (depid);
--7. �������̺� birthday �÷��߰�
alter table employee add birthday date;
--8. ��ȸ
select *
from department;
select *
from employee;

--9. ���� ���̺��� ������ �÷����� not null �������� �߰�
alter table employee
modify empname not null;

--10. �ѹ��� ����
select e.empname, e.hiredate, d.deptname
from employee e inner join department d
on d.depid = e.depid
where e.depid = 1001;

--11. �뱸 ���� ����
delete from employee
where addr = '�뱸';

--12. ������ ���� ��� ȸ��������
--���ظ� �߸���
update employee
set depid = (select depid
             from department
             where deptname = 'ȸ����')
where depid = (select depid
               from department
               where deptname = '������');

--13. ������ȣ 20121729 �Ի��� ���� �ʰ� �Ի��� ���� ����
select e.empid, e.empname, e.birthday, d.deptname
from department d inner JOIN employee e
on e.depid = d.depid
where e.hiredate > (select hiredate from employee where empid = 20121729);

--14. �ѹ��� �ٹ� ���� �̸�, �ּ�, �μ��� view ����
create view ga
as
select e.empname, e.addr, d.deptname
from employee e inner join department d
on e.depid = d.depid
where d.depatname = '�ѹ���';

select *
from ga
