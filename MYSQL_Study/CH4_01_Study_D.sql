USE market_db_2;
CREATE TABLE hongong5(
	tinyint_col		TINYINT,
    smallint_col	SMALLINT,
    int_col			INT,
    bigint_col		BIGINT	);
    
INSERT INTO hongong5 VALUES(127, 32767, 214521462, 90000000000000000);

INSERT INTO hongong5 VALUES(128, 32768, 214521432, 90000000000000000);

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member -- 회원 테이블
(	mem_id			CHAR(8)	NOT NULL PRIMARY KEY, -- 회원 아이디(PK)
	mem_name		VARCHAR(10)	NOT NULL, -- 이름
    mem_number		INT	NOT NULL, -- 인원수
	addr			CHAR(2) NOT NULL, -- 주소(경기, 서울, 경남 식으로 2글자만 입력)
    phone1			CHAR(3), -- 연락처의 국번(02, 031, 055)
    phone2			CHAR(8), -- 연락처의 나머지 전화번호(하이픈 제외)
    height			TINYINT unsigned, -- 평균 키
    debut_date		DATE -- 데뷔 일자
) ;

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member -- 회원 테이블
( mem_id			CHAR(8) NOT NULL PRIMARY KEY,
  mem_name			VARCHAR(10) NOT NULL,
  mem_number		TINYINT NOT NULL,
  addr				CHAR(2) NOT NULL,
  phone1			CHAR(3),
  phone2			CHAR(8),
  height			TINYINT unsigned,
  debut_date		date
) ;

CREATE TABLE big_table (
	data1		CHAR(256),
    data2		VARCHAR(16384)
);

CREATE DATABASE netflix_db;
USE netflix_db;
CREATE TABLE movie
	( movie_id			INT,
      movie_title		VARCHAR(30),
      movie_director	VARCHAR(30),
      movie_star		VARCHAR(30),
      movie_script		LONGTEXT,
      movie_film		LONGBLOB
	) ;
    
USE market_db_2;
SET @myVar1 = 5;
SET @myVar2 = 4.25;

SELECT @myVar1 ;
SELECT @myVar1 + @myVar2 ;

SET @txt = '가수 이름==> ' ;
SET @height = 166 ;
SELECT @txt, mem_name FROM member WHERE height < @height ;mem_idmem_idmem_name

SET @count = 3;
PREPARE mySQL FROM 'SELECT mem_name, height FROM member ORDER BY height LIMIT ?';
execute mySQL USING @count;

SELECT * FROM member;

SELECT AVG(price) AS '평균 가격' FROM buy;

SELECT CAST(AVG(price) AS signed) '평균 가격' FROM buy;
SELECT CONVERT(AVG(price), SIGNED) '평균 가격' FROM buy;

SELECT CAST('2022$12$12' AS DATE);
SELECT CAST('2022/12/12' AS DATE);
SELECT CAST('2022%12%12' AS DATE);
SELECT CAST('2022@12@12' AS DATE);

SELECT num, CONCAT(CAST(price AS CHAR), 'X', CAST(amount AS CHAR), '=' ) '가격X수랑', price*amount '구매액' FROM buy;