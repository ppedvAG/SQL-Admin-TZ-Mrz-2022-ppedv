/*
Dienstkonto
Restore ist idR manuell (Ausnahme: LogShipping)  daher das Dienstkonto ( im Fall lokal immer das MSSQLServer)

NT Security: 
User MSSQLServer



Anderer Server
Es gelten immer die Laufwerke des Server ,mit dem man vcerbunden ist... 



--Alle Endungen aktiviert

--Kann man Backups von älteren Servern restoren?
--ja.. ab SQL 2008

--Kann man Backups von neueren Versionen auf ältere Versionen restoren?
--eher nicht wg  select @@microsoftversion

---RESTORE DER restoreMe DB
--55
select 1600/55 --> 29MB 

select 1100/7 --> 157MB

--Das TLog...!!! war der große Aufwand

--der schnellste Restore : V 


--Restore der ContainedDB
--Error: sp_configure  contrained DB Authentification ist nicht auf true gesetzt

--> Error Sp_configure = Serversetting


EXEC sys.sp_configure N'min server memory (MB)', N'3999'
GO
RECONFIGURE WITH OVERRIDE
GO			



---SystemDBs: master (DBs, Logins)  msdb (Jobs..) , tempdb (temporäres Zeug #tab), model (Vorlage)


--Backup der DBx --> kopieren auf Server B.. dort Restore..
--_> Alles was in SystemDBs war  wurde nicht mitkopiert


--> Contrained DB --> Eigenständige DB





*/