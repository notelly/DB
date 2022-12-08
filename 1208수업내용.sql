--������ ���� ����
SELECT table_name
FROM user_tables;

SELECT DISTINCT object_type
FROM user_objects;

SELECT *
FROM user_catalog;

--���̺� ����
--���� ���̺� ����. ����
DROP TABLE temp;
DROP TABLE test;

--ȸ�� ������ �����ϴ� ���̺� ����
-- id, name, birth, addr, phone, signUP
-- memeber_id, member_name, member_birth
--ȸ�� ��ٱ���
--id, price, history
--���谡 �ִ� ���̺��� ������ �� �տ� ��� ������ �� �������� �������� ������ ��ĥ ���ɼ��� �ִ�.
-- ������ �ȵȴ�. ���� ���̺� �̸��� ������.

CREATE table member(
member_id varchar2(10),
member_name varchar2(9),
member_birth number(6),
member_addr varchar2(50),
member_phone varchar(12),
member_signUp Date);

SELECT *
FROM member;

INSERT INTO member
VALUES ('yedam01', '���ġ', 221208, '�뱸�߱��߾Ӵ��403', '10-1234-1234', sysdate);

--�ѱ��� �ѱ��ڴ� 3byte, ������ �ؾ��Ѵ�. ��� ���� �� �ѱ��� ������ >> ����: (actual: 12, maximum: 9)
INSERT INTO member
VALUES ('yedam01', '�����μ�', 221208, '�뱸�߱��߾Ӵ��403', '10-1234-1234', sysdate); --������

INSERT INTO member(member_id, member_name, member_birth, member_addr, member_phone)
VALUES ('yedam01', '��Ѹ�', 221208, '�뱸�߱��߾Ӵ��403', '10-1234-1234'); --member_signUP null�� ��.

DROP TABLE member;

CREATE table member(
member_id varchar2(10),
member_name varchar2(9),
member_birth number(6),
member_addr varchar2(50),
member_phone varchar(12),
member_signUp Date default sysdate);
--ȸ����� ����, ó�� �������� �� �Ϲ�ȸ���� ����Ʈ ������ ǥ���ϰ�
--���� �°� �ڰ��� �Ǿ��� �� ���ڸ� �ٲ��ִ��� �ϴ� ������� ǥ���Ѵ�.
--member_memberShip char(1) default 'N');

INSERT INTO member(member_id, member_name, member_birth, member_addr, member_phone)
VALUES ('yedam01', '��Ѹ�', 221208, '�뱸�߱��߾Ӵ��403', '10-1234-1234'); --default�� ���� �˾Ƽ� ���� ����.

--��ȸ�� �������� ���ο� ���̺��� ���� ��
SELECT employee_id, last_name, salary*12 ANNSAL, hire_date
FROM employees
WHERE department_id > 50;

CREATE TABLE subemployees
AS 
    SELECT employee_id, last_name, salary*12 ANNSAL, hire_date
    FROM employees
    WHERE department_id > 50;

SELECT *
FROM subemployees;

DESC subemployees;
DESC employees;

--���̺� �ɹ��� �÷� �߰�
ALTER TABLE member
ADD         (member_memberShip char(1) default 'N');

SELECT *
FROM member;

ALTER TABLE member
ADD         (member_account number(5));

-- �÷� ����
ALTER TABLE member
MODIFY      (member_memberShip varchar2(1));

DESC member;

ALTER TABLE member
MODIFY      (member_signUP number); -- ����Ʈ ���� �־ �÷� �ȿ� �����Ͱ� ��� ������ �Ұ���
--�翬�� ������ 22/12/08 �� ���ڷ� �ٲٴ� ���� �Ұ���
--������ Ÿ���� �ٸ� ���� �����ϸ� �翬�� �ٲ� �� ����.
-- �����Ϳ� ���̰� ���� �ʾƵ� �翬�� �ٲ� �� ����.
ALTER TABLE member
MODIFY      (member_name char(2));
--������ ������ ������ ���� ����־���Ѵ�.
ALTER TABLE member
MODIFY      (member_birth varchar2(10));

DELETE member;

--�÷� ����
ALTER TABLE member
DROP (member_memberShip); --������ ���ﶧ ���� �ǵ� �Ѱ��� ����

ALTER TABLE member
DROP COLUMN member_account; --�ϳ��� ����� ����. //DDL ���� �� �ڵ� Ŀ�� ��

DROP TABLE member;
--SET UNUSED

--���� �Ǿ����ϴ�. ���� ���.
ALTER TABLE member
SET UNUSED (member_id);

SELECT *
FROM member;
DESC member;

ALTER TABLE member
DROP UNUSED COLUMNS;

--�̸� �ٲٱ�
RENAME member to mem;

SELECT *
FROM mem;

--comment
COMMENT ON TABLE mem
IS 'member';

SELECT *
FROM ALL_TAB_COMMENTS
WHERE table_name = 'MEN';
-- �ȵ�
COMMENT ON TABLE mem
IS 'ȸ���̸�';

SELECT *
FROM ALL_COL_COMMENTS
WHERE table_name = 'MEN'; --??


INSERT INTO mem(member_name, member_birth, member_addr, member_phone)
VALUES ('��Ѹ�', 221208, '�뱸�߱��߾Ӵ��403', '10-1234-1234');

SELECT *
FROM mem;

DELETE mem;
TRUNCATE TABLE mem;

DROP TABLE member;

--��������
CREATE table member(
member_id varchar2(10) NOT NULL, --�̸��� ����Ŭ���� �˾Ƽ�.
member_name varchar2(9) CONSTRAINT memeber_name_nn NOT NULL,--�̸� �������ְ� ���� ��
member_birth number(6),
member_addr varchar(50));

DESC member;

SELECT *
FROM user_CONSTRAINTs
WHERE table_name = 'MEMBER';-- ���������� ������ Ȯ���� �� �ִ�.

INSERT INTO member(member_id, member_birth, member_addr)
VALUES ('��Ѹ�', 221208, '�뱸�߱��߾Ӵ��403'); --���������� ���̸��� null�� �Ұ����ѵ� �ƹ��͵� �Ƚ��༭.

--UNIQUE
CREATE table member(
member_id varchar2(10) UNIQUE,
member_name varchar2(9) CONSTRAINT memeber_name_uk UNIQUE,
member_birth number(6),
member_addr varchar(50),
CONSTRAINT member_birth_uk UNIQUE(member_birth));--��� �÷����ٰ� ����ũ ���������� �ɲ��� ���� ǥ���� �־���Ѵ�.

--NULL�� �ߺ����� �������� �ʴ´� ��� ���� ��
INSERT INTO member(member_id, member_birth, member_addr)
VALUES (null, null, '�뱸�߱��߾Ӵ��403');

SELECT *
FROM member;

--PRIMARY KEY
CREATE table member(
member_id varchar2(10) primary key,
member_name varchar2(9),
member_birth number(6),
member_addr varchar(50),
CONSTRAINT member_birth_uk UNIQUE(member_birth));

DESC member;
SELECT *
FROM user_constraints
WHERE table_name = 'MEMBER';

DESC member;
SELECT *
FROM ALL_IND_COLUMNS
WHERE table_name = 'MEMBER';

CREATE table member(
member_id varchar2(10),
member_name varchar2(9),
member_birth number(6),
member_addr varchar(50),
CONSTRAINT member_id_pk PRIMARY KEY(member_id),
CONSTRAINT member_birth_uk UNIQUE(member_birth));

--FOREIGN KEY
CREATE table member(
member_id varchar2(10),
member_name varchar2(9),
member_birth number(6),
member_addr varchar(50),
employee_id number(6) CONSTRAINT employee_id_fk REFERENCES employees(employee_id), --COLUMN ����
CONSTRAINT member_id_pk PRIMARY KEY(member_id),
CONSTRAINT member_birth_uk UNIQUE(member_birth));
--CONSTRAINT employee_id_fk FOREIGN KEY (employee_id) REFERENCES employees(employee_id)); --table ����

SELECT *
FROM user_constraints
WHERE table_name = 'MEMBER';

DESC member;
SELECT *
FROM ALL_IND_COLUMNS
WHERE table_name = 'MEMBER';

INSERT INTO member
VALUES ('yedam01', '���ġ', 221208, '�뱸�߱��߾Ӵ��403', 206);

--�ĺ��� : FK�� PK�� ��� >> FK�̸鼭 PK�� ���
--��ĺ��� : FK�� �Ϲ� Column �� ��� >> FK�� �Ϲ� �÷��� ���

--ON DELETE CASCADE
CREATE table member(
member_id varchar2(10),
member_name varchar2(9),
member_birth number(6),
member_addr varchar(50),
employee_id number(6),
CONSTRAINT member_id_pk PRIMARY KEY(member_id),
CONSTRAINT member_birth_uk UNIQUE(member_birth),
CONSTRAINT employee_id_fk FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
ON DELETE CASCADE); -- �θ𲨸� ����� ���ڽŵ� ������.

INSERT INTO member
VALUES ('yedam01', '���ġ', 221208, '�뱸�߱��߾Ӵ��403', 206);

SELECT *
FROM member;

DELETE FROM employees
WHERE employee_id = 206;
rollback;

--ON DELETE SET NULL
CREATE table member(
member_id varchar2(10),
member_name varchar2(9),
member_birth number(6),
member_addr varchar(50),
employee_id number(6),
CONSTRAINT member_id_pk PRIMARY KEY(member_id),
CONSTRAINT member_birth_uk UNIQUE(member_birth),
CONSTRAINT employee_id_fk FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
ON DELETE SET NULL);

--CHECK
CREATE TABLE animal(
id number(5),
name varchar(20) CHECK (name IN ('������', 'ȣ����')), --�� ����
title varchar2(30));

INSERT INTO animal
VALUES (12345, '������', '�ٳ���');

INSERT INTO animal
VALUES (12345, 'ȣ����', '�����');

DROP TABLE animal;

CREATE TABLE animal(
id number(5),
name varchar(20),
title varchar2(30),
CONSTRAINT animal_id_check CHECK (id >=1 AND id <=10)); -- ���̺� ����

INSERT INTO animal
VALUES (1, '������', '�߰��');

