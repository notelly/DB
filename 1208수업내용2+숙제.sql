--Ŭ���� �ʵ� : ������ �����ϴ� �� >> ���� ����.

CREATE TABLE customer(
customer_id NUMBER(5) primary key,
customer_name VARCHAR2(12) not null, --> PK
customer_addr VARCHAR2(100),
customer_phone VARCHAR2(13));

INSERT INTO customer
VALUES (12345, '���ùμ�', '�뱸�� ���', '010-1234-1234');

CREATE TABLE product(
order_number NUMBER(6) primary key, --> PK
customer_id NUMBER(5) REFERENCES customer(customer_id), --> FK
order_product VARCHAR2(50),
product_number NUMBER(3),
product_price NUMBER(38));

INSERT INTO product
VALUES (123456, 12345, 1, 1, 100);

--�������� �߰�
ALTER TABLE product
ADD CONSTRAINT order_product_uk UNIQUE (product_number);

SELECT *
FROM ALL_IND_COLUMNS
WHERE table_name = 'product';

ALTER TABLE product
MODIFY (product_price NOT NULL);

DESC product

--�������� ����
SELECT *
FROM ALL_CONSTRAINTS
WHERE table_name = 'PRODUCT';
--CONSTRAINT_NAME Ȯ���� ���� product_price�� �̸��� SYS_C007085
ALTER TABLE product
DROP CONSTRAINT SYS_C007085;

--not null �� �� ����� 
ALTER TABLE product
DROP primary key cascade;


--�������� ��Ȱ��ȭ
CREATE table member(
member_id varchar2(10),
member_name varchar2(9),
employee_id number(6));

DROP TABLE member;

CREATE table emp 
AS
    SELECT *
    FROM employees;

ALTER TABLE emp
ADD CONSTRAINT emp_id_pk PRIMARY KEY(employee_id);

ALTER TABLE member
ADD CONSTRAINT member_emp_id_fk FOREIGN KEY (employee_id)
    REFERENCES emp (employee_id);
    
SELECT *
FROM ALL_CONSTRAINTS
WHERE table_name IN ('EMP', 'MEMBER');

ALTER TABLE emp
DISABLE CONSTRAINT EMP_ID_PK CASCADE; --CASCADE �����ۿ� �����Ǵ� �ֵ鵵 ������
--EMP_ID_PK => PK�� PK������ ���� ���ϵ��� ����
-- CASCAED�� ���鼭 FK�� employee_id�� ��Ȱ��ȭ ��


--�����̸Ӹ� ��Ȱ��ȭ�� �����ϱ� ������ �ΰ��� ���� �� �� �ִ�.
INSERT INTO emp
    SELECT *
    FROM employees;
    
SELECT *
FROM emp;

--������� 1000�� �Է� �Ұ���. �����ϴ� ���� �ִ� ������ �ƴϱ� ������.
-- �ٵ� ��Ȱ��ȭ�� �����ν� ������ ������ ��
INSERT INTO member
VALUES ('����', '����', 1000);


--�������� Ȱ��ȭ
--���� �ߺ� ���� ���� �־ �ٷ� Ȱ��ȭ�� ����Ŵ
DELETE emp;
INSERT INTO emp
    SELECT *
    FROM employees;

ALTER TABLE emp
ENABLE CONSTRAINT EMP_ID_PK; --���������� ��Ƴ���.

INSERT INTO member
VALUES ('����', '����', 2000);--������ �ȴ�. ���� �ɹ� ���̺��� ��Ȱ��ȭ �Ǿ��ִ�.
--�θ� Ȱ��ȭ �ǵ� �ڽ��� �״�� �ִ´�. �ٵ� ENABLE�� CASCADE�� ����.

ALTER TABLE member
ENABLE CONSTRAINT member_emp_id_fK; --�ߺ��� ���ְ� �����ϸ� ��.


--�������� ����
SELECT * --constraint_name, column_name
FROM user_cons_columns;
--or
SELECT *
FROM ALL_CONSTRAINTS
WHERE table_name IN ('EMP', 'MEMBER');

--�б� ����
ALTER TABLE member READ ONLY;

SELECT *
FROM member;
--member table�� �б� �����̱� ������ ������ �翬�� �Ұ��� ��.
UPDATE member
SET employee_id = 100
WHERE employee_id = 1000;

--�б� ���� ���
ALTER TABLE member READ WRITE;

DROP TABLE member;
DROP TABLE emp;

SELECT *
FROM employees;

--�ǽ�2
CREATE TABLE emp(
employee_id NUMBER(3) NOT NULL,
last_name VARCHAR2(12) NOT NULL,
emp_email VARCHAR2(20) primary key,
phone_number VARCHAR2(13) NOT NULL,
emp_position VARCHAR2(10),
salary NUMBER(5) CHECK(salary >= 2000),
department_id NUMBER(2)
);

INSERT INTO emp
VALUES (100, 'Kim', 'aaa123@naver.com', '010-1234-1234', 'manager', 2500, 10);

INSERT INTO emp
VALUES (100, 'lee', 'bbb123@naver.com', '010-1234-1234', 'manager', 3500, 10);

INSERT INTO emp
VALUES (200, 'Park', 'ccc123@naver.com', '010-1234-1234', 'manager', 2000, 10);

SELECT *
FROM emp;

-- ��������
UPDATE emp SET
last_name = 'Lee'
WHERE last_name = 'lee';

--��������Ȯ��
SELECT *
FROM ALL_CONSTRAINTS
WHERE table_name = 'EMP';


--������ �����ͺ��̽��� �ǹ̸� ���� �����͸� ����
--����(FK)
CREATE TABLE store(
store_name VARCHAR2(30),
fruit_id NUMBER(6) primary key,
fruit_name VARCHAR2(20) NOT NULL,
fruit_price NUMBER(6) NOT NULL,
receiving_date DATE DEFAULT sysdate,
expiration_date DATE,
fruit_number number(5)NOT NULL,
CONSTRAINT fruit_id_fk FOREIGN KEY(fruit_id) REFERENCES fruit(fruit_id)
);
DROP TABLE store;

--����(PK)
CREATE TABLE fruit (
fruit_id NUMBER(6) primary key,
fruit_origin VARCHAR2(20),
fruit_storage VARCHAR(6) CHECK (fruit_storage IN ('�õ�', '����'))
);


SELECT *
FROM ALL_CONSTRAINTS
WHERE table_name = 'STORE';

DESC store;

SELECT *
FROM store;

INSERT INTO fruit
VALUES (4, 'JezuIsland', '����');

INSERT INTO store
VALUES ('���ְ��ϰ���', 4, '��', 1000, sysdate, sysdate+180, 20);

ALTER TABLE fruit
MODIFY fruit_origin NOT NULL;

ALTER TABLE store
MODIFY expiration_date DEFAULT sysdate+180;


--ȸ������ ���̺�
CREATE TABLE member (
member_id VARCHAR2(10) primary key,
member_pw VARCHAR2(20) NOT NULL,
member_addr VARCHAR2(50),
member_rank CHAR(1) DEFAULT 'N'
);

CREATE TABLE fruitorder(
order_numder NUMBER(6) primary key, 
member_id VARCHAR2(10),
fruit_id NUMBER(6),
order_state VARCHAR(30),
CONSTRAINT memder_id_fk FOREIGN KEY(member_id) REFERENCES fruitorder(member_id),
CONSTRAINT fruit_id_fk FOREIGN KEY(fruit_id) REFERENCES fruitorder(fruit_id)
);











