CREATE OR ALTER  PROCEDURE DodajAktora
@FilmID int,
@OsobaID	int = NULL,
@AktorID int = NULL,
@Imie	nvarchar(100) = NULL,
@Nazwisko	nvarchar(100) = NULL,
@KrajID	int = NULL,
@DataUrodzenia	datetime = NULL
AS
BEGIN
	
	SET NOCOUNT ON


	IF NOT EXISTS(SELECT * FROM Film WHERE FilmID = @FilmID)
	BEGIN
	  RAISERROR('Niepoprawny FilmID', 11, 1)
	  RETURN
	END


	IF @AktorID IS NOT NULL AND NOT EXISTS(SELECT * FROM Aktor WHERE AktorID = @AktorID)
	BEGIN
	  RAISERROR('Niepoprawny AktorID', 11, 1)
	  RETURN
	END


	IF @OsobaID IS NOT NULL AND NOT EXISTS(SELECT * FROM Osoba WHERE OsobaID = @OsobaID)
	BEGIN
	  RAISERROR('Niepoprawny OsobaID', 11, 1)
	  RETURN
	END


	IF ((@AktorID IS NOT NULL OR @OsobaID IS NOT NULL )
		AND (@Imie IS NOT NULL OR @Nazwisko IS NOT NULL OR @KrajID IS NOT NULL OR @DataUrodzenia IS NOT NULL))
	BEGIN
	  RAISERROR('Jesli znasz AktorID albo OsobaID to po co podajesz dane osobowe???', 11, 1)
	  RETURN
	END

	IF @AktorID IS NOT NULL 
		AND EXISTS(SELECT * FROM FilmAktor WHERE AktorID = @AktorID AND FilmID = @FilmID)
	BEGIN
	  RAISERROR('Ten aktor juz jest przypisany do TEGO filmu!', 11, 1)
	  RETURN
	END


/*
 1/ podany @AktorID - dodaje rekord do teabe 
 2/ podany @OsobaID i istnieje aktor o takim @OsobaID
 3/ podany @OsobaID
 4/ podane dane osobowe bez identyfikatorow
	* dodaj nowy rek. w Osoba
	* nowy rek w Aktor
	* w FilmAktor 
*/

	-- 1
	-- znamy @AktorID 
	IF @AktorID IS NOT NULL 
	BEGIN
	  INSERT INTO FilmAktor (AktorID, FilmID) VALUES (@AktorID, @FilmID) -- !!!
	END
	-- 2
	ELSE IF @OsobaID IS NOT NULL AND EXISTS(SELECT * FROM Aktor WHERE OsobaID = @OsobaID)
	BEGIN
	  SELECT @AktorID = AktorID FROM Aktor WHERE OsobaID = @OsobaID
	  INSERT INTO FilmAktor (AktorID, FilmID) VALUES (@AktorID, @FilmID) -- !!!
	END
	-- 3
	ELSE IF @OsobaID IS NOT NULL
	BEGIN
	  INSERT INTO Aktor (OsobaID) VALUES (@OsobaID)
	  SET @AktorID = SCOPE_IDENTITY()
	  INSERT INTO FilmAktor (AktorID, FilmID) VALUES (@AktorID, @FilmID) --!!!!
	END

	-- 4
	ELSE
	BEGIN
		INSERT INTO Osoba (Imie, Nazwisko, KrajID, DataUrodzenia)
		VALUES (@Imie, @Nazwisko, @KrajID, @DataUrodzenia)
		SELECT @OsobaID = SCOPE_IDENTITY()

		INSERT INTO Aktor (OsobaID) VALUES (@OsobaID)
		SELECT @AktorID = SCOPE_IDENTITY()

		INSERT INTO FilmAktor(FilmID, AktorID) VALUES (@FilmID, @AktorID) -- !!!!

	END

END
GO