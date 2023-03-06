USE Northwind;

-- WHERE: Ausgabe filtern nach Bedingungen
-- Operatoren
	-- <, >, <=, >= kleiner, größer, kleiner-gleich, größer-gleich
	-- =, !=, <> gleich, ungleich, ungleich
	-- BETWEEN, IN, LIKE: BETWEEN: Zwischen X und Y, IN: innerhalb einer Liste
	-- AND, OR: Bedingungen verknüpfen, AND: Beide Bedingungen müssen wahr sein, OR: Mindestens eine Bedingung muss wahr sein
	-- NOT: Bedingungen invertieren

SELECT * FROM Orders WHERE Freight > 50; --Bestellungen mit Freight mindestens 50

SELECT * FROM Orders WHERE Freight < 50; --Bestellungen mit Frachtkosten weniger als 50

SELECT * FROM Orders WHERE EmployeeID = 1; --Alle Bestellungen vom Employee 1 finden

SELECT * FROM Orders WHERE EmployeeID = 1 AND Freight > 50; --Alle Bestellungen vom Employee 1 die mindestens 50 Frachtkosten hatten

SELECT * FROM Orders WHERE EmployeeID = 1 OR Freight < 10; --Alle Bestellungen vom Employee 1 und/oder alle Bestellungen mit Frachtkosten < 10

--BETWEEN

SELECT * FROM Orders WHERE Freight BETWEEN 10 AND 20; --Alle Bestellungen mit Frachtkosten zwischen 10 und 20

SELECT * FROM Orders WHERE EmployeeID BETWEEN 1 AND 3; --Grenzen sind bei BETWEEN inkludiert

SELECT * FROM Orders WHERE OrderDate BETWEEN '19970101' AND '19970330'; --Datum mit BETWEEN nur ohne Bindestriche möglich

SELECT * FROM Orders WHERE OrderDate BETWEEN '1997-01-01' AND '1997-30-03'; --Hier muss Tag und Monat vertauscht werden

--Funktionen

SELECT * FROM Orders WHERE YEAR(OrderDate) = 1997; --Funktionen im WHERE verwenden

SELECT * FROM Orders WHERE MONTH(OrderDate) = 10; --Bestellungen im Oktober finden

SELECT * FROM Orders WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 10;

--IN

--Szenario: Ich möchte alle Kunden aus UK, USA oder Spain finden
SELECT * FROM Customers WHERE Country = 'UK' OR Country = 'USA' OR Country = 'Spain'; --Lang und unübersichtlich

SELECT * FROM Customers WHERE Country IN('UK', 'USA', 'Spain'); --Selbiges wie oben nur mit IN

SELECT * FROM Orders WHERE EmployeeID IN(1, 2, 5, 8); --Numerische Werte auch möglich bei IN

SELECT * FROM Orders WHERE YEAR(OrderDate) IN(1997, 1998); --IN mit Funktion

--NULL

--Leere Werte (gelb hinterlegt), Zellen mit leeren Werten sind nicht automatisch NULL -> Zellen ohne NULL sind nicht leer

SELECT * FROM Customers WHERE Fax = NULL; --NULL Vergleiche funktionieren nicht mit = und !=

SELECT * FROM Customers WHERE Fax IS NULL; --IS NULL/IS NOT NULL um zu schauen welche Datensätze leer sind

SELECT * FROM Customers WHERE Fax IS NOT NULL;

--NOT

SELECT * FROM Orders WHERE Freight NOT BETWEEN 10 AND 20;

SELECT * FROM Orders WHERE EmployeeID NOT IN(1, 2, 5, 8);