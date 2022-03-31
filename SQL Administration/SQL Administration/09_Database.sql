
Create database TestDB


/*
Wieviele Fehler haben wir eben gemacht??

1: Wie groß ist die DB?
16 MB

8 MB Datenfile
8 MB Logfile

2. Wachstumrate?
64 MB

früher 2014
DB  per default ca 7 MB (5 MB Daten / 2 MB LogFile)
  Wacshtum  Daten + 1MB  Logfile + 10%

  ----> permanent IO  !!!


  --Bessere Startgrößen:
  --Wie groß in 3 bis 5 Jahren etwa (Lebenszeit des Server)
  Wachstum der Datendatei .. seleten aber wenig aufwendig (1000MB)
  --> Volumewartungstask (Setup) --> kein Ausnullen .. Wachstum geht schneller


  Das Logfile sollte nie wachsen_-> Backup
  Das Logfile hat etwa 25 - 30% Volumen der Datendateien

  --Lok Sicherhehtisrichtlinie --> Lokale Richtline --> Zuweisen von Benutzerrechten -->Durchführen von  Volume...

  Durchführen von Volumewartungsaufgaben

Mit dieser Sicherheitseinstellung wird festgelegt, welche Benutzer und Gruppen Wartungsaufgaben auf einem Volume ausführen können, zum Beispiel eine Remotedefragmentierung.

Gehen Sie beim Zuweisen dieses Benutzerrechts vorsichtig vor. Benutzer mit diesem Benutzerrecht können Datenträger durchsuchen und Dateien in den Speicher erweitern, der andere Daten enthält. Wenn die erweiterten Dateien geöffnet werden, kann der Benutzer möglicherweise die so erlangten Daten lesen und ändern.

Standardwert: Administratoren



Kann man nachsehene, wie voll meine DB ist ?
--Kontext DB --> Berichte -- Datenträgerverwendung








*/


use testdb;
GO


select * into t1 from sysmessages


--Wo liegt die Tabelle t1 physikalisch ?  ..mdf Datei!

--Tabellen auf anderen Datenträger...

--> Dateigruppe

--     .mdf = PRIMARY


create table tabellenname (id int..) ON DATEIGRUPPE (= Datei .mdf | .ndf


create table t2 (id int) on HOT --eigtl  c.\SQLDBS\hotdata.ndf


--Lege auf Northwinebenfalls eine Dgruppe HOT mit Datendatei an!

--best Tabellen auf andere DGruppe schieben...?





