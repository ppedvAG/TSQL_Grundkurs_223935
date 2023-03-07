USE Northwind;

SELECT COUNT(*) FROM Customers; --Anzahl der Datensätze

SELECT COUNT(*) FROM Customers WHERE Country = 'UK'; --Anzahl Customer aus UK (7)

SELECT COUNT(DISTINCT Country) FROM Customers; --Anzahl einzigartiger (verschiedener) Länder (22)

SELECT
AVG(Freight) AS Durchschnittskosten,
SUM(Freight) AS Gesamtkosten,
MIN(Freight) AS BilligsteBestellung,
MAX(Freight) AS TeuersteBestellung
FROM Orders
WHERE Freight > 100; --Können auch mit WHERE kombiniert werden

---------------------------------------------------------------------------------------

SELECT * FROM Orders GROUP BY EmployeeID; --1er Gruppe (10258, 10270, 10275, ...), 2er Gruppe (11073, 11070, 11060, ...), ...
--Jede Gruppe enthält die Datensätze mit der entsprechenden EmployeeID
--Spalten die nicht in der Gruppierung sind können nicht selektiert werden

SELECT
EmployeeID, --Spalten in GROUP BY können immer im SELECT direkt verwendet werden
COUNT(*) AS AnzBestellungen, --Aggregatsfunktionen beziehen sich hier auf die Gruppen anstatt auf die gesamte Tabelle
AVG(Freight) AS Durchschnittskosten,
SUM(Freight) AS Gesamtkosten,
MIN(Freight) AS BilligsteBestellung,
MAX(Freight) AS TeuersteBestellung
FROM Orders
GROUP BY EmployeeID
ORDER BY EmployeeID;

--Wie viele Kunden haben wir pro Land?
SELECT 
Country,
COUNT(*) AS AnzKunden
FROM Customers
GROUP BY Country --Ländergruppen: UK, USA, Spain, ...
ORDER BY AnzKunden DESC; --Sortierung nach Alias

--Wie schauen die Rechnungssummen aus?
SELECT 
OrderID,
COUNT(*) AS AnzahlProdukte,
SUM(UnitPrice * Quantity * (1 - Discount)) AS Rechnungssumme
FROM [Order Details]
GROUP BY OrderID --Bestellungsgruppen: 10248, 10249, 10250, ...
ORDER BY Rechnungssumme DESC;

--Wie viele Kunden haben wir pro Land und Stadt?
SELECT 
Country,
City,
COUNT(*) AS AnzKunden
FROM Customers
GROUP BY Country, City --Länder- und Stadtgruppen: UK, London    UK, Cowes ...
ORDER BY AnzKunden DESC, Country;

--Wenn nach einem Schlüssel gruppiert wird, dann können weitere Spalten kostenlos hinzugefügt werden
SELECT CustomerID, CompanyName
FROM Customers
GROUP BY CustomerID, CompanyName; --CompanyName kostenlos, weil die Gruppierung nach CustomerID pro Gruppe nur einen Datensatz enthält (weil Key eindeutig)

--Wie hoch waren die durchschnittlichen Frachtkosten pro Jahr?
SELECT
YEAR(OrderDate) AS Jahr,
COUNT(*) AS AnzBestellungen,
AVG(Freight) AS Durchschnittsfrachtkosten
FROM Orders
GROUP BY YEAR(OrderDate) --Nach Funktion gruppieren -> Jahresgruppen: 1996, 1997, 1998
ORDER BY YEAR(OrderDate);

SELECT
MONTH(OrderDate) AS Monat,
COUNT(*) AS AnzBestellungen,
AVG(Freight) AS Durchschnittsfrachtkosten
FROM Orders
GROUP BY MONTH(OrderDate) --Monatsgruppen: Jänner, Februar, März, ...
ORDER BY MONTH(OrderDate);

SELECT
YEAR(OrderDate) AS Jahr,
MONTH(OrderDate) AS Monat,
COUNT(*) AS AnzBestellungen,
AVG(Freight) AS Durchschnittsfrachtkosten
FROM Orders
WHERE Freight < 50 --WHERE auch möglich, wird vor GROUP BY ausgeführt
GROUP BY YEAR(OrderDate), MONTH(OrderDate) --Jahres- und Monatsgruppen: 07/96, 08/96, 09/96, ...
ORDER BY YEAR(OrderDate), MONTH(OrderDate);

---------------------------------------------------------------------------------------

--WHERE vs. GROUP BY + HAVING
--WHERE filtert die Daten vorher (vor der Gruppierung)
--HAVING filtert die Gruppen (die Daten nach dem WHERE)

--Finde alle Kunden die mindestens 10 Bestellungen getätigt haben
SELECT 
CustomerID,
COUNT(*) AS AnzBestellungen
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY AnzBestellungen DESC;

SELECT 
CustomerID,
COUNT(*) AS AnzBestellungen
FROM Orders
WHERE Freight >= 100 --WHERE vor HAVING
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY AnzBestellungen DESC;

--Gib die Anzahl der Bestellungen pro Kunde aus die im Durchschnitt zwischen 50$ und 60$ Frachtkosten verursacht haben
SELECT 
CustomerID,
COUNT(*) AS AnzBestellungen
FROM Orders
GROUP BY CustomerID
HAVING AVG(Freight) BETWEEN 50 AND 60 --Alle Aggregatsfunktionen möglich, auch wenn sie oben nicht verwendet werden
ORDER BY COUNT(*) DESC; --Aggregatsfunktionen auch im ORDER BY möglich

--Finde alle Kunden, ihre Anzahl Bestellungen und den Firmennamen + Ansprechpartner
SELECT
o.CustomerID, c.CompanyName, c.ContactName,
COUNT(*) AS AnzBestellungen
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CompanyName, c.ContactName --GROUP BY mit JOIN (hier kostenlose Spalten, nachdem CustomerID ein Schlüssel ist)
ORDER BY AnzBestellungen DESC;