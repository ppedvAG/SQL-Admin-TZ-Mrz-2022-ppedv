/*

Proxy Stellvertreterkonto f�r exterene Ressourcen
--> Name und Kennwort

ausf�hren als


manchmal soll ein Auftrag bzw ein Scxhtitt unter einem anderem Konto ausgef�hrt werden
als dem Agent Konto (NT service\sqlagent)




Login ist das Betreten des SQL Server
User sind Bestandteil einer DB.. dem User werden Rechte in der DB zugewiesen


LOGIN (SID  0x7623478294jhdfkjshkfjw98473lk2)
USER   (SID  0x7623478294jhdfkjshkfjw98473lk2)

Login Max  26
User   Max  117

Login Max ( 19)
User: Susi  (19)



-------------------------
1. Anmeldeinformation hinterlegen
		Konto und Kennwort
		USE [master]
GO
CREATE CREDENTIAL [DerWindowsAdmin] WITH IDENTITY = N'KAIRO\Administrator', SECRET = N'ppedv2020!'
GO


2.. Anmeldeinfirmation einem Proxy zurodnen

USE [msdb]
GO
EXEC msdb.dbo.sp_add_proxy @proxy_name=N'Stellvertreter_CMD',@credential_name=N'DerWindowsAdmin', 
		@enabled=1
GO
EXEC msdb.dbo.sp_grant_proxy_to_subsystem @proxy_name=N'Stellvertreter_CMD', @subsystem_id=3
GO


3. Schritt mit Proxy ausf�hren
dh.. im Job ..Schritt w�hlen ... Kategorie ausw�hlen.. Proxy ausw�hlen#

