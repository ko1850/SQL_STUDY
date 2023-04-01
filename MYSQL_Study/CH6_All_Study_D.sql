USE market_db1;
CREATE TABLE table1
(	col1			int PRIMARY KEY,
	col2			int,
	col3			int	);
	
SHOW INDEX FROM TABLE1;

CREATE TABLE table2
(	col1				int PRIMARY KEY,
	col2				int UNIQUE,
	col3				int UNIQUE	);
	
SHOW INDEX FROM table2;

USE market_db1;
CREATE TABLE member2
(	mem_id					char(8),
	mem_name					varchar(10),
	mem_number				int,
	addr						char(2)	);
	
INSERT INTO MEMBER2 VALUES ('TWC', '트와이스', 9, '서울');
INSERT INTO MEMBER2 VALUES ('BLK', '블랙핑크', 4, '경남');
INSERT INTO member2 VALUES ('WHM', '여자친구', 6, '경기');
INSERT INTO member2 VALUES ('OMY', '오마이걸', 7, '서울');

SELECT * FROM member2;

ALTER TABLE member2
	ADD CONSTRAINT
	PRIMARY KEY (mem_id);
SELECT * FROM MEMBER2;
-- primary key로 지정한 열을 기준으로 정렬됨을 확인할 수 있다.

ALTER TABLE member2 DROP PRIMARY KEY;
ALTER TABLE member2
	ADD CONSTRAINT
	PRIMARY KEY (mem_name);  -- 클러스터형 인덱스 생
SELECT * FROM member2;
-- 여기서부터는 추가로 데이터를 입력하면 알아서 기준에 맞춰 정렬

INSERT INTO member2 VALUES ('GRL', '소녀시대', 8, '서울');
SELECT * FROM MEMBER2;


DROP TABLE IF EXISTS member3;
CREATE TABLE member3
(	mem_id							char(8),
	mem_name							varchar(10),
	mem_number						int,
	addr								char(2)	);
	

INSERT INTO member3 VALUES ('TWC', '트와이스', 9, '서울');
INSERT INTO member3 VALUES ('BLK', '블랙핑크', 4, '경남');
INSERT INTO MEMBER3 VALUES ('WMN', '여자친구', 6, '경기');
INSERT INTO member3 VALUES ('OMY', '오마이걸', 7, '서울');
SELECT * FROM member3;

ALTER TABLE member3 
	ADD CONSTRAINT
	UNIQUE (mem_id);
SELECT * FROM member3;  -- 보조 인덱스를 생성해도 데이터의 내용이나 순서는 변경 x

ALTER TABLE member3 
	ADD CONSTRAINT 
	UNIQUE (mem_name);
SELECT * FROM member3;

-- 데이터를 추가로 기입하면 본문의 제일 뒤에 추가되는 것과 동일하게 맨 뒤에 차례로 추가됨.

INSERT INTO member3 VALUES ('GRL', '소녀시대', 8, '서울');
SELECT * FROM member3;


USE market_db1;
CREATE TABLE cluster 
(	mem_id					char(8),
	mem_name					varchar(10)	);
	
INSERT INTO cluster VALUES ('TWC', '트와이스');
INSERT INTO cluster VALUES ('BLK', '블랙핑크');
INSERT INTO cluster VALUES ('WHM', '여자친구');
INSERT INTO cluster VALUES ('OMY', '오마이걸');
INSERT INTO cluster VALUES ('GRL', '소녀시대');
INSERT INTO cluster VALUES ('ITZ', '잇지');
INSERT INTO cluster VALUES ('RED', '레드벨벳');
INSERT INTO cluster VALUES ('APN', '에이핑크');
INSERT INTO cluster VALUES ('SPC', '우주소녀');
INSERT INTO cluster VALUES ('MMU', '마마무');

SELECT * FROM cluster;

ALTER TABLE cluster
	ADD CONSTRAINT 
	PRIMARY KEY (mem_id);
	
SELECT * FROM cluster;
-- 실제 데이터는 데이터 페이지가 정렬되고 균형 트리 형태의 인덱스가 형성.

USE market_db1;
CREATE TABLE SECOND
(	mem_id 						char(8),
	mem_name						varchar(10)	);
	
INSERT INTO second VALUES('TWC', '트와이스');
INSERT INTO second VALUES('BLK', '블랙핑크');
INSERT INTO second VALUES('WMN', '여자친구');
INSERT INTO second VALUES('OMY', '오마이걸');
INSERT INTO second VALUES('GRL', '소녀시대');
INSERT INTO second VALUES('ITZ', '잇지');
INSERT INTO second VALUES('RED', '레드벨벳');
INSERT INTO second VALUES('APN', '에이핑크');
INSERT INTO second VALUES('SPC', '우주소녀');
INSERT INTO second VALUES('MMU', '마마무');
ALTER TABLE SECOND 
	ADD CONSTRAINT 
	UNIQUE (mem_id);
	
SELECT * FROM SECOND;  -- 보조 인덱스는 데이터 베이지를 건드리지 않음. -- 주소값으로 빠른 인덱스!


USE market_db1;
SELECT * FROM MEMBER;

SHOW INDEX FROM MEMBER;  -- SHOW index는 테이블에 생성된 인덱스 정보를 보여줌.

SHOW TABLE status LIKE 'member';  -- 인덱스의 크기를 확인. member라는 글자가 들어간 테이블의 정보를 보자는 의미.

CREATE INDEX idx_member_addr -- CREATE index를 하는 건 보통 보조 인덱스를 만들 때 사용.
	ON MEMBER (addr);

SHOW INDEX FROM MEMBER;  -- Non_unique가 1로 설정되어 있으므로 고유 보조 인덱스가 아니라는 점. => 중복된 데이터를 허용함.

SHOW TABLE status LIKE 'member';  -- index_length가 보조 인덱스의 크기를 나타냄.

ANALYZE TABLE MEMBER;  -- 생성한 인덱스를 실제로 적용하려면 ANALYZE TABLE 문으로 먼저 테이블을 분석/처리해 주어야 함.

SHOW TABLE status LIKE 'member';

CREATE UNIQUE INDEX idx_member_mem_number
	ON MEMBER (mem_number);  -- 이미 중복된 값들이 있기 때문에 고유 보조 인덱스를 생성할 수 없음.
	
CREATE UNIQUE INDEX idx_member_mem_name 
	ON MEMBER (mem_name);

SHOW INDEX FROM MEMBER;

INSERT INTO MEMBER VALUES ('MOO', '마마무', 2, '태국', '001', '12341234', 155, '2020.10.10');  -- 고유 보조 인덱스가 적용되어 에러
-- 업무상 절대로 중복되지 않는 열 (주민등록번호, 학번, 이메일 주소 등)에만 unique 옵션을 사용해야 한다.

ANALYZE TABLE MEMBER;  -- 지금까지 만든 인덱스를 모두 적용
SHOW INDEX FROM MEMBER;

SELECT * FROM MEMBER;

SELECT mem_id, mem_name, addr FROM MEMBER;

SELECT mem_id, mem_name, addr 
	FROM MEMBER 
	WHERE mem_name = '에이핑크';  -- const  >> 인덱스를 사용해서 결과를 얻었다는 의미.
	
DROP TABLE hongong1;
DROP TABLE hongong2;
DROP TABLE hongong3;
DROP TABLE hongong4;
	
CREATE INDEX idx_member_mem_number 
	ON MEMBER (mem_number);
ANALYZE TABLE MEMBER;

SELECT mem_name, mem_number FROM MEMBER
	WHERE mem_number >= 7;

SELECT mem_name, mem_number FROM MEMBER 
	WHERE mem_number >= 1;

SELECT mem_name, mem_number FROM MEMBER 
	WHERE mem_number*2 >= 14;  -- where문에서 열에 연산이 가해지면 인덱스를 사용하지 않음.
	
SELECT mem_name, mem_number FROM MEMBER 
	WHERE mem_number >= 14/2;  -- where문에 아무런 연산을 가하지 않으니 인덱스를 사용함.
	
SHOW INDEX FROM MEMBER;
-- 클러스터형 인덱스와 보조 인덱스가 섞여 있을 때는 보조 인덱스를 먼저 제거하는 것이 좋다.
-- 보조 인덱스는 어떤 것을 먼저 제거해도 무관.

DROP INDEX idx_member_mem_name ON MEMBER;
DROP INDEX idx_member_addr ON MEMBER;
DROP INDEX idx_member_mem_number ON MEMBER;

ALTER TABLE MEMBER 
	DROP PRIMARY KEY;  -- 에러가 뜨는 이유 : member의 mem_id 열을 buy가 참조하고 있기 때문.
	-- 기본 키를 제거하기 전에 외래 키 관계부터 정리해야 함.
	
-- 테이블에는 여러 개의 외래 키가 있을 수 있음. 그러므로 먼저 외래 키 이름을 알아내야 함.
SELECT table_name, constraint_name
	FROM information_schema.referential_constraints 
	WHERE constraint_schema = 'market_db1';
-- information_schema DB의 referential_constraints 테이블은 MySQL 안에 원래 포함되어 있는 System DB와 테이블.
-- 여기에 MySQL 전체의 외래 키 정보가 들어있음.

ALTER TABLE buy 
	DROP FOREIGN KEY buy_ibfk_1;
ALTER TABLE MEMBER 
	DROP PRIMARY KEY;
-- 모든 인덱스 제
