USE Northwind;

--Numerische Typen
	--int: Ganze Zahl
	--decimal, numeric, float, real: Kommazahl
	--bit: 1 oder 0, wahr oder falsch
	--money: Geldwerte

--Texttypen
	--char(X): Text mit genau X Zeichen
	--varchar(X): Text mit maximal X Zeichen
	--text: Text mit beliebiger Länge (veraltet) -> varchar(MAX)
	--n vor Typen: Unicode

--Datumstypen:
	--datetime: Datum + Zeit
	--date: Nur Datum
	--time: Nur Zeit



--Funktionen

--Datumsfunktionen
SELECT GETDATE(); --Das jetztiges Datum + Zeit, millisekundengenau
SELECT SYSDATETIME(); --Das jetztiges Datum + Zeit, nanosekundengenau

/*
	Intervalle:
    year, yyyy, yy = Year
    month, MM, M = month
    week, ww, wk = Week
    day, dd, d = Day
    hour, hh = hour
    minute, mi, m = Minute
    second, ss, s = Second
    millisecond, ms = Millisecond
	nanosecond, ns

    weekday, dw, w = Weekday (1-7)
    dayofyear, dy, y = Day of the year (1-366)
    quarter, qq, q = Quarter (1-4)
*/

--YEAR/MONTH/DAY
SELECT YEAR(GETDATE()); --Vom heutigen Datum nur das Jahr zurückgeben
SELECT MONTH(GETDATE()); --Vom heutigen Datum nur das Monat zurückgeben
SELECT DAY(GETDATE()); --Vom heutigen Datum nur den Tag zurückgeben

SELECT YEAR(HireDate) FROM Employees; --Funktionen auf Spalten anwenden

--DATEPART: Teil eines Datums, anhand eines Intervalls
SELECT DATEPART(HOUR, GETDATE()); --Die Stunde vom heutigen Datum
SELECT DATEPART(SECOND, GETDATE()); --Die Sekunde vom heutigen Datum

SELECT DATEPART(WEEKDAY, GETDATE()); --Wochentag vom heutigen Datum (1)
SELECT DATEPART(DAYOFYEAR, GETDATE()); --Jahrestag vom heutigen Datum seit 01.01. (65)
SELECT DATEPART(QUARTER, GETDATE()); --Quartal vom heutigen Datum (1)

SELECT HireDate, DATEPART(QUARTER, HireDate) FROM Employees;

--DATEDIFF: Unterschied zwischen zwei Datumswerten
SELECT HireDate, DATEDIFF(YEAR, HireDate, GETDATE()) FROM Employees; --Wie lange sind unsere Mitarbeiter schon in der Firma? (ungenau)

SELECT DATEDIFF(YEAR, '2020-01-01', GETDATE()); --ISO-8601 Datum immer möglich
SELECT DATEDIFF(YEAR, '01.01.2020', GETDATE()); --Deutsches Datum möglich weil deutscher Server
SELECT DATEDIFF(YEAR, '01/30/2020', GETDATE()); --Amerikanisches Datum nicht möglich, da deutscher Server (aber auf amerikanischem Server wäre das möglich)

--DATENAME: Gibt den Namen eines Monats/Tags zurück
SELECT DATENAME(MONTH, GETDATE()); --Name des heutigen Monats (März)
SELECT DATENAME(WEEKDAY, GETDATE()); --Name des heutigen Tags (Montag)

--Stringfunktionen
SELECT Address + City + PostalCode + Country FROM Customers; --Strings verbinden mit +

SELECT CONCAT(Address, City, PostalCode, Country) FROM Customers; --CONCAT: beliebig viele Strings zusammenbauen

SELECT CONCAT_WS(' ', Address, City, PostalCode, Country) FROM Customers; --CONCAT_WS: beliebig viele Strings zusammenbauen mit Separator

SELECT CONCAT_WS(' ', Address, City, PostalCode, Country) AS [Volle Adresse] FROM Customers;

--LEN/DATALENGTH: Gibt die Länge des Textes zurück
SELECT LEN('Text'); --4
SELECT LEN(' Text '); --5, weil automatisch Abstände am Ende weggeschnitten werden

SELECT DATALENGTH(' Text '); --6
SELECT LEN(FirstName) FROM Employees;

--Konvertierungsfunktionen

--CAST: Wandelt einen Wert in einen anderen Typen um
SELECT CAST(GETDATE() AS DATE); --Datetime zu Date umwandeln -> Zeit fällt weg

SELECT CAST(GETDATE() AS TIME); --Datetime zu Time umwandeln -> Datum fällt weg

SELECT CAST(HireDate AS DATE) FROM Employees;

SELECT '123' + 4; --Automatische Konvertierung von varchar zu int möglich

SELECT '123.4' + 5; --Hier nicht möglich

SELECT CAST('123.4' AS FLOAT) + 5; --Explizite Konvertierung notwendig

--CONVERT: Selbiges wie CAST, nur alt

SELECT CONVERT(DATE, GETDATE());

--Date Styles
--https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles

SELECT CONVERT(VARCHAR, GETDATE(), 4); --Kurzes deutsches Datum
SELECT CONVERT(VARCHAR, GETDATE(), 104); --Langes deutsches Datum

--FORMAT: Formatiert den gegebenen Wert in die angegebene Formatierung

/*
	Intervalle:
    year, yyyy, yy = Year
    month, MM, M = month
    week, ww, wk = Week
    day, dd, d = Day
    hour, hh = hour
    minute, mi, m = Minute
    second, ss, s = Second
    millisecond, ms = Millisecond
	nanosecond, ns

    weekday, dw, w = Weekday (1-7)
    dayofyear, dy, y = Day of the year (1-366)
    quarter, qq, q = Quarter (1-4)
*/

SELECT GETDATE();

SELECT FORMAT(GETDATE(), 'dd.MM.yyyy');

SELECT FORMAT(GETDATE(), 'dd.MM.yyyy hh:mm:ss'); --komplett freie Formatierung möglich

SELECT FORMAT(GETDATE(), 'dd ddd dddd MM MMM MMMM yy yyyy');

SELECT FORMAT(GETDATE(), 'dddd, dd. MMMM yyyy hh:mm:ss'); --Schönstes deutsches Datum

--Schnellformatierung
SELECT FORMAT(GETDATE(), 'd');
SELECT FORMAT(GETDATE(), 'D');

SELECT FORMAT(HireDate, 'D') FROM Employees;

--Dokumentation
--https://learn.microsoft.com/en-us/sql/t-sql/functions/functions?view=sql-server-2017