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