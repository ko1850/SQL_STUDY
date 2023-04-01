USE market_db1;

SELECT * FROM MEMBER;

SELECT mem_name FROM MEMBER;

SELECT addr, debut_date, mem_name FROM MEMBER;

SELECT addr 주소, debut_date "데뷔 일자", mem_name FROM MEMBER;		-- 열 이름에 별칭(alias) 줄 수 있음. 별칭에 공백을 두고 싶으면 큰따옴표(")로 묶어야 함.

SELECT * FROM MEMBER WHERE mem_name = '블랙핑크';

SELECT * FROM MEMBER WHERE mem_number = 4;

SELECT mem_id, mem_name, height FROM MEMBER WHERE height <= 162;	-- 관계연산자

SELECT mem_name, height, mem_number FROM MEMBER WHERE height >= 165 AND mem_number > 6;	-- 논리연산자

SELECT mem_name, height, mem_number FROM MEMBER WHERE height >= 165 OR mem_number > 6;

SELECT mem_name, height FROM MEMBER WHERE height >= 163 AND height <= 165;

SELECT mem_name, height FROM MEMBER WHERE height BETWEEN 163 AND 165;

SELECT mem_name, addr
	FROM MEMBER
	WHERE addr IN ('경기','전남','경남');

SELECT mem_name, addr
	FROM MEMBER
	WHERE addr='경기' OR addr='전남' OR addr='경남';
	
SELECT * FROM MEMBER WHERE mem_name LIKE '우%';		-- % : 무엇이든 허용한다

SELECT *
	FROM MEMBER
	WHERE mem_name LIKE '__핑크';	-- 한 글자와 매치하기 위해서는 언더바(_)를 사용 
	
-- 서브 쿼리 : select 안에 또다른 select 가 들어갈 수 있음.
	
SELECT height FROM MEMBER WHERE mem_name = '에이핑크';
SELECT mem_name, height FROM MEMBER WHERE height > 164;

SELECT mem_name, height FROM MEMBER
	WHERE height > (SELECT height FROM MEMBER WHERE mem_name = '에이핑크');		-- 164 대신 select문을 사용.
	
SELECT mem_id, mem_name, debut_date FROM MEMBER ORDER BY debut_date;		-- 기본값 : ASC(오름차순)
SELECT mem_id, mem_name, debut_date FROM MEMBER ORDER BY debut_date DESC;

SELECT mem_id, mem_name, debut_date, height
	FROM MEMBER
	ORDER BY height DESC 
	WHERE height >= 164;		-- error : syntax error -> where문 다음에 ORDER by가 올 수 있음.
	
SELECT mem_id, mem_name, debut_date, height
	FROM MEMBER
	WHERE height >= 164
	ORDER BY height DESC;
	
SELECT * FROM MEMBER LIMIT 3;		-- Python 에서의 head() 느낌과 같음.

SELECT mem_name, debut_date FROM MEMBER 
	ORDER BY debut_date
	LIMIT 3;
	
SELECT mem_name, height FROM MEMBER 
	ORDER BY height DESC 
	LIMIT 3, 2;		-- LIMIT 시작, 개수 = LIMIT 개수 offset 시작
	
SELECT addr FROM MEMBER;

SELECT addr FROM MEMBER ORDER BY addr;

SELECT DISTINCT addr FROM MEMBER;


SELECT mem_id, amount FROM buy ORDER BY mem_id;

SELECT mem_id, sum(amount) FROM buy GROUP BY mem_id;

SELECT mem_id '회원 아이디', sum(amount) '총 구매 개수' FROM buy GROUP BY mem_id;

SELECT mem_id '회원 아이디', sum(price*amount) '총 구매 금액' FROM buy GROUP BY mem_id;

SELECT avg(amount) '평균 구매 개수' FROM buy;

SELECT mem_id, avg(amount) '평균 구매 개수' FROM buy GROUP BY mem_id;

SELECT count(*) FROM MEMBER;	-- 행 개수

SELECT count(phone1) "연락처가 있는 회원" FROM MEMBER;	-- count(열_이름)은 값이 null인 것을 제외한 행의 개수를 센다.

SELECT mem_id '회원 아이디', sum(price*amount) '총 구매 금액' FROM buy GROUP BY mem_id;

SELECT mem_id '회원 아이디', sum(price*amount) '총 구매 금액' FROM buy 
	GROUP BY mem_id 
	HAVING sum(price*amount) > 1000;
	
SELECT mem_id '회원 아이디', sum(price*amount) '총 구매 금액' FROM buy 
	GROUP BY mem_id 
	HAVING sum(price*amount) > 1000 
	ORDER BY sum(price*amount) DESC;
	


CREATE TABLE hongong1 
(	toy_id	int,
	toy_name	char(4),
	age		int	);
	
INSERT INTO hongong1 VALUES (1, '우디', 25);
INSERT INTO hongong1 (toy_id, toy_name) VALUES (2, '버즈');
INSERT INTO hongong1 (toy_name, age, toy_id) VALUES ('제시', 20, 3);

SELECT * FROM hongong1;

CREATE TABLE hongong2 
(	toy_id	int	AUTO_INCREMENT PRIMARY KEY,
	toy_name	char(4),
	age		int	);		-- 자동 증가 부분(auto_increment)은 NULL 값으로 채워 놓으면 된다.
	
INSERT INTO hongong2 VALUES (NULL, '보필', 25);
INSERT INTO hongong2 VALUES (NULL, '슬링키', 22);
INSERT INTO hongong2 VALUES (NULL, '렉스', 21);

SELECT * FROM hongong2;

SELECT last_insert_id();	-- 자동 증가가 얼마만큼 되었는지 확인하기 위한.

ALTER TABLE hongong2 AUTO_INCREMENT = 100;	-- 자동 증가의 처음 시작을 지정하기 위한.
INSERT INTO hongong2 VALUES (NULL, '재남', 35);
SELECT * FROM hongong2;

CREATE TABLE hongong3
(	toy_id			int AUTO_INCREMENT PRIMARY KEY,
	toy_name			char(4),
	age				int	);
	
ALTER TABLE hongong3 AUTO_INCREMENT = 1000;	-- 시작값은 1000으로 지정.
SET @@auto_increment_increment = 3;	-- 증가값은 3으로 지정.

INSERT INTO hongong3 VALUES (NULL, '토마스', 20);
INSERT INTO hongong3 VALUES (NULL, '제임스', 23);
INSERT INTO hongong3 VALUES (NULL, '고든', 25);

SELECT * FROM hongong3;


SELECT * FROM sys.sys_config;

-- delete 문은 where절 없이 사용하면 모든 행 데이터가 삭제됨.