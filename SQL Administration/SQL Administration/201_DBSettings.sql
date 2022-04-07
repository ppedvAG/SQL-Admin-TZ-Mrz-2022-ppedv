--DB Settings

/*
Anfangsgrößen !!! wie groß in 3 Jahren ..

Wachstumsrate : mehr als 64!!!!!.. eher 1 GB


--Wo kann man Vergößerung sehen.. Bericht: Datenträgerverwendung


Sonderfall: TLOG

-------------------------------------------------
     .... | TX........| TX TX |  TX TX |  TX TX TX TX TX TX TX
-------------------------------------------------

je mehr Virtuelle Logfiles desto größer der aufwand

hängt von der Wachstumsrate ab..

10MB Logfile.. Vergößerung um 1 MB  + 10 Vergrößerungen
10 VLF                                            10 VLF     10*10 VLF


1000MB Logfile.. Vergößerung um 1000 MB  + 10 Vergrößerungen
10 VLF                                            10 VLF     10*10 VLF

siehe Skript zu VLF


--man sollte einfach nicht mehr als 3000 / 5000 VLF

--Wie kann man es zu weniger VLF bringen

--Logfiles leeren: Gute Idee TLOG Sicherung
--oder RecModel: Simple


--Trenne Daten von Logfiles

-- Dateigruppen: Trenne Stammdaten von Bewegungsdaten 


Tabellen werden immer größer....

Tab A hat 10000
TAB B hat 1000000

Abfrage bringt (ob A oder B) 10 Zeilen raus...  A!!!



Idee.. dann machen wir die tabellen kleiner!!!




*/



