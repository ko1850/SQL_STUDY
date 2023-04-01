USE market_db_2;

SELECT mem_id, mem_name, debut_date FROM member ORDER BY debut_date;

SELECT mem_id, mem_name, debut_date FROM member ORDER BY debut_date DESC;

SELECT mem_id, mem_name, debut_date, height FROM member ORDER BY height DESC WHERE height >= 162;

SELECT mem_id, mem_name, debut_date, height FROM member WHERE height >= 162 ORDER BY height DESC; 

SELECT mem_id, mem_name, debut_date, height FROM member WHERE height >= 164 ORDER BY height DESC, debut_date ASC;

SELECT * FROM member LIMIT 3;

SELECT mem_name, debut_date FROM member ORDER BY debut_date DESC LIMIT 3;

SELECT mem_name, height FROM member ORDER BY height LIMIT 3, 2;

SELECT addr FROM member ORDER BY addr;

SELECT DISTINCT addr FROM member;

SELECT mem_id, amount FROM buy ORDER BY mem_id;

SELECT mem_id, SUM(amount) FROM buy group by mem_id;

SELECT mem_id '회원 아이디', SUM(amount) '총 구매 개수' FROM buy GROUP BY mem_id;

SELECT mem_id '회원 아이디', SUM(amount*price) '총 구매 금액' FROM buy GROUP BY mem_id;

SELECT AVG(amount) '평균 구매 금액' FROM buy;

SELECT mem_id, AVG(amount) "평균 구매 개수" FROM buy GROUP BY mem_id;

SELECT COUNT(*) FROM member;

SELECT COUNT(phone1) '연락처가 있는 회원' FROM member;

SELECT mem_id '회원 아이디', SUM(price*amount) '총 구매 금액' FROM buy GROUP BY mem_id;

SELECT mem_id '회원 아이디', SUM(price*amount) '총 구매 금액' FROM buy WHERE SUM(price*amount) > 1000 GROUP BY mem_id;

SELECT mem_id '회원 아이디', SUM(price*amount) '총 구매 금액' FROM buy GROUP BY mem_id HAVING SUM(price*amount) > 1000;

SELECT mem_id '회원 아이디', SUM(price*amount) '총 구매 금액'
	FROM buy
    GROUP BY mem_id
    HAVING SUM(price*amount) > 1000
    ORDER BY SUM(price*amount) DESC;