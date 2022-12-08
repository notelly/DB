--데이터 사전 질의
SELECT table_name
FROM user_tables;

SELECT DISTINCT object_type
FROM user_objects;

SELECT *
FROM user_catalog;

--테이블 생성
--전에 테이블 정리. 삭제
DROP TABLE temp;
DROP TABLE test;

--회원 정보를 보관하는 테이블 생성
-- id, name, birth, addr, phone, signUP
-- memeber_id, member_name, member_birth
--회원 장바구니
--id, price, history
--관계가 있는 테이블을 구성할 때 앞에 어디서 가지고 온 정보인지 적어주지 않으면 겹칠 가능성이 있다.
-- 구별이 안된다. 보통 테이블 이름을 적어줌.

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
VALUES ('yedam01', '김또치', 221208, '대구중구중앙대로403', '10-1234-1234', sysdate);

--한글은 한글자당 3byte, 생각을 해야한다. 영어를 넣을 지 한글을 넣을지 >> 오류: (actual: 12, maximum: 9)
INSERT INTO member
VALUES ('yedam01', '제갈민수', 221208, '대구중구중앙대로403', '10-1234-1234', sysdate); --오류남

INSERT INTO member(member_id, member_name, member_birth, member_addr, member_phone)
VALUES ('yedam01', '김둘리', 221208, '대구중구중앙대로403', '10-1234-1234'); --member_signUP null이 들어감.

DROP TABLE member;

CREATE table member(
member_id varchar2(10),
member_name varchar2(9),
member_birth number(6),
member_addr varchar2(50),
member_phone varchar(12),
member_signUp Date default sysdate);
--회원등급 지정, 처음 가입했을 때 일반회원을 디폴트 값으로 표시하고
--추후 승격 자격이 되었을 때 글자를 바꿔주던지 하는 방식으로 표현한다.
--member_memberShip char(1) default 'N');

INSERT INTO member(member_id, member_name, member_birth, member_addr, member_phone)
VALUES ('yedam01', '김둘리', 221208, '대구중구중앙대로403', '10-1234-1234'); --default로 인해 알아서 값이 들어간다.

--조회된 내용으로 새로운 테이블을 만들 것
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

--테이블에 맴버쉽 컬럼 추가
ALTER TABLE member
ADD         (member_memberShip char(1) default 'N');

SELECT *
FROM member;

ALTER TABLE member
ADD         (member_account number(5));

-- 컬럼 수정
ALTER TABLE member
MODIFY      (member_memberShip varchar2(1));

DESC member;

ALTER TABLE member
MODIFY      (member_signUP number); -- 디폴트 값이 있어서 컬럼 안에 데이터가 없어도 변경이 불가능
--당연히 오류남 22/12/08 을 숫자로 바꾸는 것은 불가능
--데이터 타입이 다른 것을 지정하면 당연히 바꿀 수 없다.
-- 데이터와 길이가 맞지 않아도 당연히 바꿀 수 없다.
ALTER TABLE member
MODIFY      (member_name char(2));
--데이터 유형을 변경할 열은 비어있어야한다.
ALTER TABLE member
MODIFY      (member_birth varchar2(10));

DELETE member;

--컬럼 삭제
ALTER TABLE member
DROP (member_memberShip); --여러개 지울때 쓰는 건데 한개도 가능

ALTER TABLE member
DROP COLUMN member_account; --하나만 지우기 가능. //DDL 전부 다 자동 커밋 됨

DROP TABLE member;
--SET UNUSED

--변경 되었습니다. 숨김 기능.
ALTER TABLE member
SET UNUSED (member_id);

SELECT *
FROM member;
DESC member;

ALTER TABLE member
DROP UNUSED COLUMNS;

--이름 바꾸기
RENAME member to mem;

SELECT *
FROM mem;

--comment
COMMENT ON TABLE mem
IS 'member';

SELECT *
FROM ALL_TAB_COMMENTS
WHERE table_name = 'MEN';
-- 안됨
COMMENT ON TABLE mem
IS '회원이름';

SELECT *
FROM ALL_COL_COMMENTS
WHERE table_name = 'MEN'; --??


INSERT INTO mem(member_name, member_birth, member_addr, member_phone)
VALUES ('김둘리', 221208, '대구중구중앙대로403', '10-1234-1234');

SELECT *
FROM mem;

DELETE mem;
TRUNCATE TABLE mem;

DROP TABLE member;

--제약조건
CREATE table member(
member_id varchar2(10) NOT NULL, --이름은 오라클에서 알아서.
member_name varchar2(9) CONSTRAINT memeber_name_nn NOT NULL,--이름 지정해주고 싶을 때
member_birth number(6),
member_addr varchar(50));

DESC member;

SELECT *
FROM user_CONSTRAINTs
WHERE table_name = 'MEMBER';-- 제약조건의 내용을 확인할 수 있다.

INSERT INTO member(member_id, member_birth, member_addr)
VALUES ('김둘리', 221208, '대구중구중앙대로403'); --오류날꺼임 ∴이름에 null이 불가능한데 아무것도 안써줘서.

--UNIQUE
CREATE table member(
member_id varchar2(10) UNIQUE,
member_name varchar2(9) CONSTRAINT memeber_name_uk UNIQUE,
member_birth number(6),
member_addr varchar(50),
CONSTRAINT member_birth_uk UNIQUE(member_birth));--어느 컬럼에다가 유니크 제약조건을 걸껀지 끝에 표기해 주어야한다.

--NULL은 중복으로 인정되지 않는다 계속 값이 들어감
INSERT INTO member(member_id, member_birth, member_addr)
VALUES (null, null, '대구중구중앙대로403');

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
employee_id number(6) CONSTRAINT employee_id_fk REFERENCES employees(employee_id), --COLUMN 레벨
CONSTRAINT member_id_pk PRIMARY KEY(member_id),
CONSTRAINT member_birth_uk UNIQUE(member_birth));
--CONSTRAINT employee_id_fk FOREIGN KEY (employee_id) REFERENCES employees(employee_id)); --table 레벨

SELECT *
FROM user_constraints
WHERE table_name = 'MEMBER';

DESC member;
SELECT *
FROM ALL_IND_COLUMNS
WHERE table_name = 'MEMBER';

INSERT INTO member
VALUES ('yedam01', '김또치', 221208, '대구중구중앙대로403', 206);

--식별자 : FK가 PK일 경우 >> FK이면서 PK인 경우
--비식별자 : FK가 일반 Column 인 경우 >> FK가 일반 컬럼인 경우

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
ON DELETE CASCADE); -- 부모꺼를 지우면 나자신도 지워짐.

INSERT INTO member
VALUES ('yedam01', '김또치', 221208, '대구중구중앙대로403', 206);

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
name varchar(20) CHECK (name IN ('원숭이', '호랑이')), --열 레벨
title varchar2(30));

INSERT INTO animal
VALUES (12345, '원숭이', '바나나');

INSERT INTO animal
VALUES (12345, '호랑이', '물고기');

DROP TABLE animal;

CREATE TABLE animal(
id number(5),
name varchar(20),
title varchar2(30),
CONSTRAINT animal_id_check CHECK (id >=1 AND id <=10)); -- 테이블 레벨

INSERT INTO animal
VALUES (1, '강아지', '닭고기');

