-- SQL SALVESTATUD PROTSEDUURID -- Funktsioonid -> mitu SQL käsku käivitakse järjest (несколько повторов повторяются подряд)
-- SQL SERVER 

CREATE DATABASE	procTARgv24;

USE procTARgv24;
CREATE TABLE uudised(
uudisID int PRIMARY KEY identity (1,1),
uudiseTeema varchar(50),
kuupaev date,
autor varchar(25),
kirjeldus text
)

-------------------------------------------------------------------
SELECT * FROM uudised;
-------------------------------------------------------------------

INSERT INTO uudised(
uudiseTeema, kuupaev, autor, kirjeldus)
VALUES(
'udune ilm', '2025-02-06', 'postimees', 'Tana on ebahuvitav ilm');

-------------------------------------------------------------------
	-- protseduuri loomine
	-- sisestab uudised tabelisse ja kohe näitab
-------------------------------------------------------------------

CREATE PROCEDURE lisaUudis

@uusTeema varchar(50),
@paev date,
@autor varchar (25),
@kirjeldus text

AS
BEGIN
INSERT INTO uudised(
uudiseTeema, kuupaev, autor, kirjeldus)
VALUES(
@uusTeema, @paev, @autor, @kirjeldus);
SELECT * FROM uudised;

END;

-------------------------------------------------------------------
	-- kutse prots
-------------------------------------------------------------------

EXEC lisaUudis 'windows11', '2025-02-06', 'õpetaja Pant', 'win11 ei tööta praegu';

-------------------------------------------------------------------
	-- teine kutse võimalu
-------------------------------------------------------------------

EXEC lisaUudis 
@uusTeema = '1.märts on juba kevad',
@paev = '2025-02-06',
@autor = 'test',
@kirjeldus = 'puudub';

-------------------------------------------------------------------
	-- kustutamine tabelist id järgi
-------------------------------------------------------------------

CREATE PROCEDURE kustUudis

@id int

AS
BEGIN
SELECT * FROM uudised;
DELETE FROM uudised WHERE uudisID = @id;
SELECT * FROM uudised;

END;

-------------------------------------------------------------------
	-- kutse
-------------------------------------------------------------------

EXEC kustUudis 3;
EXEC kustUudis @id=3;

-------------------------------------------------------------------
	-- protseduur mis uuendab andmed tabelist/UPDATE
-------------------------------------------------------------------

CREATE PROCEDURE uuendaK

@uuskirjeldus text

AS
BEGIN
SELECT * FROM uudised;
UPDATE uudised SET kirjeldus = @uuskirjeldus
WHERE kirjeldus Like 'puudub'
SELECT * FROM uudised;
END;

-------------------------------------------------------------------
	-- kutse
-------------------------------------------------------------------

EXEC uuendaK 'uus tekst kirjelduses';

-------------------------------------------------------------------
	-- protseduur mis otsib ja näitab uudist esimese tähte järgi
-------------------------------------------------------------------

CREATE PROCEDURE otsingUudiseTeema
@taht char(1)
AS
BEGIN
SELECT * FROM uudised
WHERE uudiseTeema Like @taht +'%';
END;

-------------------------------------------------------------------
	-- kutse
-------------------------------------------------------------------

EXEC otsingUudiseTeema 'w';


--------|  XAMPP  |----------

CREATE TABLE uudised(
uudisID int PRIMARY KEY AUTO_INCREMENT,
uudiseTeema varchar(50),
kuupaev date,
autor varchar(25),
kirjeldus text
);

INSERT INTO uudised(
uudiseTeema, kuupaev, autor, kirjeldus)
VALUES(
'udune ilm', '2025-02-06', 'postimees', 'Tana on ebahuvitav ilm');

BEGIN
SELECT * FROM uudised;
DELETE FROM uudised WHERE uudisID = id;
SELECT * FROM uudised;

END


