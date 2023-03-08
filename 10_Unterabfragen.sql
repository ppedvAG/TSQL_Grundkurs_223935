USE Northwind;

--Alle Bestellungen finden die überdurchschnittlich hohe Frachtkosten haben
SELECT * FROM Orders WHERE Freight > AVG(Freight);

--Mit Variable
DECLARE @avg float = 0;
SET @avg = (SELECT AVG(Freight) FROM Orders);
SELECT * FROM Orders WHERE Freight > @avg;

--Mit Unterabfrage
SELECT * FROM Orders WHERE Freight > (SELECT AVG(Freight) FROM Orders);

--Bestellungen mit Frachtkosten größer als Bestellung mit ID 10250
SELECT * FROM Orders WHERE Freight > (SELECT Freight FROM Orders WHERE OrderID = 10250);

--Mit TOP genau einen Wert holen
SELECT * FROM Orders WHERE Freight > (SELECT TOP 1 Freight FROM Orders);

--Hier kommt zufälligerweise genau ein Wert heraus
SELECT * FROM Orders WHERE Freight >= (SELECT Freight FROM Orders WHERE Freight > 1000);

--Subselect im IN
--Finde alle Kunden die in einem Land wohnen in dem auch ein Employee wohnt
SELECT * FROM Customers
WHERE Country IN(SELECT DISTINCT Country FROM Employees); --Alle Ergebnisse einer Unterabfrage werden in das IN gegeben

--Subselect im SELECT
SELECT Freight, (SELECT AVG(Freight) FROM Orders) AS Durchschnittsfrachtkosten
FROM Orders
ORDER BY Freight;

--Subselect im FROM
SELECT *
FROM
(
	SELECT
	o.EmployeeID, --Unterabfrage darf keine Spaltennamen doppelt haben
	o.Freight,
	CONCAT_WS(' ', e.FirstName, e.LastName) AS FullName --Jede Spalte muss einen Namen haben
	FROM Orders o
	INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID
) AS Ergebnis --Unterabfrage muss einen Namen haben
WHERE Ergebnis.Freight > 50 --Korrelierte Abfrage
ORDER BY Ergebnis.EmployeeID; --Mit Ergebnis.<Spalte> in die Unterabfrage hereingreifen

--EXISTS: Gibt wahr/falsch zurück wenn die Unterabfrage ein/kein Ergebnis hat
SELECT * FROM Customers
WHERE EXISTS (SELECT * FROM Customers WHERE Country LIKE 'X%'); --Unterabfrage hat kein Ergebnis

SELECT * FROM Customers
WHERE NOT EXISTS (SELECT * FROM Customers WHERE Country LIKE 'X%'); --Ergebnis wird invertiert (falsch -> wahr)