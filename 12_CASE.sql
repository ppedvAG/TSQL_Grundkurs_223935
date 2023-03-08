USE Northwind;

--CASE: Erzeugt eine neue Spalte im SELECT abh�ngig von Bedingungen

--Jede Bestellung mit Frachtkosten > 100 soll eine teure Bestellung sein, sonst eine g�nstige Bestellung
SELECT *,
	CASE
		WHEN Freight > 100 THEN 'Teure Bestellung'
		WHEN Freight <= 100 THEN 'G�nstige Bestellung'
	END AS Status
FROM Orders;

--Finde alle Customer die Deutsch sprechen k�nnen
SELECT *,
	CASE
		WHEN Country IN('Austria', 'Germany', 'Switzerland') THEN 'Spricht Deutsch' --Alle Bedingungen die auch in einem WHERE m�glich w�ren
		ELSE 'Spricht kein Deutsch' --ELSE f�r alles andere
	END AS Deutschkenntnisse
FROM Customers
ORDER BY Deutschkenntnisse;

--Lieferstatus: Welche Order sind vorzeitig/rechtzeitig/zu sp�t/noch nicht angekommen?
SELECT *,
	CASE
		WHEN ShippedDate < RequiredDate THEN 'Vorzeitig angekommen'
		WHEN ShippedDate = RequiredDate THEN 'Rechtzeitig angekommen'
		WHEN ShippedDate > RequiredDate THEN 'Zu sp�t'
		WHEN ShippedDate IS NULL THEN 'Noch nicht angekommen' --ELSE auch m�glich
	END AS Lieferstatus
FROM Orders
ORDER BY Lieferstatus, ShippedDate;