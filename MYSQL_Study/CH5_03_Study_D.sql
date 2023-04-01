USE market_db;
SELECT mem_id, mem_name, addr FROM member;

USE market_db;
CREATE VIEW v_member  -- view는 앞에 v를 붙여주는 게 좋음. 그래야 뷰인지 확실하게 인지할 수 있음
AS
	SELECT mem_id, mem_name, addr FROM member;
    
SELECT * FROM v_member;

SELECT mem_name, addr FROM v_member
	WHERE addr IN ('서울', '경기');
    
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr,
									CONCAT(M.phone1, M.phone2) '연락처'
	FROM buy B
		INNER JOIN member M
        ON B.mem_id = M.mem_id;
        
CREATE VIEW v_memberbuy
AS
	SELECT B.mem_id, M.mem_name, B.prod_name, M.addr,
									CONCAT(M.phone1, M.phone2) '연락처'
		FROM buy B
			INNER JOIN member M
			ON B.mem_id = M.mem_id;
            
SELECT * FROM v_memberbuy WHERE mem_name = '블랙핑크';

USE market_db;
CREATE VIEW v_viewtest1
AS
	SELECT B.mem_id 'Member ID', M.mem_name AS 'Member Name', B.prod_name 'Product Name',
											CONCAT(M.phone1, M.phone2) AS 'Office Phone'
		FROM buy B
			INNER JOIN member M
            ON B.mem_id = M.mem_id;
            
SELECT DISTINCT `Member ID`, `Member Name` FROM v_viewtest1;

ALTER VIEW v_viewtest1
AS
	SELECT B.mem_id '회원 아이디', M.mem_name AS '회원 이름', B.prod_name '제품 이름',
									CONCAT(M.phone1, M.phone2) AS '연락처'
		FROM buy B
			INNER JOIN member M
            ON B.mem_id = M.mem_id;
            
SELECT DISTINCT `회원 아이디`, `회원 이름` FROM v_viewtest1;

DROP VIEW v_viewtest1;

USE market_db;
CREATE OR REPLACE VIEW v_viewtest2
AS
	SELECT mem_id, mem_name, addr FROM member;
    
DESCRIBE v_viewtest2;

DESCRIBE member;

SHOW CREATE VIEW v_viewtest2;

UPDATE v_member SET addr = '부산' WHERE mem_id = 'BLK';

INSERT INTO v_member (mem_id, mem_name, addr) VALUES ('BTS', '방탄소년단', '경기');

CREATE VIEW v_height167
AS
	SELECT * FROM member WHERE height >= 167;
    
SELECT * FROM v_height167;

DELETE FROM v_height167 WHERE height < 167;

INSERT INTO v_height167 VALUES ('TRA', '티아라', 6, '서울', NULL, NULL, 159, '2005-01-01');

SELECT * FROM v_height167;

ALTER VIEW v_height167
AS
	SELECT * FROM member WHERE height >= 167
		WITH CHECK OPTION ;

INSERT INTO v_height167 VALUES ('TOB', '텔레토비', 4, '영국', NULL, NULL, 140, '1995-01-01' );

CREATE VIEW v_complex
AS
	SELECT B.mem_id, M.mem_name, B.prod_name, M.addr
		FROM buy B
			INNER JOIN member M
            ON B.mem_id = M.mem_id;
            
DROP TABLE IF EXISTS buy, member;

SELECT * FROM v_height167;
CHECK TABLE v_height167;