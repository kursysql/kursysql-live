IF DB_ID('Filmy') IS NOT NULL
ALTER DATABASE Filmy SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

USE master
GO



--DROP DATABASE IF EXISTS Filmy
--GO

IF EXISTS (SELECT DB_ID('Filmy'))
DROP DATABASE Filmy
GO


CREATE DATABASE Filmy
GO

ALTER DATABASE Filmy SET RECOVERY SIMPLE WITH NO_WAIT
GO

USE Filmy
GO





CREATE TABLE dbo.Gatunek(
	GatunekID int NOT NULL PRIMARY KEY IDENTITY,
	Gatunek char(100) NULL
)
GO


CREATE TABLE dbo.Kraj(
	KrajID int NOT NULL PRIMARY KEY IDENTITY,
	Kraj nvarchar(100) NOT NULL
)
GO


CREATE TABLE dbo.Osoba(
	OsobaID int NOT NULL PRIMARY KEY IDENTITY,
	Imie char(100) NULL,
	Nazwisko char(100) NULL,
	KrajID int NULL,
	DataUrodzenia datetime NULL,
	Zdjecie varbinary(50) NULL,
	-- Wiek int NULL
	Wiek AS DATEDIFF(year, DataUrodzenia, GETDATE())
)
GO


ALTER TABLE dbo.Osoba  WITH CHECK ADD  CONSTRAINT FK_Osoba_Kraj FOREIGN KEY(KrajID)
REFERENCES dbo.Kraj (KrajID)
GO




CREATE TABLE dbo.Aktor(
	AktorID int NOT NULL PRIMARY KEY IDENTITY,
	OsobaID int NOT NULL
)
GO

ALTER TABLE dbo.Aktor  WITH CHECK ADD  CONSTRAINT FK_Aktorzy_Osoby FOREIGN KEY(OsobaID)
REFERENCES dbo.Osoba (OsobaID)
GO



CREATE TABLE dbo.Rezyser(
	RezyserID int NOT NULL PRIMARY KEY IDENTITY,
	OsobaID int NULL
)
GO

ALTER TABLE dbo.Rezyser  WITH CHECK ADD  CONSTRAINT FK_Rezyser_Osoba FOREIGN KEY(OsobaID)
REFERENCES dbo.Osoba (OsobaID)
GO





CREATE TABLE Film (
	FilmID int NOT NULL PRIMARY KEY IDENTITY,
	Tytul char(50) NULL,
	KrajID int NULL,
	CzasTrwania time(7) NULL,
	Opis nvarchar(max) NULL,
	GatunekID int NULL,
	Premiera date NULL,
	RezyseriaID int NULL,
	-- LatOdPremiery nchar(10) NULL
	LatOdPremiery AS DATEDIFF(year, Premiera, GETDATE())
)
GO


ALTER TABLE Film  WITH CHECK ADD  CONSTRAINT FK_Film_Garunek FOREIGN KEY(GatunekID)
REFERENCES Gatunek (GatunekID)
GO

ALTER TABLE Film  WITH CHECK ADD  CONSTRAINT FK_Film_Kraj FOREIGN KEY(KrajID)
REFERENCES Kraj (KrajID)
GO

ALTER TABLE Film  WITH CHECK ADD  CONSTRAINT FK_Filmy_Rezyser FOREIGN KEY(RezyseriaID)
REFERENCES Rezyser (RezyserID)
GO



CREATE TABLE dbo.FilmAktor(
	FilmID int NOT NULL,
	AktorID int NOT NULL,
	NazwaRoli char(100) NULL
)
GO

ALTER TABLE FilmAktor ADD CONSTRAINT PK_FilmAktor PRIMARY KEY (FilmID, AktorID)
GO



ALTER TABLE dbo.FilmAktor  WITH CHECK ADD  CONSTRAINT FK_FilmAktor_Aktor FOREIGN KEY(AktorID)
REFERENCES dbo.Aktor (AktorID)
GO


ALTER TABLE dbo.FilmAktor  WITH CHECK ADD  CONSTRAINT FK_FilmAktor_Film FOREIGN KEY(FilmID)
REFERENCES dbo.Film (FilmID)
GO





/*

    DANE

*/

USE Filmy
GO

--SELECT * FROM Kraj

SET NOCOUNT ON

SET IDENTITY_INSERT Kraj ON 

INSERT INTO Kraj (KrajID, Kraj) VALUES (1, 'USA')
INSERT INTO Kraj (KrajID, Kraj) VALUES (2, 'Polska')
INSERT INTO Kraj (KrajID, Kraj) VALUES (3, 'Francja')
INSERT INTO Kraj (KrajID, Kraj) VALUES (4, 'Japonia')
INSERT INTO Kraj (KrajID, Kraj) VALUES (5, 'Austria')
INSERT INTO Kraj (KrajID, Kraj) VALUES (6, 'Wielka Brytania')
INSERT INTO Kraj (KrajID, Kraj) VALUES (7, 'Belgia')
INSERT INTO Kraj (KrajID, Kraj) VALUES (8, 'Izrael')
INSERT INTO Kraj (KrajID, Kraj) VALUES (9, 'Ukraina')
INSERT INTO Kraj (KrajID, Kraj) VALUES (10, 'San Escobar')


SET IDENTITY_INSERT Kraj OFF
GO


SET IDENTITY_INSERT Gatunek ON 

INSERT INTO Gatunek(GatunekID, Gatunek) VALUES
 (1, 'akcja'),
 (2, 'animacja' ),
 (3, 'anime'),
 (4, 'biograficzny' ),
 (5, 'dokumentalny' ),
 (6, 'dramat' ),
 (7, 'dramat historyczny' ),
 (8, 'edukacyjny' ),
 (9, 'erotyczny' ),
 (10, 'etiuda' ),
 (11, 'familijny' ),
 (12, 'fantasy' ),
 (13, 'historyczny' ),
 (14, 'horror' ),
 (15, 'komedia' ),
 (16, 'komedia kryminalna' ),
 (17, 'komedia obycz.' ),
 (18, 'komedia rom.' ),
 (19, 'krótkometrażowy' ),
 (20, 'kryminał'),
 (21, 'melodramat' ),
 (22, 'musical' ),
 (23, 'muzyczny' ),
 (24, 'niemy' ),
 (25, 'przygodowy' ),
 (26, 'romans' ),
 (27, 'sci-fi' ),
 (28, 'sportowy' ),
 (29, 'thriller' ),
 (30, 'western'),
 (31, 'wojenny')

 SET IDENTITY_INSERT Gatunek OFF
 INSERT INTO Gatunek (Gatunek) VALUES ('Gangsterski')

UPDATE Gatunek SET Gatunek = UPPER(LEFT(Gatunek,1)) + SUBSTRING(Gatunek, 2, LEN(Gatunek))
GO

SET IDENTITY_INSERT Osoba ON 

INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (1, 'Quentin', 'Tarantino', 1, '19630327')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (2, 'Samuel L.', 'Jackson', 1, '19481221')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (3, 'Kurt', 'Russell', 1, '19510317')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (4, 'Jamie', 'Foxx', 1, '19671213')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (5, 'Christoph', 'Waltz', 5, '19561004')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (6, 'Leonardo', 'DiCaprio', 1, '19741111')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (7, 'Walton', 'Goggins', 1, '19711110')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (8, 'John', 'Travolta', 1, '19540218')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (9, 'Uma', 'Thurman', 1, '19700429')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (10, 'Bruce', 'Willis', 1, '19550319')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (11, 'Tim', 'Roth', 6, '19610514')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (12, 'Elijah', 'Wood', 1, '19810128')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (13, 'Robert', 'Zemeckis', 1, '19510514')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (14, 'Peter', 'Jackson', 1, '19611031')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (15, 'Felix', 'Van Groeningen', 7, '19771031')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (16, 'Steve', 'Carell', 1, '19620816')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (17, 'Kinga', 'Dębska', 2, '19690904')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (18, 'Dorota', 'Kolak', 2, '19570620')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (19, 'Agata', 'Kulesza', 2, '19710927')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (20, 'Paweł', 'Pawlikowski', 2, '19570915')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (21, 'Joanna', 'Kulig', 2, '19820624')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (22, 'Tomasz', 'Kot', 2, '19770421')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (23, 'Marian', 'Dziędziel', 2, '19470805')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (24, 'Gabriela', 'Muskała', 2, '19690611')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (25, 'Jon', 'Turteltaub', 1, '19630808')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (26, 'Jason', 'Statham', 6, '19670726')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (27, 'Robert', 'Rodriguez I', 1, '19680620')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (28, 'Jennifer', 'Connelly I', 1, '19701212')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (29, 'Michelle', 'Rodriguez', 1, '19780712')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (30, 'Steve', 'McQueen', 6, '19691009')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (31, 'Liam', 'Neeson', 1, '19520607')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (32, 'Darren', 'Aronofsky', 1, '19690212')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (33, 'Natalie', 'Portman', 8, '19810609')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (34, 'Mila', 'Kunis', 9, '19830814')
INSERT INTO Osoba (OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia) VALUES (35, 'George', 'Lucas', 1, '19440514')
                                        
        

SET IDENTITY_INSERT Osoba OFF 


--SELECT DATEDIFF(year, '19711110', GETDATE())
--SELECT OsobaID, Imie, Nazwisko, KrajID, DataUrodzenia FROM Osoba



SET IDENTITY_INSERT Aktor ON 

INSERT INTO Aktor (AktorID, OsobaID) VALUES (1, 1)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (2, 2) 
INSERT INTO Aktor (AktorID, OsobaID) VALUES (3, 3)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (4, 4)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (5, 5)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (6, 6)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (7, 7)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (8, 8)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (9, 9)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (10, 10)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (11, 11)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (12, 12)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (13,16)
INSERT INTO Aktor (AktorID, OsobaID) VALUES (14,18)
INSERT INTO Aktor (AktorID, OsobaID) VALUES  (15,19) -- A Kulesza
INSERT INTO Aktor (AktorID, OsobaID) VALUES  (16, 21) -- J Kulig
INSERT INTO Aktor (AktorID, OsobaID) VALUES  (17, 22) -- T Kot
INSERT INTO Aktor (AktorID, OsobaID) VALUES  (18, 23) -- M Dziedziel
INSERT INTO Aktor (AktorID, OsobaID) VALUES  (19, 24) -- G MUskala
INSERT INTO Aktor (AktorID, OsobaID) VALUES  (20, 26) -- G Statham
INSERT INTO Aktor (AktorID, OsobaID) VALUES  (21, 28) -- G Conelly
INSERT INTO Aktor (AktorID, OsobaID) VALUES  (22, 29) -- M Rodrigez 
INSERT INTO Aktor (AktorID, OsobaID) VALUES  (23, 31) -- Neeson 
INSERT INTO Aktor (AktorID, OsobaID) VALUES  (24, 33) -- Portman 
INSERT INTO Aktor (AktorID, OsobaID) VALUES  (25, 34) -- Kunis 


SET IDENTITY_INSERT Aktor OFF





SET IDENTITY_INSERT Rezyser ON 


INSERT INTO Rezyser (RezyserID, OsobaID) VALUES (1, 1) -- 8, Django, PF, SS
INSERT INTO Rezyser (RezyserID, OsobaID) VALUES (2, 13) -- BTTF
INSERT INTO Rezyser (RezyserID, OsobaID) VALUES (3, 14) -- Władca
INSERT INTO Rezyser (RezyserID, OsobaID) VALUES (4, 15) -- Felix Van Groeningen, Mój piękny syn
INSERT INTO Rezyser (RezyserID, OsobaID) VALUES (5, 17) -- Kinga Dębska, Zabawa Zabawa, Moje corki krowy
INSERT INTO Rezyser (RezyserID, OsobaID) VALUES (6, 20) -- P pawlikowski
INSERT INTO Rezyser (RezyserID, OsobaID) VALUES (7, 25) -- The meg
INSERT INTO Rezyser (RezyserID, OsobaID) VALUES (8, 27) -- Alita
INSERT INTO Rezyser (RezyserID, OsobaID) VALUES (9, 30) -- Wdowy
INSERT INTO Rezyser (RezyserID, OsobaID) VALUES (10, 32) -- Aronofsky
INSERT INTO Rezyser (RezyserID, OsobaID) VALUES (11, 35) -- Lucas

SET IDENTITY_INSERT Rezyser OFF



SET IDENTITY_INSERT Film ON 

INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(1, 'Nienawistna ósemka', 1, '2:47', 
 'Dwaj łowcy głów, próbując znaleźć schronienie przed zamiecią śnieżną, trafiają do Wyoming, gdzie wplątani zostają w splot krwawych wydarzeń.', 
 30, '20160115', 1)

INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(2, 'Django', 1, '2:45', 
 'Łowca nagród Schultz i czarnoskóry niewolnik Django wyruszają w podróż, aby odbić żonę tego drugiego z rąk bezlitosnego Calvina Candieego.', 
 30, '20130118', 1)

INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(3, 'Pulp Fiction', 1, '2:34', 
 'Przemoc i odkupienie w opowieści o dwóch płatnych mordercach pracujących na zlecenie mafii, żonie gangstera, bokserze i parze okradającej ludzi w restauracji.', 
 32, '20061215', 1)

INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(4, 'Sin City - Miasto grzechu', 1, '2:04', 
 'Trzy historie, których akcja rozgrywa się w Basin City - Mieście Grzechu - będącym siedliskiem prostytutek, przestępców i skorumpowanych obrońców prawa.', 
 20, '20050610', 1)

INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(5, 'Powrót do przyszłości II', 1, '1:48', 
 'Doktor Emmet Brown wysyła Marty-ego i Jennifer w przyszłość, by zapobiegli rozpadowi swojej przyszłej rodziny.', 
 25, '19891101', 2)
 
INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(6, 'Władca Pierścieni: Drużyna Pierścienia', 1, '2:58', 
 'Podróż hobbita z Shire i jego ośmiu towarzyszy, której celem jest zniszczenie potężnego pierścienia pożądanego przez Czarnego Władcę - Saurona.', 
 12, '20020215', 3)
 
INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(7, 'Mój piękny syn', 1, '1:51', 
 'Opowieść o losach rodziny, która musi zmierzyć się z uzależnieniem dorastającego chłopaka.', 
 6, '20190104', 4)
 
INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(8, 'Zabawa zabawa', 2, '1:28', 
 '40-letnia prokurator Dorota (Agata Kulesza) pije, by – jak sama mówi – „nie zwariować”. Zasłaniając się immunitetem, ukrywa wszystkie...', 
 6, '20190104', 5)
 
INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(9, 'Zimna wojna', 2, '1:24', 
 'Historia wielkiej i trudnej miłości dwojga ludzi, którzy nie potrafią być ze sobą i jednocześnie nie mogą bez siebie żyć. W tle wydarzenia zimnej wojny lat 50. w Polsce, Berlinie, Jugosławii i Paryżu.', 
 6, '20180608', 6)
 

INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(10, 'Moje córki krowy', 2, '1:28', 
 'W obliczu choroby jednego z rodziców, siostry postanawiają polepszyć relacje między sobą.', 
 6, '20160108', 5)
 
INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(11, 'The Meg', 1, '1:53', 
 'Były wojskowy ekspert od nurkowania zostaje zwerbowany do misji ratunkowej. Mężczyzna otrzymuje zadanie ocalenia grupy naukowców przed ogromnym rekinem.', 
 14, '20180824', 7)
 
INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(12, 'Alita: Battle Angel', 1, '2:58', 
 'Naukowiec ratuje kobietę-cyborga od zniszczenia', 
 27, '20190214', 8)
 
INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(13, 'Wdowy', 1, '2:08', 
 'Cztery kobiety, które zostały pozostawione z długami przez zmarłych mężów, biorą sprawy we własne ręce.', 
 6, '20181116', 9)
 
INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(14, 'Requiem for a Dream', 1, '1:42', 
 'Historia czwórki bohaterów, dla których używki są ucieczką przed otaczającą ich rzeczywistością.', 
 6, '20010316', 10)
 
INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(15, 'Black Swan', 1, '1:48', 
 'Nina desperacko pragnie zdobyć rolę w "Jeziorze łabędzim". Gdy jej marzenie się spełnia, odkrywa swoją mroczną stronę.', 
 6, '20110121', 10)
 
INSERT INTO Film (FilmID, Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID) VALUES 
(16, 'Gwiezdne wojny: Część I - Mroczne widmo', 1, '2:16', 
 'Dwaj rycerze Jedi wyruszają z misją ocalenia planety Naboo przed inwazją wojsk Federacji Handlowej. Trafiają na pustynny glob, gdzie pomoże im mały Anakin Skywalker.', 
 6, '19990917', 11)
 

 

SET IDENTITY_INSERT Film OFF


INSERT INTO FilmAktor (FilmID, AktorID) VALUES (1, 1), (1, 2), (1, 3), (1, 7), (1, 11) -- 8
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (2, 4), (2, 5), (2, 6), (2, 2), (2, 7) -- Django
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (3, 8), (3, 9), (3, 10), (3, 11), (3, 2), (3, 1) -- PF
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (4, 10), (4, 12) -- SC  
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (5, 12) -- BTTF  
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (6, 12) -- Wladca pier
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (7, 13) -- Moj piekny syn  
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (8, 14), (8, 15) -- Zabawa zabawa
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (9, 21), (9, 22), (9, 15)  -- Zimna wojna
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (10, 15), (10, 18), (10, 19)  -- Moje corki krowy
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (11, 20)  -- Meg
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (12, 22), (12, 21)  -- Alita
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (13, 22), (13, 23)  -- Wdowy
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (14, 21)  -- Requem dla snu
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (15, 24), (15, 25)  -- Black Swan
INSERT INTO FilmAktor (FilmID, AktorID) VALUES (16, 24), (16, 23)  -- GW1 Mroczne widmo
--SELECT * FROM FilmAktor







