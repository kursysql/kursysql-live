/*
	TSQL Funkcje
	KursySQL.pl - webinary - styczeń 2021

	libera@kursysql.pl
	https://www.kursysql.pl/kurs-t-sql-live-on-line/
	https://github.com/kursysql/kursysql-live
    
*/


/* 
	Funkcje skalarne i funkcje agregujące 
*/

SELECT GETDATE()

SELECT * FROM Customers

SELECT UPPER(CompanyName), * FROM Customers

SELECT count(*) FROM Customers


/* 
	Funkcje konwersji 
*/

SELECT 12+3

SELECT 'SQL Server' + ' ' + '2019'

SELECT CompanyName + ', ' + ContactName, * FROM Customers


SELECT * FROM Orders
-- !!!
SELECT 'SQL Server' + ' ' + 2019
-- !!!
SELECT ShipVia + ', ' + ShipName, * FROM Orders

-- https://docs.microsoft.com/en-us/sql/t-sql/data-types/data-type-precedence-transact-sql?view=sql-server-ver15


SELECT 'SQL Server' + ' ' + CAST(2019 AS char(4))

SELECT CAST(ShipVia AS varchar(5)) + ', ' + ShipName, * FROM Orders



SELECT 'SQL Server' + ' ' + CONVERT(char(4), 2019)

SELECT CONVERT(varchar(5), ShipVia) + ', ' + ShipName, * FROM Orders




SELECT * FROM Orders


SELECT ShippedDate + ', ' + ShipCity, * FROM Orders

SELECT CAST(ShippedDate AS varchar(20)) + ', ' + ShipCity, * FROM Orders
SELECT CONVERT(varchar(20), ShippedDate) + ', ' + ShipCity, * FROM Orders

SELECT CAST(GETDATE() AS varchar(20))

SET LANGUAGE polish

SELECT CAST(GETDATE() AS varchar(20))

SET LANGUAGE english


-- https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15

SELECT CONVERT(varchar(20), GETDATE())

SELECT CONVERT(varchar(20), GETDATE(), 120) -- 120 - ODBC canonical

SELECT CONVERT(varchar(10), GETDATE(), 120) -- bez godziny


SELECT CONVERT(varchar(20), GETDATE(), 103) -- 103 - British/French
SELECT CONVERT(varchar(20), GETDATE(), 3) 


SELECT ShippedDate + ', ' + ShipCity, * FROM Orders

SELECT CONVERT(varchar(20), ShippedDate, 3)  + ', ' + ShipCity, * FROM Orders





/* 
	Funkcje tekstowe 
	https://docs.microsoft.com/en-us/sql/t-sql/functions/string-functions-transact-sql?view=sql-server-ver15
*/

SELECT * FROM Customers

-- usuwanie spacji
SELECT RTRIM('test   ')
SELECT LTRIM('   test')

SELECT TRIM('   test    ')

-- wielkie litery
SELECT UPPER(CompanyName), * FROM Customers

-- pięć pierwszych znaków
SELECT LEFT(ContactName, 5), * FROM Customers

-- pozycja spacji
SELECT CHARINDEX(' ', ContactName, 0), * FROM Customers

-- imię
SELECT LEFT(ContactName, CHARINDEX(' ', ContactName, 0)-1), * FROM Customers
-- imię
SELECT SUBSTRING(ContactName, 1, CHARINDEX(' ', ContactName, 0)-1), * FROM Customers

-- nazwisko
SELECT SUBSTRING(ContactName, CHARINDEX(' ', ContactName, 0)+1, LEN(ContactName)), * FROM Customers



-- zamienia łańcuch znaków na odrębne wiersze
SELECT Description FROM Categories

SELECT value FROM STRING_SPLIT('Soft drinks, coffees, teas, beers', ',')

SELECT TRIM(value) FROM STRING_SPLIT('Soft drinks, coffees, teas, beers', ',')

SELECT * FROM Categories WHERE CategoryID = 1

SELECT CategoryName, Description, TRIM(value) 
FROM Categories
CROSS APPLY STRING_SPLIT(CAST(Description AS varchar(max)), ',')
WHERE CategoryID = 1







/* 
	Funkcje daty i czasu
	https://docs.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-ver15
*/

SELECT GETDATE()

SELECT OrderDate, 
	YEAR(OrderDate) AS _year, 
	MONTH(OrderDate) AS _month, 
	DAY(OrderDate) AS _day 
FROM Orders


-- https://docs.microsoft.com/en-us/sql/t-sql/functions/datename-transact-sql?view=sql-server-ver15
SELECT DATENAME(MONTH, GETDATE()), DATENAME(WEEKDAY, GETDATE())

SELECT OrderDate, DATENAME(month, OrderDate) AS _month, DATENAME(WEEKDAY, OrderDate) AS _weekday FROM Orders

SET language polish
SELECT OrderDate, DATENAME(month, OrderDate) AS _month, DATENAME(WEEKDAY, OrderDate) AS _weekday FROM Orders
SET language english

-- https://docs.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql?view=sql-server-ver15
SELECT DATEPART(DAYOFYEAR, GETDATE()), DATENAME(WEEK, GETDATE())

SELECT OrderDate, 
	DATEPART(DAYOFYEAR, OrderDate) AS _DAYOFYEAR, 
	DATEPART(WEEK, OrderDate) AS _WEEK 
FROM Orders


SELECT OrderDate, ShippedDate, 
	DATEDIFF(day, OrderDate, ShippedDate) AS _diff_days
FROM Orders

SELECT OrderDate, ShippedDate, 
	DATEDIFF(WEEK, OrderDate, ShippedDate) AS _diff_weeks 
FROM Orders


SELECT OrderDate, DATEDIFF(YEAR, OrderDate, GETDATE()) AS _diff_years FROM Orders

SELECT OrderDate, DATEDIFF(MONTH, OrderDate, GETDATE()) AS _diff_months FROM Orders

SELECT OrderDate, DATEDIFF(DAY, OrderDate, GETDATE()) AS _diff_days FROM Orders

SELECT DATEDIFF(DAY, GETDATE(), '20210131') -- do konca miesiąca

SELECT EOMONTH(GETDATE())


-- ile dni do końca zapisów na SQL od podstaw ;)
SELECT DATEDIFF(DAY, GETDATE(), EOMONTH(GETDATE())) 

-- ile godzin do końca zapisów na SQL od podstaw ;)
SELECT DATEDIFF(HOUR, GETDATE(), '20210131 21:00')




/* 
	Matematyczne
	https://docs.microsoft.com/en-us/sql/t-sql/functions/mathematical-functions-transact-sql?view=sql-server-ver15
*/

SELECT * FROM [Order Details]

-- zaokrąglanie
SELECT OrderID, ProductID, UnitPrice, ROUND(UnitPrice, 0)
FROM [Order Details]

SELECT OrderID, ProductID, UnitPrice, ROUND(UnitPrice, -1)
FROM [Order Details]

SELECT OrderID, ProductID, UnitPrice, FLOOR(UnitPrice), CEILING(UnitPrice)
FROM [Order Details]



SELECT RAND()


-- przedział 10 - 20
SELECT 10 + CONVERT(INT, (20-10+1) * RAND())
-- Przedział 0-10
SELECT 0 + CONVERT(INT, (10-0+1) * RAND())

-- deterministyczna
SELECT 
	RAND(), 
	10 + CONVERT(INT, (20-10+1) * RAND()), 
	* 
FROM Categories

SELECT 
	RAND(), 
	10 + CONVERT(INT, (20-10+1) * RAND()), 
	RAND(CHECKSUM(NEWID())), 
	10 + CONVERT(INT, (20-10+1) * RAND(CHECKSUM(NEWID()))), 
	* 
FROM Categories



/* 
	Logiczne
	https://docs.microsoft.com/en-us/sql/t-sql/functions/mathematical-functions-transact-sql?view=sql-server-ver15
*/


SELECT IIF(2>3, '2 większe niż 3', '3 większe niż 2')

SELECT EmployeeID, Country FROM Employees

SELECT EmployeeID, Country, IIF(Country='USA', 'United States', 'other') 
FROM Employees

SELECT EmployeeID, Country, IIF(Country='UK', 'United Kingdom', 'other') 
FROM Employees

SELECT EmployeeID, Country, 
	IIF(Country='UK', 'United Kingdom', IIF(Country='USA', 'United States', 'other'))
FROM Employees


SELECT EmployeeID, Country, 
	CASE 
		WHEN Country='UK' THEN 'United Kingdom'
		WHEN Country='USA' THEN 'United States'
	END AS Country
FROM Employees

SELECT EmployeeID, Country, 
	CASE Country
		WHEN 'UK' THEN 'United Kingdom'
		WHEN 'USA' THEN 'United States'
	END AS Country
FROM Employees



/* 
	Tworzenie funkcji skalarnych - wprowadzenie
*/

SELECT * FROM Categories
GO

DROP FUNCTION dbo.GetCategoryName
GO

CREATE FUNCTION dbo.GetCategoryName(@CategoryID int)
RETURNS nvarchar(15)
AS
BEGIN
	RETURN (SELECT CategoryName FROM Categories WHERE CategoryID = @CategoryID)
END
GO


SELECT dbo.GetCategoryName(2)
SELECT dbo.GetCategoryName(3)

-- !!!
SELECT GetCategoryName(2)


SELECT * FROM Products

SELECT ProductID, ProductName, CategoryID, dbo.GetCategoryName(CategoryID) 
FROM Products




/*
	Funkcje agregujące
*/


SELECT * FROM Categories


SELECT COUNT(*) FROM Orders

SELECT COUNT(*) FROM Orders WHERE YEAR(OrderDate) = 1997

SELECT MAX(OrderDate) FROM Orders 

SELECT MIN(OrderDate) FROM Orders 





