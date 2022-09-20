CREATE TABLE [dbo].[Rezyser] (
    [RezyserID] INT IDENTITY (1, 1) NOT NULL,
    [OsobaID]   INT NULL,
    PRIMARY KEY CLUSTERED ([RezyserID] ASC),
    CONSTRAINT [FK_Rezyser_Osoba] FOREIGN KEY ([OsobaID]) REFERENCES [dbo].[Osoba] ([OsobaID])
);


GO

