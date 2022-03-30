--HV-SQL 1

/*


der Server (VM( hatte nach Instalation 2 Kerne mehr bekommen---> muss man manuell wieer anpassen


NUmaKnoten 1   4 Kerne

Auth:
gemischte Auth

RAM 5500MB ( HV-SQL 2: 4500MB)
0 bis 2,1 PB
Max RAM: 3000  

Standard Pfade der DBs
C.\_SQLDBS
C:\BACKUP
+ Backup komprimieren

MAXDOP
Kostenschwellwert: 5
Maxdop 2

Tempdb Dateien
2 Datenddateien und 1 Logfile
--> soviele Dateien wie Kerne und gleiche Größe wie die anderen Dateien

