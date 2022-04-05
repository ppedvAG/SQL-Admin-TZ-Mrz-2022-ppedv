--Securtiy


/*
Login --Anmeldung am Server

User -- der typ in der DB.. die db merkt sich nur die Rechte
Ausnahme: Contained Database -Login an der DB 

--toDO (Server Feature aktivieren .. auf DB Option 


USE [master]
GO
ALTER DATABASE [Northwind] SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO

+ User mit eig Login 
- msdb (Jobs , Zeitpläne, Emailsystem)
- Cross Abfragen

use testdDB
select * from northwind.dbo.customers


--Backup Security Problem
-- Backup einer DB auf einen anderen Server restoren....

--whoami
--verwaiste Benutzer

--Idee: Login anlegen ohne Benutzerzuprdnung .. geht nicht weil andere SID

--wenn Windows Konto , dann kein Thema, weil Windows SID verwendet wird 

--Im Fall von SQL Logins

Workaround: 
Hast du mit DB Rollen gearbeitet... Ja ..nur!
--User löschen und komplett neu anlegen inkl Benutzerzuordnung und dann in Rolle mitreinnehmen


--Wenn nicht sicher, dann härtere Massnahmen:

-- sp_help_revlogin



*/


select * from syslogins

use whoamiDB

select * from sysusers

use whoamiDB

sp_Change_users_login 'Report'--varwaistern User

--mit folgendem: Login anlegen passsend zum User
sp_Change_Users_login 'Auto_fix' , JamesBond, NULL, 'ppedv2019!'

--Jetzt bekommt der User die SID des Logins
sp_change_users_login 'Update_one' , 'JamesBond', 'JamesBond'