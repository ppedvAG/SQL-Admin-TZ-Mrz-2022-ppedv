--HADR

/*

1) LogShipping
Backup Log  (auf OrigDB) / Kopieren und Restore Log automatisiert (auf Zielserver)
Zeitdiff: mind 2 min.. idR mehr
ZielDB: lesbar
Replika: 1:N
Pro Replika andere Zeitdifferenzen
Voraussetzung : \\Freigabe  (Datei kopieren)
Vollst Backup auf anderen Server herstellen (Standby oder no Recovery)
RecModel: Bulk oder höher

Kann der Client bei Ausfal sofoert zu m anderen zugreifen und produktiv werden
Nein und nein
kein autom FO
kein Client Redirect 

Dauer des Einrichtens: 1min .. Cool ein Assi ;-)
Troubleshooting: Kopieren Rechte auf Pfade und Freigaben (Jobverlauf)




http://blog.fumus.de/sql-server/sql-server-problem-beim-einrichten-der-spiegelung?msclkid=d8bce5fcb57c11ec8295dc47b0084df7
2) Spiegeln
 DB synchon (asynchron)
 Idee: TX übertragen über Endpunkte Port 5022.. eig Kanal
 DB : DB   1:1 nur ein Replika  ..nicht lesbar

 nur wenn man einen Zeugen (muss SQL Instanz sein,,SQL Express)
 Failover unter 3 sekunden

 Client Redirect ??  Änderungen am Client notwendig ConnString (Failover Partner)


 Voraussetzung
 V+T restore auf Server 2 no recovery 
 RecModel: Full

 Wie lange zum Einrichten :  10sek
 Probleme: SQL Dienstkonto --Login auf beiden Seiten und Zugriff auf den Endpunkt 5022

 ist depricated



 3 ) Cluster
 keine sync DB
 Netzwerkstorage auf dem die DB sind
 Ausfall des Dienstes

 autom Failover
 Client redirect

 kein Sync von Logins oder Jobs notwendig

 Voraussetzung
 NT Cluster + SQL Cluster 

 Wie lange braucht man:  5min
 SQL Cluster: 5 pro Server

 Mehrheitsentscheind kann auch per \\

 Problem: NT Cluster an der Backe




 4) 
 was war best of: 
 Logshipping:  
 
 Assi;-) mehrer Replika lesbar
  Troubleshooting rel einfach


  Spiegel: 
  sync DB
  Assi
  Failover unter 3 Sek

  Cluster:
  autom Client redirect
  autom Failover
  Virt Name im Netz

  Hochverfügbarkeitsgruppe

  sync DB lesbar (asnyc)
  1:7 Replica
  virt Namen im Netz
  autom Failover
  autom Client Redirect 
  unter 3 Sek Failover
  keinen SQL Cluster
  brauche ein NT Cluster
  Lastenausgleioch für Lesen

  DB Gruppe (funktioniert wie ein DB oder SQL Knoten)--virt Name im Netzwerk .. bei Aufall einer DB 
  --failover der ganzen Gruppen

  Enterprise..ausser SQL 2016 Sp1 und höher ab Standard (nur 1:1 nicht lesbar, aber Cluster Vorzüge)




  alle Lösungen lassen sich auch kombinieren

  im Prinzip = Spiegeln


















3) SQL Cluster
4) Hochverfügbarkeitsgruppen
5) Replikation






*/