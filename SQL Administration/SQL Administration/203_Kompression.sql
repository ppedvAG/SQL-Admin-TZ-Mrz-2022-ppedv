--Kompression

--Zeilen  trim bei Datentypen... --> mehr DS auf Seiten zusammenziehen 

--Seiten : zuerst Zeilenkompression

--zu erwarten ist : von 40 bis 60%

--Was passiert mit Abfragen beim Client? 
--transparent.. Client bekommt immer die entpackten Daten?

--Was passiert auf dem Server?

--SQL Server Start...
--RAM : 250MB

--Abfrage auf unkomprimierte Tabelle: 160MB---> RAM + 160
--  CPU: 100ms



set statistics io, time on
select * from testdb..t3 --komplette Tabelle wurde in RAM geladen 
--20038 Seiten  .. , CPU-Zeit = 265 ms, verstrichene Zeit = 1297 ms.

.--nach Kompression
--RAM : gleich 
--.. nach Laden der Tabelle: + 160 .. real: fast nicht gestiegen plus 30 Seiten + 8kb
--CPU steigt -- SQL Service muss DAten bei Übergeben an lcient entpacken
--Seiten: sinken  auf 30

--Kompression ist ein Vorteil für andere!!  Mehr RAM für andere, bezahlt mit CPU


--Auch Partitionen lassen sich komprimieren 
USE [Northwind]
ALTER TABLE [dbo].[ptab] REBUILD PARTITION = 3 WITH(DATA_COMPRESSION = PAGE )





