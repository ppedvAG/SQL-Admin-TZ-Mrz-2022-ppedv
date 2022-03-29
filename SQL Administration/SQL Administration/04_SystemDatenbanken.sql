/*

tempdb
eig HDDs besitzten und soviele Dateien wie Kerne max 8
nach jedem SQL- Neustart wird die tempdb neu initialisiert

#t ##t
Zeilenversionierung
IX Wartung

Backup?  
Nö..!



master
"Herz"
Logins 
Datenbanken
Konfiguration

Backup ?
Jo ..unbedingt!!


model
Vorlage für neue DBs
create database testdb... Kopie der model
Änderung an model hat eine Auswirkung auf alle nachfolgenden neuen DB

Backup model? 
bei Änderung eigtl ja..aber IDee : Script = Doku und geht viel schnelle

USE [master]
GO
ALTER DATABASE [model] SET RECOVERY SIMPLE WITH NO_WAIT
GO


msdb
Db für den Agent (Jobs, Verlauf, Emailsystem...)





distribution : wenn Replikation


Regelmäßige Sicherung aller SystemDBs


per Wartungplan täglich!!

Cleanup: Verlauf bereinigen und alte Sicherung löschen

Verteilen der Wartungpläne auf mehrere Server:
Idee: Script generieren und per Regstrierte Server verteilen






*/