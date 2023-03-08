USE Northwind;

SELECT 'T1', 'T2'; --Zwei Spalten

SELECT 'T1'
UNION --Ergebnisse von beiden SELECTs kombinieren
SELECT 'T2';

--UNION
--Baut mehrere SELECT Statements zusammen zu einem Ergebnis
--Beide SELECTs müssen die selbe Struktur haben (Spalten, Typen)
--Filtert Duplikate (Performance)

--Wir wollen alle Adressen aus der Datenbank haben
SELECT * FROM Customers;
SELECT * FROM Suppliers;

SELECT Address FROM Customers
UNION
SELECT Address FROM Suppliers; --Alle Adressen in einem Ergebnis

SELECT CONCAT_WS(' ', Address, City, PostalCode, Country) FROM Customers
UNION
SELECT CONCAT_WS(' ', Address, City, PostalCode, Country) FROM Suppliers; --Alle langen Adressen

SELECT CompanyName FROM Customers
UNION
SELECT CompanyName FROM Suppliers; --Alle Firmennamen

SELECT CompanyName, ContactName FROM Customers
UNION
SELECT CompanyName FROM Suppliers; --Unterschiedlich viele Spalten sind nicht möglich

SELECT CompanyName, ContactName FROM Customers
UNION
SELECT CompanyName, '' FROM Suppliers; --Spalten ergänzen durch leeren Wert (NULL, '', 0, ...)

SELECT CustomerID FROM Customers
UNION
SELECT SupplierID FROM Suppliers; --Unterschiedliche Datentypen sind auch nicht kompatibel

SELECT CustomerID FROM Customers
UNION
SELECT CAST(SupplierID AS VARCHAR) FROM Suppliers; --Einzelnen Typen in einen anderen Typen konvertieren

--Alle Telefonnummern in der Datenbank mit 3 SELECTs
SELECT Phone FROM Customers
UNION
SELECT Phone FROM Suppliers
UNION
SELECT HomePhone FROM Employees;

--AS bei UNION
SELECT Phone AS P1 FROM Customers --Das AS beim ersten SELECT wird akzeptiert, der Rest wird verworfen
UNION
SELECT Phone AS P2 FROM Suppliers --P2 wird verworfen
UNION
SELECT HomePhone AS P3 FROM Employees; --P3 wird verworfen

--INTERSECT: Gibt alle Datensätze zurück, die in beiden Tabellen enthalten sind
SELECT Country FROM Customers
INTERSECT
SELECT Country FROM Suppliers; --Alle Länder in denen wir Kunden und Supplier haben

--EXCEPT: Gibt alle Datensätze zurück, die in der ersten Tabelle sind aber nicht in der zweiten sind
SELECT Country FROM Customers
EXCEPT --Reihenfolge der SELECTs ist relevant
SELECT Country FROM Suppliers; --Alle Länder in denen wir Kunden aber keine Lieferanten haben

SELECT Country FROM Customers
INTERSECT
SELECT Country FROM Suppliers --Alle Länder in denen wir Kunden und Supplier haben
EXCEPT
SELECT Country FROM Employees; --Außer Länder in denen Employees arbeiten

--Umsatztabellen

CREATE TABLE Umsatz2021
(
	Datum date,
	Betrag float
);

DECLARE @i int = 0
WHILE @i < 20000
BEGIN
	INSERT INTO Umsatz2021 VALUES
	(DATEADD(DAY, RAND()*365, '20210101'), RAND()*1000);
	SET @i += 1;
END

SET STATISTICS time, io ON

--Umsatztabellen wieder zusammenbauen
SELECT * FROM Umsatz2019
UNION
SELECT * FROM Umsatz2020
UNION
SELECT * FROM Umsatz2021
GO
--CPU-Zeit = 46 ms, verstrichene Zeit = 506 ms.

CREATE VIEW UmsatzGesamt
AS
	SELECT * FROM Umsatz2019
	UNION ALL --UNION ALL: Selbiges wie UNION, nur ohne Duplikatfilterung
	SELECT * FROM Umsatz2020
	UNION ALL
	SELECT * FROM Umsatz2021
GO

SELECT * FROM UmsatzGesamt ORDER BY 1;