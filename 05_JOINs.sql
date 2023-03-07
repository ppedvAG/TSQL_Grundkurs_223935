USE Northwind;

--Tabellen haben Abh�ngigkeiten in Form von IDs

--Prim�rschl�ssel (PK -> Primary Key)
	--Existiert generell in jeder Tabelle (nicht erzwungen)
	--Werte in der Schl�sselspalte m�ssen eindeutig sein -> Datens�tze eindeutig identifizieren
	--Jeder Datensatz muss einen Schl�ssel haben (kann nicht leer sein)

--Fremdschl�ssel (FK -> Foreign Key)
	--Prim�rschl�ssel aus einer anderen Tabelle -> Referenz
	--Kann nur Werte enthalten die auch in der anderen Tabelle vorkommen
	--Wenn eine Referenz hergestellt ist, kann der Datensatz mit der entsprechenden ID nicht entfernt werden

SELECT * FROM Orders; --EmployeeID
SELECT * FROM Employees; --Datens�tze kombinieren �ber EmployeeID

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
ON Orders.EmployeeID = Employees.EmployeeID; --Sinnvolle Spalten ausw�hlen

--Aliases: Name von Tabellen �ndern um JOINs zu vereinfachen

SELECT 
e.EmployeeID, --Hier ist der Alias erzwingend, da die Spalte in beiden Tabellen vorhanden ist
CONCAT_WS(' ', e.FirstName, e.LastName) AS FullName,
o.Freight, --Hier ist der Alias optional, da jede Spalte nur in einer Tabelle vorkommt
o.ShipName,
o.ShipAddress
FROM Orders AS o --Tabellenalias: Tabelle einen kurzen Namen geben damit diese einfacher zu verwenden ist
INNER JOIN Employees e --AS nicht notwendig
ON o.EmployeeID = e.EmployeeID;

--�berblick �ber Datenbank verschaffen
--Query -> Design Query in Editor -> Mit Shift + Click alle Tabellen ausw�hlen

--Beziehungen
--1:1 -> Ein Kunde kann nur maximal eine Bestellung haben und umgekehrt (0.1%)
--1:n -> Eine Bestellung hat einen Kunden, jeder Kunde kann beliebig viele Bestellungen haben (95%)
--m:n -> Jede Bestellung hat beliebig viele Produkte, jedes Produkt ist in beliebig vielen Bestellung (4.9%)
	--Manifestiert sich in einer Extra Tabelle (Order Details)
	--Hat die Schl�ssel beider Tabellen als Prim�rschl�ssel & Fremdschl�ssel
	--Extra Informationen k�nnen gespeichert werden

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
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID; --Sinnvolle Spalten ausw�hlen

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
WHERE Orders.OrderID = 10248 --WHERE und ORDER BY auch m�glich
ORDER BY Products.ProductName;

--Outer Join
--Manchmal haben Datens�tze auf der anderen Seite kein Match und werden dadurch ausgelassen
--Mit LEFT/RIGHT/FULL JOIN k�nnen diese Datens�tze erg�nzt werden
--LEFT: holt nur Datens�tze die links kein Match haben, RIGHT das gleiche
--FULL holt Datens�tze von beiden Seiten die kein Match haben
--Datens�tze die kein Match haben aber jetzt angezeigt werden werden mit NULL-Werten erg�nzt

SELECT * FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID; --830 Datens�tze

SELECT * FROM Orders o
RIGHT JOIN Customers c --Beachtet auch Datens�tze die auf der anderen Seite kein Match haben
ON o.CustomerID = c.CustomerID; --832 Datens�tze, Kunden die keine Bestellungen werden jetzt erg�nzt

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