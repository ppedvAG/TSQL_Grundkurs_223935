USE Northwind;

--Wildcards: Ermöglichen eine ungefähre Suche im WHERE

--%

SELECT * FROM Customers WHERE Country LIKE 'A%'; --Alle Customer finden die in einem Land wohnen das mit A anfängt

SELECT * FROM Customers WHERE Country LIKE 'a%'; --Keine Groß-/Kleinschreibung

SELECT * FROM Customers WHERE Country LIKE '%A'; --Alle Länder die mit A enden

SELECT * FROM Customers WHERE Country LIKE '%A%'; --A enthalten (beliebig viele Zeichen sind auch 0 Zeichen)

SELECT * FROM Customers WHERE Country LIKE '%A%A%'; --Alle Länder die 2 A enthalten

--_

SELECT * FROM Customers WHERE City LIKE '_ünchen'; --Genau ein beliebiges Zeichen suchen

SELECT * FROM Customers WHERE PostalCode LIKE '____'; --Genau vier beliebige Zeichen suchen

SELECT * FROM Customers WHERE PostalCode LIKE '1___'; --Alle Postleitzahlen die eine 1 am Anfang haben und genau 4 Stellen haben

--[]

SELECT * FROM Customers WHERE Country LIKE '[abc]%'; --Länder die mit A, B oder C anfangen

SELECT * FROM Customers WHERE Country LIKE '[a-f]%'; --Bereich festlegen mit Bindestrich

SELECT * FROM Customers WHERE PostalCode LIKE '[0-9][0-9][0-9][0-9]'; --Alle 4-Stelligen und numerischen Postleitzahlen

SELECT * FROM Customers WHERE Country LIKE '[^a-f]%'; --^: Bereich invertieren (G-Z)

SELECT * FROM Customers WHERE Country LIKE '[a-c|v-z]%'; --Bereiche verbinden

SELECT * FROM Customers WHERE Country LIKE '[^a-c|v-z]%'; --Verbundene Bereiche werden vollständig invertiert (D-U)

--Sonderfälle (% und ')

SELECT * FROM Customers WHERE CompanyName LIKE '%[%]%';

SELECT * FROM Customers WHERE CompanyName LIKE '%['']%';