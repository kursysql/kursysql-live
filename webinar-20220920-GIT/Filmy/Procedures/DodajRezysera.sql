CREATE OR ALTER PROCEDURE DodajRezysera
  @Imie nvarchar(100),
  @Nazwisko nvarchar(100),
  @KrajID int,
  @DataUrodzenia date
AS
BEGIN
	
	SET NOCOUNT ON
	DECLARE @OsobaID int

	-- walidacja
	IF EXISTS(
		SELECT * FROM Osoba AS o JOIN Rezyser AS r  ON r.OsobaID = o.OsobaID
		WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
	BEGIN
	  RAISERROR('Jest juz taki rezyser!', 11, 1)
	  RETURN -1
	END

	BEGIN TRY -- !!!

		IF EXISTS(SELECT * FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie)
		BEGIN
			PRINT 'mam juz jego dane osobowe -> aktualizuje i dodaje do rezyserow'
			SELECT @OsobaID = OsobaID FROM Osoba WHERE Nazwisko = @Nazwisko AND Imie = @Imie

			UPDATE Osoba SET KrajID = @KrajID, DataUrodzenia = @DataUrodzenia
			WHERE OsobaID = @OsobaID

			INSERT INTO Rezyser (OsobaID) VALUES (@OsobaID)
			SELECT SCOPE_IDENTITY() AS RezyserID
		END
		ELSE 
		BEGIN
			PRINT 'nie ma jeszcze takiej osoby w bazie'

			INSERT INTO Osoba (Imie, Nazwisko, KrajID, DataUrodzenia)
			VALUES (@Imie, @Nazwisko, @KrajID, @DataUrodzenia)

			SELECT @OsobaID = SCOPE_IDENTITY()

			INSERT INTO Rezyser (OsobaID) VALUES (@OsobaID)
			SELECT SCOPE_IDENTITY() AS RezyserID
		END

	-- !!! start
	END TRY
	BEGIN CATCH
		EXEC ZapiszBlad;
		THROW
		RETURN -1
	END CATCH
	-- !!! end
END
GO