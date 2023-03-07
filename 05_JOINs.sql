USE Northwind;

--Tabellen haben Abhängigkeiten in Form von IDs

--Primärschlüssel (PK -> Primary Key)
	--Existiert generell in jeder Tabelle (nicht erzwungen)
	--Werte in der Schlüsselspalte müssen eindeutig sein -> Datensätze eindeutig identifizieren
	--Jeder Datensatz muss einen Schlüssel haben (kann nicht leer sein)

--Fremdschlüssel (FK -> Foreign Key)
	--Primärschlüssel aus einer anderen Tabelle -> Referenz
	--Kann nur Werte enthalten die auch in der anderen Tabelle vorkommen
	--Wenn eine Referenz hergestellt ist, kann der Datensatz mit der entsprechenden ID nicht entfernt werden

SELECT * FROM Orders; --EmployeeID
SELECT * FROM Employees; --Datensätze kombinieren über EmployeeID

SELECT * FROM Orders
INNER JOIN Employees --Hier andere Tabelle angeben
ON Orders.EmployeeID = Employees.EmployeeID; --Hier angeben welche 2 Spalten verbunden werden

SELECT 
Employees.EmployeeID, --Ambiguous column name EmployeeID (in Orders und Employees ist eine EmployeeID enthalten, Datenbank kann sich nicht entscheiden)
CONCAT_WS(' ', FirstName, LastName) AS FullName,
Freight,
ShipName,
ShipAddress
FROM Orders
INNER JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID; --Sinnvolle Spalten auswählen

--Aliases: Name von Tabellen ändern um JOINs zu vereinfachen

SELECT 
e.EmployeeID, --Hier ist der Alias erzwingend, da die Spalte in beiden Tabellen vorhanden ist
CONCAT_WS(' ', e.FirstName, e.LastName) AS FullName,
o.Freight, --Hier ist der Alias optional, da jede Spalte nur in einer Tabelle vorkommt
o.ShipName,
o.ShipAddress
FROM Orders AS o --Tabellenalias: Tabelle einen kurzen Namen geben damit diese einfacher zu verwenden ist
INNER JOIN Employees e --AS nicht notwendig
ON o.EmployeeID = e.EmployeeID;

--Überblick über Datenbank verschaffen
--Query -> Design Query in Editor -> Mit Shift + Click alle Tabellen auswählen

--Beziehungen
--1:1 -> Ein Kunde kann nur maximal eine Bestellung haben und umgekehrt (0.1%)
--1:n -> Eine Bestellung hat einen Kunden, jeder Kunde kann beliebig viele Bestellungen haben (95%)
--m:n -> Jede Bestellung hat beliebig viele Produkte, jedes Produkt ist in beliebig vielen Bestellung (4.9%)
	--Manifestiert sich in einer Extra Tabelle (Order Details)
	--Hat die Schlüssel beider Tabellen als Primärschlüssel & Fremdschlüssel
	--Extra Informationen können gespeichert werden

SELECT * FROM [Order Details]
INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID; --Mehr als zwei Tabellen kombinieren

SELECT 
Orders.OrderID,
--[Order Details].ProductID,
Products.ProductName,
Products.QuantityPerUnit,
[Order Details].UnitPrice,
[Order Details].Quantity,
Orders.Freight
FROM [Order Details]
INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID; --Sinnvolle Spalten auswählen

SELECT 
Orders.OrderID,
--[Order Details].ProductID,
Products.ProductName,
Products.QuantityPerUnit,
[Order Details].UnitPrice,
[Order Details].Quantity,
Orders.Freight
FROM [Order Details]
INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE Orders.OrderID = 10248 --WHERE und ORDER BY auch möglich
ORDER BY Products.ProductName;

--Outer Join
--Manchmal haben Datensätze auf der anderen Seite kein Match und werden dadurch ausgelassen
--Mit LEFT/RIGHT/FULL JOIN können diese Datensätze ergänzt werden
--LEFT: holt nur Datensätze die links kein Match haben, RIGHT das gleiche
--FULL holt Datensätze von beiden Seiten die kein Match haben
--Datensätze die kein Match haben aber jetzt angezeigt werden werden mit NULL-Werten ergänzt

SELECT * FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID; --830 Datensätze

SELECT * FROM Orders o
RIGHT JOIN Customers c --Beachtet auch Datensätze die auf der anderen Seite kein Match haben
ON o.CustomerID = c.CustomerID; --832 Datensätze, Kunden die keine Bestellungen werden jetzt ergänzt

SELECT c.* FROM Orders o --c.* um nur Spalten aus Customers zu holen (Order Spalten werden weggelassen)
RIGHT JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL; --Nachdem OrderID nicht null sein kann (weil PK), finde ich damit genau die Ergebnisse vom JOIN

SELECT * FROM Customers c --Reihenfolge von Tabelle im FROM und im JOIN ist bei OUTER JOINs relevant (aber nicht bei INNER JOINs)
LEFT JOIN Orders o --Wenn Tabellen anders herum sind muss der JOIN gedreht werden
ON o.CustomerID = c.CustomerID;

SELECT * FROM Orders o
FULL JOIN Customers c --FULL JOIN = LEFT & RIGHT JOIN gleichzeitig
ON o.CustomerID = c.CustomerID;

SELECT * FROM Customers CROSS JOIN Orders; --Alle Bestellungen mit allen Kunden kombinieren