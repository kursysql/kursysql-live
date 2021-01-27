

CREATE DATABASE WczasyDB
GO

USE WczasyDB
GO

DROP TABLE IF EXISTS RodzajPokoju

CREATE TABLE RodzajPokoju (
	RodzajPokojuID int CONSTRAINT PK_RodzajPokoju PRIMARY KEY IDENTITY,
	RodzajPokoju nvarchar(50)
)

INSERT INTO RodzajPokoju (RodzajPokoju) VALUES ('1 osobowy'), ('2 osobowy'), ('3 osobowy'), ('4 osobowy'), ('apartament 2 os')

SELECT * FROM RodzajPokoju
GO


DROP TABLE IF EXISTS RodzajWyzywienia

CREATE TABLE RodzajWyzywienia (
	RodzajWyzywieniaID int CONSTRAINT PK_RodzajWyzywienia PRIMARY KEY IDENTITY,
	RodzajWyzywienia nvarchar(50)
)
GO

INSERT INTO RodzajWyzywienia (RodzajWyzywienia) VALUES (N'Śniadania'), (N'Śniadanie+kolacja'), (N'All inclusive soft'), (N'All inclusive')

SELECT * FROM RodzajWyzywienia



DROP TABLE IF EXISTS Panstwo


CREATE TABLE Panstwo (
	PanstwoID int CONSTRAINT PK_Panstwo PRIMARY KEY IDENTITY,
	Opis nvarchar(max),
	Panstwo nvarchar(50)
)
GO 

INSERT INTO Panstwo (Panstwo, Opis) VALUES (N'Chorwacja', 'Dubrownik – perła Adriatyku i Korcula – wyspa Marco Polo')
INSERT INTO Panstwo (Panstwo, Opis) VALUES (N'Czarnogóra', 'Przepiękne krajobrazy gór schodzących bezpośrednio do morza')
INSERT INTO Panstwo (Panstwo, Opis) VALUES (N'Grecja', 'Kolebka kultury, ojczyzna mitów i Igrzysk Olimpijskich')
INSERT INTO Panstwo (Panstwo, Opis) VALUES (N'Hiszpania', 'Klejnoty architektury w miastach Gaudi’ego, Dalego i Picassa')
INSERT INTO Panstwo (Panstwo, Opis) VALUES (N'Włochy', 'Doskonała kuchnia z pizzą i spaghetti, pyszne wina i świetna kawa')
INSERT INTO Panstwo (Panstwo, Opis) VALUES (N'Tunezja', 'Słynne miasteczko z Gwiezdnych Wojen')
INSERT INTO Panstwo (Panstwo, Opis) VALUES (N'Polska', 'Szerokie, piaszczyste plaże wyjątkowego Bałtyku. Góralski folklor i piękne górskie krajobrazy')
INSERT INTO Panstwo (Panstwo, Opis) VALUES (N'Egipt', 'Królestwo faraonów i tajemnicze piramidy')

SELECT * FROM Panstwo



CREATE TABLE Miejsce (
	MiejsceID int CONSTRAINT PK_Miejsce PRIMARY KEY IDENTITY,
	Miejsce nvarchar(50),
	Opis nvarchar(max),
	PanstwoID int REFERENCES Panstwo(PanstwoID)
)
GO 

-- Polska
INSERT INTO Miejsce (Miejsce, PanstwoID) VALUES (N'Góry', 7)
INSERT INTO Miejsce (Miejsce, PanstwoID) VALUES (N'Jeziora', 7)
INSERT INTO Miejsce (Miejsce, PanstwoID) VALUES (N'Morze', 7)

-- Egipt
INSERT INTO Miejsce (Miejsce, PanstwoID, Opis) VALUES (N'Hurghada', 8, 'Świetny punkt wypadowy do zwiedzania zabytków starożytnego świata')
INSERT INTO Miejsce (Miejsce, PanstwoID, Opis) VALUES (N'Marsa Alam', 8, 'Wspaniałe piaszczyste plaże')
INSERT INTO Miejsce (Miejsce, PanstwoID, Opis) VALUES (N'Taba', 8, 'Piękne plaże, błękitne morze na tle gór Synaj')

-- Tunezja
INSERT INTO Miejsce (Miejsce, PanstwoID) VALUES (N'Djerba', 6)
INSERT INTO Miejsce (Miejsce, PanstwoID) VALUES (N'Hammamet', 6)
INSERT INTO Miejsce (Miejsce, PanstwoID) VALUES (N'Mahdia', 6)
INSERT INTO Miejsce (Miejsce, PanstwoID) VALUES (N'Monastir', 6)
INSERT INTO Miejsce (Miejsce, PanstwoID) VALUES (N'Sousse', 6)

-- Hiszpania
INSERT INTO Miejsce (Miejsce, PanstwoID, Opis) VALUES (N'Costa Brava', 4, 'Zachwycająca Barcelona')
INSERT INTO Miejsce (Miejsce, PanstwoID, Opis) VALUES (N'Costa Dorada', 4, 'Tętniące nocnym życiem nadmorskie kurorty, z Salou na czele')
INSERT INTO Miejsce (Miejsce, PanstwoID, Opis) VALUES (N'Costa de la Luz', 4, 'Doskonałe tapas i słynne sherry z Jerez de la Frontera')
INSERT INTO Miejsce (Miejsce, PanstwoID, Opis) VALUES (N'Ibiza', 4, 'Najlepsze dyskoteki w Europie, najlepsi DJ-e z całego świata')
INSERT INTO Miejsce (Miejsce, PanstwoID, Opis) VALUES (N'Majorka', 4, 'Pachnące gaje pomarańczy, majestatycznie góry, smocze jaskinie i zielone wzgórza')
INSERT INTO Miejsce (Miejsce, PanstwoID, Opis) VALUES (N'Sevilla', 4, 'Stolica i największe miasto Andaluzji, to jedno z najciekawszych miast całego Półwyspu Iberyjskiego')



SELECT * FROM Miejsce




CREATE TABLE Kategoria (
	KategoriaID int CONSTRAINT PK_Kategoria PRIMARY KEY IDENTITY,
	Kategoria nvarchar(20),
)
GO 

INSERT INTO Kategoria (Kategoria) VALUES ('Animacje dla dzieci'), ('Bon turystyczny 500+'), 
	('Dla odkrywców'), ('Dla odważnych'), ('Hotel dla dorosłych'), ('Nowość w ofercie'), 
	('Postaw na aktywność'), ('Romantyczna podróż'), ('SPA'), ('Wifi w cenie'), 
	('Wypocznij z rodziną'), ('Zanurz się z rodziną'), ('Wczasy bez testu'), ('Egzotyka'), ('Dojazd własny')


SELECT * FROM Kategoria
GO





CREATE TABLE Wczasy (
	WczasyID int CONSTRAINT PK_Wczasy PRIMARY KEY IDENTITY,
	NazwaHotelu nvarchar(50),
	IleGwiazdek int,
	MiejsceID int REFERENCES Miejsce(MiejsceID),
	Opis nvarchar(max),
)
GO 

-- Egipt / Hurghada
INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis)
VALUES ('Hotel Sea Gull Beach Resort', 4, 4, 'Czterogwiazdkowy, stylowy, otwarty w 2001 r., częściowo odnowiony w 2019 r.')
GO

INSERT INTO Wczasy (NazwaHotelu, IleGwiazdek, MiejsceID, Opis)
VALUES ('Hotel Albatros Aqua Park', 4, 4, '243 pokoje, przestronne lobby, całodobowa recepcja')
GO


SELECT * FROM Wczasy




CREATE TABLE WczasyKategoria (
	WczasyID int REFERENCES Wczasy(WczasyID),
	KategoriaID int REFERENCES Kategoria(KategoriaID),
	CONSTRAINT PK_WczasyKategoria PRIMARY KEY(WczasyID, KategoriaID)
)
GO 



INSERT INTO WczasyKategoria (WczasyID, KategoriaID) VALUES (1, 1)
INSERT INTO WczasyKategoria (WczasyID, KategoriaID) VALUES (1, 11)

INSERT INTO WczasyKategoria (WczasyID, KategoriaID) VALUES (2, 11)


SELECT * FROM WczasyKategoria




SELECT w.NazwaHotelu, w.IleGwiazdek, 
	m.Miejsce, m.Opis AS MiejsceOpis, 
	p.Panstwo, p.Opis AS PanstwoOpis, 
	k.Kategoria
FROM Wczasy AS w
JOIN Miejsce m ON m.MiejsceID = w.MiejsceID
JOIN Panstwo p ON p.PanstwoID = m.PanstwoID
JOIN WczasyKategoria AS wk ON wk.WczasyID = w.WczasyID
JOIN Kategoria AS k ON k.KategoriaID = wk.KategoriaID





DROP TABLE IF EXISTS Termin

CREATE TABLE Termin (
	TerminID int CONSTRAINT PK_Termin PRIMARY KEY IDENTITY,
	WczasyID int REFERENCES Wczasy(WczasyID),
	PobytOd date,
	PobytDo date,
	LiczbaDni AS DATEDIFF(day, PobytOd, PobytDo)
)
GO 

INSERT INTO Termin (WczasyID, PobytOd, PobytDo) VALUES (1, '20210704', '20210711')
INSERT INTO Termin (WczasyID, PobytOd, PobytDo) VALUES (1, '20210711', '20210718')
INSERT INTO Termin (WczasyID, PobytOd, PobytDo) VALUES (1, '20210718', '20210725')

SELECT * FROM Termin
GO






DROP TABLE IF EXISTS Cennik

CREATE TABLE Cennik (
	CennikID int CONSTRAINT PK_Cennik PRIMARY KEY IDENTITY,
	TerminID int REFERENCES Termin(TerminID),
	RodzajPokojuID int REFERENCES RodzajPokoju(RodzajPokojuID),
	WyzywienieID int REFERENCES RodzajWyzywienia(RodzajWyzywieniaID),
	Cena money
)
GO 

SELECT * FROM RodzajPokoju
SELECT * FROM RodzajWyzywienia

-- Egipt / Hurghada, 1 tydz lipca
INSERT INTO Cennik (TerminID, RodzajPokojuID, WyzywienieID, Cena)
VALUES (1, 1, 2, 1500) -- 1 osobowy
INSERT INTO Cennik (TerminID, RodzajPokojuID, WyzywienieID, Cena)
VALUES (1, 2, 2, 2500) -- 2 osobowy
INSERT INTO Cennik (TerminID, RodzajPokojuID, WyzywienieID, Cena)
VALUES (1, 5, 2, 3500) -- apartament
GO

-- Egipt / Hurghada, 2 tydz lipca
INSERT INTO Cennik (TerminID, RodzajPokojuID, WyzywienieID, Cena)
VALUES (2, 1, 2, 1600) -- 1 osobowy
INSERT INTO Cennik (TerminID, RodzajPokojuID, WyzywienieID, Cena)
VALUES (2, 2, 2, 2600) -- 2 osobowy
INSERT INTO Cennik (TerminID, RodzajPokojuID, WyzywienieID, Cena)
VALUES (2, 5, 2, 3600) -- apartament
GO


SELECT * FROM Cennik






/*

	Cleanup

*/

DROP TABLE IF EXISTS WczasyKategoria
DROP TABLE IF EXISTS Kategoria

DROP TABLE IF EXISTS Termin
DROP TABLE IF EXISTS Cennik


DROP TABLE IF EXISTS Wczasy

DROP TABLE IF EXISTS RodzajWyzywienia
DROP TABLE IF EXISTS RodzajPokoju

DROP TABLE IF EXISTS Miejsce
DROP TABLE IF EXISTS Panstwo
DROP TABLE IF EXISTS RodzajPokoju

