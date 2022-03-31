/* aus was bestehen eiglt die Dateien?



1 Seiten =  8192 bytes --> 1 Block = 64 kb

1 Seiten hat max 700 Slots für DS
1 DS kann max 8060bytes groß werden bei fixen Längen
1 Seiten kann nicht mehr als 8072bytes Datenbestand haben
1 DS muss in Seiten passen

SQL liest Seiten 1:1 in RAM


*/
create table test (id int identity, spx varchar(4100), sp2 char(4100))--geht

create table test (id int identity, spx varchar(4100), sp2 char(4100))
--Error: 8060 Bytes.

--Datentypen text, image varchar(max), char(max) --- 2 GB

create table t3 (id int identity, spx char(4100));:
GO

insert into t3
select 'XY'
 GO 20000 --11 Sekunden

 --Wie groß ist die Tabelle t3?
 --20000*4 KB = 80MB
 --aber !! = 160MB 
 --..und hat 160MB im RAM

 --alle Seiten der Tabelle werden 1:1 in RAM geladen

 --warum aber nun 160MB?

 --1 DS hat aktuell in T3 hat 4100bytes (ca 51% der Seite---8060)
 --nur 1 DS passt in eine Seite

 --je mehr Seiten desto mehr CPU desto mehr RAM Verbrauch!!!!

 ---ZIEL: Reduziere die Seitenzahlen

 --kann man Seiten der Tabellen messen ..am besten immer die Tabelle angeben

 dbcc showcontig('t3')

 --- Gescannte Seiten.............................: 20000
 --- Mittlere Seitendichte (voll).....................: 50.79%


 --kann man die Seiten messen, die eine Abfrage verbraucht

 set statistics  io, time on --Anzahl der Seiten , CPU Dauer in ms und gesate Dauer in ms

 select * from t3 where id = 10 --




