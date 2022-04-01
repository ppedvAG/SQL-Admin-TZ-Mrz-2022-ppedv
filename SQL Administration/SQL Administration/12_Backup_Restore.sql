/*
BackupMethoden

Vollständige   V

Diffrentielle Sicherung    D

Transaktionsprotokollsicherung  T

V
merkt sich Dateien + Pfade 
Checkpoint zum Zeitpunkt der Sicherung
Sicherung des Zeitpunkts der Sicherung selbst


D
sichert nur die geänderten Seiten / Blöcke weg seit der letzten V Sicherung
Checkpoint


T
sichert den Weg der Daten (INS UP DEL...)
und muss entprechend auch wieder durchgegangen werden


Was ist der schnellste Restore:?
V

Wie lange dauert der restore eines T?    --- Tsicherug.bak  122039434 bytes   -- Sek
dauert so lange wie die Anweisungen im Original dauerten



Die Sicherungen sind vom sog Wiederherstellungsmodel abhängig...

Einfach
protokolliert : I U D  Bulk (rudimentär)
TX (die committed sind) werden automatisch aus dem Log entfernt
-->keine LogSicherung.. wird nicht sehr stark wachsen

--=== Es kann nur der Backupzeitpunkt restored werden

Massenprotokolliert
wie Model Einfach
TX werden nicht aus dem Log entfernt
Das Logfile muss immer wieder geleert werden, damit es nicht unendlich wächst
---> LogSicherung !!!

--=== Es kann nur der Backupzeitpunkt restored werden
------------------> es kann auf die Sekunden restored werden, aber nur wenn keine BULK stattfand


Vollständig
wie Einfach , aber auch Bulk sehr exakt
--> es wird nichts gelöscht aus dem Log

--> es kann auf die Sekunden restored werden
--es wird umfangreichern (mehr) prokolliert


! V  n   6:00
	T
	T
	T
		D
	T
	T
	T
!		D 15:00
	T   I UUUUU DDDDDIIII
	T   IIIDDDDDUUUDLDI
	T      IIIUUUUUDDIIIII        18:00


	Zwei Aussagen zur Sicherung sind wichtig ?

	1) Wie lange darf ein Server / DB ausfallen? --> Hochverfügbarkeit
	2) Wie groß darf der Datenverlust in Zeit sein? -- Intervall der Sicherung


	Fälle: was kann passieren

	a) Logischer Fehler : verkacktes Update mit bzw ohne where
	b) Server ist tot.. brauchen anderen Server Backup einspielen
	c) Server ist tot, aber HDDs leben --> Datendateien statt Backup
	d) Wenn man weiß, dass gleich was passiert.......


*/

--VOLLSICHERUNG
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' 
WITH  RETAINDAYS = 14, NOFORMAT, NOINIT,  NAME = N'Northwind-Full', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--RETAINDAYS: wann werden Sicherung aus der BAK Datei gelöscht
--NOFORMAT: Die Sicherungsdatei nicht intern löschen

--DIFFSICHERUNG
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH  DIFFERENTIAL ,
RETAINDAYS = 14, NOFORMAT, NOINIT,  NAME = N'Northwind-Diff', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--TLOGSICHERUNG
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' 
WITH  RETAINDAYS = 14, NOFORMAT, NOINIT,  NAME = N'Northwind-Log', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


--  V TTT D TTT D TTT


--Fall: Restore auf anderen Server


--Tipp:: Immer die Std Pfade verwenden


--Fall: DB muss restored wg logischen Fehler (verkacktes Update)
--mit geringst möglichen Datenverlust

--Idee... Kundenadressen wurden versehentlich geändert (falsche Adressen)
--DB restoren unter anderen Namen (auch andere Dateien)
--auf Dateinamen aufpassen... 




--Fall: Restore wg umfangreichen logischen Fehler
--DB muss restored werden
--mit geringst möglichen Datenverlust

--6:00 V
--9:00 D
--alle 30min T 

--Error um  11:03
--akt 11:18
--nächste Sicherung : 11:30


--Letzte Sicherung : 18min Verlust, weil letzte Sicherung 11:00

--Warten auf 11:30, dann restore von 11:02.... Datenverlust : 28 min

--Sicherung verlaufen ONLINE
--Jetzt (11:18) Sicherung , dann Restore von 11.02  Sicherung läuft 5 min.. und alle Änderungen seit Beginn der Sicherung sind weg


--zuerst alle User runterkicken und keine neuen Connections erlauben
--restore auf Sekunden genau


USE [master]
ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE --User kicken--keinen IUD auf DB mehr möglich
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind_LogBackup_2022-04-01_11-10-46.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind_LogBackup_2022-04-01_11-10-46', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
--alles bis zum letzte i-Tüpfelchen gesichert

RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind\Northwind_backup_2022_04_01_110500_8272307._diff.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind_LogBackup_2022-04-01_11-10-46.bak' WITH  NOUNLOAD,  STATS = 5,  STOPAT = N'2022-04-01T11:11:00'
ALTER DATABASE [Northwind] SET MULTI_USER

GO




--Server tot.. HDD / Dateien leben

--Dateien lassen sich nicht kopieren , wenn sie im Betrieb sind....
--DB trennen oder offline setzen

--Offline.. nicht mehr zugreifbar, aber sichtbar


ALTER DATABASE [NorthwindX] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
EXEC master.dbo.sp_detach_db @dbname = N'NorthwindX'
GO


USE [master]
GO
CREATE DATABASE [NorthwindX] ON 
( FILENAME = N'D:\_SQLDB\Nwind\northwnd.mdf' ),
( FILENAME = N'D:\_SQLDB\Nwind\northwnd.ldf' ),
( FILENAME = N'D:\_SQLDB\Nwind\NwindHotdata.ndf' )
 FOR ATTACH
GO


--Fall: Server tot.. HDD lebt, aber leider nicht die LDF

USE [master]
GO
CREATE DATABASE [NorthwindX] ON 
( FILENAME = N'D:\_SQLDB\Nwind\northwnd.mdf' ),
( FILENAME = N'D:\_SQLDB\Nwind\NwindHotdata.ndf' )
 FOR ATTACH
GO
--LDF wurde automatisch neu erstellt...


--Was wäre wenn : mdf defekt oder weg?
--Kacke! Backup!!