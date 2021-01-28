/*
	Tomasz Libera | libera@kursysql.pl

	ŚLEDZENIE ZMIAN w bazie danych
	_Setup

*/

/*

RESTORE DATABASE [AdventureWorks2017] FROM  DISK = N'C:\SQL_Backup\AdventureWorks2017.bak' 
WITH  FILE = 1,  REPLACE,
MOVE N'AdventureWorks2017' TO N'C:\SQL_Data\AdventureWorks2017.mdf',  
MOVE N'AdventureWorks2017_log' TO N'C:\SQL_Data\AdventureWorks2017_log.ldf'
 
GO

*/



USE AdventureWorks2017
GO




--DROP TABLE IF EXISTS People 
--GO

BEGIN
--If table is system-versioned, SYSTEM_VERSIONING must be set to OFF first
	IF ((SELECT temporal_type FROM sys.tables WHERE object_id = OBJECT_ID('dbo.People', 'U')) = 2)
	BEGIN
	ALTER TABLE dbo.People SET (SYSTEM_VERSIONING = OFF)
	END
	DROP TABLE IF EXISTS dbo.PeopleHistory
	DROP TABLE IF EXISTS dbo.People
END
GO




CREATE TABLE dbo.People
(
	ID int PRIMARY KEY CLUSTERED
	,FirstName nvarchar(50) NOT NULL
	,LastName nvarchar(50) NOT NULL
	,EmailAddress nvarchar(50) NOT NULL
	,AddressLine1 nvarchar(50) NOT NULL
	,City nvarchar(30) NOT NULL
	,PostalCode nvarchar(15) NOT NULL
	,Country nvarchar(50) NOT NULL
	,ValidFrom datetime2 (2) GENERATED ALWAYS AS ROW START
	,ValidTo datetime2 (2) GENERATED ALWAYS AS ROW END
	,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
--WITH (SYSTEM_VERSIONING = ON);
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.PeopleHistory));




DROP SEQUENCE IF EXISTS dbo.PeopleID 
GO

CREATE SEQUENCE dbo.PeopleID 
 AS [int]
 START WITH 1
 INCREMENT BY 1
GO


ALTER TABLE People ADD CONSTRAINT DF_People_ID DEFAULT (NEXT VALUE FOR PeopleID) FOR ID
GO


DROP FUNCTION IF EXISTS udf_People
GO

CREATE FUNCTION udf_People (@Loop int)
RETURNS TABLE AS
RETURN 

WITH PeopleCTE AS (

	SELECT 
		p.BusinessEntityID AS ID,
		IIF(@Loop = 0, p.FirstName, p.FirstName + CAST(@Loop AS varchar(3))) AS FirstName,
		IIF(@Loop = 0, p.LastName, p.LastName + CAST(@Loop AS varchar(3))) AS LastName,
		em.EmailAddress,
		a.AddressLine1,
		a.City,
		a.PostalCode,
		sp.Name AS RegionName,
		c.Name AS Country,
		ROW_NUMBER() OVER(PARTITION BY be.BusinessEntityID ORDER BY be.BusinessEntityID) AS RN
	FROM Person.Person AS p
	JOIN Person.BusinessEntity AS be ON be.BusinessEntityID = p.BusinessEntityID
	JOIN Person.BusinessEntityAddress AS bea ON bea.BusinessEntityID = be.BusinessEntityID
	JOIN Person.AddressType AS atype ON atype.AddressTypeID = bea.AddressTypeID
	JOIN Person.Address AS a ON a.AddressID = bea.AddressID
	JOIN Person.StateProvince AS sp ON sp.StateProvinceID = a.StateProvinceID
	JOIN Person.CountryRegion AS c ON c.CountryRegionCode = sp.CountryRegionCode
	JOIN Person.EmailAddress AS em ON em.BusinessEntityID = be.BusinessEntityID 
	LEFT JOIN HumanResources.Employee AS emp ON emp.BusinessEntityID = be.BusinessEntityID
) 
SELECT * 
FROM PeopleCTE
WHERE Rn = 1
GO





	INSERT INTO People
		(FirstName, LastName, EmailAddress, 
		AddressLine1, City, PostalCode, Country)
	SELECT 
		FirstName, LastName, EmailAddress,  
		AddressLine1, City, PostalCode, Country
	FROM udf_People(0)	
	ORDER BY ID



ALTER TABLE dbo.People REBUILD;
GO



