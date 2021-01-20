/*
	Northwind
	Podstawy zapytań

	libera@kursysql.pl
	https://github.com/microsoft/sql-server-samples/blob/master/samples/databases/northwind-pubs/instnwnd.sql
*/


USE Northwind
GO


/*

	PIERWSZE ZAPYTANIA

*/


-- wszystkie kolumny
SELECT * FROM Region


-- wybrane kolumny
SELECT EmployeeID, FirstName, LastName, City,  Region, Country 
FROM Employees


-- aliasy kolumn
SELECT EmployeeID AS PracownikID, FirstName AS Imie, LastName AS Nazwisko, City AS Miasto,  Region AS Region, Country AS Panstwo
FROM Employees


-- zawartość jednej kolumny
SELECT Country 
FROM Employees


-- zawartość jednej kolumny, bez powtózeń
SELECT DISTINCT Country 
FROM Employees

-- pierwszych 10 wierszy
SELECT TOP 10 *
FROM Orders


-- Wyrażenia
SELECT EmployeeID, FirstName + ' ' + LastName AS FullName
FROM Employees


-- Wyrażenia
SELECT TOP 10 OrderID, ProductID, UnitPrice, Quantity, UnitPrice*Quantity AS Total
FROM [Order Details]

/*
	SORTOWANIE
*/

-- Pracownicy posortowanie wg nazwiska rosnąco
SELECT EmployeeID, FirstName, LastName, City
FROM Employees
ORDER BY Lastname

-- Pracownicy posortowanie wg nazwiska malejąco
SELECT EmployeeID, FirstName, LastName, City
FROM Employees
ORDER BY Lastname DESC



-- Pracownicy posortowanie wg nazwiska i imienia rosnąco
SELECT EmployeeID, FirstName, LastName, City
FROM Employees
ORDER BY Lastname, Firstname

-- Pracownicy posortowanie wg miasto malejąco oraz nazwiska i imienia rosnąco
SELECT EmployeeID, FirstName, LastName, City
FROM Employees
ORDER BY City DESC, Lastname, Firstname


-- 10 najnowszych zamówień
SELECT TOP 10 OrderID, CustomerID, OrderDate, ShipCity, ShipCountry
FROM Orders
ORDER BY OrderDate DESC


-- 10 najnowszych zamówień - inaczej (SQL Server 2012+)
SELECT OrderID, CustomerID, OrderDate, ShipCity, ShipCountry
FROM Orders
ORDER BY OrderDate DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY

-- 10 KOLEJNYCH zamówień (SQL Server 2012+)
SELECT OrderID, CustomerID, OrderDate, ShipCity, ShipCountry
FROM Orders
ORDER BY OrderDate DESC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY


/*
	FILTROWANIE
*/



SELECT * FROM Employees

-- liczby
SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE EmployeeID = 5

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE EmployeeID < 6

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE EmployeeID BETWEEN 1 AND 6

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE EmployeeID >= 1 AND EmployeeID <= 6


-- tekst
SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE Country = 'UK'

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE Country = 'USA'


SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE LastName LIKE 'B%'



SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE Title LIKE '%Sales%'

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE Title LIKE '%sales%' -- wielkość liter nie ma znaczenia

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE Title LIKE '%sales%' COLLATE Polish_CS_AS -- chyba że zmienimy COLLATION

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE Title LIKE '%Sales%' COLLATE Polish_CS_AS -- chyba że zmienimy COLLATION



SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE Country LIKE 'U__'

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees 
WHERE Country LIKE 'U_'


-- daty
SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees
WHERE BirthDate = '19630830'

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees
WHERE BirthDate >= '19630101' AND BirthDate <= '19631231'

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees
WHERE BirthDate BETWEEN '19630101' AND '19631231'

-- to zapytanie zwraca to samo co powyższe, jest mniej wydajne ale i tak zapraszam za webinar 20 stycznia ;)
SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees
WHERE YEAR(BirthDate) = 1963



-- NULL
SELECT CustomerID, CompanyName, ContactName, ContactTitle, City, Region
FROM Customers 

SELECT CustomerID, CompanyName, ContactName, ContactTitle, City, Region
FROM Customers 
WHERE Region IS NULL

SELECT CustomerID, CompanyName, ContactName, ContactTitle, City, Region
FROM Customers 
WHERE Region IS NOT NULL





-- Operatory logiczne

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees
WHERE Country = 'USA' AND City = 'Redmond'

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees
WHERE Country = 'USA' AND City <> 'Redmond'

SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees
WHERE City = 'Redmond' OR City = 'Seattle'

-- !!! AND jest ważniejszy niż OR
SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees
WHERE City = 'Redmond' OR City = 'Seattle' AND FirstName = 'Laura'

-- ten sam wynik co powyższe
SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees
WHERE City = 'Redmond' OR (City = 'Seattle' AND FirstName = 'Laura')


SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees
WHERE (City = 'Redmond' OR City = 'Seattle') AND FirstName = 'Laura'

-- można też tak
SELECT EmployeeID, FirstName, LastName, Title, BirthDate, Address, City, Country 
FROM Employees
WHERE City IN ('Redmon', 'Seattle') AND FirstName = 'Laura'






















