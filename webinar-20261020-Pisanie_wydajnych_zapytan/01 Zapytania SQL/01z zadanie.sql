/*

    Pisanie wydajnych zapytań - szkolenie hybrydowe
    Spotkanie 1 - Zapytania SQL
    z/ zadania

    Tomasz Libera | MVP Data Platform
    libera@kursysql.pl

    http://www.kursysql.pl
    http://www.youtube.com/c/KursySQL

*/

USE StackOverflowMini;
GO


-- 1. Wyświetl nazwę użytkownika, reputację i lokalizację użytkowników,
-- którzy mają więcej niż 5000 punktów reputacji.
-- Wyniki posortuj malejąco według reputacji.


-- 2. Wyświetl 20 użytkowników o najwyższej reputacji.
-- Pokaż kolumny: Id, DisplayName, Reputation, Location.


-- 3. Wyświetl wszystkie różne lokalizacje użytkowników.
-- Pomiń wartości NULL i posortuj wynik alfabetycznie.


-- 4. Wyświetl użytkowników, którzy utworzyli konto w pierwszym kwartale 2009 roku.
-- Pokaż kolumny: Id, DisplayName, CreationDate.
-- Wyniki posortuj rosnąco według daty utworzenia konta.


-- 5. Wyświetl użytkowników, którzy mają od 1000 do 5000 punktów reputacji
-- oraz w polu Location mają tekst "Poland".
-- Wyniki posortuj malejąco według reputacji.


-- 6. Wyświetl pierwszych 20 użytkowników, których DisplayName zaczyna się na literę A
-- i którzy mają podaną lokalizację.
-- Wyniki posortuj alfabetycznie według DisplayName.


-- 7. Wyświetl 20 najczęściej oglądanych postów, które mają tytuł.
-- Pokaż kolumny: Id, Title, ViewCount, Score.


-- 8. Wyświetl posty, których tytuł zawiera tekst "SQL" i które mają co najmniej 5 punktów Score.
-- Pokaż kolumny: Id, Title, Score, ViewCount.
-- Wyniki posortuj malejąco według Score, a następnie ViewCount.


-- 9. Wyświetl posty utworzone w drugiej połowie 2009 roku,
-- których tytuł zawiera tekst "database".
-- Pokaż kolumny: Id, Title, CreationDate, Score, ViewCount.
-- Wyniki posortuj malejąco według CreationDate.


-- 10. Wyświetl 25 postów, które:
--     - mają tytuł,
--     - mają Score od 10 do 50,
--     - mają co najmniej 1000 wyświetleń,
--     - a w tytule zawierają "SQL" lub "database".
-- Pokaż kolumny: Id, Title, Score, ViewCount, CreationDate.
-- Wyniki posortuj malejąco według ViewCount, a następnie Score.
