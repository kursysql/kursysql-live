USE AdventureWorks2017
GO


/*
    ZADANIA
*/

-- pracownicy
SELECT * FROM HumanResources.Employee

-- dane osobowe
SELECT * FROM Person.Person

-- adresy
SELECT * FROM  Person.Address

-- powiązanie osób z adresami
SELECT * FROM  Person.BusinessEntityAddress


-- 1/ ranking imion - zlicz osoby o poszczególnych imionach
SELECT * FROM Person.Person

-- 2/ połącz tabelę z danymi osobymi z tabelą z adresami (w sumie3 tabele)
--      wyświetl imię, nazwisko, nazwę stanowiska i miasto

SELECT *
FROM Person.Person AS p
JOIN Person.BusinessEntityAddress AS bea ON bea.BusinessEntityID = p.BusinessEntityID
JOIN Person.Address AS a ON a.AddressID = bea.AddressID

-- 3/ ZLICZ pracowników mieszkających w poszczególnych miastach
SELECT a.City, count(*)
FROM Person.Person AS p
JOIN Person.BusinessEntityAddress AS bea ON bea.BusinessEntityID = p.BusinessEntityID
JOIN Person.Address AS a ON a.AddressID = bea.AddressID
GROUP BY a.City

-- 3/ Poprzwednie zapytanie - pokaż tylko miasta w których mieszka min 200 osób
SELECT a.City, COUNT(*)
FROM Person.Person AS p
JOIN Person.BusinessEntityAddress AS bea ON bea.BusinessEntityID = p.BusinessEntityID
JOIN Person.Address AS a ON a.AddressID = bea.AddressID
GROUP BY a.City
HAVING count(*) >= 200
ORDER BY COUNT(*) DESC

-- 5/ Sprawdź gdzie mieszka NAJWIĘCEJ osób
SELECT a.City, COUNT(*)
FROM Person.Person AS p
JOIN Person.BusinessEntityAddress AS bea ON bea.BusinessEntityID = p.BusinessEntityID
JOIN Person.Address AS a ON a.AddressID = bea.AddressID
GROUP BY a.City
ORDER BY COUNT(*) DESC