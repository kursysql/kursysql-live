CREATE OR ALTER PROCEDURE KasujAktora
  @AktorID int
AS
BEGIN

	DECLARE @OsobaID int

	-- walidacja
	IF NOT EXISTS(SELECT * FROM Aktor WHERE AktorID = @AktorID)
	BEGIN
	  RAISERROR('Niepoprawny AktorID', 11, 1)
	  RETURN
	END

	IF EXISTS(SELECT * FROM FilmAktor WHERE AktorID = @AktorID)
	BEGIN
	  RAISERROR('Nie mozna skasowac - przypisany do filmu', 11, 1)
	  RETURN
	END

	SELECT @OsobaID = OsobaID FROM Aktor WHERE AktorID = @AktorID

	DELETE FROM Aktor WHERE AktorID = @AktorID

	-- skasuj dane osobowe pod warunkiem, ze ta osoba nie jest jednoczesnie rozeserem
	IF NOT EXISTS(SELECT * FROM Rezyser WHERE OsobaID = @OsobaID )
	DELETE FROM Osoba WHERE OsobaID = @OsobaID


END
GO
