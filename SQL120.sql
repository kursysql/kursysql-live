/*

	Kurs SQL120 - Język SQL w 2 godziny
	www.kursysql.pl

	Tomasz Lbera | MVP Data Platform | 	libera@kursysql.pl

*/



USE AdventureWorks2017
GO




/*
	1. Wprowadzenie do SSMS
	- wyświetl zawartość kilku tabel, wybierająć z menu podręcznego
	"Select Top 1000 Rows"
*/



/*
	2. Pierwsze zapytania 
*/

-- NAZWA_SCHEMATU.NAZWA_TABELI
SELECT * FROM Production.Product

SELECT * FROM Person.Person

-- brakuje nazwy schematu
SELECT * FROM Person

SELECT * FROM dbo.DatabaseLog


-- schemat dbo to domyślny schemat
SELECT * FROM DatabaseLog




-- j.w. zaznaczenie kilku zapytań - wykonywanie wsadu



-- w tym przypadku nawiasy kwadratowe są opcjonalne
SELECT * FROM [Person].[Person]

-- zmiana nazwy na taką ze spacją
sp_rename 'HumanResources.JobCandidate', 'Job Candidate'

-- nawiasy kwadratowe - obowiązkowe
SELECT * FROM [HumanResources].[Job Candidate]

--!
SELECT * FROM HumanResources.Job Candidate


-- powrót do oryginalnej nazwy
sp_rename 'HumanResources.Job Candidate', 'JobCandidate'




-- wybieranie kolumn
SELECT ProductID, Name, Color, Size 
FROM Production.Product
-- ProductID = klucz główny (PRIMARY KEY, PK)

-- aliasy
SELECT ProductID AS ID, Name AS Nazwa, Color AS Kolor, Size AS Rozmiar
FROM Production.Product


/*
	3. Podpowiadanie składni - Intellisense
*/

SELECT * FROM Production.Product


-- zapytanie bez kolumn - jak ro zrobić



/*
	4. Sortowanie danych
*/

-- domyślny porządek sortowania
SELECT * FROM Production.Product


-- wiersze posortowane ROSNĄCO wg zawartości kolumny Name
-- = produkty posortowanie wg nazwy
SELECT * FROM Production.Product
ORDER BY Name

-- porządek sortowania malejący
SELECT * FROM Production.Product
ORDER BY Name DESC

-- dwa poziomy sortowania
-- produkty posortowane wg koloru, a te które mają ten sam kolor - wg nazwy
SELECT * FROM Production.Product
ORDER BY Color, Name

-- malejąco wg koloru i rosnąco wg nazwy
SELECT * FROM Production.Product
ORDER BY Color DESC, Name



/*
	5. Filtrwanie danych
*/


SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID = 707

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID > 100

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID BETWEEN 13 AND 290



-- wartości tekstowe - w pojedynczych apostrofach
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Red'

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Size = 'M'




-- Operator LIKE
SELECT * FROM Production.Product 
WHERE Name LIKE 'B%'

-- % - dowolony znak w dowolnej liczbie
SELECT * FROM Production.Product 
WHERE Name LIKE '%Bike%'

-- _ dowolny pojedynczy znak
SELECT * FROM Production.Product
WHERE Name LIKE 'Mountain Bike Socks, _'

--! = zamiast LIKE
SELECT * FROM Production.Product 
WHERE Name = '%Bike%'





-- Operatory AND OR

-- produkty koloru czarnego, o rozmiarze M
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Black' AND Size = 'M'

-- produkty koloru czarnego, srebrnego i niebieskiego
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Black' OR Color = 'Silver' OR Color = 'Blue'

-- łączymy razem...
SELECT * FROM Production.Product 
WHERE Name LIKE '%Bike%' AND Color = 'White'



-- NULL

-- na początku w kolumnie kolor wartości nieokreślone
SELECT * FROM Production.Product
ORDER BY Color

--! czy na pewno nie ma takich wierszy
SELECT * FROM Production.Product
WHERE Color = NULL


SELECT * FROM Production.Product
WHERE Color IS NULL

SELECT * FROM Production.Product
WHERE Color IS NOT NULL


-- łączymy razem...
SELECT * FROM Production.Product 
WHERE Color = 'Black' AND Size IS NOT NULL AND Name LIKE '%Frame%'


-- nawiasy...
-- produkty koloru czarnego i rozmiarze M LUB czerwone produkty związane z szosą
SELECT * FROM Production.Product 
WHERE (Color = 'Black' AND Size = 'M') OR (Color = 'Red' AND Name LIKE '%Road%')

--! uwaga na warunki wykluczające się
SELECT * FROM Production.Product 
WHERE Color = 'Black' AND Color = 'Red'

-- zamiast tego...
SELECT * FROM Production.Product 
WHERE Color = 'Black' OR Color = 'Red'


-- zamiast tego...
SELECT * FROM Production.Product 
WHERE Color = 'Black' OR Color = 'Red'

SELECT * FROM Production.Product 
WHERE Color IN ('Black', 'Red')





/*
	6. Logiczna kolejność wykonywania zapytania
*/

--! odwołanie się do aliasu kolumny w WHERE nie zadziała
SELECT ProductID, Name, Color AS Kolor, Size 
FROM Production.Product
WHERE Kolor = 'Red'


-- odwołanie się do aliastu kolumny w ORDER BY - jest OK
SELECT ProductID, Name, Color AS Kolor, Size 
FROM Production.Product
ORDER BY Kolor 


-- kolejność wykonywania instrukcji SELECT
SELECT ProductID, Name, Color AS Kolor, Size	-- 2
FROM Production.Product							-- 1
ORDER BY Kolor									-- 3



-- bez aliastu też się uda
SELECT ProductID, Name, Color AS Kolor, Size 
FROM Production.Product
ORDER BY Color




/*
	7. Funkcje 
*/

-- skalarne
SELECT GETDATE()


SELECT GETDATE() AS CurrentDateTime



SELECT UPPER('Bardzo ładny rower') AS CurrentDateTime

-- godziny/ miesiace/ lata.... , OD KIEDY, DO KIEDY
SELECT DATEDIFF(HOUR, '20190801 12:15', '20190801 15:15')

SELECT DATEDIFF(MONTH, '20190801', '20201201')

SELECT DATEDIFF(YEAR, '20190801', '20201201')



SELECT DATEDIFF(YEAR, GETDATE(), '20401201')

SELECT DATEDIFF(DAY, GETDATE(), '20401201')
SELECT DATEDIFF(HOUR, GETDATE(), '20401201')


-- nazwy produktów wielkimi literami
SELECT ProductID, UPPER(Name) AS Name, Color AS Kolor, Size 
FROM Production.Product


-- ile dni upłynęło od początku sprzedaży
SELECT ProductID, Name, Color AS Kolor, Size, DATEDIFF(DAY, SellStartDate, GETDATE()) 
FROM Production.Product



-- Funkcje agregujące
SELECT COUNT(*) AS FnCount FROM Production.Product

SELECT SUM(ListPrice) AS FnSum FROM Production.Product

SELECT MIN(ListPrice) AS FnMIN FROM Production.Product




/*
	8. Grupowanie danych
*/

SELECT COUNT(*) AS Cnt FROM Production.Product

-- liczba produktów koloru czerwonego
SELECT COUNT(*) AS Cnt FROM Production.Product
WHERE Color = 'Red'

-- liczba produktów poszczególnych kolorów
SELECT Color, COUNT(*) AS Cnt 
FROM Production.Product
GROUP BY Color

--! nie możemy wyświetlać kolumn, po których nie pogrupowaliśmy 
SELECT Color, Size, COUNT(*) AS Cnt 
FROM Production.Product
GROUP BY Color


-- ... chyba, że po nich również pogrupujemy
SELECT Color, Size, COUNT(*) AS Cnt 
FROM Production.Product
GROUP BY Color, Size


/*
	9. Łączenie tabel
*/


SELECT * FROM Production.Product


SELECT * FROM Production.ProductSubcategory



SELECT * 
FROM Production.Product
JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID

--! obie tabele zawierają kolumnę Name
SELECT ProductID, Name, Color, Size, Name
FROM Production.Product
JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID


SELECT ProductID, Production.Product.Name, Color, Size, Production.ProductSubcategory.Name
FROM Production.Product
JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID


-- aliasy tabel
SELECT ProductID, p.Name, Color, Size, ps.Name, p.ProductSubcategoryID, ps.ProductSubcategoryID
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID




/*
	skrypt: www.kursysql.pl


*/



