/*
	Tworzenie tabel
	KursySQL.pl - webinary - styczeń 2021

	libera@kursysql.pl
	https://www.kursysql.pl/kurs-t-sql-live-on-line/
	https://github.com/kursysql/kursysql-live
    
*/





/* 
	Pierwsza tabela
	* pk, identity, null not null
*/




-- live coding....

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













