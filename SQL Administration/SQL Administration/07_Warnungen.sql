--Warnungen

/*
Ebenen:
16...  DAU
15 .. Depp
14... kein Recht
1-10 reine Infos
17.. uff Arbeit
..
23.. muss aufs Klo
24.. bist auf dem Klo und suchst verzweifelt Auswege
25  bist auf dem Klo und buchst Last Minute reisen,, die sofort losgehen



*/

select *  from xyz

select * from sysmessages where msgLangid = 1031

USE [msdb]
GO

/****** Object:  Alert [Security_Nwind_AccessDenied]    Script Date: 30.03.2022 12:11:21 ******/
EXEC msdb.dbo.sp_add_alert @name=N'Security_Nwind_AccessDenied', 
		@message_id=0, 
		@severity=14, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=0, 
		@database_name=N'Northwind', 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

