USE market_db1;
CREATE TABLE IF NOT EXISTS trigger_table (id int, txt varchar(10));
INSERT INTO trigger_table VALUES (1, '레드벨벳');
INSERT INTO TRIGGER_table VALUES (2, '잇지');
INSERT INTO trigger_table VALUES (3, '블랙핑크');

DROP TRIGGER IF EXISTS myTrigger;
delimiter $$
CREATE TRIGGER myTrigger 
	AFTER DELETE 
	ON trigger_table 
	FOR EACH ROW 
BEGIN 
	SET @msg = '가수 그룹이 삭제됨' ; -- 트리거 실행 시 작동되는 코드
END $$
delimiter ;

SET @msg = '';
INSERT INTO trigger_table VALUES (4, '마마무');
SELECT @msg;
UPDATE trigger_table SET txt = '블핑' WHERE id = 3;
SELECT @msg;

DELETE FROM trigger_table WHERE id = 4;
SELECT @msg;


CREATE TABLE singer (SELECT mem_id, mem_name, mem_number, 
	addr FROM MEMBER) ;
	
CREATE TABLE backup_singer
(	mem_id						char(8) NOT NULL, 
	mem_name						varchar(10) NOT NULL,
	mem_number					int NOT NULL, 
	addr							char(2) NOT NULL, 
	modType						char(2),  -- 변경된 타입. '수정' 또는 '삭제'
	modDate						date,
	modUser						varchar(30)	);

SELECT * FROM singer;
SELECT * FROM backup_singer;

DROP TRIGGER IF EXISTS singer_updateTrg;
delimiter $$
CREATE TRIGGER singer_updateTrg 
	AFTER UPDATE 
	ON singer 
	FOR EACH ROW 
BEGIN 
	INSERT INTO backup_singer VALUES ( OLD.mem_id, OLD.mem_name, 
		OLD.mem_number, OLD.addr, '수정', curdate(), current_user() );
END $$
delimiter ;

DROP TRIGGER IF EXISTS singer_deleteTrg;
delimiter $$
CREATE TRIGGER singer_deleteTrg 
	AFTER DELETE 
	ON singer 
	FOR EACH ROW 
BEGIN 
	INSERT INTO backup_singer VALUES ( OLD.mem_id, OLD.mem_name, 
		OLD.mem_number, OLD.addr, '삭제', curdate(), current_user() );
END $$
delimiter ;

UPDATE singer SET addr = '영국' WHERE mem_id = 'BLK';
DELETE FROM singer WHERE mem_number >= 7;


SELECT * FROM backup_singer;

truncate TABLE singer;

SELECT * FROM backup_singer;