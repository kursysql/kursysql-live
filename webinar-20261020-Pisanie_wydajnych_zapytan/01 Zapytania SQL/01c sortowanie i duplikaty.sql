/*

	Pisanie wydajnych zapytań - szkolenie hybrydowe
	Spotkanie 1 - Zapytania SQL
    c/ sortowanie i duplikaty

	Tomasz Libera | MVP Data Platform
	libera@kursysql.pl
	
    http://www.kursysql.pl
    http://www.youtube.com/c/KursySQL

*/





-- ORDER BY

SELECT 
    DisplayName,
    Reputation
FROM dbo.Users
ORDER BY Reputation;


SELECT 
    DisplayName,
    Reputation
FROM dbo.Users
ORDER BY Reputation;



SELECT TOP (10)
    DisplayName,
    Reputation
FROM dbo.Users
ORDER BY Reputation DESC;


SELECT
    DisplayName,
    Reputation,
    CreationDate
FROM dbo.Users
ORDER BY Reputation DESC, CreationDate ASC;


-- DISTINCT

SELECT Location
FROM dbo.Users
WHERE Location IS NOT NULL
ORDER BY Location;


SELECT DISTINCT
    Location
FROM dbo.Users
WHERE Location IS NOT NULL
ORDER BY Location;


SELECT DISTINCT
    Location,
    Reputation
FROM dbo.Users
WHERE Location IS NOT NULL
ORDER BY Location;