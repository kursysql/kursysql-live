/*
	Tomasz Libera | libera@kursysql.pl

	Wyszukiwanie pełnotekstowe
	Zapytania

*/


/*
	LIKE vs FTS
*/


USE iFTSDemo
GO

SELECT * FROM NewsPL

SET STATISTICS IO ON

-- 
SELECT * FROM NewsPL WHERE Title LIKE N'%praktyki%'






SELECT * FROM NewsPL WHERE CONTAINS(Title, N'praktyki')


-- 
SELECT * FROM NewsPL WHERE FREETEXT(Title, N'praktyki')


SELECT * FROM NewsPL WHERE FREETEXT(Title, N'praktyki')
EXCEPT
SELECT * FROM NewsPL WHERE Title LIKE N'%praktyki%'


-- FTS jest zależny od języka
SELECT * FROM NewsPL WHERE Title LIKE '%gra%' -- proGRAm, inteGRAcyjny, GRAduacja

SELECT * FROM NewsPL WHERE FREETEXT(Title, N'gra') 





-- czy aby na pewno zawsze bardziej wydajnie niż LIKE?

-- Nonclustered index - Title
CREATE INDEX IDX_News_Title ON NewsPL(Title)



SELECT * FROM NewsPL WHERE Title LIKE N'%praktyki%'



-- 
SELECT * FROM NewsPL WHERE Body LIKE N'%praktyki%'



SELECT * FROM NewsPL WHERE CONTAINS(Body, N'praktyki')


-- 
SELECT * FROM NewsPL WHERE FREETEXT(Body, N'praktyki')



-- ! Nonclustered index - Body
CREATE INDEX IDX_News_Body ON NewsPL(Body)

/*

	SZKOLENIE Optymalizacja zapytań SQL - Moduł: Indeksy pełnotekstowe
	Przykłady na tabelach zawierających miliony wierszy, XX GB
	- analiza planów zapytań bardziej złożonych zapytań korzystających z FTS
	- ograniczenia FTS
	- alternatywy dla FTS
	- zadania (zapytania do napisania)
	- quiz
	https://www.kursysql.pl/szkolenie-optymalizacja-zapytan-sql/



*/





/*
	FREETEXT / FREETEXTTABLE
*/



USE iFTSDemo
GO


/* Funkcja FREETEXT  */

SELECT * FROM NewsPL WHERE FREETEXT(Title, N'europa')

SELECT * FROM NewsPL WHERE FREETEXT(Body, N'europa')

SELECT * FROM NewsPL WHERE FREETEXT((Title, Body), N'europa')

SELECT * FROM NewsPL WHERE FREETEXT(*, N'europa')







SELECT * FROM NewsPL 
WHERE FREETEXT(Title, N'studia podyplomowe')


/*  Funkcja tabelaryczna FREETEXTTABLE  */

SELECT * FROM FREETEXTTABLE(dbo.NewsPL, *, N'"studia podyplomowe"', 50)

SELECT *
FROM FREETEXTTABLE(dbo.NewsPL, *, N'"studia podyplomowe"', 50) AS free
INNER JOIN NewsPL AS a ON free.[KEY] = a.ID
ORDER BY [RANK] DESC


SELECT INDEXPROPERTY( OBJECT_ID('NewsPL'), 'PK_NewsPL',  'IsFulltextKey' )

-- How Search Query Results Are Ranked
-- https://docs.microsoft.com/en-us/sql/relational-databases/search/limit-search-results-with-rank




/*  Niezależne wyszukiwanie po dwóch różnych kolumnach */

SELECT *, 1 AS TitleSearch FROM NewsPL AS a
INNER JOIN FREETEXTTABLE(dbo.NewsPL, Title, N'"studia podyplomowe"', 20) AS free
ON free.[KEY] = a.ID
UNION ALL
SELECT *, 0 AS TitleSearch FROM NewsPL AS a
INNER JOIN FREETEXTTABLE(dbo.NewsPL, Body, N'"studia podyplomowe"', 20) AS free
ON free.[KEY] = a.ID
-- ORDER BY TitleSearch DESC, free.[RANK] DESC
ORDER BY ID -- ID 1146 -- 18




/*  Wyszukiwanie po kilku kolumnach jednocześnie */
DECLARE @szukaj nvarchar(50) = N'studia podyplomowe'

SELECT TOP 20 * 
FROM 
(
	SELECT ArticleID, SUM([RANK])AS [Rank]
	FROM (
		SELECT
			t.[KEY] AS ArticleID,
			t.[RANK] * 10 AS [RANK]
		FROM FREETEXTTABLE(dbo.NewsPL, Title, @szukaj) AS t
		UNION ALL
		SELECT 
			c.[KEY],
			c.[RANK]
		FROM FREETEXTTABLE(dbo.NewsPL, Body, @szukaj) AS c
	) AS ResultUnion
	GROUP BY ArticleID
) AS ResultGrouped
INNER JOIN NewsPL 
ON NewsPL.ID = ResultGrouped.ArticleID
ORDER BY [Rank] DESC





/*

  CONTAINS / CONTAINSTABLE

*/


USE iFTSDemo
GO


/* pojedyncze slowa */
SELECT * FROM NewsPL 
WHERE FREETEXT(Title, N'rektor')

SELECT * FROM NewsPL
WHERE CONTAINS(Title, N'rektor')


/* frazy */
SELECT * FROM NewsPL
WHERE FREETEXT(Title, N'studia podyplomowe')

SELECT * FROM NewsPL
WHERE CONTAINS(Title, N'"studia podyplomowe"')






/* Boolean searches 

Możliwość wskazania w dokładnym wyszukiwaniu (CONTAINS)- że 
wyniki mają zawierać wszystkie z wymienionych slow- nie ma znaczenia kolejnosc 
i jak są blisko siebie. 
*/

SELECT * FROM NewsEN 
WHERE CONTAINS(Title, N'"Enrolment" and "courses" and "CISCO"')


/* 
Można używac: AND (&), OR (|), AND NOT (&!)
OR NOT nie jest wspierany przez iFTS
*/


SELECT * FROM NewsPL
WHERE CONTAINS(Title, N'"inauguracja" and "podyplomowych"')

SELECT * FROM NewsPL 
WHERE CONTAINS(Title, N'"inauguracja" or "podyplomowych"')
-- taki sam wynik
SELECT * FROM NewsPL
WHERE CONTAINS(Title, N'"inauguracja" | "podyplomowych"')


SELECT * FROM NewsPL AS a
WHERE CONTAINS(a.Title, N'"inauguracja" AND NOT "roku"') -- inauguracja nie-roku











/* Prefix searches */

SELECT * FROM NewsPL 
WHERE CONTAINS(Title, N'"kurs*"') 


/* Suffix search niewspierane (w Oracle/DB2 owszem) */
SELECT * FROM NewsPL
WHERE CONTAINS(Title, N'"*rs"')




/* INFLECTIONAL

FREETEXT automatycznie wyszukuje wszystkie odmiany wyszukiwanej frazy;
wykorzystujac thezaurus i slowa wynikajace. CONTAINS tego NIE robi.
Mozemy go jednak zachecic- uzywajac operatora FORMSOF i wskazujac, czy chcemy uzyc
INFLECTIONAL czy THESAURUS
*/


SELECT * FROM NewsPL 
WHERE CONTAINS(Title, N'kurs')

SELECT * FROM NewsPL
WHERE CONTAINS(Title, N'FORMSOF(INFLECTIONAL, kurs)')

SELECT * FROM NewsPL
WHERE CONTAINS(Title, N'FORMSOF(THESAURUS, kurs)')



/* THESAURUS 

C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\FTData

        <expansion>
            <sub>kurs</sub>
            <sub>szkolenie</sub>
        </expansion>

*/ 

-- przeładowanie Thesaurus na podstawie pliku xml, dla wskazanego języka
EXEC sp_fulltext_load_thesaurus_file @lcid = 1045


SELECT * FROM sys.dm_fts_parser ( N'FORMSOF(THESAURUS, kurs)', 1045, null, 0 )

SELECT * FROM NewsPL
WHERE CONTAINS(Title, N'FORMSOF(THESAURUS, kurs)')




-- 
SELECT * FROM NewsPL
WHERE CONTAINS(Title, N'FORMSOF(THESAURUS, kurs) OR FORMSOF(INFLECTIONAL, kurs)')






/* Proximity searches

Wyszukiwanie słów znajdujących się blisko siebie

*/



SELECT * FROM NewsPL
WHERE CONTAINS(*, N'"azure" NEAR "microsoft"')


SELECT * FROM NewsPL 
WHERE CONTAINS(*, N'NEAR(("azure", "microsoft"),4)')

SELECT * FROM NewsPL 
WHERE CONTAINS(*, N'NEAR(("azure", "microsoft"),10)')






/*  Funkcja tabelaryczna CONTAINSTABLE  */

SELECT * 
FROM dbo.NewsPL AS a
JOIN CONTAINSTABLE(dbo.NewsPL, Body, N'student', 10) AS cont
ON cont.[KEY] = a.ID



/*
	https://www.kursysql.pl/szkolenie-optymalizacja-zapytan-sql/
*/