USE Northwind;

--ORDER BY: Ergebnis nach einer/mehreren Spalte(n) sortieren

SELECT * FROM Customers ORDER BY Country;

SELECT * FROM Customers ORDER BY Country, City; --Sortierung nach mehreren Spalten (Prim�r: Country, Sekund�r: City)

SELECT * FROM Customers ORDER BY Country DESC, City ASC; --ASC/DESC: Sortierrichtung vorgeben (DESC -> Absteigend, ASC -> Aufsteigend)

SELECT * FROM Customers ORDER BY 3; --Nach Spaltenindex sortieren (hier CompanyName)

SELECT CompanyName, ContactName, Address, Phone FROM Customers ORDER BY 2; --ContactName

SELECT * FROM Customers ORDER BY 9, 6; --Sortierung nach mehreren Spalten mit Indizes

SELECT CONCAT_WS(' ', TitleOfCourtesy, FirstName, LastName) AS FullName FROM Employees ORDER BY FullName; --Nach Spaltenalias sortieren

SELECT CONCAT_WS(' ', TitleOfCourtesy, FirstName, LastName) AS [Full Name] FROM Employees ORDER BY [Full Name];

--DISTINCT: Macht das Ergebnis eindeutig (filtert Duplikate)

SELECT Country FROM Customers ORDER BY 1; --Duplikate -> 91 Datens�tze

SELECT DISTINCT Country FROM Customers; --Keine Duplikate mehr -> 22 Datens�tze

SELECT DISTINCT Country, City FROM Customers; --Entfernt alle Duplikate von Kombinationen

SELECT COUNT(*) FROM Customers; --Anzahl der Customer

SELECT COUNT(*) FROM Customers WHERE Country = 'UK'; --Anzahl Customer aus UK

SELECT COUNT(DISTINCT Country) FROM Customers; --Anzahl der einzigartigen L�nder

--TOP: Gibt die obersten X Datens�tze aus (auch Prozentual)

SELECT TOP 10 *
FROM Orders; --Obersten 10 Datens�tze der Tabelle (nicht aussagekr�ftig)

SELECT TOP 10 * FROM Orders ORDER BY Freight; --Die 10 g�nstigsten Bestellungen

SELECT TOP 10 * FROM Orders ORDER BY Freight DESC; --Die 10 teuersten Bestellungen

SELECT TOP 2 PERCENT *
FROM Orders ORDER BY Freight; --Gibt die obersten 2% des Ergebnissen anhand der Anzahl der Datens�tze aus (2% der Tabelle -> 17 Datens�tze)

SELECT TOP 2 PERCENT *
FROM Orders WHERE Freight > 100; --Filterung mit WHERE zuerst -> 187 Datens�tze -> 2%: 4 Datens�tze

SELECT * FROM [Order Details]
ORDER BY Quantity; --Q1 -> Z17, Q2 -> Z69, Q3 -> Z115

SELECT TOP 2 PERCENT *
FROM [Order Details] ORDER BY Quantity; --Nur 44 Zeilen, manche Bestellungen mit Q2 werden abgeschnitten

SELECT TOP 2 PERCENT WITH TIES *
FROM [Order Details] ORDER BY Quantity; --Alle Datens�tze die ich haben wollte

SELECT TOP 4 PERCENT *
FROM [Order Details] ORDER BY Quantity; --87 Datens�tze, Q3 wird abgeschnitten

SELECT TOP 4 PERCENT WITH TIES *
FROM [Order Details] ORDER BY Quantity; --115 Datens�tze
