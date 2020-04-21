USE AdventureWorks2017
GO


SELECT * FROM HumanResources.Employee


-- liczba pracowników 
SELECT count(*) FROM HumanResources.Employee

-- wiek pracowników
SELECT DATEDIFF(YEAR, BirthDate, GETDATE()), *  FROM HumanResources.Employee

-- średni wiek pracowników
SELECT AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) FROM HumanResources.Employee

-- suma godzin chorobowych 
SELECT SUM(SickLeaveHours) FROM HumanResources.Employee

-- !
SELECT SUM(SickLeaveHours), LoginID FROM HumanResources.Employee


-- dane pogrupowane dla poszczególnych pracowników
SELECT LoginID, SUM(SickLeaveHours) SickLeaveHoursSum, SUM(VacationHours) VacationHoursSum
FROM HumanResources.Employee
GROUP BY LoginID

-- dane pogrupowane dla poszczególnych stanowisk
SELECT JobTitle, count(*) AS Cnt, SUM(SickLeaveHours) SickLeaveHoursSum, SUM(VacationHours) VacationHoursSum
FROM HumanResources.Employee
GROUP BY JobTitle


-- dane pogrupowane dla poszczególnych stanowisk
-- tylko kobiety
SELECT JobTitle, count(*) AS Cnt, SUM(SickLeaveHours) SickLeaveHoursSum, SUM(VacationHours) VacationHoursSum
FROM HumanResources.Employee
WHERE Gender = 'F'
GROUP BY JobTitle

-- tylko mężczyźni
SELECT JobTitle, count(*) AS Cnt, SUM(SickLeaveHours) SickLeaveHoursSum, SUM(VacationHours) VacationHoursSum
FROM HumanResources.Employee
WHERE Gender = 'M'
GROUP BY JobTitle


-- grupowanie po dwóch kolumnach
SELECT Gender, JobTitle, count(*) AS Cnt, SUM(SickLeaveHours) SickLeaveHoursSum, SUM(VacationHours) VacationHoursSum
FROM HumanResources.Employee
GROUP BY Gender, JobTitle


-- sortowanie po wyniku funkcji agregującej
SELECT Gender, JobTitle, count(*) AS Cnt, SUM(SickLeaveHours) SickLeaveHoursSum, SUM(VacationHours) VacationHoursSum
FROM HumanResources.Employee
GROUP BY Gender, JobTitle
ORDER BY Cnt DESC
-- ORDER BY count(*)



-- ! próba filtrowania po wyniku funkcji agregującej
SELECT Gender, JobTitle, count(*) AS Cnt, SUM(SickLeaveHours) SickLeaveHoursSum, SUM(VacationHours) VacationHoursSum
FROM HumanResources.Employee
WHERE count(*) > 9
GROUP BY Gender, JobTitle
ORDER BY Cnt DESC


-- HAVING
SELECT Gender, JobTitle, count(*) AS Cnt, SUM(SickLeaveHours) SickLeaveHoursSum, SUM(VacationHours) VacationHoursSum
FROM HumanResources.Employee
GROUP BY Gender, JobTitle
HAVING count(*) > 9
ORDER BY Cnt DESC











