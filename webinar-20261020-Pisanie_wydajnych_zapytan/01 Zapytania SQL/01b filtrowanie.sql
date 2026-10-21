/*

	Pisanie wydajnych zapytań - szkolenie hybrydowe
	Spotkanie 1 - Zapytania SQL
    b/ filtrowanie

	Tomasz Libera | MVP Data Platform
	libera@kursysql.pl
	
    http://www.kursysql.pl
    http://www.youtube.com/c/KursySQL

*/



SELECT
    Id,
    DisplayName,
    Reputation,
    Location
FROM dbo.Users
WHERE Reputation > 10000;


SELECT
    Id,
    DisplayName,
    Reputation
FROM dbo.Users
WHERE Reputation >= 50000;

SELECT


    Id,
    DisplayName,
    Reputation
FROM dbo.Users
WHERE Reputation <> 1;



SELECT
    DisplayName,
    Reputation,
    Location
FROM dbo.Users
WHERE Location = 'Poland'
   


/*

    Operatory

    =
    <>
    >
    >=
    <
    <=

*/


-- AND/ OR


SELECT
    DisplayName,
    Reputation,
    Views
FROM dbo.Users
WHERE Reputation > 10000
  AND Views > 1000;


SELECT
    DisplayName,
    Reputation,
    Location
FROM dbo.Users
WHERE Location = 'Poland'
   OR Location = 'Germany';


-- nawiasy
SELECT
    DisplayName,
    Reputation,
    Location
FROM dbo.Users
WHERE Reputation > 10000
  AND (Location = 'Poland' OR Location = 'Germany');


-- bez nawiasów
SELECT
    DisplayName,
    Reputation,
    Location
FROM dbo.Users
WHERE Reputation > 10000
  AND Location = 'Poland'  OR Location = 'Germany'

-- IN

SELECT
    DisplayName,
    Reputation,
    Location
FROM dbo.Users
WHERE Location IN ('Poland', 'Germany', 'France');

--WHERE Location = 'Poland'
--   OR Location = 'Germany'
--   OR Location = 'France'



-- BETWEEN

SELECT
    DisplayName,
    Reputation
FROM dbo.Users
WHERE Reputation BETWEEN 10000 AND 20000;

SELECT
    Id,
    DisplayName,
    CreationDate
FROM dbo.Users
WHERE CreationDate BETWEEN '2008-01-01' AND '2008-12-31';


SELECT
    Id,
    DisplayName,
    CreationDate
FROM dbo.Users
WHERE CreationDate >= '2008-01-01' AND CreationDate <=  '2008-12-31';




-- LIKE - wyszukiwanie tekstu

SELECT
    DisplayName,
    Location
FROM dbo.Users
WHERE DisplayName LIKE 'Tom%';


SELECT
    DisplayName,
    Location
FROM dbo.Users
WHERE DisplayName LIKE '%SQL%';


SELECT
    DisplayName,
    Location
FROM dbo.Users
WHERE Location LIKE '%Poland%';



-- NULL

SELECT
    DisplayName,
    Location
FROM dbo.Users
WHERE Location = NULL;


SELECT
    DisplayName,
    Location
FROM dbo.Users
WHERE Location IS NULL;


