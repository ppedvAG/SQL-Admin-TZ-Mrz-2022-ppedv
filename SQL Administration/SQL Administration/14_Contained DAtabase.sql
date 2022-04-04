--  http://blog.fumus.de/sql-server/contained-databasedie-eigenstndige-datenbank

--Logins in der DB

--#tabellen sind in der tempdb , aber sie haben die Sprachsortierung der Orig(ContainedDB) 

--DB mit Finnnish_Swedish  -- #tab (temdb Latin1_general)


--Man muss das Konfigurieren


--Auf derm Server aktivieren


EXEC sys.sp_configure N'contained database authentication', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO


---Wenn eine DB eine Contained DB sein soll, dann muss man die noch aktivieren
USE [master]
GO
ALTER DATABASE [TestDB] SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO


--Jede Contained DB ist eien DB +

-- man kann keine Replikatoipn betrieben
--man kann zunächst keine Cross Abfragen schreiben