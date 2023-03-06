USE Northwind; --Datenbank auswählen

/*
Mehrzeilige
Kommentare
*/

--SELECT: Spalten auswählen die geholt werden

SELECT 100; --Einzelnen Wert ausgeben

SELECT 10.5; --Kommazahl mit Punkt statt mit Komma

SELECT 'Test'; --Texte mit Hochkomma herum ''

--Strg + E: Markiertes Statement ausführen
--Strg + R: Ergebnisansicht schließen

SELECT 100 * 3; --Berechnung

SELECT '100 * 3'; --Wird als Text interpretiert (und nicht berechnet)

SELECT 100 AS Zahl; --Mit AS einer Spalte einen Namen geben

SELECT 100 AS Z1, 200 AS Z2, 300 AS Z3; --Mehrere Spalten auswählen mit Komma getrennt

--FROM: Tabelle auswählen aus der die Daten geholt werden

SELECT * FROM Customers; --*: Alle Spalten und Datensätze

SELECT CompanyName, ContactName FROM Customers; --Bestimmte Spalten auswählen

SELECT Freight * 5 FROM Orders; --Einfache Berechnung

SELECT Freight % 5 FROM Orders; --Modulo: Gibt den Rest einer Division zurück

SELECT *, UnitPrice * Quantity FROM [Order Details]; --Berechnungen zwischen Spalten

SELECT Address + City + PostalCode + Country FROM Customers; --Strings (Texte) verbinden (unschön)

SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country FROM Customers; --Strings verbinden mit Abständen

SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS [Volle Adresse] FROM Customers;
SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS "Volle Adresse" FROM Customers;
SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS 'Volle Adresse' FROM Customers;
--Namen mit Abständen müssen mit [], "" oder '' angegeben werden

--Umbrüche sind beliebig möglich
SELECT --SELECT kann mehrere Zeilen beanspruchen
CompanyName,
ContactName,
Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS [Volle Adresse]
FROM Customers; --Befehle allgemein (z.B.: FROM) sollten in einer Zeile sein