
Create database TestDB


/*
Wieviele Fehler haben wir eben gemacht??

1: Wie gro� ist die DB?
16 MB

8 MB Datenfile
8 MB Logfile

2. Wachstumrate?
64 MB

fr�her 2014
DB  per default ca 7 MB (5 MB Daten / 2 MB LogFile)
  Wacshtum  Daten + 1MB  Logfile + 10%

  ----> permanent IO  !!!


  --Bessere Startgr��en:
  --Wie gro� in 3 bis 5 Jahren etwa (Lebenszeit des Server)
  Wachstum der Datendatei .. seleten aber wenig aufwendig (1000MB)
  --> Volumewartungstask (Setup) --> kein Ausnullen .. Wachstum geht schneller


  Das Logfile sollte nie wachsen_-> Backup
  Das Logfile hat etwa 25 - 30% Volumen der Datendateien

  --Lok Sicherhehtisrichtlinie --> Lokale Richtline --> Zuweisen von Benutzerrechten -->Durchf�hren von  Volume...

  Durchf�hren von Volumewartungsaufgaben

Mit dieser Sicherheitseinstellung wird festgelegt, welche Benutzer und Gruppen Wartungsaufgaben auf einem Volume ausf�hren k�nnen, zum Beispiel eine Remotedefragmentierung.

Gehen Sie beim Zuweisen dieses Benutzerrechts vorsichtig vor. Benutzer mit diesem Benutzerrecht k�nnen Datentr�ger durchsuchen und Dateien in den Speicher erweitern, der andere Daten enth�lt. Wenn die erweiterten Dateien ge�ffnet werden, kann der Benutzer m�glicherweise die so erlangten Daten lesen und �ndern.

Standardwert: Administratoren



Kann man nachsehene, wie voll meine DB ist ?
--Kontext DB --> Berichte -- Datentr�gerverwendung








*/


use testdb;
GO


select * into t1 from sysmessages


--Wo liegt die Tabelle t1 physikalisch ?  ..mdf Datei!

--Tabellen auf anderen Datentr�ger...

--> Dateigruppe

--     .mdf = PRIMARY


create table tabellenname (id int..) ON DATEIGRUPPE (= Datei .mdf | .ndf


create table t2 (id int) on HOT --eigtl  c.\SQLDBS\hotdata.ndf


--Lege auf Northwinebenfalls eine Dgruppe HOT mit Datendatei an!

--best Tabellen auf andere DGruppe schieben...?





