--DB Settings

/*
Anfangsgr��en !!! wie gro� in 3 Jahren ..

Wachstumsrate : mehr als 64!!!!!.. eher 1 GB


--Wo kann man Verg��erung sehen.. Bericht: Datentr�gerverwendung


Sonderfall: TLOG

-------------------------------------------------
     .... | TX........| TX TX |  TX TX |  TX TX TX TX TX TX TX
-------------------------------------------------

je mehr Virtuelle Logfiles desto gr��er der aufwand

h�ngt von der Wachstumsrate ab..

10MB Logfile.. Verg��erung um 1 MB  + 10 Vergr��erungen
10 VLF                                            10 VLF     10*10 VLF


1000MB Logfile.. Verg��erung um 1000 MB  + 10 Vergr��erungen
10 VLF                                            10 VLF     10*10 VLF

siehe Skript zu VLF


--man sollte einfach nicht mehr als 3000 / 5000 VLF

--Wie kann man es zu weniger VLF bringen

--Logfiles leeren: Gute Idee TLOG Sicherung
--oder RecModel: Simple


--Trenne Daten von Logfiles

-- Dateigruppen: Trenne Stammdaten von Bewegungsdaten 


Tabellen werden immer gr��er....

Tab A hat 10000
TAB B hat 1000000

Abfrage bringt (ob A oder B) 10 Zeilen raus...  A!!!



Idee.. dann machen wir die tabellen kleiner!!!




*/



