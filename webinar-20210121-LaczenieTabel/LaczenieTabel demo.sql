/*
	Łączenie tabel
	KursySQL.pl - webinary - styczeń 2021

	libera@kursysql.pl
	https://www.kursysql.pl/kurs-t-sql-live-on-line/
	https://github.com/kursysql/kursysql-live
    
*/


/* 
	INNER Join
*/

USE Northwind
GO

SELECT * FROM Categories

SELECT * FROM Products

SELECT * FROM Suppliers


SELECT * 
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID

SELECT 
	Products.ProductID,
	Products.ProductName,
	Products.UnitPrice,
	Products.CategoryID,
	Categories.CategoryName,
	Categories.Description
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID

SELECT 
	ProductID,
	ProductName,
	UnitPrice,
	Products.CategoryID, -- !!!
	CategoryName,
	Description
FROM Products
JOIN Categories ON Categories.CategoryID = Products.CategoryID


-- aliasy kolumn
SELECT 
	p.ProductID,
	p.ProductName,
	p.UnitPrice,
	p.CategoryID,
	c.CategoryName,
	c.Description
FROM Products AS p
JOIN Categories AS c ON c.CategoryID = p.CategoryID

SELECT 
	p.ProductID,
	p.ProductName,
	p.UnitPrice,
	p.CategoryID,
	c.CategoryName,
	c.Description
FROM Products AS p
JOIN Categories AS c ON c.CategoryID = p.CategoryID




-- trzecia tabela
SELECT 
	p.ProductID,
	p.ProductName,
	p.UnitPrice,
	p.CategoryID,
	c.CategoryName,
	c.Description,
	s.SupplierID,
	s.CompanyName
FROM Products AS p
JOIN Categories AS c ON c.CategoryID = p.CategoryID
JOIN Suppliers AS s ON s.SupplierID = p.SupplierID

-- uwaga na kolumny!
SELECT 
	p.ProductID,
	p.ProductName,
	p.UnitPrice,
	p.CategoryID,
	c.CategoryID,
	c.CategoryName,
	c.Description,
	s.SupplierID,
	s.CompanyName
FROM Products AS p
JOIN Categories AS c ON c.CategoryID = p.SupplierID -- !!!
JOIN Suppliers AS s ON s.SupplierID = p.SupplierID

SELECT 
	p.ProductID,
	p.ProductName,
	p.UnitPrice,
	p.CategoryID,
	c.CategoryName,
	c.Description,
	s.SupplierID,
	s.CompanyName
FROM Products AS p
JOIN Categories AS c ON c.CategoryID = p.ProductName -- !!!
JOIN Suppliers AS s ON s.SupplierID = p.SupplierID


SELECT * FROM Orders -- 830
SELECT * FROM Customers -- 91

SELECT * -- 830
FROM Customers AS c 
INNER JOIN Orders AS o ON o.CustomerID = c.CustomerID 


-- unikalne identyfikatory klientów - 89
SELECT DISTINCT c.CustomerID
FROM Customers AS c 
JOIN Orders AS o ON o.CustomerID = c.CustomerID 




/* 
	OUTER Join
*/

-- włącznie z klientami bez zamówień
SELECT c.CustomerID, c.CompanyName, c.Country, o.OrderID, o.CustomerID, o.OrderDate -- 832
FROM Customers AS c 
LEFT OUTER JOIN Orders AS o ON o.CustomerID = c.CustomerID 
ORDER BY o.CustomerID

-- TYLKO klienci bez zamówień
SELECT c.CustomerID, c.CompanyName, c.Country, o.OrderID, o.CustomerID, o.OrderDate -- 2
FROM Customers AS c 
LEFT JOIN Orders AS o ON o.CustomerID = c.CustomerID 
WHERE o.OrderID IS NULL

-- taki sam efekt jak powyżej
SELECT c.CustomerID, c.CompanyName, c.Country, o.OrderID, o.CustomerID, o.OrderDate -- 2
FROM Orders AS o 
RIGHT JOIN Customers AS c ON o.CustomerID = c.CustomerID 
WHERE o.OrderID IS NULL


-- z zamówieniami bez klientów
SELECT c.CustomerID, c.CompanyName, c.Country, o.OrderID, o.CustomerID, o.OrderDate -- 830
FROM Customers AS c 
RIGHT JOIN Orders AS o ON o.CustomerID = c.CustomerID 
ORDER BY o.CustomerID

-- TYLKO zamówienia bez klientów
SELECT c.CustomerID, c.CompanyName, c.Country, o.OrderID, o.CustomerID, o.OrderDate -- 830
FROM Customers AS c 
RIGHT JOIN Orders AS o ON o.CustomerID = c.CustomerID 
WHERE c.CustomerID IS NULL


UPDATE Orders SET CustomerID = NULL WHERE OrderID = 10643 -- było: ALFKI

SELECT c.CustomerID, c.CompanyName, c.Country, o.OrderID, o.CustomerID, o.OrderDate -- 1
FROM Customers AS c 
RIGHT JOIN Orders AS o ON o.CustomerID = c.CustomerID 
WHERE c.CustomerID IS NULL


-- zamówienia bez klientów i klienci bez zamówień
SELECT c.CustomerID, c.CompanyName, c.Country, o.OrderID, o.CustomerID, o.OrderDate -- 832
FROM Customers AS c 
FULL JOIN Orders AS o ON o.CustomerID = c.CustomerID 
ORDER BY o.CustomerID

-- Cleanup
UPDATE Orders SET CustomerID = NULL WHERE OrderID = 10643 -- było: ALFKI



-- CROSS JOIN - iloczyn kartezjański

SELECT ProductID, ProductName, CategoryID FROM Products -- 77

SELECT CategoryID, CategoryName FROM Categories  -- 8

-- 77x8 = 616

SELECT *
FROM Products
CROSS JOIN Categories





/* 
	Podzapytania
*/

SELECT * FROM Categories

-- produkty z kategorii, których nazwy zaczynają się na C
SELECT * 
FROM Products 
WHERE CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName LIKE 'C%' )

-- produkty z kategorii o najdłuższym opisie
SELECT * 
FROM Products 
WHERE CategoryID = (SELECT TOP 1 CategoryID FROM Categories ORDER BY LEN(CAST(Description AS nvarchar(max))) DESC)

SELECT * FROM Categories

-- podzapytanie w FROM
-- zamówienia złożone w 1996
SELECT * 
FROM (SELECT OrderID, CustomerID, OrderDate FROM Orders WHERE YEAR(OrderDate) = 1996) AS tab

-- klienci, którzy złożyli zamówienia w 1996
SELECT *
FROM Customers AS c
JOIN (
	SELECT OrderID, CustomerID, OrderDate 
	FROM Orders 
	WHERE YEAR(OrderDate) = 1996
	) AS tab
ON tab.CustomerID = c.CustomerID

SELECT c.*
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
WHERE YEAR(OrderDate) = 1996




-- podzapytania skorelowane

-- liczba zamówień
SELECT CustomerID, 
	CompanyName, 
	ContactName, 
	(SELECT count(*) FROM Orders WHERE CustomerID = c.CustomerID) AS OrdersCount
FROM Customers AS c


-- kupowane produkty
SELECT * 
FROM Products AS p
WHERE EXISTS(SELECT * FROM [Order Details] WHERE ProductID = p.ProductID)

-- to samo co powyżej... poza liczbą wierszy???
SELECT p.*
FROM Products AS p
JOIN [Order Details] AS od ON od.ProductID = p.ProductID



SELECT DISTINCT p.*
FROM Products AS p
JOIN [Order Details] AS od ON od.ProductID = p.ProductID





-- NIE kupowane produkty
-- kupowane produkty
SELECT * 
FROM Products AS p
WHERE NOT EXISTS(SELECT * FROM [Order Details] WHERE ProductID = p.ProductID)

SELECT DISTINCT p.*
FROM Products AS p
LEFT JOIN [Order Details] AS od ON od.ProductID = p.ProductID
WHERE od.OrderID IS NULL



/* 
	UNION, EXCEPT, INTERSECT
	wymagania: tyle samo kolumn, typy danych
*/


SELECT DISTINCT YEAR(OrderDate) FROM Orders

-- klienci którzy składali zamówienia w 1996 -- 67
SELECT DISTINCT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1996

-- klienci którzy składali zamówienia w 1997 -- 87
SELECT DISTINCT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1997

-- 154
SELECT DISTINCT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1996
UNION ALL
SELECT DISTINCT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1997

-- bez duplikatów
SELECT DISTINCT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1996
UNION 
SELECT DISTINCT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1997

-- Ci który składali zamówienia w 1996 - ale nie składali w 1997
SELECT DISTINCT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1996
EXCEPT
SELECT DISTINCT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1997

-- odwrotnie :)
SELECT DISTINCT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1997
EXCEPT
SELECT DISTINCT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1996

-- czy wśród klientów są jacyś pracownicy?
SELECT ContactName FROM Customers
INTERSECT
SELECT FirstName + ' ' + LastName FROM Employees



/* 
	CTE
*/

;WITH cte AS 
(
	SELECT ProductID, ProductName, UnitPrice
	FROM Products
)
SELECT * FROM cte


-- deklaracja kolumn
;WITH cte (ID, Name, Price, Category) AS 
(
	SELECT ProductID, ProductName, UnitPrice, CategoryName
	FROM Products AS p
	JOIN Categories AS c ON c.CategoryID = p.CategoryID
)
SELECT * FROM cte



-- https://github.com/kursysql/TSQL/blob/master/02%20CTE.sql
-- https://www.youtube.com/watch?v=4QuT6OwZ9ic