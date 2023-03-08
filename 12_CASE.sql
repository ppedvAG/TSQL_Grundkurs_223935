USE Northwind;

--CASE: Erzeugt eine neue Spalte im SELECT abhängig von Bedingungen

--Jede Bestellung mit Frachtkosten > 100 soll eine teure Bestellung sein, sonst eine günstige Bestellung
SELECT *,
	CASE
		WHEN Freight > 100 THEN 'Teure Bestellung'
		WHEN Freight <= 100 THEN 'Günstige Bestellung'
	END AS Status
FROM Orders;

--Finde alle Customer die Deutsch sprechen können
SELECT *,
	CASE
		WHEN Country IN('Austria', 'Germany', 'Switzerland') THEN 'Spricht Deutsch' --Alle Bedingungen die auch in einem WHERE möglich wären
		ELSE 'Spricht kein Deutsch' --ELSE für alles andere
	END AS Deutschkenntnisse
FROM Customers
ORDER BY Deutschkenntnisse;

--Lieferstatus: Welche Order sind vorzeitig/rechtzeitig/zu spät/noch nicht angekommen?
SELECT *,
	CASE
		WHEN ShippedDate < RequiredDate THEN 'Vorzeitig angekommen'
		WHEN ShippedDate = RequiredDate THEN 'Rechtzeitig angekommen'
		WHEN ShippedDate > RequiredDate THEN 'Zu spät'
		WHEN ShippedDate IS NULL THEN 'Noch nicht angekommen' --ELSE auch möglich
	END AS Lieferstatus
FROM Orders
ORDER BY Lieferstatus, ShippedDate;