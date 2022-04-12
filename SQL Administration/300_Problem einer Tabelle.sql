dbcc showcontig('ku1')
--- Gescannte Seiten.............................: 41096

sp_blitzIndex

set statistics io on
select * from ku1 where unitsinstock = 10 ----57336???


select * from sys.dm_db_index_physical_stats(db_id(),object_id('ku1'),NULL,NULL,'detailed')

--forward record counts = zusätziche Seiten --müssen weg
--Tabelle muss physikalisch neu abgelegt werden...


--reiner HEAP

--> fehlende IX


--Gleichzeitige zugriff auf eine Tabelle:



--Session 1 : User A ändert den Kunden Maier..
--Session 2: user will lesen.. Schmitt

--kein IX: dann Tabellen Sperre
--mit Partitionierung. zumndest Sperre auf Partition
--mit IX: Zeilen oder Seiten oder Block--
--je eher die Stufe, desto eher wir d was gesperrt ,was man gar nicht ändert

--Default: READ COMMITTED--> READ UNCOMMITTED
--also erst Lesen nach Änderung und Commit oder man liest den nicht commited Datensatz

-->Alternative: Zeilenversionierung auf der DB aktiv.. Ein Ändern hindert das Lesen nicht mehr
-- man liest den Datensatz , der noch gültig ist , da das Update noch nicht commited hat

USE [master]
GO
ALTER DATABASE [Northwind] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

GO
ALTER DATABASE [Northwind] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
