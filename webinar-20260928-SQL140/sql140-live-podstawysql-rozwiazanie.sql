/*
    SQL140 LIVE – rozwiązania

    http://www.kursysql.pl
    http://www.youtube.com/c/KursySQL
    https://github.com/kursysql/kursysql-live

    Jeśli Twoja baza ma inną nazwę, zmień polecenie USE.
*/

USE AdventureWorks2025;
GO

/* ============================================================
   ZADANIE 1 – Produkty czarne
   ============================================================

Wyświetl kolumny:
- ProductID,
- Name,
- Color,
- ListPrice

dla produktów koloru Black.

Posortuj wynik malejąco według ceny.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color = 'Black'
ORDER BY ListPrice DESC;
GO

/* ============================================================
   ZADANIE 2 – Produkty w dwóch kolorach
   ============================================================

Wyświetl produkty koloru Red lub Silver.

Pokaż:
- ProductID,
- Name,
- Color,
- ListPrice.

Posortuj wynik najpierw według koloru, a następnie według nazwy.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IN ('Red', 'Silver')
ORDER BY Color, Name;
GO

/* ============================================================
   ZADANIE 3 – Najdroższe produkty
   ============================================================

Wyświetl 10 najdroższych produktów.

Pokaż:
- ProductID,
- Name,
- ListPrice.

Posortuj wynik od najdroższego produktu.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT TOP (10) ProductID, Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;
GO

/* ============================================================
   ZADANIE 4 – Produkty z nazwą Road
   ============================================================

Znajdź produkty, których nazwa zawiera słowo Road.

Pokaż:
- ProductID,
- Name,
- Color,
- ListPrice.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Name LIKE '%Road%';
GO

/* ============================================================
   ZADANIE 5 – Cena z przedziału
   ============================================================

Wyświetl produkty, których cena mieści się w przedziale
od 500 do 1000.

Pokaż:
- ProductID,
- Name,
- ListPrice.

Posortuj rosnąco według ceny.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE ListPrice BETWEEN 500 AND 1000
ORDER BY ListPrice;
GO

/* ============================================================
   ZADANIE 6 – Produkty bez określonego koloru
   ============================================================

Wyświetl produkty, dla których nie określono koloru.

Pokaż:
- ProductID,
- Name,
- Color,
- ListPrice.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NULL;
GO

/* ============================================================
   ZADANIE 7 – Kilka warunków
   ============================================================

Wyświetl produkty:
- koloru Black lub Red,
- o cenie większej niż 1000.

Pokaż:
- ProductID,
- Name,
- Color,
- ListPrice.

Posortuj malejąco według ceny.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IN ('Black', 'Red') AND ListPrice > 1000
ORDER BY ListPrice DESC;
GO

/* ============================================================
   ZADANIE 8 – Mountain + cena + kolor
   ============================================================

Znajdź produkty:
- których nazwa zawiera Mountain,
- które mają określony kolor,
- których cena jest większa niż 500.

Pokaż:
- ProductID,
- Name,
- Color,
- ListPrice.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Name LIKE '%Mountain%'
  AND Color IS NOT NULL
  AND ListPrice > 500;
GO

/* ============================================================
   ZADANIE 9 – Najnowsze zamówienia
   ============================================================

Wyświetl 5 najnowszych zamówień o statusie 5.

Pokaż:
- SalesOrderID,
- OrderDate,
- Status,
- SubTotal.

Tabela: Sales.SalesOrderHeader
*/

-- ROZWIĄZANIE

SELECT TOP (5) SalesOrderID, OrderDate, Status, SubTotal
FROM Sales.SalesOrderHeader
WHERE Status = 5
ORDER BY OrderDate DESC;
GO

/* ============================================================
   ZADANIE 10 – Większe zamówienia
   ============================================================

Wyświetl zamówienia, których SubTotal jest większy niż 10000.

Pokaż:
- SalesOrderID,
- OrderDate,
- CustomerID,
- SubTotal.

Posortuj od największej wartości SubTotal.

Tabela: Sales.SalesOrderHeader
*/

-- ROZWIĄZANIE

SELECT SalesOrderID, OrderDate, CustomerID, SubTotal
FROM Sales.SalesOrderHeader
WHERE SubTotal > 10000
ORDER BY SubTotal DESC;
GO

/* ============================================================
   ZADANIE 11 – Czas realizacji zamówienia
   ============================================================

Dla zamówień pokaż:
- SalesOrderID,
- OrderDate,
- ShipDate,
- liczbę dni pomiędzy OrderDate i ShipDate.

Nazwij obliczoną kolumnę DaysToShip.

Tabela: Sales.SalesOrderHeader
*/

-- ROZWIĄZANIE

SELECT SalesOrderID, OrderDate, ShipDate,
       DATEDIFF(day, OrderDate, ShipDate) AS DaysToShip
FROM Sales.SalesOrderHeader;
GO

/* ============================================================
   ZADANIE 12 – Nazwy produktów wielkimi literami
   ============================================================

Wyświetl:
- ProductID,
- Name,
- nazwę produktu zapisaną wielkimi literami.

Nazwij obliczoną kolumnę ProductNameUpper.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT ProductID, Name,
       UPPER(Name) AS ProductNameUpper
FROM Production.Product;
GO

/* ============================================================
   ZADANIE 13 – Ile mamy produktów?
   ============================================================

Policz liczbę wszystkich produktów.

Nazwij wynik ProductsCount.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT COUNT(*) AS ProductsCount
FROM Production.Product;
GO

/* ============================================================
   ZADANIE 14 – Liczba produktów według koloru
   ============================================================

Wyświetl:
- Color,
- liczbę produktów dla każdego koloru.

Nazwij obliczoną kolumnę ProductsCount.

Posortuj wynik malejąco według liczby produktów.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT Color, COUNT(*) AS ProductsCount
FROM Production.Product
GROUP BY Color
ORDER BY ProductsCount DESC;
GO

/* ============================================================
   ZADANIE 15 – Średnia cena według koloru
   ============================================================

Wyświetl:
- Color,
- średnią wartość ListPrice dla każdego koloru.

Nazwij obliczoną kolumnę AvgListPrice.

Posortuj wynik malejąco według średniej ceny.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT Color, AVG(ListPrice) AS AvgListPrice
FROM Production.Product
GROUP BY Color
ORDER BY AvgListPrice DESC;
GO

/* ============================================================
   ZADANIE 16 – Tylko liczniejsze grupy
   ============================================================

Wyświetl tylko takie kolory, dla których istnieje
co najmniej 10 produktów.

Pokaż:
- Color,
- liczbę produktów.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT Color, COUNT(*) AS ProductsCount
FROM Production.Product
GROUP BY Color
HAVING COUNT(*) >= 10
ORDER BY ProductsCount DESC;
GO

/* ============================================================
   ZADANIE 17 – Pierwszy JOIN
   ============================================================

Połącz informacje o pozycjach zamówień z nazwami produktów.

Wyświetl:
- SalesOrderID,
- ProductID,
- Name produktu,
- OrderQty,
- LineTotal.

Tabele:
- Sales.SalesOrderDetail,
- Production.Product
*/

-- ROZWIĄZANIE

SELECT sod.SalesOrderID,
       sod.ProductID,
       p.Name AS ProductName,
       sod.OrderQty,
       sod.LineTotal
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p ON sod.ProductID = p.ProductID;
GO

/* ============================================================
   ZADANIE 18 – JOIN + filtrowanie
   ============================================================

Na podstawie poprzedniego zadania pokaż tylko te pozycje zamówień,
dla których nazwa produktu zawiera Mountain.

Wyświetl:
- SalesOrderID,
- Name produktu,
- OrderQty,
- LineTotal.

Tabele:
- Sales.SalesOrderDetail,
- Production.Product
*/

-- ROZWIĄZANIE

SELECT sod.SalesOrderID,
       p.Name AS ProductName,
       sod.OrderQty,
       sod.LineTotal
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p
  ON sod.ProductID = p.ProductID
WHERE p.Name LIKE '%Mountain%';
GO

/* ============================================================
   ZADANIE 19 – Ile sztuk sprzedano?
   ============================================================

Pokaż łączną liczbę sprzedanych sztuk dla każdego produktu.

Wyświetl:
- nazwę produktu,
- łączną liczbę sprzedanych sztuk.

Posortuj wynik malejąco według liczby sprzedanych sztuk.

Tabele:
- Sales.SalesOrderDetail,
- Production.Product
*/

-- ROZWIĄZANIE

SELECT p.Name AS ProductName,
       SUM(sod.OrderQty) AS QuantitySold
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p
  ON sod.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY QuantitySold DESC;
GO

/* ============================================================
   ZADANIE 20 – GitHub Copilot / AI
   ============================================================

Spróbuj najpierw rozwiązać zadanie z pomocą GitHub Copilot.

Treść:
Pokaż 10 produktów sprzedanych w największej liczbie sztuk.

Wyświetl:
- nazwę produktu,
- łączną liczbę sprzedanych sztuk.

Posortuj wynik od najlepiej sprzedającego się produktu.

Po wygenerowaniu kodu sprawdź:
- czy wykorzystano właściwe tabele,
- czy JOIN jest poprawny,
- czy użyto SUM(OrderQty),
- czy GROUP BY jest poprawne,
- czy TOP (10) zwraca właściwe 10 produktów.
*/

-- ROZWIĄZANIE

SELECT TOP (10)
       p.Name AS ProductName,
       SUM(sod.OrderQty) AS QuantitySold
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p
  ON sod.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY QuantitySold DESC;
GO

/* ============================================================
   ZADANIE 21 – Nazwa podkategorii produktu
   ============================================================

Rozszerz zadanie 19 i pokaż dodatkowo nazwę podkategorii produktu.

Połącz trzy tabele:
- Sales.SalesOrderDetail,
- Production.Product,
- Production.ProductSubcategory.

Pokaż:
- nazwę produktu,
- nazwę podkategorii,
- łączną liczbę sprzedanych sztuk.

Posortuj wynik malejąco według liczby sprzedanych sztuk.
*/



-- ROZWIĄZANIE

SELECT p.Name AS ProductName,
       ps.Name AS ProductSubcategory,
       SUM(sod.OrderQty) AS QuantitySold
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p
  ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory AS ps
  ON p.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY p.ProductID, p.Name, ps.ProductSubcategoryID, ps.Name
ORDER BY QuantitySold DESC;
GO

