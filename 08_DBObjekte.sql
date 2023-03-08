USE Northwind;
GO --Mit GO ein Batch �ffnen/schlie�en

--CREATE VIEW <Name> AS <SQL-Statement> GO
--Gespeichertes SQL-Statement, das bei angreifen der View ausgef�hrt wird
--v_ um Views von restlichen Objekten der Datenbank zu differenzieren
--kein ORDER BY

--Sicherheit f�r bestimmte Benutzer: Zugriff auf Tabellen verbieten, aber Zugriff auf die View/Views erlauben
CREATE VIEW v_CustomerCountries
AS
	SELECT DISTINCT Country FROM Customers;
GO --Mit GO ein Batch schlie�en

SELECT * FROM v_CustomerCountries; --View ansprechen mit SELECT (+ WHERE, + ORDER BY, ...)

SELECT * FROM v_CustomerCountries WHERE Country LIKE 'A%' ORDER BY 1;

--DROP: Datenbankobjekte l�schen (Tabellen, Views, Prozeduren, Datenbanken, ...)
DROP VIEW v_CustomerCountries;
GO

CREATE VIEW v_Chefs --Komplexe Abfrage
AS
	SELECT 
	e.EmployeeID AS EmpID,
	CONCAT_WS(' ', e.FirstName, e.LastName) AS EmpName,
	chef.EmployeeID AS ChefID,
	CONCAT_WS(' ', chef.FirstName, chef.LastName) AS ChefName
	FROM Employees chef
	RIGHT JOIN Employees e ON chef.EmployeeID = e.ReportsTo;
GO

SELECT * FROM v_Chefs;

GO

----------------------------------------------------------------------------

--CREATE PROCEDURE <Name> AS <SQL-Statement> GO
--Fixes Verhalten auf der Datenbank speichern
--p_ um Prozeduren von restlichen Objekten der Datenbank zu unterscheiden
CREATE PROCEDURE p_CountriesCities
AS
	SELECT DISTINCT Country, City FROM Customers;
GO

EXECUTE p_CountriesCities; --EXECUTE <Name> um eine Prozedur auszuf�hren
EXEC p_CountriesCities; --Kurzform
p_CountriesCities;
GO

--Prozeduren mit Parameter

CREATE PROC p_OrdersFromTo @StartDate date, @EndDate date --Zwei Parameter (StartDate, EndDate)
AS
	SELECT *
	FROM Orders
	WHERE OrderDate BETWEEN @StartDate AND @EndDate; --Parameter hier unten angreifen
GO

EXEC p_OrdersFromTo @StartDate = '19970301', @EndDate = '19970401'; --Parameter m�ssen hier �bergeben werden

DROP PROCEDURE p_CountriesCities;
DROP PROC p_OrdersFromTo;

----------------------------------------------------------------------------

--Tempor�re Tabellen: Tabellen die zur Zwischenspeicherung von Daten gedacht sind, werden nach Verbindungstrennung oder Server Neustart gel�scht

--SELECT INTO: Normales SELECT bei dem das Ergebnis direkt in eine neue Tabelle gespeichert wird

SELECT Country, City
INTO Test --F�gt die Daten in eine NEUE Tabelle ein
FROM Customers
ORDER BY 1;

DROP TABLE Test;

SELECT Country, City
INTO #Test --F�gt die Daten in eine tempor�re Tabelle ein
FROM Customers; --Tempor�re Tabelle mit # am Anfang

SELECT * FROM #Test;

--Globale Tempor�re Tabellen: Sichtbar f�r alle User statt nur f�r mich, wird gel�scht wenn alle User die mit der Tabelle gearbeitet haben die Verbindung getrennt haben

SELECT Country, City
INTO ##Test --Global machen mit ##
FROM Customers;

SELECT * FROM ##Test;

----------------------------------------------------------------------------

SELECT TOP 0
Country, City
INTO Test
FROM Customers; --Tabellenstruktur kopieren

INSERT INTO Test
EXEC p_CountriesCities; --Daten aus einer Prozedur weiterverwenden