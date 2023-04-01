SET GLOBAL log_bin_trust_function_creators = 1;  -- 한 번만 하면 됨.

USE market_db1;
DROP FUNCTION IF EXISTS sumFunc;
delimiter $$
CREATE FUNCTION sumFunc (number1 int, number2 int)
	RETURNS int 
BEGIN
	RETURN number1 + number2;
END $$
delimiter ;

SELECT sumFunc(100, 200) AS '합계';

DROP FUNCTION IF EXISTS calcYearFunc;
delimiter $$
CREATE FUNCTION calcYearFunc(dYear int)
	RETURNS int 
BEGIN
	DECLARE runYear int; -- 활동기간(연도)
	SET runYear = Year(curdate()) - dYear;
	RETURN runYear;
END $$
delimiter ;

SELECT calcYearFunc(2010) AS '활동 횟수';

SELECT calcYearFunc(2007) INTO @debut2007;
SELECT calcYearFunc(2013) INTO @debut2013;
SELECT @debut2007 - @debut2013 AS '2007과 2013 차이';

SELECT mem_id, mem_name, calcYearFunc(YEAR(debut_date)) AS '활동 햇수'
	FROM MEMBER;
	
SHOW CREATE FUNCTION calcYearFunc ; 

DROP FUNCTION calcYearFunc;

USE market_db1;
delimiter $$
BEGIN 
	DECLARE memNumber int;
	DECLARE cnt int DEFAULT 0;
	DECLARE toNumber int DEFAULT 0;
	DECLARE end0fRow boolean defaunt FALSE;
	DECLARE memberCuror CURSOR FOR 
		SELECT mem_number FROM MEMBER;
	declare CONTINUE handler 
		FOR NOT FOUND SET end0fRow = TRUE;
END $$
delimiter ;

USE market_db1;
DROP PROCEDURE IF EXISTS cursor_proc;
delimiter $$
CREATE PROCEDURE cursor_proc() 
BEGIN 
	DECLARE memNumber int;
	DECLARE cnt int DEFAULT 0;
	DECLARE toNumber int DEFAULT 0;
	DECLARE end0fRow boolean DEFAULT FALSE ;

	DECLARE memberCuror CURSOR FOR 
		SELECT mem_number FROM MEMBER; 
	
	DECLARE CONTINUE handler 
		FOR NOT FOUND SET end0fRow = TRUE;
	
	OPEN memberCuror;

	cursor_loop: LOOP
		FETCH memberCuror INTO memNumber;
	
		IF end0fRow THEN 
			LEAVE cursor_loop;
		END IF ;
	
		SET cnt = cnt + 1 ;
		SET toNumber = toNumber + memNumber ;
	END LOOP cursor_loop ;

	SELECT (toNumber/cnt) AS '회원의 평균 인원 수' ;

	CLOSE memberCuror;

END $$
delimiter ;

CALL cursor_proc() ;
