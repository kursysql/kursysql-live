/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	FUNKCJE
	A: Konwersja danych

*/



USE AdventureWorks2017
GO


/* Konwersja niejawna */
SELECT 1 + 2 
SELECT '1' + '2' 
SELECT '1' + 2 -- varchar VS int ???




-- pierwszeństwo typów
-- Google: "sql data types precedence"
-- https://docs.microsoft.com/en-us/sql/t-sql/data-types/data-type-precedence-transact-sql?view=sql-server-ver15



/* Konwersja jawna */
SELECT CAST('Funkcje' AS char(3))


SELECT CONVERT(char(3), 'Funkcje')

-- błąd konwersji
SELECT CAST('dwa' AS int)

-- niedozwolona konwersja
-- https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql

SELECT CAST(CAST(GETDATE() AS date) AS time)





SELECT '<xml><name>smith</name></xml>'
SELECT CAST('<xml><name>smith</name></xml>' AS xml)
SELECT CAST('<xml><name>smith</name>' AS xml) -- niedomknięty xml


SELECT 
   GETDATE() AS [GETDATE()],
   CAST(GETDATE() AS nvarchar(30)) AS [Cast],
   CONVERT(nvarchar(30), GETDATE(), 126) AS [Style126_ISO8601],
   CONVERT(nvarchar(30), GETDATE(), 112) AS [Style112_ISO], -- ! 112
   CONVERT(nvarchar(30), GETDATE(), 12) AS [Style12_ISO], -- ! 12
   CONVERT(nvarchar(30), GETDATE(), 120) AS [Style120_ODBC]
GO



-- PARSE ( string_value AS data_type [ USING culture ] )


SELECT PARSE('Czwartek, 2 stycznia 2020' AS datetime2 USING 'en-US') 

SELECT PARSE('Thursday, 2 January 2020' AS datetime2 USING 'en-US') 


SELECT PARSE('Czwartek, 2 stycznia 2020' AS datetime2 USING 'pl-PL')

SELECT PARSE('Środa, 2 stycznia 2020' AS datetime2 USING 'pl-PL') 


SELECT PARSE('2 stycznia 2020' AS datetime2 USING 'pl-PL') 
SELECT PARSE('2 styczeń 2020' AS datetime2 USING 'pl-PL') 
SELECT PARSE('2 sty 2020' AS datetime2 USING 'pl-PL') 



SELECT PARSE('Zima 2020' AS datetime2 USING 'pl-PL') 


-- TRY_PARSE ( string_value AS data_type [ USING culture ] )

SELECT TRY_PARSE('Zima 2020' AS datetime2 USING 'pl-PL') 

-- zwraca NULL zamiast błąd
SELECT TRY_PARSE('Zima 2020' AS datetime2 USING 'pl-PL')

-- !
SELECT CAST('dwa' AS int)
SELECT TRY_CAST('dwa' AS int)


-- ! niedozwolona konwersja
SELECT CAST(CAST(GETDATE() AS date) AS time)
-- !
SELECT TRY_CAST(CAST(GETDATE() AS date) AS time)


-- TRY_CAST ( expression AS data_type [ ( length ) ] )
SELECT TRY_CAST('<xml><name>smith</name></xml>' AS xml)
SELECT TRY_CAST('<xml><name>smith</name>' AS xml) -- niedomkniety xml


-- TRY_CONVERT ( data_type [ ( length ) ], expression [, style ] )
SELECT TRY_CONVERT(xml, '<xml><name>smith</name></xml>')
SELECT TRY_CONVERT(xml, '<xml><name>smith</name>') -- niedomkniety xml


