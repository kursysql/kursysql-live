/*
	Łączenie tabel
    ZADANIA

	libera@kursysql.pl
	https://github.com/microsoft/sql-server-samples/blob/master/samples/databases/northwind-pubs/instnwnd.sql
*/


-- 1/ Wyświetl zamówienia - numer, datę, id klienta i identyfikartor produktu oraz cenę

SELECT o.OrderID, o.OrderDate, o.CustomerID, od.ProductID, od.UnitPrice
FROM Orders AS o
JOIN Customers AS c 
  ON c.CustomerID = o.CustomerID
JOIN [Order Details] AS od 
  ON od.OrderID = o.OrderID
  

-- 2/ Dodaj do powyższego zapytania nazwę kategorii produktu

SELECT o.OrderID, o.OrderDate, o.CustomerID, od.ProductID, od.UnitPrice, cat.CategoryName
FROM Orders AS o
JOIN Customers AS c 
  ON c.CustomerID = o.CustomerID
JOIN [Order Details] AS od 
  ON od.OrderID = o.OrderID
JOIN Products AS p
  ON p.ProductID = od.ProductID
JOIN Categories AS cat 
  ON cat.CategoryID = p.CategoryID


-- 3/ Ogranicz powyższe zapytanie do zamówień klientów z Niemiec


SELECT * FROM Customers

SELECT o.OrderID, o.OrderDate, o.CustomerID, od.ProductID, od.UnitPrice, cat.CategoryName
FROM Orders AS o
JOIN Customers AS c 
  ON c.CustomerID = o.CustomerID
JOIN [Order Details] AS od 
  ON od.OrderID = o.OrderID
JOIN Products AS p
  ON p.ProductID = od.ProductID
JOIN Categories AS cat 
  ON cat.CategoryID = p.CategoryID
WHERE c.Country = 'Germany'


-- 4/ Wyświetl nazwy dostawców, którzy realizowali zamówienia w 1997 roku

SELECT DISTINCT s.CompanyName
FROM Shippers s 
JOIN Orders o ON o.ShipVia = s.ShipperID
WHERE YEAR(o.OrderDate) = 1997


-- 5/ Wyświetl nazwiska klientów który składali zamówienia zarówno w 1996, jak i 1997 i 1998

SELECT DISTINCT c.ContactName
FROM Orders AS o
JOIN Customers AS c 
  ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 1996
INTERSECT
SELECT DISTINCT c.ContactName
FROM Orders AS o
JOIN Customers AS c 
  ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 1997
INTERSECT
SELECT DISTINCT c.ContactName
FROM Orders AS o
JOIN Customers AS c 
  ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 1997
ORDER BY ContactName

