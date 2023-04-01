USE market_db1;
DROP PROCEDURE IF EXISTS user_proc;
delimiter $$
CREATE PROCEDURE user_proc()
BEGIN
	SELECT * FROM MEMBER;
END $$
delimiter ;

CALL user_proc();

DROP PROCEDURE user_proc;

USE market_db1;
DROP PROCEDURE IF EXISTS user_proc1;
delimiter $$
CREATE PROCEDURE user_proc1(IN userName varchar(10)) -- 매개변수 정의 
BEGIN 
	SELECT * FROM MEMBER WHERE mem_name = userName; -- 매개변수 대입. python에서 def함수 정의할 때와 비슷. 
END $$
delimiter ;

CALL user_proc1('에이핑크');

DROP PROCEDURE IF EXISTS user_proc2;
delimiter $$ 
CREATE PROCEDURE user_proc2 (
	IN userNumber int,
	IN userHeight int )
BEGIN
	SELECT * FROM MEMBER 
		WHERE mem_number > userNumber AND height > userHeight;
END $$
delimiter ;

CALL user_proc2(6, 165);

DROP PROCEDURE IF EXISTS user_proc3;
delimiter $$
CREATE PROCEDURE user_proc3(
	IN txtValue char(10),
	OUT outValue int )
BEGIN
	INSERT INTO noTable VALUES (NULL, txtValue);
	SELECT max(id) INTO outValue FROM noTable;
END $$
delimiter ;

DESC noTable;

CREATE TABLE IF NOT EXISTS noTable(
	id int AUTO_INCREMENT PRIMARY KEY,
	txt char(10)
) ;

CALL user_proc3 ('테스트1', @myValue) ;
SELECT concat('입력된 ID 값 ==>', @myValue);

SELECT YEAR(debut_date) FROM MEMBER;

DROP PROCEDURE IF EXISTS ifelse_proc;
delimiter $$
CREATE PROCEDURE ifelse_proc(
	IN memName varchar(10) )
BEGIN 
	DECLARE debutYear int ; -- 변수 선언
	SELECT YEAR(debut_date) INTO dubutYear FROM MEMBER 
		WHERE mem_name = memName;
	IF (debutYear >= 2015) THEN 
		SELECT '신인 가수네요. 화이팅하세요.' AS '메시지';
	ELSE
		SELECT '고참 가수네요. 그동안 수고하셨어요.' AS '메시지';
	END IF;
END $$
delimiter ;
-- 왜 오류가 뜨는지 모르겠음.

DROP PROCEDURE IF EXISTS while_proc;
delimiter $$
CREATE PROCEDURE while_proc()
BEGIN 
	DECLARE hap int ; -- 합계
	DECLARE num int ; -- 1부터 100까지 증가
	SET hap = 0 ; -- 합계 초기화
	SET num = 1 ;

	WHILE (num <= 100) do 
		SET hap = hap + num ;
		SET num = num + 1 ;
	END WHILE ;
	SELECT hap AS '1~100 합계';
END $$
delimiter ;

CALL while_proc();

DROP PROCEDURE IF EXISTS dynamic_proc;
delimiter $$
CREATE PROCEDURE dynamic_proc( 
	IN tableName varchar(20) )
BEGIN
	SET @sqlQuery = concat('select * from ', tableName);
	PREPARE myQuery FROM @sqlQuery;
	EXECUTE myQuery;
	DEALLOCATE PREPARE myQuery;
END $$
delimiter ;

CALL dynamic_proc ('member');