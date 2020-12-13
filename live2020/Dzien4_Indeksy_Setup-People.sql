

USE AdventureWorks2017
GO


DROP TABLE IF EXISTS People 
GO

	SELECT 
		p.BusinessEntityID AS ID,
		p.PersonType,
		p.Title,
		p.FirstName,
		p.MiddleName,
		p.LastName,
		p.EmailPromotion,
		p.rowguid,
		p.ModifiedDate,
		em.EmailAddress,
		bea.AddressTypeID,
		atype.Name AS AddressType,
		a.AddressLine1,
		a.AddressLine2,
		a.City,
		a.PostalCode,
		sp.Name AS RegionName,
		c.Name AS Country,
		emp.BirthDate,
		emp.Gender,
		emp.MaritalStatus,
		ROW_NUMBER() OVER(PARTITION BY be.BusinessEntityID ORDER BY be.BusinessEntityID) AS RN
	INTO People
	FROM Person.Person AS p
	JOIN Person.BusinessEntity AS be ON be.BusinessEntityID = p.BusinessEntityID
	JOIN Person.BusinessEntityAddress AS bea ON bea.BusinessEntityID = be.BusinessEntityID
	JOIN Person.AddressType AS atype ON atype.AddressTypeID = bea.AddressTypeID
	JOIN Person.Address AS a ON a.AddressID = bea.AddressID
	JOIN Person.StateProvince AS sp ON sp.StateProvinceID = a.StateProvinceID
	JOIN Person.CountryRegion AS c ON c.CountryRegionCode = sp.CountryRegionCode
	JOIN Person.EmailAddress AS em ON em.BusinessEntityID = be.BusinessEntityID 
	LEFT JOIN HumanResources.Employee AS emp ON emp.BusinessEntityID = be.BusinessEntityID
	WHERE 1 = 2
GO

ALTER TABLE People DROP COLUMN Rn
GO

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
		--p.BusinessEntityID AS ID,
		p.PersonType,
		p.Title,
		IIF(@Loop = 0, p.FirstName, p.FirstName + CAST(@Loop AS varchar(3))) AS FirstName,
		p.MiddleName,
		IIF(@Loop = 0, p.LastName, p.LastName + CAST(@Loop AS varchar(3))) AS LastName,
		p.EmailPromotion,
		p.rowguid,
		p.ModifiedDate,
		em.EmailAddress,
		bea.AddressTypeID,
		atype.Name AS AddressType,
		a.AddressLine1,
		a.AddressLine2,
		a.City,
		a.PostalCode,
		sp.Name AS RegionName,
		c.Name AS Country,
		emp.BirthDate,
		emp.Gender,
		emp.MaritalStatus,
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

DECLARE @i int = 0

WHILE @i < 1
BEGIN

	INSERT INTO People
		(PersonType, Title, FirstName, LastName,MiddleName, EmailPromotion,
		rowguid, ModifiedDate, EmailAddress, AddressTypeID, AddressType, 
		AddressLine1, AddressLine2, City, PostalCode, RegionName, Country, BirthDate,
		Gender, MaritalStatus)
	SELECT 
		PersonType, Title, FirstName, LastName,MiddleName, EmailPromotion,
		rowguid, ModifiedDate, EmailAddress, AddressTypeID, AddressType, 
		AddressLine1, AddressLine2, City, PostalCode, RegionName, Country, BirthDate,
		Gender, MaritalStatus 
	FROM udf_People(@i)	

	SET @i = @i + 1

END



ALTER TABLE dbo.People REBUILD;
GO


--SELECT * FROM udf_People(8)


