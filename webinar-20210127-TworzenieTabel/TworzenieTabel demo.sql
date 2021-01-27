/*
	Tworzenie tabel
	KursySQL.pl - webinary - styczeń 2021

	libera@kursysql.pl
	https://www.kursysql.pl/kurs-t-sql-live-on-line/
	https://github.com/kursysql/kursysql-live
    
*/


CREATE DATABASE WczasyDB2
GO

/* 
	Pierwsza tabela
	* pk, identity, null not null
*/

USE WczasyDB2
GO

DROP TABLE Kategoria

CREATE TABLE Kategoria (
	ID INT CONSTRAINT PK_Kategoria PRIMARY KEY IDENTITY,
	KategoriaNazwa nvarchar(50) NOT NULL CONSTRAINT UQ_Kategoria_Nazwa UNIQUE
)

INSERT INTO Kategoria (KategoriaNazwa) VALUES ('Animacje dla dzieci')
INSERT INTO Kategoria (KategoriaNazwa) VALUES ('Nowość w ofercie')
INSERT INTO Kategoria (KategoriaNazwa) VALUES ('Wypocznij z rodziną')

INSERT INTO Kategoria (KategoriaNazwa) VALUES ('Bon turystyczny 500+')


DELETE FROM Kategoria WHERE ID = 3

INSERT INTO Kategoria (ID) VALUES (5)

TRUNCATE TABLE Kategoria

SELECT * FROM Kategoria ORDER BY ID
-- live coding....

DROP TABLE Wczasy

CREATE TABLE Wczasy (
	WczasyID int PRIMARY KEY IDENTITY,
	NazwaHotelu nvarchar(200),
	OpisHotelu nvarchar(max),
	DataWprowadzenia datetime DEFAULT GETDATE(),
	KategoriaID int NOT NULL REFERENCES Kategoria(ID)
)

INSERT INTO Wczasy (NazwaHotelu, KategoriaID) VALUES ('xyz', 1)
INSERT INTO Wczasy (NazwaHotelu, KategoriaID) VALUES ('IUJOSHBVUIsdf', 2)

DELETE Kategoria WHERE ID = 2

SELECT * FROM Wczasy


SELECT *
FROM Wczasy AS w
LEFT JOIN Kategoria AS k ON k.ID = w.KategoriaID


/* Kategorie: 
- Animacje dla dzieci
- Nowość w ofercie
- Wypocznij z rodziną
- Bon turystyczny 500+
*/









DROP TABLE IF EXISTS Wczasy1
GO

CREATE TABLE Wczasy1 (
	ID int IDENTITY PRIMARY KEY,
	NazwaHotelu nvarchar(50),
	IleGwiazdek int,
	Miejsce nvarchar(100),
	MiejsceOpis nvarchar(max),
	Panstwo nvarchar(100),
	PanstwoOpis nvarchar(max),
	OpisOferty nvarchar(max),
	Kategoria nvarchar(20)
)

INSERT INTO Wczasy1 (NazwaHotelu, IleGwiazdek, Miejsce, MiejsceOpis, Panstwo, PanstwoOpis, OpisOferty, Kategoria)
VALUES ('Hotel Sea Gull Beach Resort', 5, 'Hurghada', 'Świetny punkt wypadowy do zwiedzania zabytków starożytnego świata', 'Egipt', 'Królestwo faraonów i tajemnicze piramidy', 'Czterogwiazdkowy, stylowy, otwarty w 2001 r., częściowo odnowiony w 2019 r.', 'Wypocznij z rodziną')

INSERT INTO Wczasy1 (NazwaHotelu, IleGwiazdek, Miejsce, MiejsceOpis, Panstwo, PanstwoOpis, OpisOferty, Kategoria)
VALUES ('Hotel Albatros Aqua Park', 4, 'Hurghada', 'Świetny punkt wypadowy do zwiedzania zabytków starożytnego świata', 'Egipt', 'Królestwo faraonów i tajemnicze piramidy', '243 pokoje, przestronne lobby, całodobowa recepcja', 'Wypocznij z rodziną')


SELECT * FROM Wczasy1



/* 
	Typy danych
*/













