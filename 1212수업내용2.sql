CREATE TABLE coffee( 
coffee_menu varchar2(50)primary key,
coffee_price number(5),
coffee_explain varchar2(100),
coffee_sales number(3) default 0 -- �������� �� �Ǹŷ��� 0�̴ϱ�
);

DROP TABLE coffee purge;
SELECT * FROM coffee;

INSERT INTO coffee
VALUES('�Ƹ޸�ī��', 2000, '����', 0);

INSERT INTO coffee
VALUES('ī���', 3000, '�ܸ�', 0);

INSERT INTO coffee
VALUES('������� �Ƹ޸�ī��', 2500, '�ܸ�', 0);

commit; -- Ŀ�� �� �� �ֱ�١ڡ١ڡ١�
