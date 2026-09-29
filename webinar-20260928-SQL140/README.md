# SQL140 LIVE - wspólne rozwiązywanie zadań

Materiały do bezpłatnego spotkania LIVE będącego uzupełnieniem szkolenia **SQL140 – SQL od zera z AI, GitHub i Microsoft Fabric**.


## Spis treści

### 1. Podstawy SQL

- [Zadania – podstawy SQL](./sql140-live-podstawysql.sql)
- [Rozwiązania – podstawy SQL](./sql140-live-podstawysql-rozwiazanie.sql)


### 2. Funkcje skalarne

- [Zadania – funkcje skalarne](./sql140-live-funkcje-skalarne.sql)
- [Rozwiązania – funkcje skalarne](./sql140-live-funkcje-skalarne_rozwiazania.sql)

Zakres obejmuje funkcje tekstowe, daty i czasu, liczbowe, konwersję typów, obsługę wartości `NULL`, konkatenację oraz proste wyrażenia regularne.

---

# Dokumentacja funkcji użytych w zadaniach

## Data i czas

| Funkcja | Zastosowanie | Dokumentacja |
|---|---|---|
| `GETDATE()` | Aktualna data i czas systemowy | [Microsoft Learn – GETDATE](https://learn.microsoft.com/en-us/sql/t-sql/functions/getdate-transact-sql?view=sql-server-ver17) |
| `DATEDIFF()` | Różnica pomiędzy dwiema datami | [Microsoft Learn – DATEDIFF](https://learn.microsoft.com/en-us/sql/t-sql/functions/datediff-transact-sql?view=sql-server-ver17) |
| `DATEADD()` | Dodawanie określonego przedziału czasu do daty | [Microsoft Learn – DATEADD](https://learn.microsoft.com/en-us/sql/t-sql/functions/dateadd-transact-sql?view=sql-server-ver17) |
| `YEAR()` | Pobranie roku z daty | [Microsoft Learn – YEAR](https://learn.microsoft.com/en-us/sql/t-sql/functions/year-transact-sql?view=sql-server-ver17) |
| `MONTH()` | Pobranie miesiąca z daty | [Microsoft Learn – MONTH](https://learn.microsoft.com/en-us/sql/t-sql/functions/month-transact-sql?view=sql-server-ver17) |
| `DAY()` | Pobranie dnia miesiąca z daty | [Microsoft Learn – DAY](https://learn.microsoft.com/en-us/sql/t-sql/functions/day-transact-sql?view=sql-server-ver17) |

Pełne zestawienie funkcji daty i czasu:  
[Date and Time Data Types and Functions – Microsoft Learn](https://learn.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-ver17)

---

## Funkcje tekstowe

| Funkcja | Zastosowanie | Dokumentacja |
|---|---|---|
| `UPPER()` | Zamiana tekstu na wielkie litery | [Microsoft Learn – UPPER](https://learn.microsoft.com/en-us/sql/t-sql/functions/upper-transact-sql?view=sql-server-ver17) |
| `LOWER()` | Zamiana tekstu na małe litery | [Microsoft Learn – LOWER](https://learn.microsoft.com/en-us/sql/t-sql/functions/lower-transact-sql?view=sql-server-ver17) |
| `LEN()` | Liczba znaków w tekście | [Microsoft Learn – LEN](https://learn.microsoft.com/en-us/sql/t-sql/functions/len-transact-sql?view=sql-server-ver17) |
| `LEFT()` | Pobranie znaków z początku tekstu | [Microsoft Learn – LEFT](https://learn.microsoft.com/en-us/sql/t-sql/functions/left-transact-sql?view=sql-server-ver17) |
| `RIGHT()` | Pobranie znaków z końca tekstu | [Microsoft Learn – RIGHT](https://learn.microsoft.com/en-us/sql/t-sql/functions/right-transact-sql?view=sql-server-ver17) |
| `SUBSTRING()` | Pobranie fragmentu tekstu | [Microsoft Learn – SUBSTRING](https://learn.microsoft.com/en-us/sql/t-sql/functions/substring-transact-sql?view=sql-server-ver17) |
| `REPLACE()` | Zamiana fragmentów tekstu | [Microsoft Learn – REPLACE](https://learn.microsoft.com/en-us/sql/t-sql/functions/replace-transact-sql?view=sql-server-ver17) |
| `CHARINDEX()` | Wyszukanie pozycji fragmentu tekstu | [Microsoft Learn – CHARINDEX](https://learn.microsoft.com/en-us/sql/t-sql/functions/charindex-transact-sql?view=sql-server-ver17) |
| `TRIM()` | Usunięcie zbędnych znaków z początku i końca tekstu | [Microsoft Learn – TRIM](https://learn.microsoft.com/en-us/sql/t-sql/functions/trim-transact-sql?view=sql-server-ver17) |
| `CONCAT()` | Łączenie kilku wartości w jeden tekst | [Microsoft Learn – CONCAT](https://learn.microsoft.com/en-us/sql/t-sql/functions/concat-transact-sql?view=sql-server-ver17) |

---

## Funkcje liczbowe i obsługa `NULL`

| Funkcja | Zastosowanie | Dokumentacja |
|---|---|---|
| `ROUND()` | Zaokrąglanie wartości liczbowych | [Microsoft Learn – ROUND](https://learn.microsoft.com/en-us/sql/t-sql/functions/round-transact-sql?view=sql-server-ver17) |
| `ISNULL()` | Zastępowanie wartości `NULL` inną wartością | [Microsoft Learn – ISNULL](https://learn.microsoft.com/en-us/sql/t-sql/functions/isnull-transact-sql?view=sql-server-ver17) |

---

## Konwersja typów

| Funkcja | Zastosowanie | Dokumentacja |
|---|---|---|
| `CAST()` | Jawna konwersja wartości do innego typu danych | [Microsoft Learn – CAST and CONVERT](https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver17) |

---

## Konkatenacja tekstu

W zadaniach pokazane są trzy sposoby łączenia tekstów:

### `CONCAT()`

```sql
CONCAT(FirstName, ' ', LastName)
```

[Dokumentacja CONCAT](https://learn.microsoft.com/en-us/sql/t-sql/functions/concat-transact-sql?view=sql-server-ver17)

### Operator `+`

```sql
FirstName + ' ' + LastName
```

[Dokumentacja operatora +](https://learn.microsoft.com/en-us/sql/t-sql/language-elements/string-concatenation-transact-sql?view=sql-server-ver17)

### Operator `||`

```sql
FirstName || ' ' || LastName
```

Operator `||` jest dostępny w **SQL Server 2025 (17.x)** i jest zgodny ze standardem ANSI SQL.

[Dokumentacja operatora ||](https://learn.microsoft.com/en-us/sql/t-sql/language-elements/string-concatenation-pipes-transact-sql?view=sql-server-ver17)

---

## Wyrażenia regularne – REGEX

W zadaniach wykorzystujemy proste przykłady nowych możliwości SQL Server 2025.

### `REGEXP_LIKE()`

Sprawdza, czy tekst pasuje do podanego wzorca wyrażenia regularnego.

```sql
REGEXP_LIKE(EmailAddress, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
```

`REGEXP_LIKE()` wymaga **database compatibility level 170**.

[Microsoft Learn – REGEXP_LIKE](https://learn.microsoft.com/en-us/sql/t-sql/functions/regexp-like-transact-sql?view=sql-server-ver17)

### `REGEXP_REPLACE()`

Wyszukuje fragmenty tekstu pasujące do wzorca i zastępuje je innym tekstem.

```sql
REGEXP_REPLACE(ProductNumber, '[^A-Za-z0-9]', '')
```

[Microsoft Learn – REGEXP_REPLACE](https://learn.microsoft.com/en-us/sql/t-sql/functions/regexp-replace-transact-sql?view=sql-server-ver17)

---

## SQL Server 2025

Materiały są przygotowane z myślą o **SQL Server 2025**.

Dokumentacja najważniejszych nowości:

[What's new in SQL Server 2025 – Microsoft Learn](https://learn.microsoft.com/en-us/sql/sql-server/what-s-new-in-sql-server-2025?view=sql-server-ver17)

---

## KursySQL

Więcej materiałów:

- [KursySQL.pl](https://www.kursysql.pl/)
- [YouTube – KursySQL](https://www.youtube.com/c/KursySQL)
- [GitHub – KursySQL](https://github.com/kursysql)
