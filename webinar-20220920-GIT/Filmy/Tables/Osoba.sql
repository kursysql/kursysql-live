CREATE TABLE [dbo].[Osoba] (
    [OsobaID]       INT            IDENTITY (1, 1) NOT NULL,
    [Imie]          CHAR (100)     NULL,
    [Nazwisko]      CHAR (100)     NULL,
    [KrajID]        INT            NULL,
    [DataUrodzenia] DATETIME       NULL,
    [Zdjecie]       VARBINARY (50) NULL,
    [Wiek]          AS             (datediff(year,[DataUrodzenia],getdate())),
    PRIMARY KEY CLUSTERED ([OsobaID] ASC),
    CONSTRAINT [FK_Osoba_Kraj] FOREIGN KEY ([KrajID]) REFERENCES [dbo].[Kraj] ([KrajID])
);


GO

