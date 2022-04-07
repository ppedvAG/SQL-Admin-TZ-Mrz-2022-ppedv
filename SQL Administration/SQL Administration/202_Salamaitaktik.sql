--Große Tabellen kleiner machen?

--Tabelle auf mehrere Tabellen verteilen

--statt großer Umsatz ... viele kleinere

create table u2022 (id int, jahr int, spx int)

create table u2021 (id int, jahr int, spx int)

create table u2020 (id int, jahr int, spx int)

create table u2019 (id int, jahr int, spx int)


---Wir brauchen "UMSATZ" !!!

create view UMSATZ
as
select * from u2020
UNION ALL--keine Suche nach doppelten
select * from u2021
UNION ALL
select * from u2022
UNION ALL
select * from u2019
GO

--bisher kein Vorteil...
select * from umsatz
where Jahr = 2022

--Beschriftung + Garantie


ALTER TABLE dbo.u2020 ADD CONSTRAINT	CK_u2020 CHECK (jahr=2020)

--kann man auf Sichten INS UP DEL machen?
--ja... geht 
--hier geht das noch nicht...
--weil PK muss eindeutig über die Sicht sein (ID + Jahr)
--die ID darf kein Identity enthalten sein...


--es gibt was besseres.. in jeder Version funktioniert ab SQL2016 SP1, davor nur in ENT


--Partitionierung

-----------100]----------------------200]-------------------------------------------------- int 
--   1							2												3

CREATE PARTITION FUNCTION fZahl(int) --- -2,1Mrd bis 100 inkl   1       101 bis 200 inkl   2      201 bis 2,1 Mrd  3
as
RANGE LEFT for VALUES (100,200)

select $partition.fzahl(117) ---  2


--4 Dateigruppen: bis100   bis200  bis5000   rest 


ALTER DATABASE [Northwind] ADD FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbis100', FILENAME = N'D:\_SQLDB\nwbis100.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbis200', FILENAME = N'D:\_SQLDB\nwbis200.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbis5000', FILENAME = N'D:\_SQLDB\nwbis5000.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [rest]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwrest', FILENAME = N'D:\_SQLDB\nwrest.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [rest]
GO

--Part Schema
CREATE PARTITION SCHEME schZahl
as
PARTITION fzahl TO (bis100,bis200,rest)
----                               1           2         3

--Tabelle auf Schema
create table ptab (id int identity, nummer int, spx char(4100)) ON schZahl(nummer)


declare @i as int=1
begin tran
while @i<=20000
	begin
			insert into ptab (nummer, spx) values (@i, 'XY')
			set @i=@i+1 --- set @i+=1        set @i=+1
	end
commit


set statistics io, time on
select * from ptab where nummer = 1117
select * from ptab where id = 117

--100% für Zahl im Plan
--bei Abfrage auf 117   100 Seiten mit 0 ms
--bei Zahl 20000 Seiten und ca 15 ms CPU und Dauer


---blöd blöd blöd... naja.... viele Abfragen im Bereich 200 bis 5000

--neue Grenze bei 5000
--Dateigruppen  neue Dateigruppe (bis5000)
--, F()  neue Grenze
--schema  neue Dateigruppe
--Tabelle ... nix !!!

CREATE PARTITION SCHEME schZahl
as
PARTITION fzahl TO (bis100,bis200,rest)

ALTER PARTITION SCHEME schzahl next used bis5000

select $partition.fzahl(nummer) , min(nummer), max(nummer), count(*)
from ptab
group by $partition.fzahl(nummer)



--F() ändern
----------100---------200--------------------5000----------------------------------------------

ALTER PARTITION FUNCTION fZahl() split range (5000)

select * from ptab where nummer = 1117


--Idee..alte Grenze rausnehmen

--Tabelle: nein niee!!!!
--f() .. ja
--schema: neee..

-------100------------200-------------------5000----------------

ALTER PARTITION FUNCTION fzahl() merge range(100)


--


USE [Northwind]
GO

/****** Object:  PartitionScheme [schZahl]    Script Date: 07.04.2022 10:22:06 ******/
CREATE PARTITION SCHEME [schZahl] AS PARTITION [fZahl] TO ([bis200], [bis5000], [rest])
GO

USE [Northwind]
GO

/****** Object:  PartitionFunction [fZahl]    Script Date: 07.04.2022 10:22:30 ******/
CREATE PARTITION FUNCTION [fZahl](int) AS RANGE LEFT FOR VALUES (200, 5000)
GO


----wir archivieren!!!
--Das Archiv muss dort sein , wo die Daten sind!!
create table archiv (id int not null, nummer int, spx char(4100)) on BIS200

--Part1 wird in Tabelle umgewandelt
alter table ptab switch partition 1 to archiv

select * from ptab
select * from archiv

--CLOU: Annahme  100 MB/sek -- Archiv 5000000000000000000000000MB  -- Dauer : knapp wenige ms

set statistics io, time on
select * from ptab where id = 117





--Jahresweise
CREATE PARTITION FUNCTION [fZahl](datetime )
AS RANGE LEFT FOR VALUES ('31.12.2021 23:59:59.999','')
GO


--A bis M   N BIS R   S Bis Z
CREATE PARTITION FUNCTION [fZahl](varchar(50) )
AS RANGE LEFT FOR VALUES ('N','RZZZZZZZZZZZZZZZZZZZZZZZZZZ')

GO




CREATE PARTITION SCHEME schZahl
as
PARTITION fzahl ALL TO ([PRIMARY])
