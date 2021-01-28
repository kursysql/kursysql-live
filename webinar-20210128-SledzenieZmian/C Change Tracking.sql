/*
	Tomasz Libera | libera@kursysql.pl

	ŚLEDZENIE ZMIAN w bazie danych
	C Change Tracking

*/


USE AdventureWorks2017
GO

-- wyłączenie mechanizmu Temporal Tables (#4)
IF EXISTS(SELECT * FROM sys.tables WHERE temporal_type=2 AND object_id = OBJECT_ID('People'))
BEGIN
	ALTER TABLE dbo.People SET (SYSTEM_VERSIONING = OFF)
	DROP TABLE IF EXISTS dbo.PeopleHistory
END
GO


USE master
GO
-- włączenie Change Tracking na poziomie instancji SQL Server (#5)
ALTER DATABASE AdventureWorks2017
SET CHANGE_TRACKING = ON
(CHANGE_RETENTION = 31 DAYS, AUTO_CLEANUP = ON)
--> SSMS


USE AdventureWorks2017
GO


ALTER TABLE People
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = OFF)
GO
--> SSMS

-- Widoki systemowe wyśiwetlające informacje o włączonym Change Tracking (#6)
SELECT * FROM sys.change_tracking_databases

SELECT * FROM sys.change_tracking_tables


-- ukryte tabele (#7)
-- Wyszukanie ukrytej tabeli zmian dla tabeli People
SELECT OBJECT_ID('People') -- 1821249543
SELECT * FROM sys.all_objects WHERE name LIKE 'change%'

-- sprawdzenie rozmiaru tabeli zmian
EXEC sp_spaceused 'sys.change_tracking_1821249543'





ALTER TABLE People
DISABLE CHANGE_TRACKING
GO


SELECT OBJECT_ID('People')
SELECT * FROM sys.all_objects WHERE name LIKE 'change%'
GO



ALTER TABLE People
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = OFF)
GO

-- Bieżąca wersja danych i najstarsza do odczytania wersja (#8)
SELECT CHANGE_TRACKING_CURRENT_VERSION() 

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('People'))


-- Zmiana i sprawdzenie wersji
SELECT * FROM People WHERE ID > 100 


UPDATE People SET LastName = 'Kowals66ki' WHERE ID = 101

SELECT * FROM People WHERE ID > 100 

-- 1xU	
SELECT * 
FROM CHANGETABLE(CHANGES People,0) AS ct 
ORDER BY SYS_CHANGE_VERSION



SELECT CHANGE_TRACKING_CURRENT_VERSION() 

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('People'))


-- Włączenie zapisywania zmienionych kolumn wymaga wyłączenia 
-- i włączenia śledzenia dla tabeli (#9)
ALTER TABLE People
DISABLE CHANGE_TRACKING
GO

ALTER TABLE People
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = ON)
GO



SELECT CHANGE_TRACKING_CURRENT_VERSION()


UPDATE People SET LastName = 'Zieliński' WHERE ID = 102
UPDATE People SET LastName = 'Nowak' WHERE ID = 103
DELETE FROM People WHERE ID = 104


-- 3xU, 1xD
SELECT * 
FROM CHANGETABLE(CHANGES People,0) AS ct 
ORDER BY SYS_CHANGE_VERSION


-- Sprawdzanie które kolumny zostały zmodyfikowane (#11)
SELECT * ,
CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('People'), 'Firstname', 'ColumnId'), CT.SYS_CHANGE_COLUMNS) AS Firstname_ColumnChanged,
CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('People'), 'Lastname', 'ColumnId'), CT.SYS_CHANGE_COLUMNS) AS Lastname_ColumnChanged
FROM CHANGETABLE(CHANGES People,0) AS ct 
ORDER BY SYS_CHANGE_VERSION



-- Skasowanie wcześniej zmodyfikowanego wiersza (#12)
DELETE FROM People WHERE ID = 103


-- 1xU, 2xD
SELECT * 
FROM CHANGETABLE(CHANGES People,0) AS ct 
ORDER BY SYS_CHANGE_VERSION


SELECT * FROM People WHERE ID > 100 


-- Wstawienie pojedynczego wiersza (#13)
INSERT INTO People (FirstName, LastName, EmailAddress,  AddressLine1, City, PostalCode, Country)
SELECT FirstName, LastName, EmailAddress, AddressLine1, City, PostalCode, Country
FROM udf_People(0) WHERE ID = 1	


-- 2xU, 2xD, 1xI
SELECT * 
FROM CHANGETABLE(CHANGES People,0) AS ct 
ORDER BY SYS_CHANGE_VERSION


SELECT * 
FROM CHANGETABLE(CHANGES People,0) AS ct
JOIN People AS p ON p.ID = ct.ID
ORDER BY SYS_CHANGE_VERSION


-- razem ze skasowanymi wierszami
SELECT * 
FROM CHANGETABLE(CHANGES People,0) AS ct
LEFT JOIN People AS p ON p.ID = ct.ID
ORDER BY SYS_CHANGE_VERSION


-- Sprawdź wersję Change Tracking i zmodyfikuj kilka rekordów (#14)
SELECT CHANGE_TRACKING_CURRENT_VERSION() -- 21


UPDATE People SET City = 'Kraków' WHERE ID BETWEEN 110 AND 114

SELECT CHANGE_TRACKING_CURRENT_VERSION() -- 22

SELECT * 
FROM CHANGETABLE(CHANGES People,0) AS ct
LEFT JOIN People AS p ON p.ID = ct.ID
ORDER BY SYS_CHANGE_VERSION



-- zmiany od wersji X (#15)
SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('People'))

SELECT * 
FROM CHANGETABLE(CHANGES People,20) AS ct
JOIN People AS p ON p.ID = ct.ID
ORDER BY SYS_CHANGE_VERSION



-- sprawdzenie rozmiaru tabeli zmian (#16)
EXEC sp_spaceused 'sys.change_tracking_1821249543'





-- w ramach planu wykonania widoczne są operacje odczytu na tabeli ze zmianami (#17)
SET STATISTICS IO ON 

SELECT * FROM CHANGETABLE(CHANGES People,0) AS ct


SELECT * FROM People

-- zmiana wszystkich wierszy
UPDATE People SET LastName = 'Kowalski'




EXEC sp_spaceused 'sys.change_tracking_1821249543'


SELECT * FROM CHANGETABLE(CHANGES People,0) AS ct



-- Zmiana identyfikatora wiersza (#18)
SELECT * FROM People

UPDATE People SET ID = 20000 WHERE ID = 2


SELECT * 
FROM CHANGETABLE(CHANGES People,0) AS ct
WHERE ID IN (2, 20000)



-- Operacja TRUNCATE jest możliwa ale kasuje zawartość tabeli zmian (#19)

TRUNCATE TABLE People

EXEC sp_spaceused 'sys.change_tracking_1821249543'


SELECT CHANGE_TRACKING_CURRENT_VERSION() 

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('People'))


-- Próba usunięcia klucza głównego (#20)
ALTER TABLE People DROP CONSTRAINT PK_People




-- Cleanup
ALTER TABLE People
DISABLE CHANGE_TRACKING
GO

/*
	Zobacz też:
	Performance Tuning SQL Server Change Tracking - Kendra Little
	https://www.brentozar.com/archive/2014/06/performance-tuning-sql-server-change-tracking/
*/