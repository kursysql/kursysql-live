/*
    SQL LIVE – wspólne rozwiązywanie zadań

    http://www.kursysql.pl
    http://www.youtube.com/c/KursySQL
    https://github.com/kursysql/kursysql-live

    Baza: AdventureWorks2025 (pełna wersja)
    Jeśli Twoja baza ma inną nazwę, zmień polecenie USE.
*/

USE AdventureWorks2025;
GO

/* ============================================================
   INTRO - diagram bazy
   ============================================================

Utwórz diagram bazy zawierający tabele:
- Production.Product
- Production.ProductSubcategory
- Production.ProductCategory
- Sales.SalesOrderHeader
- Sales.SalesOrderDetail

*/



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

/* ============================================================
   ZADANIE 13 – Ile mamy produktów?
   ============================================================

Policz liczbę wszystkich produktów.

Nazwij wynik ProductsCount.

Tabela: Production.Product
*/

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


