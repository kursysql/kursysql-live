
SELECT database_id, name FROM sys.databases

USE AdventureWorks2017
GO

ALTER DATABASE AdventureWorks2017 SET QUERY_STORE = ON
GO

SELECT * FROM  Person.Person




SELECT p.ProductID, p.Name, p.Color, ps.Name AS SubCategoryName
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS ps ON ps.ProductSubcategoryID = p.ProductSubcategoryID

