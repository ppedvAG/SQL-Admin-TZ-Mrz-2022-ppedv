---MONITORING
select getdate()
--Query Store....

--Profiler.. miese Perfomance

create proc gpname @par1 int
as
SEL
INS
UP
DEL
SEL


exec gpname 115

select * from sys.dm_os_performance_counters


----LIVE Monitoring

/*
TaskManager
CPU RAM Prozesse (mslaugh.exe  teakids.exe)
Max Arbeitssatz - Arbeitssatz (9500 MAX   /   4500 aktuell)
SQL Server gibt so gut wie nie freiwilig RAM her

--Ressozrcenmonitor filter auf Prozess sqlserver


--was wenn: CPU bei 30%   RAM bei 70% --HDD ruhig..aber Probleme bei Abfragen
--irgendetwas im SQL Server--> Aktivitätsmonitor (Task Manger des SQL Servers)

--Prozesse der USer (spid > 50)

--Ressourcenwartevorgänge

--von ca 1000 Ressourcen sieht man ketgorisch die top 10 Ressource
*/
--Alle Ressourcenwartevorgänge gesammelt seit Neustart( auf reset)
--die Zahlen sind kummulierend..

--wie findet man heraus, ob die Zahl eher gut oder schelcht ist..?

select * from sys.dm_os_wait_Stats

--durchschnittliche Wartezeit


--Q--|------------SUSPENDED------RESSOURCE|-------------RUNNABLE  ....CPU|---RUNNING
--      0                                               100                                                                       150

--																						----------signal_time---		wait_time_ms

-- wait_time-signal_time = Wartezeit auf Resssource  < 25%)



DMV


*/


select * from sysprocesses where spid > 50--- Sperren  SUPSEND RUNNABLE RUNNING



--Wartezustände

select * from sys.dm_os_wait_stats

select * from sys.dm_db_index_usage_stats

--DMV aktuelle Problem
-- Glenn Berry

--Tools zum Aufzeichen: Profiler , Perfmon, 

