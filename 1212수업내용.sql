--00 ��ȸ
SELECT tablespace_name,file_name
FROM dba_data_files;

--���̺� �����ϱ�

--DROP TABLE ���̺��; -- ���̺� ����
CREATE TABLE yedamtest(
id number
);

SELECT *
FROM yedamtest;

DROP TABLE yedamtest;

--�����뿡 ��.
SHOW recyclebin;

--������ yedamtest�� �츮�ڴ�.
FLASHBACK TABLE yedamtest to before drop;
--�ǻ�Ƴ�.
SELECT *
FROM yedamtest;

--������ ����
Purge Recyclebin;
SHOW recyclebin;

--�����뿡 �ȹ����� �ٷ� ����
DROP TABLE yedamtest Purge;

--�����뿡�� �ϳ��� ��� �����ϴ� �� (RECYCLEBIN NAME�� �Է��ؾ� �Ѵ�.)
PURGE TABLE "BIN$X6YZyxyGRYya8RFCe9JHsQ==$0";


