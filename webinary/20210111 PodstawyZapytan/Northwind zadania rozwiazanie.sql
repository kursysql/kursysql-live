/*
	Northwind - Podstawy zapytań
    ZADANIA

	libera@kursysql.pl
	https://github.com/microsoft/sql-server-samples/blob/master/samples/databases/northwind-pubs/instnwnd.sql
*/

/*
    A Pierwsze zapytania, Sortowanie
*/

-- 1 Wyświetl listę produktów 
SELECT * FROM Products

-- 2 Wyświetl listę klientów
SELECT * FROM Customers

-- 3 Wyświetl kolumnę CustomerID oraz City i Country z tabeli z klientami
SELECT CustomerID, City, Country
FROM Customers

-- 4 Wyświetl niepowtarzalną nazwę kraju z tabeli z klientami
SELECT DISTINCT Country
FROM Customers

-- 5 Wyświetl niepowtarzalną nazwę miasta z tabeli z klientami
SELECT DISTINCT City
FROM Customers

-- 6 Wyświetl niepowtarzalną kombinację kraju i miasta z tabeli z klientami
SELECT DISTINCT Country, City
FROM Customers

-- 7 Wyświetl dane pracowników - imię i nazwisko, stanowisko, datę urodzenia, datę zatrudnienia oraz miasto
-- korzystając z aliastów przetłumacz nazwy kolumn na język polski
SELECT EmployeeID,
    FirstName AS Imie,
    LastName AS Nazwisko,
    Title AS Stanowisko,
    BirthDate AS DataUrodzenia,
    HireDate AS DataZatrudnienia,
    City AS Miasto
FROM Employees

-- 8 Wyświetl informację o klientach, posortowanych wg nazwy firmy rosnąco
SELECT * 
FROM Customers
ORDER BY CompanyName


-- 9 Wyświetl informację o klientach, posortowanych wg państwa i miasta rosnąco oraz nazwy firmy malejąco
SELECT *
FROM Customers
ORDER BY Country, City, CompanyName DESC


-- 10 Wyświetl 20 klientaów o najwyższych identyfikatorach
SELECT * FROM Customers ORDER BY CustomerID DESC



/*
    B Filtrowanie
*/


-- 1. Wyświetl zamówienia przypisane do pracownika 9
SELECT * FROM Orders WHERE EmployeeID = 9

-- 2. Wyświetl zamówienia złożone przez klienta QUICK
SELECT * FROM Orders WHERE CustomerID = 'QUICK'

-- 3. Wyświetl zamówienia złożone przez klineta QUICK i przypisane do pracownika 9
SELECT * FROM Orders WHERE EmployeeID = 9 AND CustomerID = 'QUICK'

-- 4. Wyświetl zamówienia z Polski, Niemiec i Francji
SELECT * FROM Orders WHERE ShipCountry IN ('Germany', 'France', 'Poland')

-- 5. Wyświetl zamówienia z 30 kwietnia 1997
SELECT * FROM Orders WHERE OrderDate = '19970430'

-- 6. Wyświetl zamówienia z 1997 roku
SELECT * FROM Orders WHERE YEAR(OrderDate) = 1997

-- 7. Wyświetl zamówienia złożone przez klientów których kod zaczyna się na M i końcy na D
SELECT * FROM Orders WHERE CustomerID LIKE 'M___D'

-- 8. Wyświetl klientów (tabela Customers), których nazwisko kończy się na ski
SELECT * FROM Customers WHERE ContactName LIKE '%ski'

-- 9. Wyświetl klientów (tabela Customers), których nazwisko kończy się na ski lub wicz
SELECT * FROM Customers WHERE ContactName LIKE '%ski' OR ContactName LIKE '%wicz'

-- 10. Wyświetl klientów którzy mają niezdefiniowaną informację o Regionie
SELECT * FROM Customers WHERE Region IS NULL

