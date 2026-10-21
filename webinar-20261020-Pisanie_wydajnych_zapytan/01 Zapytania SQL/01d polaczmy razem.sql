/*

	Pisanie wydajnych zapytań - szkolenie hybrydowe
	Spotkanie 1 - Zapytania SQL
    d/ połączmy razem - przykłady zapytań

	Tomasz Libera | MVP Data Platform
	libera@kursysql.pl
	
    http://www.kursysql.pl
    http://www.youtube.com/c/KursySQL

*/



SELECT TOP (20)
    Id,
    DisplayName,
    Reputation,
    Location,
    CreationDate
FROM dbo.Users
WHERE Reputation >= 10000
  AND Location IS NOT NULL
  AND Location LIKE '%Poland%'
ORDER BY Reputation DESC;


-- najczęściej oglądane posty

SELECT TOP (20)
    Id,
    Title,
    ViewCount,
    Score
FROM dbo.Posts
WHERE Title IS NOT NULL
ORDER BY ViewCount DESC;


-- najwyżej oceniane posty
SELECT TOP (20)
    Id,
    Title,
    Score,
    ViewCount
FROM dbo.Posts
WHERE Title IS NOT NULL
ORDER BY Score DESC;


-- Popularne pytania dotyczące SQL
SELECT TOP (20)
    Id,
    Title,
    Score,
    ViewCount,
    CreationDate
FROM dbo.Posts
WHERE Title LIKE '%SQL%'
  AND Score >= 10
  AND ViewCount >= 1000
ORDER BY ViewCount DESC;