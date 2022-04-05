---auf OrigServer ausführen

sp_help_revlogin

--in Ausgabe erscheint der Code zum Anlegen aller Logins


--kann man das irgendwie automatiseren

---Job
--Idee Tools.. PS
https://docs.dbatools.io/

--SQLCMD
-- -E NT Auth
--   -U Login  -P Kennwort  --S Server

--auf QuellServer
sqlcmd -Q"sp_help_revlogin" -dmaster -o"c:\_SQLDB\logintransfer.sql"


--auf 2ten Server
sqlcmd  -i"c:\_SQLDB\logintransfer.sql" -Skairo\hr -dmaster