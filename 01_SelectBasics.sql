USE Northwind; --Datenbank ausw�hlen

/*
Mehrzeilige
Kommentare
*/

--SELECT: Spalten ausw�hlen die geholt werden

SELECT 100; --Einzelnen Wert ausgeben

SELECT 10.5; --Kommazahl mit Punkt statt mit Komma

SELECT 'Test'; --Texte mit Hochkomma herum ''

--Strg + E: Markiertes Statement ausf�hren
--Strg + R: Ergebnisansicht schlie�en

SELECT 100 * 3; --Berechnung

SELECT '100 * 3'; --Wird als Text interpretiert (und nicht berechnet)

SELECT 100 AS Zahl; --Mit AS einer Spalte einen Namen geben

SELECT 100 AS Z1, 200 AS Z2, 300 AS Z3; --Mehrere Spalten ausw�hlen mit Komma getrennt

--FROM: Tabelle ausw�hlen aus der die Daten geholt werden

SELECT * FROM Customers; --*: Alle Spalten und Datens�tze

SELECT CompanyName, ContactName FROM Customers; --Bestimmte Spalten ausw�hlen

SELECT Freight * 5 FROM Orders; --Einfache Berechnung

SELECT Freight % 5 FROM Orders; --Modulo: Gibt den Rest einer Division zur�ck

SELECT *, UnitPrice * Quantity FROM [Order Details]; --Berechnungen zwischen Spalten

SELECT Address + City + PostalCode + Country FROM Customers; --Strings (Texte) verbinden (unsch�n)

SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country FROM Customers; --Strings verbinden mit Abst�nden

SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS [Volle Adresse] FROM Customers;
SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS "Volle Adresse" FROM Customers;
SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS 'Volle Adresse' FROM Customers;
--Namen mit Abst�nden m�ssen mit [], "" oder '' angegeben werden

--Umbr�che sind beliebig m�glich
SELECT --SELECT kann mehrere Zeilen beanspruchen
CompanyName,
ContactName,
Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS [Volle Adresse]
FROM Customers; --Befehle allgemein (z.B.: FROM) sollten in einer Zeile sein