/*


HEAP = TABELLE in unsortierter Form


NON CLUSTERED IX
Kopie der DS in sortierter Form mit Baumstruktur
ca 1000 mal
wenn rel wenig rauskommt am besten einer oder keiner


CLUSTERED IX (gruppierte) = Tabelle in sortierter Form
nur 1 mal
gut wenn Bereichsabfragen

-----------------------------
eindeutiger IX    !

gefilterten IX nur ein Teil der DAten , macht Sinn wenn am Ende weniger Ebenen

ind Sicht  ! kaum einsetzbar.. viele Randbedingungen Count, eindeutigkeit
zusammengesetzter IX   !    (max 16 Spalten  900bytes)
sind nur die where Spalten 


IX mit eingeschlossenen Spalten     !
ca 1000 Spalten   SELECT 


abdeckender IX   !  reiner Seek ,der alles beantwortet ohne Lookup

part IX  jede Menge gefilt Ix .. für jeden ! Umstand

-------Alb----Arg----Ag------Bel-------------FR----------------------------------------------------

realen hypothetischen IX
-------------------------------
Columnstore IX 


*/

100000 Seiten   20 Spalten 200DS pro Seiten
5000 Seiten     
25 Seiten
1 Seiten


--TABLE SCAN.. komlettes Lesen der Tabellen
--IX SCAN .. komplettes durchsuchen des IX
--IX SEEK.. Herauspicken.. best !!!!!



Use northwind

set statistics io, time on

--kein PK.. nix IX..--> TABLE SCAN
select id from ku1 where id = 100 --57336


--besser mit :
--lege zuerst den CL IX fest.... Orderdate
--alles andere nur noch NON CL
--IX --> NIX_ID

select id from ku1 where id = 100 --3Seiten
--0 ms

--Seek mit Lookup
select id, freight from ku1 where id = 100 --4 Seiten 
--0 ms

--IX Seek mit Lookup (99%)
select id, freight from ku1 where id < 100 --102 Seiten ..ufff

select id, freight from ku1 where id < 11001 --ab ca 1% Table Scan

---besser wenn kein Lookup
--wir nehmen die Frachtkosten in IX mit auf
--NIX_ID_FR

select id, freight from ku1 where id < 100 --immer noch reiner Seek bei 900000
--3 Seiten
--zusammengesetzter IX kann nur 16 Spalten haben
--und alle Werte dürfen in Summe nicht mehr als 900bytes ausmachen
-- in Praxis kaum mehr als 4 oder 5 Spalten
--

--besser mit eingeschlossenen Spalten: NIX_ID_i_FREIDCYCI
select id, freight, employeeid, country, city from ku1 where id < 100 
--reiner Seek... 3 Seiten..!!

--NIX_SC_PID_i_CYCIUPQU
select country, city, sum(unitprice*quantity) from ku1
where shipcountry ='UK' AND ProductId < 3
group by country, city


--NIX_SC_PID_i_CYCIUPQU
--kein IX Vorschlag mehr seitens Plan
--2 IX : fall1 für SC und Fall2 für PID
select country, city, sum(unitprice*quantity) from ku1
where shipcountry ='UK' OR ProductId < 3
group by country, city

--Abdeckender IX.. der iddeale IX reiner SEEK ohne LOOKUP


---Part IX und gefilterter IX (nicht alle DS im IX)
--gefiltert mach tnur Sinn wenn weniger Ebenen!!
select freight from ku1 where city = 'Redmond' and Country = 'USA'
select freight from ku1 where city = 'London' and Country = 'UK'


--Part IX--rein phyisklaische Lösung für viele gefilterte IX.. voll abdeckend

-----ALBANIEN---ARGENTINIEN---BRASILIEN----CHILE---




--ind Sicht..aber geht nur mit schemabinding, count_big, eindeutig 

select country , count(*) from ku1
group by country

create or alter view v1 with schemabinding
as
select country , count_big(*) as Anz from dbo.ku1
group by country

select * from v1



select top 3 * from ku1

--welche coole Info könnten wir rausfinden (where , agg summe ..)

--beste Angestellte nach Umsatz die wo Kunde Deutschland
--NIX_CY_i_LNUPQU
select top 1 Lastname, sum(unitprice*quantity) as Umsatz from ku1
where country = 'Germany'
group by Lastname
order by Umsatz desc
--von 57000 Seiten  auf 1232.. von 250ms auf 30ms

select * into ku2 from ku1


--NIX_SC_PID_i_CYCIUPQU
select country, city, sum(unitprice*quantity) from ku1
where shipcountry ='UK' AND ProductId < 3
group by country, city


--NIX_SC_PID_i_CYCIUPQU
--kein IX Vorschlag mehr seitens Plan
--2 IX : fall1 für SC und Fall2 für PID
select country, city, sum(unitprice*quantity) from ku1
where shipcountry ='UK' OR ProductId < 3
group by country, city

--Abdeckender IX.. der iddeale IX reiner SEEK ohne LOOKUP


---Part IX und gefilterter IX (nicht alle DS im IX)
--gefiltert macht nur Sinn wenn weniger Ebenen!!
select freight from ku1 where city = 'Redmond' and Country = 'USA'
select freight from ku1 where city = 'London' and Country = 'UK'


--Part IX--rein phyisklaische Lösung für viele gefilterte IX.. voll abdeckend

-----ALBANIEN---ARGENTINIEN---BRASILIEN----CHILE---




--ind Sicht..aber geht nur mit schemabinding, count_big, eindeutig 

select country , count(*) from ku1
group by country

create or alter view v1 with schemabinding
as
select country , count_big(*) as Anz from dbo.ku1
group by country

select * from v1



select top 3 * from ku1




--Columnstore IX 
select top 1 Lastname, sum(unitprice*quantity) as Umsatz from ku2
where country = 'UK'
group by Lastname
order by Umsatz desc


--Fragmentierung
--unter 10 % nix
--über 30% Rebuild
--10 bis 30 % Reorg

--0-3 ms ab 2ten Aufruf

--KU1 550MB
--Ku2 4 MB  ..stimmt..Kompression (Seiten: 40-60%)..hier 184MB

--Std Columnstore Kompression --> Archivkompression  (von 4,2 --> 3MB)

--diese 3 MB sind genauso im RAM
--weniger CPU



select * from sys.dm_db_column_store_row_group_physical_stats


--Wartungsplan  IX Rebuild Reorg 


--Fragmentierung
--unter 10 % nix
--über 30% Rebuild
--10 bis 30 % Reorg


-Fehlende Indizes und überflüssige
0 = HEAP
1= GR IX
>1 NG IX

sp_blitzIndex  -- Brent Ozar

--Tools für fehlende Indizes




select * from sys.dm_db_index_usage_stats

Servus



