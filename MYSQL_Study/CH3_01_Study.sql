USE market_db_2;
SELECT * FROM member;

USE sys;
SELECT * FROM market_db_2.member;

SELECT mem_id, mem_name, addr, debut_date FROM member;
SELECT mem_id, mem_name 이름, addr 주소, debut_date '데뷔 일자' FROM member;

SELECT * FROM member WHERE mem_name = '블랙핑크';
SELECT * FROM member WHERE mem_number = 4;

SELECT mem_id, mem_name '그룹 이름' FROM member WHERE height >= 162;

SELECT mem_id, mem_name '그룹 이름', height FROM member WHERE height <= 162 AND mem_number > 4;
SELECT mem_id, mem_name '그룹 이름', height, mem_number FROM member WHERE height >= 162 OR mem_number > 4;

SELECT mem_id, mem_name, height, mem_number FROM member WHERE height >= 162 AND height <= 165;
SELECT mem_id, mem_name, height, mem_number FROM member WHERE height BETWEEN 162 AND 165;

SELECT mem_id, mem_name, addr 주소 FROM member WHERE addr = '경기' OR addr = '서울' OR addr = '전남';
SELECT mem_id, mem_name, addr 주소 FROM member WHERE addr IN('서울', '경기', '전남');

SELECT * FROM member WHERE mem_name LIKE '소%';
SELECT * FROM member WHERE mem_name LIKE '소___';

SELECT height FROM member WHERE mem_name = '에이핑크';
SELECT mem_name, height FROM member WHERE height > 164;

SELECT mem_name, height FROM member WHERE height > (SELECT height FROM member WHERE mem_name = '에이핑크');