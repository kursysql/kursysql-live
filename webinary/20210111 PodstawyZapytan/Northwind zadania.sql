/*
	Northwind - Podstawy zapytań
    ZADANIA

	libera@kursysql.pl
	https://github.com/microsoft/sql-server-samples/blob/master/samples/databases/northwind-pubs/instnwnd.sql
*/

/*
    A/ Pierwsze zapytania, Sortowanie
*/

-- A1 Wyświetl listę produktów 
SELECT * FROM Products

-- A2 Wyświetl listę klientów
SELECT * FROM Customers

-- A3 Wyświetl kolumnę CustomerID oraz City i Country z tabeli z klientami
SELECT CustomerID, City, Country
FROM Customers

-- A4 Wyświetl niepowtarzalną nazwę kraju z tabeli z klientami
SELECT DISTINCT Country
FROM Customers

-- A5 Wyświetl niepowtarzalną nazwę miasta z tabeli z klientami
SELECT DISTINCT City
FROM Customers

-- A6 Wyświetl niepowtarzalną kombinację kraju i miasta z tabeli z klientami
SELECT DISTINCT Country, City
FROM Customers

-- A7 Wyświetl dane pracowników - imię i nazwisko, stanowisko, datę urodzenia, datę zatrudnienia oraz miasto
-- korzystając z aliastów przetłumacz nazwy kolumn na język polski
SELECT EmployeeID,
    FirstName AS Imie,
    LastName AS Nazwisko,
    Title AS Stanowisko,
    BirthDate AS DataUrodzenia,
    HireDate AS DataZatrudnienia,
    City AS Miasto
FROM Employees

-- A8 Wyświetl informację o klientach, posortowanych wg nazwy firmy rosnąco
SELECT * 
FROM Customers
ORDER BY CompanyName


-- A9 Wyświetl informację o klientach, posortowanych wg państwa i miasta rosnąco oraz nazwy firmy malejąco
SELECT *
FROM Customers
ORDER BY Country, City, CompanyName DESC


-- A10 Wyświetl 20 klientaów o najwyższych identyfikatorach
SELECT * FROM Customers ORDER BY CustomerID DESC
