/*
	WEBINAR 2023-03-15
	Transakcje w SQL Server i SQL Database
	
	libera@kursysql.pl
	https://www.kursysql.pl

	A. Transakcje i blokady
	B. Zakleszczenia
	C. Rodzaje izolacji transakcji
	D. Accelerated Database Recovery
	E. Optimized locking
    
*/

USE AdventureWorks2019




/*
	A. Transakcje i blokady
	https://www.kursysql.pl/szkolenie-sql-zaawansowany/
*/

	SELECT * FROM Person.Person

	DROP TABLE IF EXISTS Person.Person2
	SELECT * INTO Person.Person2 FROM Person.Person
	ALTER TABLE Person.Person2 ADD CONSTRAINT PK_Person2 PRIMARY KEY (BusinessEntityID)


	-- @@TRANCOUNT
	SELECT @@TRANCOUNT

	-- sys.dm_tran_locks 
	SELECT * FROM sys.dm_tran_locks 
	WHERE request_session_id = @@SPID 
		AND resource_type in ('PAGE','RID','KEY','XACT')

	-- sp_who
	EXEC sp_who @@SPID
	EXEC sp_who 55


	-- sp_WhoIsActive
	-- https://github.com/amachanic/sp_whoisactive
	EXEC sp_whoisactive

	-- ActivityMonitor

	DBCC USEROPTIONS

	BEGIN TRAN
	-- trancount?

		SELECT * FROM Person.Person2
	
		UPDATE Person.Person2 SET LastName = 'Nowak' 
		WHERE BusinessEntityID = 3
		-- locks?

	ROLLBACK



	--> BEGIN --  Sesja 2

	USE AdventureWorks2019


	-- ! próba blokady strony
	SELECT * FROM Person.Person2


	SELECT * FROM Person.Person2 WHERE BusinessEntityID = 1

	SELECT * FROM Person.Person2 WHERE BusinessEntityID < 3 

	SELECT * FROM Person.Person2 WHERE BusinessEntityID = 4

	SELECT * FROM Person.Person2 WHERE BusinessEntityID = 3 


	-- ! próba blokady wiersza
	SELECT * FROM Person.Person2 WHERE BusinessEntityID < 4

	-- ! próba blokady strony
	SELECT * FROM Person.Person2 WHERE BusinessEntityID >4

	-- wymuszenie blokady wiersza
	SELECT * FROM Person.Person2 WITH (ROWLOCK) WHERE BusinessEntityID >4

	-- NOLOCK obniżenie poziomu izolacji transakcji
	SELECT * FROM Person.Person2 WITH (NOLOCK) 
	ORDER BY BusinessEntityID

	-- READPAST pominięcie zablokowanych danych
	SELECT * FROM Person.Person2 WITH (READPAST) WHERE BusinessEntityID <= 100
	ORDER BY BusinessEntityID
 
	--> END --  Sesja 2







/*
	B. Zakleszczenia
*/

	--> BEGIN --  Sesja 1

	SELECT * FROM Person.Person2

	SELECT @@TRANCOUNT

	SELECT * FROM sys.dm_tran_locks 
	WHERE request_session_id = @@SPID AND resource_type in ('PAGE','RID','KEY','XACT')


	BEGIN TRAN 

		UPDATE Person.Person2 SET LastName = 'Nowak' 
		WHERE BusinessEntityID = 3

		-- Sesja 2...

		SELECT * FROM Person.Person2

	ROLLBACK
	--> END --  Sesja 1



	--> BEGIN --  Sesja 2

	SELECT * FROM sys.dm_tran_locks 
	WHERE request_session_id = @@SPID AND resource_type in ('PAGE','RID','KEY','XACT')


	BEGIN TRAN 

		UPDATE Person.Person2 SET LastName = 'Kowalski' WHERE BusinessEntityID = 5

		-- Sesja 2...

		SELECT * FROM Person.Person2

	ROLLBACK
	--> END --  Sesja 2







/*
	C. Rodzaje izolacji transakcji
	https://learn.microsoft.com/en-us/sql/connect/jdbc/understanding-isolation-levels
	https://learn.microsoft.com/en-us/sql/t-sql/statements/set-transaction-isolation-level-transact-sql

	SET TRANSACTION ISOLATION LEVEL
		{ READ UNCOMMITTED
		| READ COMMITTED
		| REPEATABLE READ
		| SNAPSHOT
		| SERIALIZABLE
		}
*/

	DBCC USEROPTIONS

	SELECT @@TRANCOUNT

	BEGIN TRAN
	-- trancount?

		SELECT * FROM Person.Person2
	
		UPDATE Person.Person2 SET LastName = 'Nowak' 
		WHERE BusinessEntityID = 3
		-- Sesja 2...



	ROLLBACK




	--> BEGIN --  Sesja 2

	SELECT * FROM Person.Person2

	SELECT * FROM Person.Person2 WHERE BusinessEntityID = 1

	SELECT * FROM Person.Person2 WHERE BusinessEntityID = 3 

	DBCC USEROPTIONS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DBCC USEROPTIONS

	SELECT * FROM Person.Person2 WHERE BusinessEntityID = 3 


	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	DBCC USEROPTIONS

	SELECT * FROM Person.Person2 WHERE BusinessEntityID = 3 
	-- wait....


	-- NOLOCK obniżenie poziomu izolacji transakcji do READ_UNCOMMITED
	SELECT * FROM Person.Person2 WITH (NOLOCK) 
	ORDER BY BusinessEntityID

	-- READPAST pominięcie zablokowanych danych
	SELECT * FROM Person.Person2 WITH (READPAST) WHERE BusinessEntityID <= 100
	ORDER BY BusinessEntityID
 
	--> END --  Sesja 2

	ROLLBACK

	




	ALTER DATABASE AdventureWorks2019 SET READ_COMMITTED_SNAPSHOT ON 
	WITH ROLLBACK IMMEDIATE

	DBCC USEROPTIONS


	-- ... test



	ALTER DATABASE AdventureWorks2019 SET READ_COMMITTED_SNAPSHOT OFF
	WITH ROLLBACK IMMEDIATE

	DBCC USEROPTIONS



/*


	DEFAULT isolation level
	
	SQL Server - RC - READ COMMITTED			- pessimistic 
	Azure SQL - RCSI - READ_COMMITTED_SNAPSHOT	- optimistic (better database concurrency)


*/





/*
	D. Accelerated Database Recovery
	https://learn.microsoft.com/en-us/azure/azure-sql/accelerated-database-recovery
*/


	SELECT name, is_read_committed_snapshot_on, is_accelerated_database_recovery_on
	FROM  sys.databases
	WHERE name = db_name()


	-- rows: 121 317, reserved: 17 752 KB
	EXEC sp_spaceused 'Sales.SalesOrderDetail'




	CREATE INDEX IX_TransactionHistory_Quantity_TMP ON Production.TransactionHistory(Quantity)
	CREATE INDEX IX_TransactionHistory_ActualCost_TMP ON Production.TransactionHistory(ActualCost)


	SELECT TOP 100 * FROM Sales.SalesOrderDetail
	SELECT TOP 100 * FROM Production.TransactionHistory

	ALTER INDEX PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID ON Sales.SalesOrderDetail REBUILD 
	ALTER INDEX AK_SalesOrderDetail_rowguid ON Sales.SalesOrderDetail REBUILD 
	ALTER INDEX IX_SalesOrderDetail_ProductID ON Sales.SalesOrderDetail REBUILD 
	
	ALTER INDEX [PK_TransactionHistory_TransactionID] ON [Production].[TransactionHistory] REBUILD
	ALTER INDEX [IX_TransactionHistory_ProductID] ON [Production].[TransactionHistory] REBUILD
	ALTER INDEX [IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID] ON [Production].[TransactionHistory] REBUILD
	


	SELECT @@TRANCOUNT

	DBCC USEROPTIONS

	BEGIN TRAN
		-- 14-16 sek
		UPDATE Sales.SalesOrderDetail SET UnitPrice = UnitPrice*1.17

		-- 10-13 sek
		UPDATE Production.TransactionHistory 
		SET Quantity = Quantity + 1, ActualCost = ActualCost *1.5

	-- 10 sek
	ROLLBACK


	ALTER DATABASE AdventureWorks2019 SET accelerated_database_recovery = ON
	WITH ROLLBACK IMMEDIATE
	GO

	ALTER DATABASE AdventureWorks2019 SET accelerated_database_recovery = OFF
	WITH ROLLBACK IMMEDIATE
	GO


	SELECT name, is_read_committed_snapshot_on, is_accelerated_database_recovery_on
	FROM  sys.databases
	WHERE name = 'AdventureWorks2019'


	-- test





/*
	E. Optimized locking

https://learn.microsoft.com/en-us/sql/relational-databases/performance/optimized-locking
Optimized locking is composed of two primary components: Transaction ID (TID) locking and lock after qualification (LAQ).

- A transaction ID (TID) is a unique identifier of a transaction. 
Each row is labeled with the last TID that modified it. 
Instead of potentially many key or row identifier locks, a single lock on the TID is used. 
- Lock after qualification (LAQ) is an optimization that evaluates predicates of a query on the latest 
committed version of the row without acquiring a lock, thus improving concurrency. 

For example:
- Without optimized locking, updating 1 million rows in a table may require 
1 million exclusive (X) row locks held until the end of the transaction.
- With optimized locking, updating 1 million rows in a table may require 
1 million X row locks but each lock is released as soon as each row is updated, 
and only one TID lock will be held until the end of the transaction.


Optimized locking builds on other database features:
- Optimized locking requires accelerated database recovery (ADR) to be enabled on the database.
- For the most benefit from optimized locking, read committed snapshot isolation (RCSI) should be enabled for the database.


*/

	SELECT name, is_read_committed_snapshot_on, is_accelerated_database_recovery_on
	FROM  sys.databases
	WHERE name = 'AdventureWorks2019'


	/*
		NULL - not connected to specified database/ not Azure SQL
		0 - optimized locking disabled
		1 - optimized locking enabled
	*/
	SELECT DB_NAME() AS DBName, DATABASEPROPERTYEX('AdventureWorks2019', 'IsOptimizedLockingOn') AS IsOptimizedLockingOn


--> Azure SQL : kursysqldemo.database.windows.net


	SELECT name, is_read_committed_snapshot_on, is_accelerated_database_recovery_on
	FROM  sys.databases
	WHERE name = 'AW'

	SELECT DB_NAME() AS DBName, DATABASEPROPERTYEX('AW', 'IsOptimizedLockingOn') AS IsOptimizedLockingOn

	DBCC USEROPTIONS -- read committed snapshot (Azure SQL def.)


	SELECT * FROM sys.dm_tran_locks 
	WHERE request_session_id = @@SPID AND resource_type in ('PAGE','RID','KEY','XACT')


	SELECT @@TRANCOUNT

	BEGIN TRAN
	-- trancount?

		SELECT * FROM SalesLT.Customer
	
		UPDATE SalesLT.Customer SET LastName = 'Nowak' WHERE CustomerID = 3

		UPDATE SalesLT.Customer SET LastName = 'Kowalski' WHERE CustomerID = 4
		UPDATE SalesLT.Customer SET LastName = 'Bachleda' WHERE CustomerID = 5
		UPDATE SalesLT.Customer SET LastName = 'Wiśniewska' WHERE CustomerID = 6
		-- locks?


	ROLLBACK

