/*
	Śledzenie zmian
	KursySQL.pl - webinary - styczeń 2021

	libera@kursysql.pl
	https://www.kursysql.pl/kurs-t-sql-live-on-line/
	https://github.com/kursysql/kursysql-live
    
*/


DROP DATABASE IF EXISTS WczasyDB 

CREATE DATABASE WczasyDB
GO




CREATE TABLE Wczasy (
	WczasyID int CONSTRAINT PK_Wczasy PRIMARY KEY IDENTITY,
	NazwaHotelu nvarchar(50),
	IleGwiazdek int,
	MiejsceID int,
	Opis nvarchar(200),
	ValidFrom datetime2 (2)  DEFAULT GETUTCDATE()
)



-- Egipt / Hurghada
INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis)
VALUES 
('Hotel Sea Gull Beach Resort', 4, 4, 'Czterogwiazdkowy, stylowy, otwarty w 2001 r., częściowo odnowiony w 2019 r.'),
('Hotel Albatros Aqua Park', 4, 4, '243 pokoje, przestronne lobby, całodobowa recepcja')
GO

SELECT *FROM Wczasy




/*
	Triggery


*/
CREATE TABLE dbo.Wczasy_Audit
(
	AuditID int IDENTITY PRIMARY KEY,
	WczasyID int,
	NazwaHotelu nvarchar(50),
	IleGwiazdek int,
	MiejsceID int REFERENCES Miejsce(MiejsceID),
	Opis nvarchar(200),
	ValidFrom datetime2 (2),
	ValidTo datetime2(2) DEFAULT GETUTCDATE(),
	ModifiedBy nvarchar(100) DEFAULT SUSER_NAME(),
	IsDeleted bit
)
GO




CREATE OR ALTER TRIGGER dbo.trg_Wczasy_Audit
ON dbo.Wczasy
FOR DELETE, UPDATE
AS
BEGIN

  SELECT * FROM inserted

  SELECT * FROM deleted

END
GO



UPDATE Wczasy SET IleGwiazdek = 3 WHERE WczasyID = 1

DELETE FROM Wczasy WHERE WczasyID = 2

SELECT * FROM Wczasy WHERE WczasyID = 2
GO




CREATE OR ALTER TRIGGER dbo.trg_Wczasy_Audit
ON dbo.Wczasy
FOR DELETE, UPDATE
AS
BEGIN
  SET NOCOUNT ON
  
  INSERT INTO Wczasy_Audit 
    (WczasyID, NazwaHotelu, IleGwiazdek, MiejsceID, Opis, ValidFrom, IsDeleted)
  SELECT d.WczasyID, d.NazwaHotelu, d.IleGwiazdek, d.MiejsceID, d.Opis, d.ValidFrom, IIF(i.WczasyID IS NULL, 1, 0)
  FROM deleted AS d
  LEFT JOIN inserted AS i ON i.WczasyID = d.WczasyID
END
GO





UPDATE Wczasy SET IleGwiazdek = 3 WHERE WczasyID = 1
UPDATE Wczasy SET NazwaHotelu = 'Hotel Albatros Aqua Parking' WHERE WczasyID = 2

DELETE FROM Wczasy WHERE WczasyID = 2


SELECT * FROM Wczasy
GO

SELECT * FROM Wczasy_Audit

-- Cleaup
DROP TABLE IF EXISTS Wczasy_Audit
DROP TABLE IF EXISTS Wczasy
DROP TRIGGER IF EXISTS dbo.trg_Wczasy_Audit




/*
	Change Tracking


*/

CREATE DATABASE WczasyDB
GO

USE WczasyDB
GO


CREATE TABLE Wczasy (
	WczasyID int CONSTRAINT PK_Wczasy PRIMARY KEY IDENTITY,
	NazwaHotelu nvarchar(50),
	IleGwiazdek int,
	MiejsceID int,
	Opis nvarchar(200),
	ValidFrom datetime2 (2)  DEFAULT GETUTCDATE()
)




-- Egipt / Hurghada
INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis)
VALUES 
('Hotel Sea Gull Beach Resort', 4, 4, 'Czterogwiazdkowy, stylowy, otwarty w 2001 r., częściowo odnowiony w 2019 r.'),
('Hotel Albatros Aqua Park', 4, 4, '243 pokoje, przestronne lobby, całodobowa recepcja')
GO


SELECT *FROM Wczasy



-- włączenie Change Tracking na poziomie instancji SQL Server
ALTER DATABASE WczasyDB
SET CHANGE_TRACKING = ON
(CHANGE_RETENTION = 31 DAYS, AUTO_CLEANUP = ON)
--> SSMS


ALTER TABLE Wczasy
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = ON)
GO


-- Bieżąca wersja danych i najstarsza do odczytania wersja
SELECT CHANGE_TRACKING_CURRENT_VERSION() 

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Wczasy'))
GO



-- Zmiana i sprawdzenie wersji
UPDATE Wczasy SET IleGwiazdek = 3 WHERE WczasyID = 1


SELECT CHANGE_TRACKING_CURRENT_VERSION() AS _current_version, CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Wczasy')) AS _min_valid_version

-- 1xU	
SELECT * 
FROM CHANGETABLE(CHANGES Wczasy,0) AS ct 
ORDER BY SYS_CHANGE_VERSION






UPDATE Wczasy SET IleGwiazdek = 5 WHERE WczasyID = 1
UPDATE Wczasy SET NazwaHotelu = 'Hotel Albatros Aqua Parking' WHERE WczasyID = 2


-- 2xU
SELECT * 
FROM CHANGETABLE(CHANGES Wczasy,0) AS ct 
ORDER BY SYS_CHANGE_VERSION



DELETE FROM Wczasy WHERE WczasyID = 2


-- 1xU, 1xD
SELECT * 
FROM CHANGETABLE(CHANGES Wczasy,0) AS ct 
ORDER BY SYS_CHANGE_VERSION



INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis)
VALUES ('Hotel Activa', 3, 1, 'Hotel w Muszynie, w Beskidzie Sądeckim')



-- 1xU, 1xD, 1xI
SELECT * 
FROM CHANGETABLE(CHANGES Wczasy,0) AS ct 
ORDER BY SYS_CHANGE_VERSION


SELECT CHANGE_TRACKING_CURRENT_VERSION() AS _current_version, CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Wczasy')) AS _min_valid_version

-- aktualna wersja: 5

SELECT *FROM Wczasy

UPDATE Wczasy SET IleGwiazdek = 6 WHERE WczasyID = 1
UPDATE Wczasy SET NazwaHotelu = 'Hotel Activa - Beskid Sądecki' WHERE WczasyID = 3


SELECT CHANGE_TRACKING_CURRENT_VERSION() AS _current_version, CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Wczasy')) AS _min_valid_version



-- 1xU, 1xD, 1xI
SELECT * 
FROM CHANGETABLE(CHANGES Wczasy,0) AS ct 
ORDER BY SYS_CHANGE_VERSION

-- zmiany od wersji 5
-- 1xU, 1xD, 1xI
SELECT * 
FROM CHANGETABLE(CHANGES Wczasy,5) AS ct 
ORDER BY SYS_CHANGE_VERSION


-- Cleanup
ALTER DATABASE WczasyDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
USE master
GO

DROP DATABASE IF EXISTS WczasyDB




/*
	Change Data Capture


*/

CREATE DATABASE WczasyDB
GO

USE WczasyDB
GO


CREATE TABLE Wczasy (
	WczasyID int CONSTRAINT PK_Wczasy PRIMARY KEY IDENTITY,
	NazwaHotelu nvarchar(50),
	IleGwiazdek int,
	MiejsceID int,
	Opis nvarchar(200),
	ValidFrom datetime2 (2)  DEFAULT GETUTCDATE()
)




-- Egipt / Hurghada
INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis)
VALUES 
('Hotel Sea Gull Beach Resort', 4, 4, 'Czterogwiazdkowy, stylowy, otwarty w 2001 r., częściowo odnowiony w 2019 r.'),
('Hotel Albatros Aqua Park', 4, 4, '243 pokoje, przestronne lobby, całodobowa recepcja')
GO


SELECT *FROM Wczasy


EXEC sys.sp_cdc_enable_db


SELECT * FROM cdc.change_tables


-- włączenie dla tabeli - musi być uruchomiony SQL Server Agent
EXEC sys.sp_cdc_enable_table
	@source_schema = N'dbo',
	@source_name   = N'Wczasy',
	--@capture_instance = 'Wczasy', -- def: cdc.dbo_Wczasy_CT
	--@captured_column_list = 'WczasyID, IleGwiazdek, Opisy', -- sledzone kolumny, musi zawierac PK
	@role_name     = NULL,
	@supports_net_changes = 1 -- tylko ostatnia zmiana
GO


-- lista śledzonych tabel
SELECT * FROM cdc.change_tables

-- SSMS: WczasyDB - System Tables

-- zawartość tabeli zmian
SELECT * FROM cdc.dbo_Wczasy_CT



UPDATE Wczasy SET IleGwiazdek = 5 WHERE WczasyID = 1
UPDATE Wczasy SET NazwaHotelu = 'Hotel Albatros Aqua Parking' WHERE WczasyID = 2


SELECT * FROM cdc.dbo_Wczasy_CT


INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis)
VALUES ('Hotel Activa', 3, 1, 'Hotel w Muszynie, w Beskidzie Sądeckim')

SELECT * FROM cdc.dbo_Wczasy_CT


DELETE FROM Wczasy WHERE WczasyID = 2



SELECT * FROM cdc.dbo_Wczasy_CT





-- __$start_lsn, __$end_lsn
-- sys.fn_cdc_map_lsn_to_time
SELECT *,
	sys.fn_cdc_map_lsn_to_time(__$start_lsn) AS ChangeDateTime -- lsn na czas
FROM cdc.dbo_Wczasy_CT



-- Cleanup
ALTER DATABASE WczasyDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
USE master
GO

DROP DATABASE IF EXISTS WczasyDB




/*
	Temporal Tables


*/



CREATE DATABASE WczasyDB
GO

USE WczasyDB
GO


CREATE TABLE Wczasy (
	WczasyID int CONSTRAINT PK_Wczasy PRIMARY KEY IDENTITY,
	NazwaHotelu nvarchar(50),
	IleGwiazdek int,
	MiejsceID int,
	Opis nvarchar(200),
	ValidFrom datetime2 (2) GENERATED ALWAYS AS ROW START, -- HIDDEN -- PERIOD COLUMNs mogą być ukryte
	ValidTo datetime2 (2) GENERATED ALWAYS AS ROW END, -- HIDDEN
	PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo) 
)
--WITH (SYSTEM_VERSIONING = ON);
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.WczasyHistory))
GO


SELECT * FROM dbo.Wczasy

SELECT * FROM dbo.WczasyHistory
GO



-- Wstawienie pojedynczego wiersza
INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis)
VALUES 
('Hotel Sea Gull Beach Resort', 4, 4, 'Czterogwiazdkowy, stylowy, otwarty w 2001 r., częściowo odnowiony w 2019 r.')
GO



SELECT * FROM dbo.Wczasy

SELECT * FROM dbo.WczasyHistory
GO




---- not supported
TRUNCATE TABLE dbo.Wczasy

-- kasowanie też inaczej
-- DROP TABLE Wczasy




-- podczas wstawiania - wstawiany jest czas rozpoczęcia transakcji
BEGIN TRANSACTION

	SELECT GETUTCDATE() AS time_tran_start

	SELECT GETUTCDATE() AS time_1st_insert
		INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis)
		VALUES ('Hotel Albatros Aqua Park', 4, 4, '243 pokoje, przestronne lobby, całodobowa recepcja')
		GO

	SELECT 'WAITFOR...'
	WAITFOR DELAY '0:00:05'

	SELECT GETUTCDATE() AS time_2st_insert
		INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis)
		VALUES ('Hotel Activa', 3, 1, 'Hotel w Muszynie, w Beskidzie Sądeckim')

COMMIT

SELECT * FROM dbo.Wczasy

-- end batch


-- nie mozna jawnie wskazywać wartości ValidFrom, ValidTo
INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis, ValidFrom, ValidTo)
VALUES ('Hotel Activa2', 3, 1, 'Hotel w Muszynie, w Beskidzie Sądeckim', GETUTCDATE(), '99991231 23:59:59.99')


-- tak można
INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis, ValidFrom, ValidTo)
VALUES ('Hotel Activa2', 3, 1, 'Hotel w Muszynie, w Beskidzie Sądeckim', DEFAULT, DEFAULT)





SELECT * FROM dbo.Wczasy

SELECT * FROM dbo.WczasyHistory
GO




UPDATE Wczasy SET IleGwiazdek = 5 WHERE WczasyID = 1
UPDATE Wczasy SET NazwaHotelu = 'Hotel Albatros Aqua Parking' WHERE WczasyID = 2




SELECT * FROM dbo.Wczasy

SELECT * FROM dbo.WczasyHistory
GO



SELECT * FROM dbo.Wczasy

SELECT * FROM dbo.WczasyHistory -- data zmiany dla WczasyID 2
GO

-- po skasowaniu
SELECT * FROM Wczasy FOR SYSTEM_TIME 
AS OF '2021-01-28 18:00:30.79'
WHERE WczasyID = 2 ORDER BY ValidFrom
GO


SELECT * FROM Wczasy FOR SYSTEM_TIME 
AS OF '2021-01-28 18:00:29.79' -- -1 sek
WHERE WczasyID = 2 ORDER BY ValidFrom
GO



-- zapamiętać czas... 
SELECT GETUTCDATE() -- 2021-01-28 19:02:34.633



DELETE FROM Wczasy WHERE WczasyID = 2


-- nie ma wiersza 2...
SELECT * FROM dbo.Wczasy


-- jest wiersz o id 2...
SELECT * FROM Wczasy FOR SYSTEM_TIME 
AS OF '2021-01-28 18:02:34.633'
GO


-- wszystkie zmiany...
SELECT * FROM Wczasy FOR SYSTEM_TIME 
ALL



-- można zmieniać tabelę
ALTER TABLE Wczasy ADD Opinie nvarchar(100)


SELECT * FROM Wczasy

SELECT * FROM WczasyHistory


UPDATE Wczasy SET Opinie = 'spoko' WHERE WczasyID = 3


UPDATE Wczasy SET Opinie = 'spoko, super' WHERE WczasyID = 3


SELECT * FROM Wczasy

SELECT * FROM WczasyHistory

-- tabeli z historią jest tylko do oczytu
UPDATE WczasyHistory SET Opinie = '' 

DELETE FROM WczasyHistory



-- najpierw trzeba wyłączyć SYSTEM_VERSIONING
ALTER TABLE Wczasy SET (SYSTEM_VERSIONING = OFF);

DELETE FROM WczasyHistory

ALTER TABLE Wczasy SET (SYSTEM_VERSIONING = ON);







SELECT * FROM Wczasy

SELECT * FROM WczasyHistory






