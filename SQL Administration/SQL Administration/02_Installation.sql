/*

Sicherheit
Auth (NT oder gemischte Auth (NT und SQL) )
gemischten Auth:  SA ---> God Mode : kompexes Kennwort und evtl sp�ter deaktivieren
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

Tipp: Perfomance : trenne Daten von Log pyhsiklisch per HDD standardm��ig 
pro DB �berlegen .. muss die MessdatenDB auch dort sein wo der Amazon Shop l�uft





Dienste
SQL Server = DB Engine
SQL Agent = Jobs , EMail,, alles per Zeitplan
SQL Browser = Client-> benannte Instanz      Port 1434 UDP
  = Waschweib


  NT Service\MSSQL$FE
   virtuelle Dienstkonten
   --lokale Konten.. im Netzwerk mit Computerkonto arbeiten

   Volumewartungstask:  ?  Lokale Sicherheitsrichtlinie
   --bei Verg��erungen werden 0 geschrieben
   -- wird nicht mehr ausgenullt!!

   ---------------------------------------
   XXXXXXXXXXXXXXXXXXxxxxxxxxxxx
   ---------------------------------------

   einem guten admin ist das egal... anst�ndige Wachstumsraten , nicht 1 MB !!!!!!! -Kontrolle.
   --DB gleich mal korrekte Anfangsrg��e (in 3 Jahren)

   --Nicht der User, der einen TSQL Code ausf�hrt , ist derjenige der auf externe Ressourcen zugreift
   --ist es ein Zeitplan?... dann SQL Agent..Ausnahem : Proxy Konten
   --ist es kein Zeitplan? .. dann SQL Server 

   ---der lokale!!! Zugriff wird in der Regel immer mit dem NT Service Konto geregelt..auch wenn man f�r die Dienste ein Dom User zur Verf�gung stellt


Instanz-Features
Mehrfach installierbar

SQL DB Engine
Volltextsuche + Replikation


Freigegene Features
nur 1 mal pro Rechner
Client Konnektivit�t


Schulung\Administrator
ppedv2019!



Volumwartungstask


TempDB
Anzahl der Dateien : 4 (= Anzahl der Prozessoren , aber max 8 )
tempdb eig HDDs

wieso 8 Dateien: weil 8 Kerne

+ T1118 T1117
alle Dateien sind gleich gro� (bei automatischen Wachstum)
gilt nur bis jmd die Dateien manuel ungleich vergr��ert



jeder Zugriff auf Seiten /Bl�cke ist single thread...
daher keine gemischten Bl�cke in temdb sondern uniform extents

-- wie Traceflag setzen?
Zb Startarameter in SQL Konfig Manager bei den SQL Diensten




#tab ##tab  Zeilenversionierung IX Wartung Auslagerungen
--die TempDB gibts nur einmal, aber evtl 100DBs und 1000 User und 50 Softwares

--sozusagen der M�llschlucker... 



MAXDOP
max Anzahl an Prozessoren f�r eine Abfrage: max 8 , sonst Anzahl der Prozessoren
Kostenschwellwert korrigeren (default 5)

Arbeitsspeicher: Ber�cksichtige das OS... MAX RAM f�r SQL Server

Gesamten RAM -OS (2 bis4GB)  -Konkurrenz (andere SQL Instanz)
Mind RAM bei Bedarf (bei Konkurrenz)





*/