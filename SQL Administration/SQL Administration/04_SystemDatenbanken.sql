/*

tempdb
eig HDDs besitzten und soviele Dateien wie Kerne max 8
nach jedem SQL- Neustart wird die tempdb neu initialisiert

#t ##t
Zeilenversionierung
IX Wartung

Backup?  
N�..!



master
"Herz"
Logins 
Datenbanken
Konfiguration

Backup ?
Jo ..unbedingt!!


model
Vorlage f�r neue DBs
create database testdb... Kopie der model
�nderung an model hat eine Auswirkung auf alle nachfolgenden neuen DB

Backup model? 
bei �nderung eigtl ja..aber IDee : Script = Doku und geht viel schnelle

USE [master]
GO
ALTER DATABASE [model] SET RECOVERY SIMPLE WITH NO_WAIT
GO


msdb
Db f�r den Agent (Jobs, Verlauf, Emailsystem...)





distribution : wenn Replikation


Regelm��ige Sicherung aller SystemDBs


per Wartungplan t�glich!!

Cleanup: Verlauf bereinigen und alte Sicherung l�schen

Verteilen der Wartungpl�ne auf mehrere Server:
Idee: Script generieren und per Regstrierte Server verteilen






*/