/*
Logins (NT / gemischte Auth (NT, SQL Login)


Tipp: Nur wenn notwendig SQL Logins

VOKABLEN
Rollen = Gruppen
Tabellen, Sichten , Prozeduren , Funktionen

Ordner = Schema (dbo) --> eig Schemas für verineachte Administration


Max = IT Fuzzi
Evi = Marketing Tante

Schema IT und Schema MA


FileServer
\\ServerX\Akten
			Dat1
			Dat2
			Dat3
			Dat3


PERSON ----> SERVER <---------> master (logins  --> SID)   LoginPeter  117
																			- Serverrollen (regeln Admintätigkeiten auf dem Server)
																			- Standard DB



															--> UserDB  (User --SID)  UserPeter  117    117 = 117 Usermapping 
																		          - Rechte auf Objekte
																				  - Schema (Besitzer günstigerweise dbo)
																				  - dbo = database owner (jedes Recht in der DB)

*/

USE [master]
GO
CREATE LOGIN [Max] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO



USE [Northwind]
GO

/****** Object:  User [Max]    Script Date: 04.04.2022 11:16:26 ******/
CREATE USER [Max] FOR LOGIN [Max] WITH DEFAULT_SCHEMA=[dbo]
GO


USE [master]
GO
CREATE LOGIN [EVI] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [EVI] FOR LOGIN [EVI]
GO


USE [Northwind]
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO

USE [Northwind]
GO
CREATE SCHEMA [MA] AUTHORIZATION [dbo]
GO



--tabelle pro Schema
create table it.personal (itperso int)
create table ma.personal (maperso int)

create table it.kst (itkst int)
create table ma.kst (makst int)


--max soll alle IT Tabellen lesen können


use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [Max]
GO


--und Evi soll alle MA Tabellen lesen können

use [Northwind]
GO
GRANT SELECT ON SCHEMA::[MA] TO [EVI]
GO


--jeder User hat ein Default schema (dbo)

--dann vergeben wir ein Std Schema

USE [Northwind]
GO
ALTER USER [Max] WITH DEFAULT_SCHEMA=[IT]
GO


USE [Northwind]
GO
ALTER USER [EVI] WITH DEFAULT_SCHEMA=[MA]
GO

*/

select * from dbo.orders

select * from dbo.kst

--Evi muss auch Zurgiff zu anderen Tabellen haben

-- it.kst -- Rechte auf Tabelle
use [Northwind]
GO
GRANT SELECT ON [IT].[kst] TO [EVI]
GO


---Evi soll auch tabellen anlegene dürfen nur in Schema MA


use [Northwind]
GO
GRANT CREATE TABLE TO [EVI]
GO


use [Northwind]
GO
GRANT ALTER ON SCHEMA::[MA] TO [EVI]
GO


--JETZT MIT ROLLEN(GRUPPEN)
-- auch NT Gruppen (als Login)

--Datenbankrollen

USE [Northwind]
GO
CREATE ROLE [ITRolle] AUTHORIZATION [dbo]
GO
USE [Northwind]
GO
ALTER ROLE [ITRolle] ADD MEMBER [Max]
GO

--tauschen Person mit Rolle aus..

USE [Northwind]
GO
CREATE ROLE [MARolle] AUTHORIZATION [dbo]
GO
USE [Northwind]
GO
ALTER ROLE [MARolle] ADD MEMBER [EVI]
GO


use [Northwind]
GO
REVOKE ALTER ON SCHEMA::[MA] TO [EVI] AS [dbo]
GO
use [Northwind]
GO
REVOKE SELECT ON SCHEMA::[MA] TO [EVI] AS [dbo]
GO
use [Northwind]
GO
GRANT ALTER ON SCHEMA::[MA] TO [EVI]
GO
use [Northwind]
GO
GRANT SELECT ON SCHEMA::[MA] TO [MARolle]
GO





--Neuer IT Mitarbeiter  Moritz  soll all das tun  können was max machen  kann ..


USE [master]
GO
CREATE LOGIN [Moritz] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Moritz] FOR LOGIN [Moritz]
GO
USE [Northwind]
GO
ALTER USER [Moritz] WITH DEFAULT_SCHEMA=[IT]
GO
USE [Northwind]
GO
ALTER ROLE [ITRolle] ADD MEMBER [Moritz]
GO



--Kann ein User trotz Deny dennoch auf Daten zugreifen


use [Northwind]
GO
DENY SELECT ON [dbo].[Employees] TO [EVI]
GO


--ja



-- dbo      dbo            dbo          dbo          dbo               dbo            dbo -- Besitzverkettung
---T1<-----V1<-------V2<------V3<-------V4<---------V5<-------V6


--daher sollt emn etwas nicht tun: Vergib nie einem "Normalo" das CREATE Recht auf Sichten, Proz, F()

create view vAngUK
as
select Lastname firstname, city from employees where country = 'UK'



--DB Rollen..


--public: nichts damit tun..
--ddl   create drop alter
--security_ User Rechte vergeben



--Servrerrollen
--public 
---sysadmin = absoluter SQL Admin hat alle Rechte
--SecurityAdmin: darf Logins anlegen , ändern .. 
--processadmin: kill oder anschauen  der processes
--diskadmin: Pfade
--dbcreator: DB Anlegen
-- serveradmin: konfigurieren
--setupadmin: Funktionen aktivieren
--bulkadmin: massenimporte 


USE [master]
GO
CREATE SERVER ROLE [FirtLevelSupport] AUTHORIZATION [sa]
GRANT ALTER ON LOGIN::[Max] TO [FirtLevelSupport]



