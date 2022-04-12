--Aufzeichnungen


/*

TOOLS--------------------------------------------------LIVE-----------------------

Live Monitoring  
Aktivitätsmonitor
SystemSichten  DMVs ---> Glenn Berry als Tipp


TOOLS------------------------------------------------------Aufzeichnen-----------:

Grafisches Sytem: Windows Perfmon
Profiler : TSQL Statements nachvollziehen  Vorsicht: Ereignisse filtern.. geht aber nur , wenn Spalten sichtbar
Query Store auf Dauer sehr lightweight


--Profiler.. miese Perfomance

----------------------DMV-- ----------------------
SQL Server zeichnet jede Menge Informationen ab dem Neustart des Servers auf...
Nach Neustart werden diese Resetet..


Daher live Monitoring sehr detailiert über DMVs.. für historische Betrachtung evtl Aufzeichnen
--Datensammleroder auch manuell

--man kann sich re gut zurechtfinden.. allerdings nicht immer :-(

select * from sys.dm_os_  SQL Server
select * from sys.dm_db_  Datenbank


select * from sys.dm_os_performance_counters
select * from sysprocesses
select * from sys.dm_db_Indx_pyhsica_stats() Funktion
select * from sys.dm_os_wait_stats

----LIVE Monitoring

/*
TaskManager
CPU RAM Prozesse (mslaugh.exe  teakids.exe)
Max Arbeitssatz - Arbeitssatz (9500 MAX   /   4500 aktuell)
SQL Server gibt so gut wie nie freiwilig RAM her

--Ressourcenmonitor filter auf Prozess sqlserver


--was wenn: CPU bei 30%   RAM bei 70% --HDD ruhig..aber Probleme bei Abfragen
--irgendetwas im SQL Server--> Aktivitätsmonitor (Task Manger des SQL Servers)


Aktivitätstmonitor: 
--Prozesse der User (spid > 50)

--Ressourcenwartevorgänge
kategorisch (über 1000 Ressouren der os_wait_Stats

--von ca 1000 Ressourcen sieht man kategorisch die top Ressourcen
--der letzte 1 Sekunde und der letzte Zeit kummulativ
*/
--Alle Ressourcenwartevorgänge gesammelt seit Neustart( auf reset)
--die Zahlen sind kummulierend..

--wie findet man heraus, ob die Zahl eher gut oder schelcht ist..?

select * from sys.dm_os_wait_Stats

--durchschnittliche Wartezeit


--Q--|------------SUSPENDED------RESSOURCE|-------------RUNNABLE  ....CPU|---RUNNING
--      0                                               100                                                                       150

--																				   |-----------    signal_time---		 | --wait_time_ms

-- wait_time - signal_time = Wartezeit auf Resssource  < 25%)

Werte werden für kummuliert gespeichert

evtl regelm wegsichern mit Zeitstempel
Was hat sich wie in letzter Zeit verändert



*/


select * from sysprocesses where spid > 50--- Sperren  SUPSEND RUNNABLE RUNNING



--Wartezustände

select * from sys.dm_os_wait_stats

select * from sys.dm_db_index_usage_stats

--DMV aktuelle Problem
-- Glenn Berry

--Tools zum Aufzeichen: Profiler , Perfmon, 



*/

select * from sys.dm_os_performance_counters