--00 조회
SELECT tablespace_name,file_name
FROM dba_data_files;

--테이블 복구하기

--DROP TABLE 테이블명; -- 테이블 삭제
CREATE TABLE yedamtest(
id number
);

SELECT *
FROM yedamtest;

DROP TABLE yedamtest;

--휴지통에 들어감.
SHOW recyclebin;

--삭제한 yedamtest를 살리겠다.
FLASHBACK TABLE yedamtest to before drop;
--되살아남.
SELECT *
FROM yedamtest;

--휴지통 비우기
Purge Recyclebin;
SHOW recyclebin;

--휴지통에 안버리고 바로 삭제
DROP TABLE yedamtest Purge;

--휴지통에서 하나만 골라서 삭제하는 것 (RECYCLEBIN NAME을 입력해야 한다.)
PURGE TABLE "BIN$X6YZyxyGRYya8RFCe9JHsQ==$0";


