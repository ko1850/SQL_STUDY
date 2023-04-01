CREATE TABLE sample_table (num int);

DROP DATABASE IF EXISTS naver_db;
CREATE DATABASE naver_db;

USE naver_db;
DROP TABLE IF EXISTS MEMBER;
CREATE TABLE MEMBER 
(	mem_id						char(8) NOT NULL PRIMARY key,
	mem_name						varchar(10) NOT null,
	mem_number					TINYINT NOT null,
	addr							char(2) NOT null,
	phone1						char(3) null,
	phone2						char(8) null,
	height						TINYINT UNSIGNED null,
	debut_date					date null	);

DROP TABLE IF EXISTS buy;
CREATE TABLE buy 
(	num						int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	mem_id					char(8) NOT NULL,
	prod_name				char(6) NOT NULL,
	group_name				char(4) NULL,
	price						int UNSIGNED NOT NULL,
	amount					SMALLINT UNSIGNED NOT NULL,
	FOREIGN KEY (mem_id) REFERENCES MEMBER(mem_id)	);

INSERT INTO MEMBER VALUES ('TWC', '트와이스', 9, '서울', '02', '11111111',
	167, '2015-10-19');
INSERT INTO MEMBER VALUES ('BLK', '블랙핑크', 4, '경남', '055', '22222222',
	163, '2016-8-8');
INSERT INTO MEMBER VALUES ('WMN', '여자친구', 6, '경기', '031', '33333333',
	166, '2015-1-15');


INSERT INTO buy VALUES (NULL, 'BLK', '지갑', NULL, 30, 2);
INSERT INTO buy VALUES (NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
INSERT INTO buy VALUES (NULL, 'APN', '아이폰', '디지털', 200, 1);


USE naver_db;
DROP TABLE IF EXISTS buy1, member1;
CREATE TABLE member1
(	mem_id								char(8) NOT NULL PRIMARY KEY,
	mem_name								varchar(10) NOT NULL,
	height								TINYINT UNSIGNED NULL	);

DROP TABLE IF EXISTS member1;
CREATE TABLE member1
(	mem_id								char(8) NOT NULL,
	mem_name								varchar(10) NOT NULL,
	height								TINYINT UNSIGNED NULL	);
ALTER TABLE member1
	ADD CONSTRAINT 
	PRIMARY KEY (mem_id);

CREATE TABLE buy1
(	num									int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	mem_id								char(8) NOT NULL,
	prod_name							char(6) NOT NULL,
	FOREIGN KEY (mem_id) REFERENCES member1(mem_id)	);

DROP TABLE IF EXISTS buy1;
CREATE TABLE buy1 
(	num									int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	mem_id								char(8) NOT NULL,
	prod_name							char(6) NOT NULL	);

ALTER TABLE buy1 
	ADD CONSTRAINT 
	FOREIGN KEY (mem_id)
	REFERENCES member1(mem_id);

INSERT INTO member1 VALUES ('BLK', '블랙핑크', 163);
INSERT INTO buy1 VALUES (NULL, 'BLk', '지갑');
INSERT INTO buy1 VALUES (NULL, 'BLK', '맥북');

SELECT M.mem_id, M.mem_name, B.prod_name FROM buy1 B
	INNER JOIN MEMBER1 M 
	ON B.mem_id = M.mem_id;


DROP TABLE IF EXISTS member2;
CREATE TABLE member2
(	mem_id								char(8) NOT NULL,
	mem_name								varchar(10) NOT NULL,
	height								TINYINT UNSIGNED NULL	);
ALTER TABLE member2
	ADD CONSTRAINT 
	PRIMARY KEY (mem_id);

INSERT INTO member2 VALUES ('BLK', '블랙핑크', 163);


DROP TABLE IF EXISTS buy2;
CREATE TABLE buy2 
(	num							int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	mem_id						char(8) NOT NULL,
	prod_name					char(6) NOT NULL	);

ALTER TABLE buy2 
	ADD CONSTRAINT 
	FOREIGN KEY (mem_id) REFERENCES member2(mem_id)
	ON UPDATE CASCADE 
	ON DELETE CASCADE;

INSERT INTO buy2 VALUES (NULL, 'BLK', '지갑');
INSERT INTO buy2 VALUES (NULL, 'BLk', '맥북');

UPDATE MEMBER2 SET mem_id = 'PINK' WHERE mem_id = 'BLK';

SELECT M.mem_id, M.mem_name, B.prod_name FROM buy2 B
	INNER JOIN member2 M 
	ON B.mem_id = M.mem_id;

DELETE FROM member2 WHERE mem_id = 'PINK';
SELECT * FROM member2;
SELECT * FROM buy2;


DROP TABLE IF EXISTS buy2, member2;
CREATE TABLE member2
(	mem_id									char(8) NOT NULL PRIMARY KEY,
	mem_name									varchar(10) NOT NULL,
	height									TINYINT UNSIGNED NULL,
	email										char(30) NULL UNIQUE	);

INSERT INTO member2 VALUES ('BLK', '블랙핑크', 163, 'pink@gmail.com');
INSERT INTO MEMBER2 VALUES ('TWC', '트와이스', 167, null);
INSERT INTO MEMBER2 VALUES ('APN', '에이핑크', 164, 'pink@gamil.com');

SELECT * FROM member2;

-- 왜 insert가 먹지? 이해가 안 감...

DROP TABLE IF EXISTS member2;
CREATE TABLE member2 
(	mem_id						char(8) NOT NULL PRIMARY KEY,
	mem_name						varchar(10) NOT NULL,
	height						TINYINT UNSIGNED NULL CHECK (height >= 100),
	phone							char(3) NULL	);

INSERT INTO member2 VALUES ('BLK', '블랙핑크', 163, null);
INSERT INTO MEMBER2 VALUES ('TWC', '트와이스', 99, null);

ALTER TABLE member2 
	ADD CONSTRAINT 
	CHECK (phone IN ('02', '031', '032', '054', '055', '061'));

INSERT INTO member2 VALUES ('TWC', '트와이스', 167, '02');
INSERT INTO member2 VALUES ('OMY', '오마이걸', 167, '010');

DROP TABLE IF EXISTS member2;
CREATE TABLE member2 
(	mem_id							char(8) NOT NULL PRIMARY KEY,
	mem_name							varchar(10) NOT NULL,
	height							TINYINT UNSIGNED NULL DEFAULT 160,
	phone1							char(3) NULL	);

ALTER TABLE member2 
	ALTER COLUMN phone1 SET DEFAULT '02';

INSERT INTO member2 VALUES ('Red', '레드벨벳', 161, '054');
INSERT INTO member2 VALUES ('SPC', '우주소녀', DEFAULT, default);
SELECT * FROM member2;



USE market_db1;
CREATE VIEW v_member
	AS
		SELECT mem_id, mem_name, addr FROM MEMBER;
	
SELECT * FROM v_member;

SELECT mem_name, addr FROM v_member WHERE addr IN ('서울', '경기');

SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1, M.phone2) '연락처'
	FROM buy B
	INNER JOIN MEMBER M 
	ON B.mem_id = M.mem_id;

CREATE VIEW v_memberbuy
	AS
		SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1, M.phone2) '연락처'
			FROM buy B
				INNER JOIN MEMBER M 
				ON B.mem_id = M.mem_id;
			
SELECT * FROM v_memberbuy WHERE mem_name = '블랙핑크';


USE market_db1;
CREATE VIEW v_viewtest1
	AS
		SELECT B.mem_id 'Member ID', M.mem_name AS 'Member Name', B.prod_name 'Product Name',
			concat(M.phone1, M.phone2) AS 'Office Phone' FROM buy B 
				INNER JOIN MEMBER M 
				ON B.mem_id = M.mem_id;
			
SELECT DISTINCT `Member ID`, `Member Name` FROM v_viewtest1;

DROP VIEW v_viewtest1;

USE market_db1;
CREATE OR REPLACE VIEW v_viewtest2
	AS
		SELECT mem_id, mem_name, addr FROM MEMBER;
	
	
DESCRIBE v_viewtest2;
DESCRIBE MEMBER;

SHOW CREATE VIEW v_viewtest2;

UPDATE v_member SET addr='부산' WHERE mem_id ='BLK';

INSERT INTO v_member(mem_id, mem_name, addr) VALUES ('BTS', '방탄소년단', '경기');

CREATE VIEW v_height167
	AS
		SELECT * FROM MEMBER WHERE height >= 167;
	
SELECT * FROM v_height167;

DELETE FROM v_height167 WHERE height < 167;

INSERT INTO v_height167 VALUES ('TRA', '티아라', 6, '서울', NULL, NULL, 159, '2005-01-01');

SELECT * FROM v_height167;

ALTER VIEW v_height167 
	AS 
		SELECT * FROM MEMBER WHERE height >= 167 
			WITH CHECK OPTION;
		
INSERT INTO v_height167 VALUES ('TOB', '텔레토비', 4, '영국', NULL, NULL, 140, '1995-01-01');

DROP TABLE IF EXISTS buy, MEMBER;

SELECT * FROM v_height167;


