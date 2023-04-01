USE market_db_2;
SELECT *
FROM buy
	INNER JOIN member
    ON buy.mem_id = member.mem_id
WHERE buy.mem_id = 'GRL';

SELECT *
FROM buy
	INNER JOIN member
    ON buy.mem_id = member.mem_id;
    
SELECT mem_id, mem_name, prod_name, addr, CONCAT(phone1, phone2) '연락처'
	FROM buy
		INNER JOIN member
        ON buy.mem_id = member.mem_id;
        
SELECT buy.mem_id, mem_name, prod_name, addr, CONCAT(phone1, phone2) '연락처'
	FROM buy
		INNER JOIN member
        ON buy.mem_id = member.mem_id;
        
SELECT buy.mem_id, member.mem_name, buy.prod_name, member.addr, CONCAT(member.phone1, member.phone2) '연락처'
	FROM buy
		INNER JOIN member
        ON buy.mem_id = member.mem_id;
        
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, CONCAT(M.phone1, M.phone2) '연락처'
	FROM buy B
		INNER JOIN member M
        ON B.mem_id = M.mem_id;
        
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
	FROM buy B
		INNER JOIN member M
        ON B.mem_id = M.mem_id
	ORDER BY M.mem_id;
    
SELECT DISTINCT M.mem_id, M.mem_name, M.addr
	FROM buy B
		INNER JOIN member M
        ON B.mem_id = M.mem_id
	ORDER BY M.mem_id;
    
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
	FROM member m
		LEFT OUTER JOIN buy B
        ON M.mem_id = B.mem_id
	ORDER BY M.mem_id;
    
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
	FROM buy B
		RIGHT OUTER JOIN member M
        ON M.mem_id = B.mem_id
	ORDER BY M.mem_id;
    
SELECT DISTINCT M.mem_id, B.prod_name, M.mem_name, M.addr
	FROM member M
		LEFT OUTER JOIN buy B
        ON M.mem_id = B.mem_id
	WHERE B.prod_name IS NULL
    ORDER BY M.mem_id;
    
SELECT *
	FROM buy
		CROSS JOIN member;
        
SELECT COUNT(*) '데이터 개수'
	FROM sakila.inventory
		CROSS JOIN world.city;
        
CREATE TABLE cross_table
	SELECT *
		FROM sakila.actor  -- 200건
			CROSS JOIN world.country ; -- 239건
            
SELECT * FROM cross_table LIMIT 10;

USE market_db_2;
CREATE TABLE emp_table (emp CHAR(8), manager CHAR(4), phone VARCHAR(8));

INSERT INTO emp_table VALUES ('대표', NULL, '0000');
INSERT INTO emp_table VALUES ('엽업이사', '대표', '1111');
INSERT INTO emp_table VALUES ('관리이사', '대표', '2222');
INSERT INTO emp_table VALUES ('정보이사', '대표', '3333');
INSERT INTO emp_table VALUES ('영업과장', '영업이사', '1111-1');
INSERT INTO emp_table VALUES ('경리부장', '관리이사', '2222-1');
INSERT INTO emp_table VALUES ('인사부장', '관리이사', '2222-2');
INSERT INTO emp_table VALUES ('개발팀장', '정보이사', '3333-1');
INSERT INTO emp_table VALUES ('개발주임', '정보이사', '3333-1-1');

SELECT A.emp '직원', B.emp '직속상관', B.phone '직속상관연락처'
	FROM emp_table A -- 1단계
		INNER JOIN emp_table B  -- 2단계
        ON A.manager = B.emp
	WHERE A.emp = '경리부장';		-- 일반 INNER JOIN과 다름.
-- 일반 INNER은 FROM절에 FK, INNER JOIN절에 PK.
-- 그래서 alias를 줄 때 명확하게 A, B로 주지만
-- 내부 조인의 경우 하나의 테이블 안에서 일어나는 조인이라서 A, B 별칭은 주더라도 같은 테이블.
-- 이해를 돕기 위해 A단계, B단계 라고 인식하자!
-- A단계에서 관리이사는 manager -> B단계에서 관리이사는 emp.
-- 파이썬처럼 SQL도 들여쓰기 문법에 주의하자. WHERE절은 FROM절에 걸리므로 INNER JOIN문법과 무관하다. -> 헷갈리면 안 됨!!