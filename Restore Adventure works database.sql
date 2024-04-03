USE [master]
RESTORE DATABASE [AdventureWorks2019] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\Backup\AdventureWorks2019.bak' WITH  FILE = 1,  MOVE N'AdventureWorks2019' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\AdventureWorks2019.mdf',  MOVE N'AdventureWorks2019_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\AdventureWorks2019_log.ldf',  NOUNLOAD,  STATS = 5

GO


