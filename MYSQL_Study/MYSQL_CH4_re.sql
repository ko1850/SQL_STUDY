USE market_db1;

CREATE TABLE hongong4
(	tinyint_col				TINYINT,
	smallint_col			SMALLINT,
	int_col					int,
	bigint_col				bigint	);
	
INSERT INTO hongong4 VALUES (127, 32767, 2134531, 900000000000000000000);


CREATE TABLE member1
(	mem_id					char(8) NOT NULL PRIMARY KEY,
	mem_name 				varchar(10) NOT NULL,
	mem_number				int NOT NULL,
	addr						char(2) NOT NULL,
	phone1					char(3),
	phone2					char(8),
	height					SMALLINT,
	debut_date				date	);
	
ALTER TABLE member1 MODIFY COLUMN height TINYINT UNSIGNED;

CREATE TABLE big_table
(	data1						char(256)
	data2						varchar(16384)	);
	

CREATE DATABASE netflix_db;
USE netflix_db;
CREATE TABLE movie
(	movie_id					int,
	movie_title				varchar(30),
	movie_director			varchar(20),
	movie_star				varchar(20),
	movie_script			LONGTEXT,
	movie_film				LONGBLOB	);
	

USE market_db1;
SET @myVar1 = 5;
SET @myVar2 = 4.25;

SELECT @myVar1;
SELECT @myVar1 + @myVar2;

SET @txt = '가수 이름 ==> ';
SET @height = 166;

SELECT @txt;
SELECT @height;
SELECT @txt, mem_name FROM MEMBER WHERE height > @height;

SET @count = 3;
SELECT mem_name, height FROM MEMBER ORDER BY height LIMIT @count;  -- limit에는 변수를 사용할 수 없음. syntax error

SET @count = 3;
PREPARE mySQL FROM 'select mem_name, height from member order by height limit ?';
EXECUTE mySQL USING @count;  -- limit에는 변수를 사용하지 못 하기 때문에, 대신 PREPARE, execute를 사용한다. => 변수 사용 가능.

SELECT avg(price) AS '평균 가격' FROM buy;

SELECT cast(avg(price) AS signed) '평균 가격' FROM buy;

SELECT convert(avg(price), signed) '평균 가격' FROM buy;

SELECT num, concat(CAST(price AS char), 'X', cast(amount AS char), '=') '가격x수량', price*amount '구매액'
	FROM buy;

SELECT '100' + '200';
SELECT concat('100','200');
SELECT concat(100,'200');
SELECT 100 + '200'


USE market_db1;
SELECT * FROM buy 
	INNER JOIN MEMBER 
	ON buy.mem_id = MEMBER.mem_id 
WHERE buy.mem_id = 'GRL';

SELECT * FROM buy 
	INNER JOIN MEMBER 
	ON buy.mem_id = MEMBER.mem_id;


SELECT mem_id, mem_name, prod_name, addr, concat(phone1, phone2) '연락처' FROM buy 
	INNER JOIN MEMBER 
	ON buy.mem_id = MEMBER.mem_id;

SELECT buy.mem_id, mem_name, addr, concat(phone1, phone2) '연락처' FROM buy 
	INNER JOIN MEMBER 
	ON buy.mem_id = MEMBER.mem_id;

SELECT buy.mem_id, MEMBER.mem_name, buy.prod_name, MEMBER.addr, concat(MEMBER.phone1, MEMBER.phone2) '연락처' FROM buy 
	INNER JOIN MEMBER 
	ON buy.mem_id = MEMBER.mem_id;


SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1, M.phone2) '연락처' FROM buy B
	INNER JOIN MEMBER M
	ON B.mem_id = M.mem_id;

SELECT M.mem_id, M.mem_name, B.prod_name, M.addr FROM buy B
	INNER JOIN MEMBER M 
	ON B.mem_id = M.mem_id 
ORDER BY M.mem_id;

SELECT DISTINCT M.mem_id, M.mem_name, M.addr FROM buy B
	INNER JOIN MEMBER M 
	ON B.mem_id = M.mem_id 
ORDER BY M.mem_id;


SELECT M.mem_id, M.mem_name, B.prod_name, M.addr FROM MEMBER M
	LEFT OUTER JOIN buy B 
	ON M.mem_id = B.mem_id 
ORDER BY M.mem_id;

SELECT * FROM MEMBER;
SELECT * FROM buy;

SELECT M.mem_id, M.mem_name, B.prod_name, M.addr FROM buy B
	RIGHT OUTER JOIN MEMBER M 
	ON M.mem_id = B.mem_id 
ORDER BY M.mem_id;


SELECT DISTINCT M.mem_id, B.prod_name, M.mem_name, M.addr FROM MEMBER M 
	LEFT OUTER JOIN buy B 
	ON M.mem_id = B.mem_id 
WHERE B.prod_name IS NULL 
ORDER BY M.mem_id;

SELECT * 
	FROM buy 
		CROSS JOIN MEMBER;
	


USE market_db1;
CREATE TABLE emp_table (emp char(4), manager char(4), phone varchar(8));

INSERT INTO emp_table VALUES ('대표', NULL, '0000');
INSERT INTO emp_table VALUES ('영업이사', '대표', '1111');
INSERT INTO emp_table VALUES ('관리이사', '대표', '2222');
INSERT INTO emp_table VALUES ('정보이사', '대표', '3333');
INSERT INTO emp_table VALUES ('영업과장', '영업이사', '1111-1');
INSERT INTO emp_table VALUES ('경리부장', '관리이사', '2222-1');
INSERT INTO emp_table VALUES ('인사부장', '관리이사', '2222-2');
INSERT INTO emp_table VALUES ('개발팀장', '정보이사', '3333-1');
INSERT INTO emp_table VALUES ('개발주임', '정보이사', '3333-1-1');


SELECT A.emp '직원', B.emp '직속상관', B.phone '직속상관연락처' FROM emp_table A
	INNER JOIN emp_table B 
	ON A.manager = B.emp
WHERE A.emp = '경리부장';


DROP PROCEDURE IF EXISTS ifProc1;
DELIMITER $$
CREATE PROCEDURE ifProc1()
BEGIN 
		IF 100 = 100 THEN
			SELECT '100은 100과 같습니다.';
		END IF;
END $$
delimiter ;
CALL ifProc1;


DROP PROCEDURE IF EXISTS ifProc2;
delimiter $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE myNum int;
	SET myNum = 200;
	IF myNum = 100 THEN 
		SELECT '100입니다.';
	ELSE 
		SELECT '100이 아닙니다.';
	END IF;

END $$
delimiter ;
CALL ifProc2;


DROP PROCEDURE IF EXISTS ifProc3;
delimiter $$
CREATE PROCEDURE ifProc3()
BEGIN
	DECLARE debuDate date;
	DECLARE curDate date;
	DECLARE days int;
	SELECT debut_date INTO debuDate
		FROM market_db1.MEMBER
		WHERE mem_id = 'APN';
	
	SET curDate = current_date();
	SET days = datediff(curDate, debutDate);

	IF (days/365) >= 5 THEN
		SELECT concat('데뷔한 지 ', days, '일이 지났습니다. 핑순이들 축하합니다.');
	ELSE
		SELECT '데뷔한 지 ' + days + '일밖에 안 되었네요. 핑순이들 파이팅~';
	END IF;
END $$
delimiter ;
CALL ifProc3();


DROP PROCEDURE IF EXISTS caseProc;
delimiter $$
CREATE PROCEDURE caseProc()
BEGIN
	DECLARE point int;
	DECLARE credit char(1);
	SET point = 88;

	CASE
		WHEN point >= 90 THEN
			SET credit = 'A';
		WHEN point >= 80 THEN
			SET credit = 'B';
		WHEN point >= 70 THEN
			SET credit = 'C';
		WHEN point >= 60 THEN
			SET credit = 'D';
		ELSE
			SET credit = 'F';
	END CASE;
	SELECT concat('취득점수==>',point), concat('학점==>', credit);

END $$
delimiter $$
CALL caseProc();


SELECT mem_id, sum(price*amount) '총 구매액'
	FROM buy 
	GROUP BY mem_id;


SELECT mem_id, sum(price*amount) '총 구매액'
	FROM buy 
	GROUP BY mem_id
	ORDER BY sum(price*amount) DESC;


SELECT B.mem_id, M.mem_name, sum(price*amount) '총 구매액' FROM buy B 
	INNER JOIN MEMBER M 
	ON B.mem_id = M.mem_id 
GROUP BY B.mem_id 
ORDER BY sum(price*amount) DESC;


SELECT M.mem_id, M.mem_name, sum(price*amount) '총 구매액' FROM buy B
	RIGHT OUTER JOIN MEMBER M 
	ON B.mem_id = M.mem_id
GROUP BY M.mem_id 
ORDER BY sum(price*amount) DESC;


SELECT M.mem_id, M.mem_name, sum(price*amount) '총 구매액',
		CASE 
			WHEN (sum(price*amount) >= 1500) THEN '최우수고객'
			WHEN (sum(price*amount) >= 1000) THEN '우수고객'
			WHEN (sum(price*amount) >= 1) THEN '일반고객'
			ELSE '유령고객'
		END '회원등급'
	FROM buy B 
		RIGHT OUTER JOIN MEMBER M 
		ON B.mem_id = M.mem_id 
	GROUP BY M.mem_id
	ORDER BY sum(price*amount) DESC;


DROP PROCEDURE IF EXISTS whileProc;
delimiter $$
CREATE PROCEDURE whileProc()
BEGIN 
	DECLARE i 		int;
	DECLARE hap 	int;
	SET i = 1;
	SET hap = 0;

	WHILE (i<= 100) do
		SET hap = hap + i;
		SET i = i + 1;
	END WHILE;
	SELECT '1부터 100까지의 합 ==>', hap;
END $$
delimiter ;

CALL whileProc();


DROP PROCEDURE IF EXISTS whileProc2;
delimiter $$
CREATE PROCEDURE whileProc2()
BEGIN
	DECLARE i 			int;
	DECLARE hap			int;
	SET i = 1;
	SET hap = 0;

	mywhile:
	WHILE (i <= 100) do 
		IF (i%4 = 0) THEN 
			SET i = i+1;
			ITERATE mywhile;
		END IF;
		SET hap = hap + i;
		IF (hap > 1000) THEN 
			LEAVE mywhile; 
		END IF;
		SET i = i+1;
	END WHILE;

	SELECT '1부터 100까지의 합(4의 배수 제외), 1000 넘으면 종료 ==>', hap;
END $$
delimiter ;
CALL whileProc2();


USE market_db1;
PREPARE myQuery FROM 'select * from member where mem_id = "BLK"';
EXECUTE myQuery;
DEALLOCATE PREPARE myQuery;


DROP TABLE IF EXISTS gate_table;
CREATE TABLE gate_table
(	id					int AUTO_INCREMENT PRIMARY KEY,
	entry_time		datetime	);

SET @curDate = current_timestamp();

PREPARE myQuery FROM 'insert into gate_table values (null, ?)';
EXECUTE myQuery USING @curDate;
DEALLOCATE PREPARE myQuery;

SELECT * FROM gate_table;








