--클래스 필드 : 정보를 저장하는 곳 >> 디비와 연관.

CREATE TABLE customer(
customer_id NUMBER(5) primary key,
customer_name VARCHAR2(12) not null, --> PK
customer_addr VARCHAR2(100),
customer_phone VARCHAR2(13));

INSERT INTO customer
VALUES (12345, '남궁민수', '대구시 어딘가', '010-1234-1234');

CREATE TABLE product(
order_number NUMBER(6) primary key, --> PK
customer_id NUMBER(5) REFERENCES customer(customer_id), --> FK
order_product VARCHAR2(50),
product_number NUMBER(3),
product_price NUMBER(38));

INSERT INTO product
VALUES (123456, 12345, 1, 1, 100);

--제약조건 추가
ALTER TABLE product
ADD CONSTRAINT order_product_uk UNIQUE (product_number);

SELECT *
FROM ALL_IND_COLUMNS
WHERE table_name = 'product';

ALTER TABLE product
MODIFY (product_price NOT NULL);

DESC product

--제약조건 삭제
SELECT *
FROM ALL_CONSTRAINTS
WHERE table_name = 'PRODUCT';
--CONSTRAINT_NAME 확인을 위해 product_price의 이름은 SYS_C007085
ALTER TABLE product
DROP CONSTRAINT SYS_C007085;

--not null 도 다 사라짐 
ALTER TABLE product
DROP primary key cascade;


--제약조건 비활성화
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
DISABLE CONSTRAINT EMP_ID_PK CASCADE; --CASCADE 연쇄작용 연관되는 애들도 지워라
--EMP_ID_PK => PK가 PK역할을 하지 못하도록 막음
-- CASCAED를 쓰면서 FK의 employee_id도 비활성화 됨


--프라이머리 비활성화가 됐으니까 같은값 두개가 같이 들어갈 수 있다.
INSERT INTO emp
    SELECT *
    FROM employees;
    
SELECT *
FROM emp;

--원래라면 1000은 입력 불가능. 참조하는 곳에 있는 정보가 아니기 때문에.
-- 근데 비활성화를 함으로써 삽입이 가능해 짐
INSERT INTO member
VALUES ('고희동', '고희동', 1000);


--제약조건 활성화
--현재 중복 값이 많이 있어서 바로 활성화를 못시킴
DELETE emp;
INSERT INTO emp
    SELECT *
    FROM employees;

ALTER TABLE emp
ENABLE CONSTRAINT EMP_ID_PK; --제약조건이 살아났다.

INSERT INTO member
VALUES ('고희동', '고희동', 2000);--삽입이 된다. 아직 맴버 테이블은 비활성화 되어있다.
--부모가 활성화 되도 자식은 그대로 있는다. 근데 ENABLE은 CASCADE가 없음.

ALTER TABLE member
ENABLE CONSTRAINT member_emp_id_fK; --중복값 없애고 실행하면 됨.


--제약조건 보기
SELECT * --constraint_name, column_name
FROM user_cons_columns;
--or
SELECT *
FROM ALL_CONSTRAINTS
WHERE table_name IN ('EMP', 'MEMBER');

--읽기 전용
ALTER TABLE member READ ONLY;

SELECT *
FROM member;
--member table은 읽기 전용이기 때문에 수정이 당연히 불가능 함.
UPDATE member
SET employee_id = 100
WHERE employee_id = 1000;

--읽기 전용 취소
ALTER TABLE member READ WRITE;

DROP TABLE member;
DROP TABLE emp;

SELECT *
FROM employees;

--실습2
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

-- 정보수정
UPDATE emp SET
last_name = 'Lee'
WHERE last_name = 'lee';

--제약조건확인
SELECT *
FROM ALL_CONSTRAINTS
WHERE table_name = 'EMP';


--관계형 데이터베이스의 의미를 담은 테이터를 생성
--가게(FK)
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

--과일(PK)
CREATE TABLE fruit (
fruit_id NUMBER(6) primary key,
fruit_origin VARCHAR2(20),
fruit_storage VARCHAR(6) CHECK (fruit_storage IN ('냉동', '냉장'))
);


SELECT *
FROM ALL_CONSTRAINTS
WHERE table_name = 'STORE';

DESC store;

SELECT *
FROM store;

INSERT INTO fruit
VALUES (4, 'JezuIsland', '냉장');

INSERT INTO store
VALUES ('제주과일가게', 4, '귤', 1000, sysdate, sysdate+180, 20);

ALTER TABLE fruit
MODIFY fruit_origin NOT NULL;

ALTER TABLE store
MODIFY expiration_date DEFAULT sysdate+180;


--회원정보 테이블
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











