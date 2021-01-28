/*
	Tomasz Libera | libera@kursysql.pl

	ŚLEDZENIE ZMIAN w bazie danych
	B Triggers

*/


USE AdventureWorks2017
GO



-- utworzenie tabeli dbo.People (#4)
CREATE TABLE dbo.PeopleOLD
(
	ID int IDENTITY PRIMARY KEY
	,FirstName nvarchar(50) NULL
	,LastName nvarchar(50) NOT NULL
	,EmailAddress nvarchar(50) NULL
	,AddressLine1 nvarchar(50) NULL
	,City nvarchar(30) NULL
	,PostalCode nvarchar(15) NULL
	,Country nvarchar(50) NULL
	,ValidFrom datetime2 (2)  DEFAULT GETUTCDATE()
)


-- Utworzenie (#5)
CREATE TABLE dbo.PeopleOLD_Audit
(
	AuditID int IDENTITY PRIMARY KEY
	,ID int
	,FirstName nvarchar(50) NULL
	,LastName nvarchar(50) NOT NULL
	,EmailAddress nvarchar(50) NULL
	,AddressLine1 nvarchar(50) NULL
	,City nvarchar(30) NULL
	,PostalCode nvarchar(15) NULL
	,Country nvarchar(50) NULL	
	,ValidFrom datetime2 (2)
	,ValidTo datetime2(2) DEFAULT GETUTCDATE()
	,ModifiedBy nvarchar(100) DEFAULT SUSER_NAME()
	,IsDeleted bit
)
GO

-- Wstawienie danych (#6)
INSERT INTO PeopleOLD (FirstName, LastName, EmailAddress, AddressLine1, City, PostalCode, Country)
SELECT FirstName, LastName, EmailAddress, AddressLine1, City, PostalCode, Country 
FROM People 

SELECT * FROM PeopleOLD
GO


-- Trigger testowy (#7)
CREATE OR ALTER TRIGGER dbo.trg_PeopleOLD_Audit
ON dbo.PeopleOLD
FOR DELETE, UPDATE
AS
BEGIN

  SELECT * FROM inserted

  SELECT * FROM deleted

END
GO

-- inserted, deleted
UPDATE PeopleOLD SET LastName = 'Kowalski' WHERE ID = 101

-- inserted, deleted ??
DELETE FROM PeopleOLD WHERE ID = 101


SELECT * FROM PeopleOLD WHERE ID = 101
GO

-- (#8)
CREATE OR ALTER TRIGGER dbo.trg_PeopleOLD_Audit
ON dbo.PeopleOLD
FOR DELETE, UPDATE
AS
BEGIN
  SET NOCOUNT ON
  
  INSERT INTO PeopleOLD_Audit 
    (ID, FirstName, LastName, EmailAddress, AddressLine1, City, PostalCode, 
		Country, ValidFrom, IsDeleted)
  SELECT d.ID, d.FirstName, d.LastName, d.EmailAddress, d.AddressLine1, d.City, d.PostalCode, 
		d.Country, d.ValidFrom, IIF(i.ID IS NULL, 1, 0)
  FROM deleted AS d
  LEFT JOIN inserted AS i ON i.ID = d.ID
END
GO


-- SSMS (#9)


-- Testowanie triggera (#10)
UPDATE PeopleOLD SET LastName = 'Kowalski' WHERE ID = 1
DELETE FROM PeopleOLD WHERE ID = 1

SELECT * FROM PeopleOLD WHERE ID = 1 

SELECT * FROM PeopleOLD_Audit WHERE ID = 1 


-- Cleanup (#11)

DROP TABLE IF EXISTS dbo.PeopleOLD
DROP TABLE IF EXISTS dbo.PeopleOLD_Audit
DROP TRIGGER IF EXISTS dbo.trg_PeopleOLD_Audit 



-- Zadanie (#12)
-- Utwórz tabelę i trigger audytu dla tabeli ProductOLD
SELECT ProductID, Name, Color, Size INTO ProductOLD FROM Production.Product


