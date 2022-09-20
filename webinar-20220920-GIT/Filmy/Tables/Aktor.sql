CREATE TABLE [dbo].[Aktor] (
    [AktorID] INT IDENTITY (1, 1) NOT NULL,
    [OsobaID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([AktorID] ASC),
    CONSTRAINT [FK_Aktorzy_Osoby] FOREIGN KEY ([OsobaID]) REFERENCES [dbo].[Osoba] ([OsobaID])
);


GO

