USE market_db_2;
CREATE TABLE hongong1 (toy_id  INT, toy_name CHAR(4), age INT);
INSERT INTO hongong1 VALUES (1, '우디', 25);

INSERT INTO hongong1(toy_id, toy_name) VALUES (2, '버즈');

INSERT INTO hongong1(toy_name,age, toy_id) VALUES ('제시', 20, 3);

CREATE TABLE hongong2 ( 
   toy_id  INT AUTO_INCREMENT PRIMARY KEY, 
   toy_name CHAR(4), 
   age INT);

INSERT INTO hongong2 VALUES (NULL, '보핍', 25);
INSERT INTO hongong2 VALUES (NULL, '슬링키', 22);
INSERT INTO hongong2 VALUES (NULL, '렉스', 21);
SELECT * FROM hongong2;

SELECT LAST_INSERT_ID(); 

ALTER TABLE hongong2 AUTO_INCREMENT=100;
INSERT INTO hongong2 VALUES (NULL, '재남', 35);
SELECT * FROM hongong2;

CREATE TABLE hongong3 ( 
   toy_id  INT AUTO_INCREMENT PRIMARY KEY, 
   toy_name CHAR(4), 
   age INT);
ALTER TABLE hongong3 AUTO_INCREMENT=1000;
SET @@auto_increment_increment=3;

INSERT INTO hongong3 VALUES (NULL, '토마스', 20);
INSERT INTO hongong3 VALUES (NULL, '제임스', 23);
INSERT INTO hongong3 VALUES (NULL, '고든', 25);
SELECT * FROM hongong3;

SELECT COUNT(*) FROM world.city;

DESC world.city;

SELECT * FROM world.city LIMIT 5;

CREATE TABLE city_popul ( city_name CHAR(35), population INT);

INSERT INTO city_popul
    SELECT Name, Population FROM world.city;
    
USE market_db_2;
UPDATE city_popul
    SET city_name = '서울'
    WHERE city_name = 'Seoul';
SELECT  * FROM city_popul WHERE  city_name = '서울';

UPDATE city_popul
    SET city_name = '뉴욕', population = 0
    WHERE city_name = 'New York';
SELECT  * FROM city_popul WHERE  city_name = '뉴욕';

-- UPDATE city_popul
--    SET city_name = '서울'

UPDATE city_popul
    SET population = population / 10000 ;
SELECT * FROM city_popul LIMIT 5;

DELETE FROM city_popul 
    WHERE city_name LIKE 'New%';

DELETE FROM city_popul 
    WHERE city_name LIKE 'New%'
    LIMIT 5;

CREATE TABLE big_table1 (SELECT * FROM world.city , sakila.country); 
CREATE TABLE big_table2 (SELECT * FROM world.city , sakila.country); 
CREATE TABLE big_table3 (SELECT * FROM world.city , sakila.country); 
SELECT COUNT(*) FROM big_table1;

DELETE FROM big_table1;
DROP TABLE big_table2;
TRUNCATE TABLE big_table3;