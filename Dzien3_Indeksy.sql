/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	INDEKSY

*/

--> Setup



USE AdventureWorks2017
GO

-- 18 798 wierszy
-- Execution Plan = Ctrl + M
SELECT * FROM People




EXEC sp_spaceused 'People'
GO

/*
	HEAP
	tabela jako sterta 
*/

SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')
GO


SET STATISTICS IO ON
GO

-- 658 logical reads
SELECT * FROM People

--CHECKPOINT
--DBCC DROPCLEANBUFFERS

SELECT * FROM People WHERE FirstName = 'Kevin'

SELECT * FROM People WHERE Country = 'France'

SELECT * FROM People WHERE ID = 1771

SELECT * FROM People ORDER BY ID

/*
	CLUSTERED INDEX
	
*/

-- DROP INDEX IDX_CL_People_ID ON People
CREATE CLUSTERED INDEX IDX_CL_People_ID ON People (ID)
GO

SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')
GO


EXEC sp_spaceused 'People'


-- 658 logical reads
SELECT * FROM People
SELECT * FROM People ORDER BY ID 


SELECT * FROM People WHERE FirstName = 'Kevin'

SELECT * FROM People WHERE Country = 'France'

SELECT * FROM People WHERE ID = 1771



/*
	NONCLUSTERED INDEX
	
*/

-- DROP INDEX IDX_NCL_People_Country ON People
CREATE NONCLUSTERED INDEX IDX_NCL_People_Country ON People (Country)
GO

SELECT DISTINCT country FROM People ORDER BY Country

EXEC sp_spaceused 'People'


-- 658 logical reads
SELECT * FROM People


SELECT * FROM People WHERE FirstName = 'Kevin'

SELECT * FROM People WHERE Country = 'France'

SELECT * FROM People WHERE ID = 1771

-- ??
SELECT count(*) FROM People WHERE Country = 'France'


-- ??
SELECT ID FROM People WHERE Country = 'France'


SELECT ID, FirstName, LastName FROM People WHERE Country = 'France'




SELECT Country, COUNT(*)
FROM People
GROUP BY Country


/*
	NONCLUSTERED INDEX
	2nd
*/


-- DROP INDEX IDX_NCL_People_City ON People
CREATE NONCLUSTERED INDEX IDX_NCL_People_City ON People (City)
GO


SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')

SELECT index_id FROM sys.indexes WHERE name = 'IDX_NCL_People_City'

-- rozmiar indeksu: 74 strony
SELECT page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),5,NULL,'LIMITED')



SELECT City, COUNT(*)
FROM People
GROUP BY City
ORDER BY count(*) DESC

--SET STATISTICS TIME ON

SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'Croix'



SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'London'


SELECT ID, FirstName, LastName 
FROM People WITH (INDEX (IDX_NCL_People_City))
WHERE City = 'London'




/*
	NONCLUSTERED INDEX
	INCLUDE
*/

-- DROP INDEX IDX_NCL_People_City ON People
CREATE NONCLUSTERED INDEX IDX_NCL_People_City ON People (City)
INCLUDE (Firstname, Lastname)
WITH DROP_EXISTING -- !!!
GO

-- rozmiar indeksu: 142 strony
SELECT page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),4,NULL,'LIMITED')



SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'London'




-- ??
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'London'
ORDER BY Lastname, FirstName




CREATE NONCLUSTERED INDEX IDX_NCL_People_City 
ON People (City, Lastname, Firstname)
WITH DROP_EXISTING -- !!!
GO


-- ??
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'London'
ORDER BY Lastname, FirstName




-- ??
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'London'
ORDER BY Lastname, FirstName DESC -- !!





/*
	RID LOOKUP vs KEY LOOKUP
	
*/


CREATE NONCLUSTERED INDEX IDX_NCL_People_City ON People (City)
WITH DROP_EXISTING -- !!!
GO

-- key lookup
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'Croix'


DROP INDEX IDX_CL_People_ID ON People
GO

-- rid lookup
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'Croix'















