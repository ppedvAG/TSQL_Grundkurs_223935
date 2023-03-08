USE Northwind;

--CREATE TABLE <Name> (<Spalte1> <Typ1>, <Spalte2> <Typ2>, ...)
CREATE TABLE Test
(
	--primary key: Primärschlüssel, eindeutige Spalte, kann nicht null sein, häufig IDs, mehrere Primärschlüssel (kombinierter Schlüssel)
	--identity: Erhöht und befüllt die Spalte automatisch um 1 (gut für IDs)
	--identity(<Startwert>, <Inkrement>)
	ID int identity(1, 1) primary key,
	Vorname varchar(20) NULL,
	Nachname varchar(20) NOT NULL --Jedes Feld muss einen Wert haben
);

--------------------------------------------------------------

--INSERT INTO <Tabelle> VALUES (<Wert1>, <Wert2>, ...), (...), (...), ...
INSERT INTO Test VALUES
('Max', 'X');

--Mehrere Datensätze gleichzeitig einfügen
INSERT INTO Test VALUES
('Max', 'X'),
('Test', 'Test');

--Nur bestimmte Spalten in die Tabelle schreiben statt jeden Wert
INSERT INTO Customers(CustomerID, CompanyName, Country) VALUES
('PPEDV', 'ppedv AG', 'DE');

--Ergebnis einer Prozedur in eine Tabelle schreiben
CREATE PROC p_Test
AS
	SELECT FirstName, LastName FROM Employees;
GO

INSERT INTO Test
EXEC p_Test;

--SELECT INTO: Ergebnis einer Abfrage in eine NEUE Tabelle schreiben
SELECT FirstName, LastName
INTO Test
FROM Employees;

--INSERT INTO ... SELECT: Selbiges wie SELECT INTO, funktioniert allerdings nur auf bestehenden Tabellen
INSERT INTO Test
SELECT FirstName, LastName FROM Employees;

--------------------------------------------------------------

--UPDATE <Tabelle> SET <Spalte> = <Wert>
--WHERE sollte verwendet werden um nicht alle Datensätze zu verändern
UPDATE Test SET Nachname = 'ABC';

UPDATE Test SET Nachname = '123' WHERE ID = 5;

--Bestehenden Wert verwenden
UPDATE Test SET Nachname = Nachname + '123';

--Mehrere Spalten verändern
UPDATE Test SET Nachname = 'Y', Vorname = 'X';

--------------------------------------------------------------

--CREATE SEQUENCE <Name> AS <Datentyp>
CREATE SEQUENCE Rechnungsnummern AS int;

--Nächsten Wert aus der Sequenz entnehmen
SELECT NEXT VALUE FOR Rechnungsnummern;

DROP SEQUENCE Rechnungsnummern;

CREATE SEQUENCE Rechnungsnummern AS int
START WITH 2300000;

--Nächsten Value auch bei INSERT möglich
INSERT INTO Test VALUES
(NEXT VALUE FOR Rechnungsnummern, 'X');

--------------------------------------------------------------

--DELETE FROM <Tabelle>
DELETE FROM Test; --Löscht alle Daten ohne WHERE

DELETE FROM Customers WHERE CustomerID = 'PPEDV';

--Löscht alle Daten (kann kein WHERE enthalten)
--Programmierer wollte explizit alle Daten löschen
TRUNCATE TABLE Test;

--------------------------------------------------------------

--Transaktionen: Ermöglichen uns UPDATE/DELETE sicher zu machen und rückgängig zu machen falls etwas schief läuft

BEGIN TRANSACTION; --Transaktionsmodus gestartet

--Jedes SQL-Statement ab hier wird "gespeichert" aber noch nicht auf die Datenbank geschrieben
--Tabellen die ab hier angegriffen werden gesperrt für andere User

DELETE FROM Test WHERE ID >= 30; --Ab hier wird die Tabelle gesperrt für andere Sessions

COMMIT; --Schreibe die Änderungen
ROLLBACK; --Mach Rückgängig

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

--------------------------------------------------------------

--INFORMATION_SCHEMA: Gibt verschiedenste Informationen über die Datenbank
SELECT * FROM INFORMATION_SCHEMA.TABLES;
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Test';

--------------------------------------------------------------

--ALTER: Datenbankobjekte zu bearbeiten
ALTER TABLE Test ADD NeueSpalte int;
ALTER TABLE Test DROP COLUMN NeueSpalte;
ALTER TABLE Test ALTER COLUMN NeueSpalte varchar(20);