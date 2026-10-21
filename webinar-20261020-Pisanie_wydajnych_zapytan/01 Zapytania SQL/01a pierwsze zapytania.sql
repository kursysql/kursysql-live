/*

	Pisanie wydajnych zapytań - szkolenie hybrydowe
	Spotkanie 1 - Zapytania SQL
    a/ pierwsze zapytania 

	Tomasz Libera | MVP Data Platform
	libera@kursysql.pl
	
    http://www.kursysql.pl
    http://www.youtube.com/c/KursySQL

*/




USE StackOverflowMini;
GO

-- Jakie tabele mamy w bazie?
SELECT *
FROM sys.tables
ORDER BY name;
GO

/*

	Object Explorer:
	- lista obiektów
	- Raporty (rozmiar tabel)
	- Odświeżanie listy (np. nowa tabela)
	- SELECT TOP 1000 Rows

*/


SELECT * FROM dbo.Users;

SELECT * FROM dbo.Posts;


SELECT TOP 100 * FROM dbo.Posts




-- tylko potrzebne kolumny

SELECT
    Id,
    DisplayName,
    Reputation,
    Location
FROM dbo.Users;


/*

	skróty klawiaturowe:
	- F5 - wykonaj zapytanie
	- Alt+F1 - wyświetla dokumentację dla zaznaczonego obiektu (sp_help)
	- Ctrl+R - włącza/wyłącza wyniki

*/



-- aliasy kolumn
SELECT
    DisplayName AS UserName,
    Reputation AS ReputationPoints,
    Location AS UserLocation
FROM dbo.Users;





-- TOP

SELECT TOP (10)
    Id,
    DisplayName,
    Reputation,
    Location
FROM dbo.Users;



SELECT TOP (2) PERCENT
    Id,
    DisplayName,
    Reputation,
    Location
FROM dbo.Users;