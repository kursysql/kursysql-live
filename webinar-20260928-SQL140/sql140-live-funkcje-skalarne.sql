/*
    SQL140 LIVE – funkcje skalarne
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

/* ============================================================
   ZADANIE 2 – Nazwy produktów wielkimi literami
   ============================================================

    Wyświetl:
    - ProductID,
    - Name

    Tabela: Production.Product
*/

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

/* ============================================================
   ZADANIE 4 – Nazwy produktów małymi literami
   ============================================================

    Wyświetl:
    - ProductID,
    - Name

    Tabela: Production.Product
*/

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

/* ============================================================
   ZADANIE 9 – Pozycja znaku w tekście
   ============================================================

    Wyświetl:
    - ProductID,
    - ProductNumber,
    - pozycję pierwszego znaku '-' w ProductNumber.

    Tabela: Production.Product
*/

/* ============================================================
   ZADANIE 10 – Usuwanie zbędnych spacji
   ============================================================

    Za pomocą funkcji tekstowej usuń spacje z początku
    i końca poniższego tekstu:

    '   SQL Server 2025   '

    Nie korzystaj z żadnej tabeli.
*/

/* ============================================================
   ZADANIE 11 – Data przesunięta o 7 dni
   ============================================================

    Dla każdego zamówienia wyświetl:
    - SalesOrderID,
    - OrderDate,
    - datę przypadającą 7 dni po OrderDate.

    Tabela: Sales.SalesOrderHeader
*/

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

/* ============================================================
   ZADANIE 16 – Konkatenacja za pomocą +
   ============================================================

    Wykonaj to samo zadanie co poprzednio, ale tym razem
    połącz Title, FirstName i LastName za pomocą operatora +.

*/

/* ============================================================
   ZADANIE 17 – Konkatenacja za pomocą ||
   ============================================================

    Wykonaj to samo zadanie jeszcze raz, korzystając
    z operatora || dostępnego w SQL Server 2025.
*/

/* ============================================================
   ZADANIE 18 – Konwersja daty
   ============================================================

    Wyświetl:
    - SalesOrderID,
    - OrderDate,
    - OrderDate przekonwertowaną do typu date, czyli bez części czasowej.

    Tabela: Sales.SalesOrderHeader
*/

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

