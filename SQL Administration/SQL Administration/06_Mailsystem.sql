/*

SQL Server = SMTP Client


SMTP Server:
Port:
Auth:

Profil:  GMX  (konten) ..einfacher Name!!
	�fftl : Gruppe (=Rolle).. DatabasemailuserRole
				MSDB!!

				jder , der hier dirn ist, darf ein �ftl Profil verwenden
	
	+ privat
				Rechte m�sse explizit dem User zu gewiesen werden

	es wurde automatisch dem GUEST ein Zugriff uf das �fftl Profil gegeben
	---passiert nicht bei SQL 2014 oder fr�her




	IIS 6
	smpt Server

	funktioniert rein �ber Ordner


	TITLE: Start Jobs - KAIRO
------------------------------

Execution of job 'Demoauftrag' failed.  See the history log for details.


C:\inetpub\mailroot


Pickup: Mails die gesendet werden sollen

DROP : ankommende Emails

	*/

	exec msdb..sp_send_dbmail [GMX-Profil]




	--Benachrichtigung...

	--> Operatoren:
	USE [msdb]
GO
EXEC msdb.dbo.sp_add_operator @name=N'Andreas', 
		@enabled=1, 
		@pager_days=0, 
		@email_address=N'andreas@sql.local'
GO

--Nachricht senden bei Fehler/Erfolg /Beendigung
--an Operator


--Auch der Agent soll am Ende des Auftrage eine Nachricht senden
--dazu muss der Agent ein Mail Profil aktiv haben

--> Eigenschaften des Agent: Warnungssytem.. Profil w�hlen und aktivieren
USE [msdb]
GO
EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder=1, 
		@databasemail_profile=N'SQLOCAL'
GO


--Agent neu starten!!!!!



--Das Agent Konto muss das Recht auf ein Profil haben
--DatabasemailUserRole!!

--Siehe SQL 2014 und fr�her.. hier wird das Gastkonto nicht autmatisch 
--in msdb aktviert und der DatabasemailuserRole zugeordnet

