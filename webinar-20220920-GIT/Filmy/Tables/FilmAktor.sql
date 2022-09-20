CREATE TABLE [dbo].[FilmAktor] (
    [FilmID]    INT        NOT NULL,
    [AktorID]   INT        NOT NULL,
    [NazwaRoli] CHAR (100) NULL,
    CONSTRAINT [PK_FilmAktor] PRIMARY KEY CLUSTERED ([FilmID] ASC, [AktorID] ASC),
    CONSTRAINT [FK_FilmAktor_Aktor] FOREIGN KEY ([AktorID]) REFERENCES [dbo].[Aktor] ([AktorID]),
    CONSTRAINT [FK_FilmAktor_Film] FOREIGN KEY ([FilmID]) REFERENCES [dbo].[Film] ([FilmID])
);


GO

