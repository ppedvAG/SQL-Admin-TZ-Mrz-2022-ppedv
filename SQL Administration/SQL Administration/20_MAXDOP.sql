--MAXDOP

SELECT      Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipCity, Orders.ShipCountry, Employees.FirstName, Employees.LastName, [Order Details].OrderID, 
                   [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock
INTO KU
FROM         Customers INNER JOIN
                   Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                   [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                   Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
                   Employees ON Orders.EmployeeID = Employees.EmployeeID



INSERT INTO KU
SELECT * FROM KU
--So oft wiederholen bis 551000 betroffen

--Nochmnals ne Kopie
select * into ku1 from ku


--Eindeutigkeit

alter table ku1 add id int identity-- dauert koischerweise länger (27 Sek ) als der Import von 1 MIO DS (4 Sek)




select country, city, sum(unitprice*quantity)
from ku1
group by country, city


--machen mehr Kerne SInn?

--per default: 0 = alle Kerne
--heute max 8 


select country, city, sum(unitprice*quantity)
from ku1
group by country, city option (maxdop 4)

--mit 4 Kernen: , CPU-Zeit = 611 ms, verstrichene Zeit = 167 ms.


select country, city, sum(unitprice*quantity)
from ku1
group by country, city option (maxdop 4)

--mit 8 Kernen ist der CPU Aufwand gegenüber 1 Kern fast doppelt so hoch


--ab wann nimmt der SQL Server meh Kerne her?
--entweder 1 oder alle (oder MAXDOP)

--Kostenschwellwert: 5 default
--besser 25 OLAP / 50 OLTP

--Anfangswert .. gefühl tim Laufe der Zeit anpassen
--PLÄNE
---geschätzter Plan: vor Abfrage
--tats. Plan: erscheint nach Abfrage

--Seit SQL 2016 läßt sich der MAXDOP pro DB einstellen:
USE [Northwind]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 2;
GO

--der Wert der nicht 0 ist und näher an der Abfrage ist, gilt!



set statistics io, time on  -- Dauer in ms, CPU Zeit in ms und Anzahl der Seiten
--einmal pro Session aktiviert.. bis zum off

--schneller fertig  als CPU Dauer
--mehr CPUs!!
--, CPU-Zeit = 874 ms, verstrichene Zeit = 144 ms.
set statistics io, time off

--Doppelpfeil : Indz für mehr Kerne

--Tats. Plan und Eigenschaftsfenster
--kein Gleichverteilung der Mengen pro CPU Kern

