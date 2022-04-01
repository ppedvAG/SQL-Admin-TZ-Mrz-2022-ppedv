--Snapshot


USE master
GO

-- Create the database snapshot
CREATE DATABASE SN_DB_NAME ON
	( NAME = Northwind, --logischer Dateiname der OrgDB
	FILENAME = 'D:\_SQLDB\Dateiname.mdf' ) --neue Datei des Snapshot 
,
	( NAME = 2tedatei, --logischer Dateiname
	FILENAME = 'D:\_SQLDB\2teDateiname.ndf' ) 
AS SNAPSHOT OF OrgDB;
GO


--Bei Northwind:  northwind  NwindHotdata

create database SN_Nwind_12000
ON
(NAME=Northwind, FILENAME='D:\_SQLDB\nwindsnv1200.mdf'),
(NAME=NwindHotdata, FILENAME='D:\_SQLDB\NwindHovtdatasn1200.mdf')
as
SNAPSHOT OF NORTHWIND



---Kann man mehrere SN machen ? 
--Ja...


--Hat ein INS eine Auswirkung auf den SN?
-- eigtl nicht 
--U D dagegen schon

--kan man den SN sichern?
--Neee...

--kann man die OrgDB sichern wenn SN vorhanden?
--hoffe schon ..  jaa!!!


--kann man den SN restoren?
--hä??? neinnnn!!!

--kann ich die OrgDB restoren?
--nee... zuerst alle SN löschen!! Dann gehts wieder


--kann man wenigsten den SN zurm Restoren verwenden?
--ja ;-)



--wie?
--EXCEPT INTERSECT

select * from northwind..customers
except
select * from [SN_Nwind_1200].dbo.customers


select * from northwind..customers
intersect
select * from [SN_Nwind_1200].dbo.customers

--Restore

--alle User müssen runter!!!! von allen beteiligten DBs!
use master

select * from sysprocesses where spid > 50 --alle Prozesse der User
											and dbid in (  db_id('northinwd'), db_id('SN_Nwind_1200')   )


kill 97

restore database northwind from database_snapshot = 'SN_Nwind_1200'
