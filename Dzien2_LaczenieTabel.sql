USE AdventureWorks2017
GO


SELECT * FROM HumanResources.Employee
GO


SELECT  * FROM Person.Person
GO


SELECT *
FROM HumanResources.Employee AS e
JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID

-- 290 wierszy
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle
FROM HumanResources.Employee AS e
JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID


SELECT COUNT(*) FROM HumanResources.Employee
SELECT COUNT(*) FROM Person.Person


-- RIGHT JOIN 19 972 wierszy
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle
FROM HumanResources.Employee AS e
RIGHT JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID

-- LEFT JOIN 290 wierszy
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle
FROM HumanResources.Employee AS e
LEFT JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID




SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle
FROM HumanResources.Employee AS e
RIGHT JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID
-- taki sam wynik
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle
FROM Person.Person AS p
LEFT JOIN HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID


SELECT * FROM HumanResources.Department


SELECT * FROM  HumanResources.EmployeeDepartmentHistory ORDER BY BusinessEntityID

-- aktywne przypisanie pracowników
SELECT * FROM  HumanResources.EmployeeDepartmentHistory 
WHERE EndDate IS NULL


-- 296 wierszy!!
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle, d.Name AS DepartmenName
FROM Person.Person AS p
JOIN HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory AS dh ON dh.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.Department AS d ON d.DepartmentID = dh.DepartmentID


-- 290 wierszy
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle, d.Name AS DepartmenName
FROM Person.Person AS p
JOIN HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory AS dh ON dh.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.Department AS d ON d.DepartmentID = dh.DepartmentID
WHERE dh.EndDate IS NULL



SELECT d.Name, count(*)
-- FROM Person.Person AS p -- niepotrzebna tabela
FROM HumanResources.Employee AS e
JOIN HumanResources.EmployeeDepartmentHistory AS dh ON dh.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.Department AS d ON d.DepartmentID = dh.DepartmentID
WHERE dh.EndDate IS NULL
GROUP BY d.Name


SELECT d.Name, e.JobTitle, count(*)
FROM HumanResources.Employee AS e
JOIN HumanResources.EmployeeDepartmentHistory AS dh ON dh.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.Department AS d ON d.DepartmentID = dh.DepartmentID
WHERE dh.EndDate IS NULL
GROUP BY d.Name, e.JobTitle
ORDER BY d.Name, e.JobTitle



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



-- 3/ ZLICZ pracowników mieszkających w poszczególnych miastach



-- 3/ Poprzwednie zapytanie - pokaż tylko miasta w których mieszka min 200 osób




-- 5/ Sprawdź gdzie mieszka NAJWIĘCEJ osób





