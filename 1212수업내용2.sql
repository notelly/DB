CREATE TABLE coffee( 
coffee_menu varchar2(50)primary key,
coffee_price number(5),
coffee_explain varchar2(100),
coffee_sales number(3) default 0 -- 오픈했을 때 판매량은 0이니까
);

DROP TABLE coffee purge;
SELECT * FROM coffee;

INSERT INTO coffee
VALUES('아메리카노', 2000, '쓴맛', 0);

INSERT INTO coffee
VALUES('카페라떼', 3000, '단맛', 0);

INSERT INTO coffee
VALUES('헤이즐넛 아메리카노', 2500, '단맛', 0);

commit; -- 커밋 꼭 해 주기☆★☆★☆★
