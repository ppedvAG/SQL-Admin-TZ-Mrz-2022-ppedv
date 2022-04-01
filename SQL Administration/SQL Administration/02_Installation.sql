/*

Sicherheit
Auth (NT oder gemischte Auth (NT und SQL) )
gemischten Auth:  SA ---> God Mode : kompexes Kennwort und evtl später deaktivieren
Windows Admins sind keine SQL Admins! 


Instanzfrage
komplette eig total isolierte Installation  ..bvis zu 50 Installation
										Port						Aufruf
StdInstanz			  :			1433					"PC"
benannten Instanz:			Random				"PC\Instanzname"


DB Dateien
normalerweise 2 Dateien pro DB :
	.mdf master Data File (Daten)
	.ldf   log DAta File      (Transaktionsprotokoll)

Tipp: Perfomance : trenne Daten von Log pyhsiklisch per HDD 


Dienste
SQL Server = DB Engine
SQL Agent = Jobs , EMail,, alles per Zeitplan
SQL Browser = Client-> benannte Instanz      Port 1434 UDP
  = Waschweib


  NT Service\MSSQL$FE
   virtuelle Dienstkonten
   --lokale Konten.. im Netzwerk mit Computerkonto arbeiten


   --Nicht der User, der einen TSQL Code ausführt , ist derjenige der auf externe Ressourcen zugreift
   --ist es ein Zeitplan?... dann SQL Agent..Ausnahem : Proxy Konten
   --ist es kein Zeitplan? .. dann SQL Server 

   ---der lokale!!! Zugriff wird in der Regel immer mit dem NT Service Konto geregelt..auch wenn man für die Dienste ein Dom User zur Verfügung stellt


Instanz-Features
Mehrfach installierbar

SQL DB Engine
Volltextsuche + Replikation


Freigegene Features
nur 1 mal pro Rechner
Client Konnektivität


Schulung\Administrator
ppedv2019!



Volumwartungstask


TempDB
Anzahl der Dateien : 4 (= Anzahl der Prozessoren , aber max 8 )
tempdb eig HDDs



MAXDOP
max Anzahl an Prozessoren für eine Abfrage: max 8 , sonst Anzahl der Prozessoren


Arbeitsspeicher: Berücksichtige das OS... MAX RAM für SQL Server





*/