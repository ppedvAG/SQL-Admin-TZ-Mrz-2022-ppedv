dbcc showcontig('ku1')
--- Gescannte Seiten.............................: 41096

sp_blitzIndex

set statistics io on
select * from ku1 where unitsinstock = 10 ----57336


select * from sys.dm_db_index_physical_stats(db_id(),object_id('ku1'),NULL,NULL,'detailed')

--forward record counts = zus�tziche Seiten --m�ssen weg
--Tabelle muss physikalisch neu abgelegt werden...


--reiner HEAP

--> fehlende IX

--Session 1 : User A �ndert den Kunden Maier..
--Session 2: user will lesen.. Schmitt
--kein IX: dann Tabellen Sperre
--mit Partitionierung. zumndest Sperre auf Partition
--mit IX: Zeilen oder Seiten oder Block--
--je eher die Stufe, desto eher wir d was gesperrt ,was man gar nicht �ndert

--Default: READ COMMITTED--> READ UNCOMMITTED


