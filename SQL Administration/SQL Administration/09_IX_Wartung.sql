--Überflüssige Indizes müssen weg


select 
db_name(database_id),
object_name(object_id),
* from 
	sys.dm_db_index_usage_stats
where database_id = db_id()

select * from sys.dm_db_missing_index_group_stats

--0 = heap
--1 = CL IX
-->1 NCL IX


--Fehlende müssen rein
Fragementierung

<10% nix
> 30% Rebuild
10 - 30% REORG

--Wartung 
rebuild
reorg

--Bsp für Aufwand

--HEAP .. 200MB daten
--1 CL + 2 NCL 
--363 MB

--REBUILD
--OFFLINE ONLINE
--mit TEMPDB oder ohne TEMPDB für Sortierarbeiten

--aufwendigste Kombi: ONLINE MIT TEMPDB  1100 MB
--  geringste         OFFLINE OHNE TEMPDB 860MB

--Wartungsplan jeden Tag
--Passend zu den Abfragen


--Wartungsplan ist bis inkl SQL 20154 einen feuchten Kehrricht wert
--ab 2016 brauchbar
--Alternative Ola Hallengren
