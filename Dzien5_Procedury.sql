
USE Filmy
GO

SELECT * FROM Film

SELECT * FROM Rezyser
GO

/*
    Procedura dodająca nowy gatunek filmu
*/
CREATE OR ALTER PROCEDURE DodajGatunek
@Gatunek nvarchar(100)
AS
--SET NOCOUNT ON

	IF EXISTS(SELECT * FROM Gatunek WHERE Gatunek = @Gatunek)
	BEGIN
		RAISERROR('Jest juz taki gatunek!', 11, 1)
		RETURN -1
	END

		INSERT INTO Gatunek (Gatunek) VALUES (@Gatunek)

		SELECT SCOPE_IDENTITY() AS GatunekID

GO









/*
    Procedura dodająca nowego reżysera
*/
CREATE OR ALTER  PROCEDURE DodajRezysera
  @Imie nvarchar(100),
  @Nazwisko nvarchar(100),
  @KrajID int,
  @DataUrodzenia date
AS
BEGIN
	
	SET NOCOUNT ON
	DECLARE @OsobaID int

	-- -- walidacja -- tego sprawdzać nie będziemy (na potrzeby kolejnego zadania)
	-- IF NOT EXISTS(SELECT * FROM Kraj WHERE KrajID = @KrajID)
	-- BEGIN
	-- 	RAISERROR('Bledny KrajID!', 11, 1)
	-- 	RETURN -1
	-- END

	IF EXISTS(
		SELECT * FROM Osoba AS o JOIN Rezyser AS r  ON r.OsobaID = o.OsobaID
		WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
	BEGIN
	  RAISERROR('Jest juz taki rezyser!', 11, 1)
	  RETURN -1
	END
		--A/ mam juz jego dane osobowe -> aktualizuje i dodaje do rezyserow
		--B/ nie ma jeszcze takiej osoby w bazie

	IF EXISTS(SELECT * FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
	BEGIN
		PRINT 'mam juz jego dane osobowe -> aktualizuje i dodaje do rezyserow'
		SELECT @OsobaID = OsobaID FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie

		UPDATE Osoba SET KrajID = @KrajID, DataUrodzenia = @DataUrodzenia
		WHERE OsobaID = @OsobaID

		INSERT INTO Rezyser (OsobaID) VALUES (@OsobaID) -- powtórzenie
		SELECT SCOPE_IDENTITY() AS RezyserID
	END
	ELSE 
	BEGIN
		PRINT 'nie ma jeszcze takiej osoby w bazie'

		INSERT INTO Osoba (Imie, Nazwisko, KrajID, DataUrodzenia)
		VALUES (@Imie, @Nazwisko, @KrajID, @DataUrodzenia)

		SELECT @OsobaID = SCOPE_IDENTITY()

		INSERT INTO Rezyser (OsobaID) VALUES (@OsobaID)  -- powtórzenie
		SELECT SCOPE_IDENTITY() AS RezyserID
	END

END
GO






/*
    Procedura kasująca film (przyjmuje tylko parametr FilmID)
*/
CREATE OR ALTER  PROCEDURE KasujFilm 
  @FilmID int
AS
BEGIN

	SET NOCOUNT ON

	-- walidacja
	IF NOT EXISTS(SELECT * FROM Film WHERE FilmID = @FilmID)
	BEGIN
	  RAISERROR('Niepoprawny FilmID', 11, 1)
	  RETURN
	END

	DELETE FROM FilmAktor WHERE FilmID = @FilmID

	DELETE FROM Film WHERE FilmID = @FilmID


END
GO





CREATE OR ALTER  PROCEDURE KasujRezysera
  @RezyserID int
AS
BEGIN

	DECLARE @OsobaID int

	-- walidacja
	IF NOT EXISTS(SELECT * FROM Rezyser WHERE RezyserID = @RezyserID)
	BEGIN
	  RAISERROR('Niepoprawny RezyserID', 11, 1)
	  RETURN
	END

	IF EXISTS(SELECT * FROM Film WHERE RezyseriaID = @RezyserID)
	BEGIN
	  RAISERROR('Nie mozna skasowac - przypisany do filmu', 11, 1)
	  RETURN
	END

	SELECT @OsobaID = OsobaID FROM Rezyser WHERE RezyserID = @RezyserID

	DELETE FROM Rezyser WHERE RezyserID = @RezyserID

	-- skasuj dane osobowe pod warunkiem, ze ta osoba nie jest jednoczesnie aktorem
	IF NOT EXISTS(SELECT * FROM Aktor WHERE OsobaID = @OsobaID )
	  DELETE FROM Osoba WHERE OsobaID = @OsobaID


END
GO








/*
    Obsługa błędów
*/




EXEC DodajRezysera @Imie = 'Lana', @Nazwisko = 'Wachowski', @KrajID = 1, @DataUrodzenia = '19650621'

EXEC KasujRezysera @RezyserID = 12

SELECT * FROM Osoba
SELECT * FROM Rezyser



EXEC DodajRezysera @Imie = 'Lana', @Nazwisko = 'Wachowski', @KrajID = 111, @DataUrodzenia = '19650621'

SELECT * FROM Osoba
SELECT * FROM Rezyser -- !!!


EXEC KasujRezysera @RezyserID = 12

DELETE FROM Rezyser WHERE OsobaID IS NULL
GO







/*
    Procedura dodająca nowego reżysera - z obsługą TRY-CATCH
*/
CREATE OR ALTER  PROCEDURE DodajRezysera2
  @Imie nvarchar(100),
  @Nazwisko nvarchar(100),
  @KrajID int,
  @DataUrodzenia date
AS
BEGIN
	
	SET NOCOUNT ON
	DECLARE @OsobaID int

	-- -- walidacja -- tego sprawdzać nie będziemy (na potrzeby kolejnego zadania)
	-- IF NOT EXISTS(SELECT * FROM Kraj WHERE KrajID = @KrajID)
	-- BEGIN
	-- 	RAISERROR('Bledny KrajID!', 11, 1)
	-- 	RETURN -1
	-- END

	IF EXISTS(
		SELECT * FROM Osoba AS o JOIN Rezyser AS r  ON r.OsobaID = o.OsobaID
		WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
	BEGIN
	  RAISERROR('Jest juz taki rezyser!', 11, 1)
	  RETURN -1
	END

	
    BEGIN TRY -- !!!


            --A/ mam juz jego dane osobowe -> aktualizuje i dodaje do rezyserow
            --B/ nie ma jeszcze takiej osoby w bazie

        IF EXISTS(SELECT * FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
        BEGIN
            PRINT 'mam juz jego dane osobowe -> aktualizuje i dodaje do rezyserow'
            SELECT @OsobaID = OsobaID FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie

            UPDATE Osoba SET KrajID = @KrajID, DataUrodzenia = @DataUrodzenia
            WHERE OsobaID = @OsobaID

            INSERT INTO Rezyser (OsobaID) VALUES (@OsobaID) -- powtórzenie
            SELECT SCOPE_IDENTITY() AS RezyserID
        END
        ELSE 
        BEGIN
            PRINT 'nie ma jeszcze takiej osoby w bazie'

            INSERT INTO Osoba (Imie, Nazwisko, KrajID, DataUrodzenia)
            VALUES (@Imie, @Nazwisko, @KrajID, @DataUrodzenia)

            SELECT @OsobaID = SCOPE_IDENTITY()

            INSERT INTO Rezyser (OsobaID) VALUES (@OsobaID)  -- powtórzenie
            SELECT SCOPE_IDENTITY() AS RezyserID
        END

	-- !!! stop
	END TRY
	BEGIN CATCH
        -- THROW
		RETURN -1
        
	END CATCH
	-- !!! end

END
GO





EXEC DodajRezysera2 @Imie = 'Lana', @Nazwisko = 'Wachowski', @KrajID = 111, @DataUrodzenia = '19650621'

SELECT * FROM Osoba
SELECT * FROM Rezyser -- !!!
GO






/*
    Obsługa transakcji
*/




/*
    Procedura dodająca nowego reżysera - z błędną instrukcją wstawiającą dane do Osoba
*/
CREATE OR ALTER  PROCEDURE DodajRezysera3
  @Imie nvarchar(100),
  @Nazwisko nvarchar(100),
  @KrajID int,
  @DataUrodzenia date
AS
BEGIN
	
	SET NOCOUNT ON
	DECLARE @OsobaID int

	-- -- walidacja -- tego sprawdzać nie będziemy (na potrzeby kolejnego zadania)
	-- IF NOT EXISTS(SELECT * FROM Kraj WHERE KrajID = @KrajID)
	-- BEGIN
	-- 	RAISERROR('Bledny KrajID!', 11, 1)
	-- 	RETURN -1
	-- END

	IF EXISTS(
		SELECT * FROM Osoba AS o JOIN Rezyser AS r  ON r.OsobaID = o.OsobaID
		WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
	BEGIN
	  RAISERROR('Jest juz taki rezyser!', 11, 1)
	  RETURN -1
	END

	
    BEGIN TRY -- !!!


            --A/ mam juz jego dane osobowe -> aktualizuje i dodaje do rezyserow
            --B/ nie ma jeszcze takiej osoby w bazie

        IF EXISTS(SELECT * FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
        BEGIN
            PRINT 'mam juz jego dane osobowe -> aktualizuje i dodaje do rezyserow'
            SELECT @OsobaID = OsobaID FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie

            UPDATE Osoba SET KrajID = @KrajID, DataUrodzenia = @DataUrodzenia
            WHERE OsobaID = @OsobaID

            INSERT INTO Rezyser (OsobaID) VALUES ('aaa') -- OsobaID vs 'aaa'
            SELECT SCOPE_IDENTITY() AS RezyserID
        END
        ELSE 
        BEGIN
            PRINT 'nie ma jeszcze takiej osoby w bazie'

            INSERT INTO Osoba (Imie, Nazwisko, KrajID, DataUrodzenia)
            VALUES (@Imie, @Nazwisko, @KrajID, @DataUrodzenia)

            SELECT @OsobaID = SCOPE_IDENTITY()

            INSERT INTO Rezyser (OsobaID) VALUES ('aaaaa')  -- OsobaID vs 'aaa'
            SELECT SCOPE_IDENTITY() AS RezyserID
        END

	-- !!! stop
	END TRY
	BEGIN CATCH
        THROW
		RETURN -1
        
	END CATCH
	-- !!! end

END
GO




EXEC DodajRezysera3 @Imie = 'Lana', @Nazwisko = 'Wachowski', @KrajID = 1, @DataUrodzenia = '19650621'

SELECT * FROM Osoba  -- !!!
SELECT * FROM Rezyser
GO


DELETE FROM Osoba WHERE Imie = 'Lana'
GO







/*
    Procedura dodająca nowego reżysera - z obsługą transakcji
*/
CREATE OR ALTER  PROCEDURE DodajRezysera3
  @Imie nvarchar(100),
  @Nazwisko nvarchar(100),
  @KrajID int,
  @DataUrodzenia date
AS
BEGIN
	
	SET NOCOUNT ON
	DECLARE @OsobaID int

	-- -- walidacja -- tego sprawdzać nie będziemy (na potrzeby kolejnego zadania)
	-- IF NOT EXISTS(SELECT * FROM Kraj WHERE KrajID = @KrajID)
	-- BEGIN
	-- 	RAISERROR('Bledny KrajID!', 11, 1)
	-- 	RETURN -1
	-- END

	IF EXISTS(
		SELECT * FROM Osoba AS o JOIN Rezyser AS r  ON r.OsobaID = o.OsobaID
		WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
	BEGIN
	  RAISERROR('Jest juz taki rezyser!', 11, 1)
	  RETURN -1
	END


    BEGIN TRY -- !!!
    BEGIN TRANSACTION -- !!!!

        --A/ mam juz jego dane osobowe -> aktualizuje i dodaje do rezyserow
        --B/ nie ma jeszcze takiej osoby w bazie

        IF EXISTS(SELECT * FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
        BEGIN
            PRINT 'mam juz jego dane osobowe -> aktualizuje i dodaje do rezyserow'
            SELECT @OsobaID = OsobaID FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie

            UPDATE Osoba SET KrajID = @KrajID, DataUrodzenia = @DataUrodzenia
            WHERE OsobaID = @OsobaID

            INSERT INTO Rezyser (OsobaID) VALUES ('aaa') -- OsobaID vs 'aaa'
            SELECT SCOPE_IDENTITY() AS RezyserID
        END
        ELSE 
        BEGIN
            PRINT 'nie ma jeszcze takiej osoby w bazie'

            INSERT INTO Osoba (Imie, Nazwisko, KrajID, DataUrodzenia)
            VALUES (@Imie, @Nazwisko, @KrajID, @DataUrodzenia)

            SELECT @OsobaID = SCOPE_IDENTITY()

            INSERT INTO Rezyser (OsobaID) VALUES ('aaaaa')  -- OsobaID vs 'aaa'
            SELECT SCOPE_IDENTITY() AS RezyserID
        END


    COMMIT

	-- !!! stop
	END TRY
	BEGIN CATCH
        THROW
        ROLLBACK -- !!!
		RETURN -1
        
	END CATCH
	-- !!! end

END
GO





EXEC DodajRezysera3 @Imie = 'Lana', @Nazwisko = 'Wachowski', @KrajID = 1, @DataUrodzenia = '19650621'

SELECT * FROM Osoba  -- !!!
SELECT * FROM Rezyser
GO






-- zapis informacji o błędach


CREATE TABLE BledyLog (
	ID int identity NOT NULL PRIMARY KEY,
	ErrNumber int NULL,
	ErrSeverity int NULL,
	ErrState int NULL,
	ErrProcedure nvarchar(128) NULL,
	ErrLine int NULL,
	ErrMessage nvarchar(4000) NULL,
	DataDodania datetime CONSTRAINT DF_BledyLog_DataDodania DEFAULT (GETDATE())
)
GO



CREATE PROCEDURE ZapiszBlad
AS
BEGIN

	INSERT INTO dbo.BledyLog 
		(ErrNumber, ErrSeverity, ErrState, ErrProcedure, ErrLine, ErrMessage)
	SELECT ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), 
		ERROR_PROCEDURE(), ERROR_LINE(), ERROR_MESSAGE()


END
GO

EXEC ZapiszBlad

SELECT * FROM BledyLog
GO







/*
    Procedura dodająca nowego reżysera - z obsługą transakcji i logowaniem błędów
*/
CREATE OR ALTER  PROCEDURE DodajRezysera4
  @Imie nvarchar(100),
  @Nazwisko nvarchar(100),
  @KrajID int,
  @DataUrodzenia date
AS
BEGIN
	
	SET NOCOUNT ON
	DECLARE @OsobaID int

	-- -- walidacja -- tego sprawdzać nie będziemy (na potrzeby kolejnego zadania)
	-- IF NOT EXISTS(SELECT * FROM Kraj WHERE KrajID = @KrajID)
	-- BEGIN
	-- 	RAISERROR('Bledny KrajID!', 11, 1)
	-- 	RETURN -1
	-- END

	IF EXISTS(
		SELECT * FROM Osoba AS o JOIN Rezyser AS r  ON r.OsobaID = o.OsobaID
		WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
	BEGIN
	  RAISERROR('Jest juz taki rezyser!', 11, 1)
	  RETURN -1
	END


    BEGIN TRY -- !!!
    BEGIN TRANSACTION -- !!!!

        --A/ mam juz jego dane osobowe -> aktualizuje i dodaje do rezyserow
        --B/ nie ma jeszcze takiej osoby w bazie

        IF EXISTS(SELECT * FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
        BEGIN
            PRINT 'mam juz jego dane osobowe -> aktualizuje i dodaje do rezyserow'
            SELECT @OsobaID = OsobaID FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie

            UPDATE Osoba SET KrajID = @KrajID, DataUrodzenia = @DataUrodzenia
            WHERE OsobaID = @OsobaID

            INSERT INTO Rezyser (OsobaID) VALUES ('aaa') -- OsobaID vs 'aaa'
            SELECT SCOPE_IDENTITY() AS RezyserID
        END
        ELSE 
        BEGIN
            PRINT 'nie ma jeszcze takiej osoby w bazie'

            INSERT INTO Osoba (Imie, Nazwisko, KrajID, DataUrodzenia)
            VALUES (@Imie, @Nazwisko, @KrajID, @DataUrodzenia)

            SELECT @OsobaID = SCOPE_IDENTITY()

            INSERT INTO Rezyser (OsobaID) VALUES ('aaaaa')  -- OsobaID vs 'aaa'
            SELECT SCOPE_IDENTITY() AS RezyserID
        END


    COMMIT

	-- !!! stop
	END TRY
	BEGIN CATCH
        ROLLBACK
        EXEC ZapiszBlad;  -- !!!
        THROW
		RETURN -1
      
	END CATCH
	-- !!! end

END
GO





EXEC DodajRezysera4 @Imie = 'Lana', @Nazwisko = 'Wachowski', @KrajID = 1, @DataUrodzenia = '19650621'

SELECT * FROM Osoba  -- !!!
SELECT * FROM Rezyser
GO

SELECT *FROM BledyLog
GO







-- tabele tymczasowe

