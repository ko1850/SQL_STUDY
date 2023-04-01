USE naver_db;
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member (
	mem_id				CHAR(8)	NOT NULL	PRIMARY KEY,
    mem_name			VARCHAR(10)	NOT NULL,
    height				TINYINT	UNSIGNED	NULL
);

DESCRIBE member;

DROP TABLE IF EXISTS member;
CREATE TABLE member (
	mem_id				CHAR(8)	NOT NULL,
    mem_name			VARCHAR(10)	NOT NULL,
    height				TINYINT	UNSIGNED	NULL,
    PRIMARY KEY (mem_id)
);

DROP TABLE IF EXISTS member;
CREATE TABLE member (
	mem_id				CHAR(8)	NOT NULL,
    mem_name			VARCHAR(10)	NOT NULL,
	height				TINYINT	UNSIGNED	NULL
);
ALTER TABLE	member
	ADD CONSTRAINT
    PRIMARY KEY (mem_id);
    
DROP TABLE IF EXISTS member;
CREATE TABLE member (
	mem_id				CHAR(8)	NOT NULL,
    mem_name			VARCHAR(10)	NOT NULL,
    height				TINYINT UNSIGNED	NULL,
    CONSTRAINT PRIMARY KEY PK_member_mem_id (mem_id)
);

DESCRIBE member;

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member (
	mem_id				CHAR(8)	NOT NULL	PRIMARY KEY,
    mem_name			VARCHAR(10)	NOT NULL,
    height				TINYINT UNSIGNED	NULL
);
CREATE TABLE buy (
	num				INT	AUTO_INCREMENT	NOT NULL	PRIMARY KEY,
    mem_id			CHAR(8)	NOT NULL,
    prod_name		CHAR(6)	NOT NULL,
    FOREIGN KEY (mem_id) REFERENCES member (mem_id)
);

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member (
	mem_id				CHAR(8)	NOT NULL	PRIMARY KEY,
    mem_name			VARCHAR(10)	NOT NULL,
    height				TINYINT UNSIGNED	NULL
);
CREATE TABLE buy (
	num				INT	AUTO_INCREMENT	NOT NULL	PRIMARY KEY,
    user_id			CHAR(8)	NOT NULL,
    prod_name		CHAR(6)	NOT NULL,
    FOREIGN KEY (user_id) REFERENCES member (mem_id)
);
-- mem_id와 user_id 기준 테이블의 열 이름과 참조 테이블의 열 이름이 달라도 상관은 없는데, 실무를 하다 보면 헷갈리는 경우가 많아서 통일하는 것이 좋음.

DROP TABLE IF EXISTS buy;
CREATE TABLE buy (
	num					INT AUTO_INCREMENT	NOT NULL	PRIMARY KEY,
    mem_id				CHAR(8)	NOT NULL,
    prod_name			CHAR(6)	NOT NULL
);
ALTER TABLE buy
	ADD CONSTRAINT
    FOREIGN KEY (mem_id)
    REFERENCES member (mem_id);
    
INSERT INTO member VALUES('BLK', '블랙핑크', 163);
INSERT INTO buy VALUES(NULL, 'BLK', '지갑');
INSERT INTO buy VALUES(NULL, 'BLK', '맥북');

SELECT * FROM member;
SELECT * FROM buy;

SELECT M.mem_id, M.mem_name, B.prod_name
	FROM buy B
		INNER JOIN member M
        ON B.mem_id = M.mem_id;

UPDATE member SET mem_id = 'PINK' WHERE mem_id = 'BLK';
-- 기본 키 - 외래 키로 맺어진 후에는 기준 테이블의 열 이름이 변경되지 않음
DELETE FROM member WHERE mem_id = 'BLK';

DROP TABLE IF EXISTS buy;
CREATE TABLE buy (
	num					INT AUTO_INCREMENT NOT NULL	PRIMARY KEY,
    mem_id				CHAR(8)	NOT NULL,
    prod_name			CHAR(6)	NOT NULL
);
ALTER TABLE buy
	ADD CONSTRAINT
    FOREIGN KEY (mem_id)
    REFERENCES member (mem_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;
    
INSERT INTO buy VALUES (NULL, 'BLK', '지갑');
INSERT INTO buy VALUES (NULL, 'BLK', '맥북');

UPDATE member SET mem_id = 'PINK' WHERE mem_id = 'BLK';

SELECT M.mem_id, M.mem_name, B.prod_name
	FROM buy B
		INNER JOIN member M
        ON M.mem_id = B.mem_id;
        
DELETE FROM member WHERE mem_id = 'PINK';

SELECT * FROM buy;

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member (
	mem_id				CHAR(8)	NOT NULL PRIMARY KEY,
    mem_name			VARCHAR(10) NOT NULL,
    height				TINYINT UNSIGNED NULL,
    email				CHAR(30) NULL UNIQUE
);

INSERT INTO member VALUES ('BLK', '블랙핑크', 163, 'pink@gmail.com');
INSERT INTO member VALUES ('TWC', '트와이스', 167, NULL);
INSERT INTO member VALUES ('APN', '에이핑크', 164, 'pink@gmail.com');

DROP TABLE IF EXISTS member;
CREATE TABLE member (
	mem_id				CHAR(8) NOT NULL PRIMARY KEY,
    mem_name			VARCHAR(10) NOT NULL,
    height				TINYINT UNSIGNED NULL CHECK (height >= 100),
    phone1				CHAR(3)	NULL
);
INSERT INTO member VALUES ('BLK', '블랙핑크', 163, NULL);
INSERT INTO member VALUES ('TWC', '트와이스', 99, NULL);

ALTER TABLE member
	ADD CONSTRAINT
    CHECK (phone1 IN ('02', '031', '032', '054', '055', '061' ));
    
INSERT INTO member VALUES ('TWC', '트와이스', 167, '02');
INSERT INTO member VALUES ('OMY', '오마이걸', 168, '010');

DROP TABLE IF EXISTS member;
CREATE TABLE member (
	mem_id				CHAR(8)	NOT NULL	PRIMARY KEY,
    mem_name			VARCHAR(10)	NOT NULL,
    height				TINYINT	UNSIGNED	NULL	DEFAULT 160,
    phone1				CHAR(3)	NULL
);
ALTER TABLE member
	ALTER COLUMN phone1 SET DEFAULT '02';
    
INSERT INTO member VALUES ('RED', '레드벨벳', 161, '054');
INSERT INTO member VALUES ('SPC', '우주소녀', default, default);
SELECT * FROM member;