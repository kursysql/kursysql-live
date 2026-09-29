/*
    SQL140 LIVE – funkcje skalarne – rozwiązania
    Baza: AdventureWorks2025
    SQL Server 2025

    http://www.kursysql.pl
    http://www.youtube.com/c/KursySQL
    https://github.com/kursysql/kursysql-live

*/

USE AdventureWorks2025;
GO

/* ============================================================
   ZADANIE 1 – Aktualna data i czas
   ============================================================

    Wyświetl aktualną datę i czas serwera.
    Nie korzystaj z żadnej tabeli.
*/

-- ROZWIĄZANIE

SELECT GETDATE() AS CurrentDateTime;
GO

/* ============================================================
   ZADANIE 2 – Nazwy produktów wielkimi literami
   ============================================================

    Wyświetl:
    - ProductID,
    - Name

    Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT
    ProductID,
    Name,
    UPPER(Name)
FROM Production.Product;
GO

/* ============================================================
   ZADANIE 3 – Ile dni produkt jest w sprzedaży?
   ============================================================

    Dla każdego produktu wyświetl:
    - ProductID,
    - Name,
    - SellStartDate,
    - liczbę dni od SellStartDate do dzisiaj.

    Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT
    ProductID,
    Name,
    SellStartDate,
    DATEDIFF(DAY, SellStartDate, GETDATE()) 
FROM Production.Product;
GO

/* ============================================================
   ZADANIE 4 – Nazwy produktów małymi literami
   ============================================================

    Wyświetl:
    - ProductID,
    - Name,

    Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT
    ProductID,
    Name,
    LOWER(Name) 
FROM Production.Product;
GO

/* ============================================================
   ZADANIE 5 – Długość nazwy produktu
   ============================================================

    Wyświetl:
    - ProductID,
    - Name,
    - liczbę znaków w nazwie produktu.

    Posortuj wynik malejąco według długości nazwy.

    Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT
    ProductID,
    Name,
    LEN(Name) 
FROM Production.Product
ORDER BY LEN(Name) DESC;
GO

/* ============================================================
   ZADANIE 6 – Początek i koniec nazwy
   ============================================================

Wyświetl:
- ProductID,
- Name,
- pierwsze 10 znaków nazwy jako NameBeginning,
- ostatnie 5 znaków nazwy jako NameEnding.

Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT
    ProductID,
    Name,
    LEFT(Name, 10) AS NameBeginning,
    RIGHT(Name, 5) AS NameEnding
FROM Production.Product;
GO

/* ============================================================
   ZADANIE 7 – Fragment tekstu
   ============================================================

    Wyświetl:
    - ProductID,
    - Name,
    - fragment nazwy produktu zaczynający się od 2. znaku
      i zawierający 8 znaków.

    Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT
    ProductID,
    Name,
    SUBSTRING(Name, 2, 8) 
FROM Production.Product;
GO

/* ============================================================
   ZADANIE 8 – Zamiana znaków w numerze produktu
   ============================================================

    Wyświetl:
    - ProductID,
    - ProductNumber,
    - ProductNumber, w którym wszystkie znaki '-' zostaną
      zastąpione znakiem '/'.

    Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT
    ProductID,
    ProductNumber,
    REPLACE(ProductNumber, '-', '/') 
FROM Production.Product;
GO

/* ============================================================
   ZADANIE 9 – Pozycja znaku w tekście
   ============================================================

    Wyświetl:
    - ProductID,
    - ProductNumber,
    - pozycję pierwszego znaku '-' w ProductNumber.

    Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT
    ProductID,
    ProductNumber,
    CHARINDEX('-', ProductNumber) 
FROM Production.Product;
GO

/* ============================================================
   ZADANIE 10 – Usuwanie zbędnych spacji
   ============================================================

    Za pomocą funkcji tekstowej usuń spacje z początku
    i końca poniższego tekstu:

    '   SQL Server 2025   '

    Nie korzystaj z żadnej tabeli.
*/

-- ROZWIĄZANIE

SELECT TRIM('   SQL Server 2025   ')
GO

/* ============================================================
   ZADANIE 11 – Data przesunięta o 7 dni
   ============================================================

    Dla każdego zamówienia wyświetl:
    - SalesOrderID,
    - OrderDate,
    - datę przypadającą 7 dni po OrderDate.

    Tabela: Sales.SalesOrderHeader
*/

-- ROZWIĄZANIE

SELECT
    SalesOrderID,
    OrderDate,
    DATEADD(DAY, 7, OrderDate) 
FROM Sales.SalesOrderHeader;
GO

/* ============================================================
   ZADANIE 12 – Rok, miesiąc i dzień zamówienia
   ============================================================

    Dla każdego zamówienia wyświetl:
    - SalesOrderID,
    - OrderDate,
    - rok jako OrderYear,
    - miesiąc jako OrderMonth,
    - dzień miesiąca jako OrderDay.

    Tabela: Sales.SalesOrderHeader
*/

-- ROZWIĄZANIE

SELECT
    SalesOrderID,
    OrderDate,
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    DAY(OrderDate) AS OrderDay
FROM Sales.SalesOrderHeader;
GO

/* ============================================================
   ZADANIE 13 – Zaokrąglona cena po rabacie
   ============================================================

    Załóżmy rabat 12,5%.

    Dla każdego produktu wyświetl:
    - ProductID,
    - Name,
    - ListPrice,
    - cenę po rabacie 12,5%, zaokrągloną do 2 miejsc po przecinku.

    Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT
    ProductID,
    Name,
    ListPrice,
    ROUND(ListPrice * 0.875, 2)
FROM Production.Product;
GO

/* ============================================================
   ZADANIE 14 – Brak koloru jako tekst
   ============================================================

    Wyświetl:
    - ProductID,
    - Name,
    - Color.

    Jeżeli Color jest NULL, zamiast NULL wyświetl tekst '(brak)'.

    Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT
    ProductID,
    Name,
    Color,
    ISNULL(Color, '(brak)') 
FROM Production.Product;
GO

/* ============================================================
   ZADANIE 15 – Konkatenacja za pomocą CONCAT
   ============================================================

    Wyświetl osoby z tabeli Person.Person.

    Pokaż:
    - BusinessEntityID,
    - Title,
    - FirstName,
    - LastName,
    - tytuł, imię i nazwisko w jednej kolumnie rozdzielone spacją.

    Do połączenia tekstów użyj funkcji CONCAT().

    Nazwij wynik FullName.
*/

-- ROZWIĄZANIE

SELECT * FROM Person.Person;

SELECT
    BusinessEntityID,
    Title,
    FirstName,
    LastName,
    CONCAT(Title, FirstName, ' ', LastName) AS FullName
FROM Person.Person;
GO

/* ============================================================
   ZADANIE 16 – Konkatenacja za pomocą +
   ============================================================

    Wykonaj to samo zadanie co poprzednio, ale tym razem
    połącz Title, FirstName i LastName za pomocą operatora +.


*/

-- ROZWIĄZANIE

SELECT
    BusinessEntityID,
    Title,
    FirstName,
    LastName,
    Title + ' ' + FirstName + ' ' + LastName AS FullName
FROM Person.Person;
GO

/* ============================================================
   ZADANIE 17 – Konkatenacja za pomocą ||
   ============================================================

    Wykonaj to samo zadanie jeszcze raz, korzystając
    z operatora || dostępnego w SQL Server 2025.

*/

-- ROZWIĄZANIE

SELECT
    BusinessEntityID,
    Title,
    FirstName,
    LastName,
    Title || ' ' || FirstName || ' ' || LastName AS FullName
FROM Person.Person;
GO

/* ============================================================
   ZADANIE 18 – Konwersja daty
   ============================================================

    Wyświetl:
    - SalesOrderID,
    - OrderDate,
    - OrderDate przekonwertowaną do typu date, czyli bez części czasowej.

    Tabela: Sales.SalesOrderHeader
*/

-- ROZWIĄZANIE

SELECT
    SalesOrderID,
    OrderDate,
    CAST(OrderDate AS date) 
FROM Sales.SalesOrderHeader;
GO

/* ============================================================
   ZADANIE 19 – Prosty REGEX: poprawny e-mail
   ============================================================

    Wyświetl adresy e-mail, które pasują do prostego wzorca adresu e-mail:
    ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$

    Użyj funkcji REGEXP_LIKE().

    Pokaż:
    - BusinessEntityID,
    - EmailAddress.

    Tabela: Person.EmailAddress

    Uwaga: REGEXP_LIKE wymaga compatibility level 170.
*/

-- ROZWIĄZANIE

SELECT
    BusinessEntityID,
    EmailAddress
FROM Person.EmailAddress
WHERE REGEXP_LIKE(
    EmailAddress,
    '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
);
GO

/* ============================================================
   ZADANIE 20 – Prosty REGEX: oczyszczenie numeru produktu
   ============================================================

    Wyświetl:
    - ProductID,
    - ProductNumber,
    - ProductNumber po usunięciu wszystkich znaków innych niż litery i cyfry.
    - wzorzec do usunięcia znaków: [^A-Za-z0-9]

    Użyj funkcji REGEXP_REPLACE().

    Nazwij obliczoną kolumnę CleanProductNumber.

    Tabela: Production.Product
*/

-- ROZWIĄZANIE

SELECT
    ProductID,
    ProductNumber,
    REGEXP_REPLACE(ProductNumber, '[^A-Za-z0-9]', '') AS CleanProductNumber
FROM Production.Product;
GO

