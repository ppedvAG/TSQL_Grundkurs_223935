USE Northwind;

--Wildcards: Erm�glichen eine ungef�hre Suche im WHERE

--%

SELECT * FROM Customers WHERE Country LIKE 'A%'; --Alle Customer finden die in einem Land wohnen das mit A anf�ngt

SELECT * FROM Customers WHERE Country LIKE 'a%'; --Keine Gro�-/Kleinschreibung

SELECT * FROM Customers WHERE Country LIKE '%A'; --Alle L�nder die mit A enden

SELECT * FROM Customers WHERE Country LIKE '%A%'; --A enthalten (beliebig viele Zeichen sind auch 0 Zeichen)

SELECT * FROM Customers WHERE Country LIKE '%A%A%'; --Alle L�nder die 2 A enthalten

--_

SELECT * FROM Customers WHERE City LIKE '_�nchen'; --Genau ein beliebiges Zeichen suchen

SELECT * FROM Customers WHERE PostalCode LIKE '____'; --Genau vier beliebige Zeichen suchen

SELECT * FROM Customers WHERE PostalCode LIKE '1___'; --Alle Postleitzahlen die eine 1 am Anfang haben und genau 4 Stellen haben

--[]

SELECT * FROM Customers WHERE Country LIKE '[abc]%'; --L�nder die mit A, B oder C anfangen

SELECT * FROM Customers WHERE Country LIKE '[a-f]%'; --Bereich festlegen mit Bindestrich

SELECT * FROM Customers WHERE PostalCode LIKE '[0-9][0-9][0-9][0-9]'; --Alle 4-Stelligen und numerischen Postleitzahlen

SELECT * FROM Customers WHERE Country LIKE '[^a-f]%'; --^: Bereich invertieren (G-Z)

SELECT * FROM Customers WHERE Country LIKE '[a-c|v-z]%'; --Bereiche verbinden

SELECT * FROM Customers WHERE Country LIKE '[^a-c|v-z]%'; --Verbundene Bereiche werden vollst�ndig invertiert (D-U)

--Sonderf�lle (% und ')

SELECT * FROM Customers WHERE CompanyName LIKE '%[%]%';

SELECT * FROM Customers WHERE CompanyName LIKE '%['']%';