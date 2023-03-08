USE Northwind;

--CREATE TABLE <Name> (<Spalte1> <Typ1>, <Spalte2> <Typ2>, ...)
CREATE TABLE Test
(
	--primary key: Prim�rschl�ssel, eindeutige Spalte, kann nicht null sein, h�ufig IDs, mehrere Prim�rschl�ssel (kombinierter Schl�ssel)
	--identity: Erh�ht und bef�llt die Spalte automatisch um 1 (gut f�r IDs)
	--identity(<Startwert>, <Inkrement>)
	ID int identity(1, 1) primary key,
	Vorname varchar(20) NULL,
	Nachname varchar(20) NOT NULL --Jedes Feld muss einen Wert haben
);

--------------------------------------------------------------

--INSERT INTO <Tabelle> VALUES (<Wert1>, <Wert2>, ...), (...), (...), ...
INSERT INTO Test VALUES
('Max', 'X');

--Mehrere Datens�tze gleichzeitig einf�gen
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
--WHERE sollte verwendet werden um nicht alle Datens�tze zu ver�ndern
UPDATE Test SET Nachname = 'ABC';

UPDATE Test SET Nachname = '123' WHERE ID = 5;

--Bestehenden Wert verwenden
UPDATE Test SET Nachname = Nachname + '123';

--Mehrere Spalten ver�ndern
UPDATE Test SET Nachname = 'Y', Vorname = 'X';

--------------------------------------------------------------

--CREATE SEQUENCE <Name> AS <Datentyp>
CREATE SEQUENCE Rechnungsnummern AS int;

--N�chsten Wert aus der Sequenz entnehmen
SELECT NEXT VALUE FOR Rechnungsnummern;

DROP SEQUENCE Rechnungsnummern;

CREATE SEQUENCE Rechnungsnummern AS int
START WITH 2300000;

--N�chsten Value auch bei INSERT m�glich
INSERT INTO Test VALUES
(NEXT VALUE FOR Rechnungsnummern, 'X');

--------------------------------------------------------------

--DELETE FROM <Tabelle>
DELETE FROM Test; --L�scht alle Daten ohne WHERE

DELETE FROM Customers WHERE CustomerID = 'PPEDV';

--L�scht alle Daten (kann kein WHERE enthalten)
--Programmierer wollte explizit alle Daten l�schen
TRUNCATE TABLE Test;

--------------------------------------------------------------

--Transaktionen: Erm�glichen uns UPDATE/DELETE sicher zu machen und r�ckg�ngig zu machen falls etwas schief l�uft

BEGIN TRANSACTION; --Transaktionsmodus gestartet

--Jedes SQL-Statement ab hier wird "gespeichert" aber noch nicht auf die Datenbank geschrieben
--Tabellen die ab hier angegriffen werden gesperrt f�r andere User

DELETE FROM Test WHERE ID >= 30; --Ab hier wird die Tabelle gesperrt f�r andere Sessions

COMMIT; --Schreibe die �nderungen
ROLLBACK; --Mach R�ckg�ngig

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

--------------------------------------------------------------

--INFORMATION_SCHEMA: Gibt verschiedenste Informationen �ber die Datenbank
SELECT * FROM INFORMATION_SCHEMA.TABLES;
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Test';

--------------------------------------------------------------

--ALTER: Datenbankobjekte zu bearbeiten
ALTER TABLE Test ADD NeueSpalte int;
ALTER TABLE Test DROP COLUMN NeueSpalte;
ALTER TABLE Test ALTER COLUMN NeueSpalte varchar(20);