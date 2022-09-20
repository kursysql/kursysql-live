/*
	Tomasz Libera | libera@kursysql.pl

	Wyszukiwanie pełnotekstowe
	Indeksy

*/


USE iFTSDemo
GO


SELECT * FROM NewsPL

-- Msg 7601, Level 16, State 2, Line 21
-- Cannot use a CONTAINS or FREETEXT predicate on table or indexed view 'NewsPL' because it is not full-text indexed.
SELECT * FROM NewsPL WHERE CONTAINS(*, N'praktyki')


SELECT * FROM sys.dm_fts_parser(N'"W dzisiejszych czasach sam dyplom uczelni nie jest wystarczającą przepustką do uzyskania"', 1045, 0, 0)

SELECT * FROM sys.dm_fts_parser(N'"W dzisiejszych czasach sam dyplom uczelni nie jest wystarczającą przepustką do uzyskania"', 1045, 0, 0)
WHERE special_term <> 'Noise Word'


-- DROP FULLTEXT CATALOG FtsCatalog
CREATE FULLTEXT CATALOG FtsCatalog
WITH ACCENT_SENSITIVITY = OFF
AS DEFAULT
GO


SELECT * FROM sys.fulltext_catalogs



-- DROP FULLTEXT INDEX ON NewsPL
CREATE FULLTEXT INDEX ON NewsPL (
	Title LANGUAGE Polish,
	Body LANGUAGE Polish)
KEY INDEX PK_NewsPL ON (FtsCatalog)
WITH (CHANGE_TRACKING = AUTO) -- AUTO | MANUAL | OFF
GO


/*
CHANGE_TRACKING
* AUTO (domyślnie) - SQL Server śledzi zmiany i automatycznie aktualizuje indeks
* MANUAL - SQL Server śledzi modyfikacje, ale nie aktualizuje indeksu, należy ręcznie uruchomić   ALTER FULLTEXT INDEX ... START UPDATE POPULATION
* OFF = żadne zmiany nie są śledzone, aktualizacja indeksu to zawsze pełna przebudowa
*/


-- SSMS
-- > ForumPosts
-- > NewsEN


SELECT * FROM sys.fulltext_indexes


/* 
	crawl_type:
	* F = Full crawl
	* I = Incremental, timestamp-based crawl
	* U = Update crawl, based on notifications
	* P = Full crawl is paused.
https://docs.microsoft.com/en-us/sql/relational-databases/search/populate-full-text-indexes

*/



SELECT * FROM sys.fulltext_index_catalog_usages


SELECT ftc.*, o.name, i.name
FROM sys.fulltext_index_catalog_usages AS ftc
JOIN sys.objects AS o ON o.object_id = ftc.object_id
JOIN sys.indexes AS i ON i.index_id = ftc.index_id AND i.object_id = o.object_id


SELECT * FROM sys.fulltext_index_columns

-- zawartość indeksu
SELECT * FROM sys.dm_fts_index_keywords(DB_ID('iFTSDemo'), OBJECT_ID('NewsPL')) 

-- więcej wierszy, bo zawiera informację o identyfikatorach wierszy
SELECT * FROM sys.dm_fts_index_keywords_by_document(DB_ID('iFTSDemo'), OBJECT_ID('NewsPL')) 




/*
	Dane binarne
*/

-- jakie pliki są wspierane
SELECT * FROM sys.fulltext_document_types

-- doc
SELECT * FROM sys.fulltext_document_types WHERE document_type LIKE '%doc%'




/*
Microsoft Office 2010 Filter Packs 
https://www.microsoft.com/en-us/download/details.aspx?id=17062

*/

EXEC sp_fulltext_service @action='load_os_resources', @value=1
GO

SELECT * FROM sys.fulltext_document_types WHERE document_type LIKE '%doc%'


-- tabela z plikami PDF
SELECT * FROM Articles

-- > SSMS
-- DROP FULLTEXT INDEX ON dbo.Articles
CREATE FULLTEXT INDEX ON dbo.Articles (
	ArticleFile TYPE COLUMN ArticleFileExt LANGUAGE Polish
)
KEY INDEX PK_Articles 
GO



SELECT * FROM sys.dm_fts_index_keywords(DB_ID('iFTSDemo'), OBJECT_ID('Articles')) 


SELECT * FROM Articles WHERE ArticleFileExt <> 'pdf'

/*

	https://www.pdflib.com/download/tet-pdf-ifilter/
	On desktop operating systems (Windows 8/10) TET PDF IFilter is freely available 
	for non-commercial use which provides a convenient basis for test and evaluation. 
	The commercial use on desktop systems requires a commercial license.

*/

SELECT * FROM Articles WHERE FREETEXT(ArticleFile, N'finanse')



SELECT * FROM sys.dm_fts_index_keywords(DB_ID('iFTSDemo'), OBJECT_ID('Articles')) 

-- > SSMS + Descript, Keywords, 



/*
	https://www.kursysql.pl/szkolenie-optymalizacja-zapytan-sql/
*/