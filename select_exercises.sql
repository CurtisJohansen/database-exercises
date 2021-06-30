USE albums_db;

SHOW TABLES;

DESCRIBE albums;

SELECT * FROM albums;

SELECT DISTINCT artist FROM albums;

SELECT MAX(release_date) AS max_date, min(release_date) AS min_date
FROM albums; 

SELECT name FROM albums WHERE artist = 'Pink Floyd';

SELECT release_date FROM albums WHERE name ='Sgt. Pepper\'s Lonely Hearts Club Band';

SELECT genre FROM albums WHERE name = 'Nevermind';

SELECT name, release_date FROM albums WHERE release_date BETWEEN 1990 AND 1999;

SELECT name, sales FROM albums WHERE sales < 20.0;

SELECT genre, name FROM albums WHERE genre ='Rock';

SELECT genre, name FROM albums WHERE genre LIKE '%rock%';

SELECT DISTINCT genre FROM albums;