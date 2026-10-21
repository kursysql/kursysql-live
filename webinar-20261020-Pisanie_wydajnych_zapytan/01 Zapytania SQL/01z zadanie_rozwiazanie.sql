/*

    Pisanie wydajnych zapytań - szkolenie hybrydowe
    Spotkanie 1 - Zapytania SQL
    z/ zadania - rozwiązania

    Tomasz Libera | MVP Data Platform
    libera@kursysql.pl

    http://www.kursysql.pl
    http://www.youtube.com/c/KursySQL

*/

USE StackOverflowMini;
GO


-- 1. Wyświetl nazwę użytkownika, reputację i lokalizację użytkowników,
-- którzy mają więcej niż 5000 punktów reputacji.
-- Wyniki posortuj malejąco według reputacji.
SELECT
    DisplayName,
    Reputation,
    Location
FROM dbo.Users
WHERE Reputation > 5000
ORDER BY Reputation DESC;


-- 2. Wyświetl 20 użytkowników o najwyższej reputacji.
-- Pokaż kolumny: Id, DisplayName, Reputation, Location.
SELECT TOP (20)
    Id,
    DisplayName,
    Reputation,
    Location
FROM dbo.Users
ORDER BY Reputation DESC;


-- 3. Wyświetl wszystkie różne lokalizacje użytkowników.
-- Pomiń wartości NULL i posortuj wynik alfabetycznie.
SELECT DISTINCT
    Location
FROM dbo.Users
WHERE Location IS NOT NULL
ORDER BY Location;


-- 4. Wyświetl użytkowników, którzy utworzyli konto w pierwszym kwartale 2009 roku.
-- Pokaż kolumny: Id, DisplayName, CreationDate.
-- Wyniki posortuj rosnąco według daty utworzenia konta.
SELECT
    Id,
    DisplayName,
    CreationDate
FROM dbo.Users
WHERE CreationDate >= '2009-01-01'
  AND CreationDate <  '2009-04-01'
ORDER BY CreationDate;


-- 5. Wyświetl użytkowników, którzy mają od 1000 do 5000 punktów reputacji
-- oraz w polu Location mają tekst "Poland".
-- Wyniki posortuj malejąco według reputacji.
SELECT
    DisplayName,
    Reputation,
    Location
FROM dbo.Users
WHERE Reputation BETWEEN 1000 AND 5000
  AND Location LIKE '%Poland%'
ORDER BY Reputation DESC;


-- 6. Wyświetl pierwszych 20 użytkowników, których DisplayName zaczyna się na literę A
-- i którzy mają podaną lokalizację.
-- Wyniki posortuj alfabetycznie według DisplayName.
SELECT TOP (20)
    Id,
    DisplayName,
    Reputation,
    Location
FROM dbo.Users
WHERE DisplayName LIKE 'A%'
  AND Location IS NOT NULL
ORDER BY DisplayName;


-- 7. Wyświetl 20 najczęściej oglądanych postów, które mają tytuł.
-- Pokaż kolumny: Id, Title, ViewCount, Score.
SELECT TOP (20)
    Id,
    Title,
    ViewCount,
    Score
FROM dbo.Posts
WHERE Title IS NOT NULL
ORDER BY ViewCount DESC;


-- 8. Wyświetl posty, których tytuł zawiera tekst "SQL" i które mają co najmniej 5 punktów Score.
-- Pokaż kolumny: Id, Title, Score, ViewCount.
-- Wyniki posortuj malejąco według Score, a następnie ViewCount.
SELECT
    Id,
    Title,
    Score,
    ViewCount
FROM dbo.Posts
WHERE Title LIKE '%SQL%'
  AND Score >= 5
ORDER BY Score DESC, ViewCount DESC;


-- 9. Wyświetl posty utworzone w drugiej połowie 2009 roku,
-- których tytuł zawiera tekst "database".
-- Pokaż kolumny: Id, Title, CreationDate, Score, ViewCount.
-- Wyniki posortuj malejąco według CreationDate.
SELECT
    Id,
    Title,
    CreationDate,
    Score,
    ViewCount
FROM dbo.Posts
WHERE CreationDate >= '2009-07-01'
  AND CreationDate <  '2010-01-01'
  AND Title LIKE '%database%'
ORDER BY CreationDate DESC;


-- 10. Wyświetl 25 postów, które:
--     - mają tytuł,
--     - mają Score od 10 do 50,
--     - mają co najmniej 1000 wyświetleń,
--     - a w tytule zawierają "SQL" lub "database".
-- Pokaż kolumny: Id, Title, Score, ViewCount, CreationDate.
-- Wyniki posortuj malejąco według ViewCount, a następnie Score.
SELECT TOP (25)
    Id,
    Title,
    Score,
    ViewCount,
    CreationDate
FROM dbo.Posts
WHERE Title IS NOT NULL
  AND Score BETWEEN 10 AND 50
  AND ViewCount >= 1000
  AND (
        Title LIKE '%SQL%'
        OR Title LIKE '%database%'
      )
ORDER BY ViewCount DESC, Score DESC;
