create database HZ;

use HZ;

create table laps(
lapsID int primary key identity(1,1),
nimi varchar(50) not null,
pikkus smallint,
synniaasta smallint,
synnilinn varchar(20)
);

------------------------------------------------------------------------
SELECT * FROM laps
------------------------------------------------------------------------

INSERT INTO laps(nimi, pikkus, synniaasta, synnilinn)
VALUES
('Kati', 156, 2001, 'Tallinn'),
('Nikita',182,2004,'Puru'),
('Kristina',171,2004,'Puru'),
('Evgeni',182,2000,'Puru'),
('Anastasia', 162, 1995, 'Moscow'),
('Dmitry', 178, 1989, 'St. Petersburg'),
('Olga', 160, 1992, 'Kiev'),
('Andrei', 175, 1990, 'Minsk'),
('Maria', 168, 1998, 'Riga'),
('Sergey', 180, 1985, 'Vilnius'),
('Elena', 165, 1994, 'Warsaw'),
('Ivan', 185, 1988, 'Helsinki'),
('Natalia', 170, 1997, 'Bucharest'),
('Maxim', 182, 1987, 'Budapest'),
('Vera', 158, 1996, 'Tallinn');

------------------------------------------------------------------------
	-- sorteerimine
-- ASC, DESC - suurimast väikseni
------------------------------------------------------------------------

SELECT nimi, pikkus
FROM laps
ORDER by pikkus DESC;

SELECT nimi, pikkus
FROM laps
ORDER by pikkus DESC, nimi;

------------------------------------------------------------------------
	-- lapsed, mis on sündinud peale 2005
------------------------------------------------------------------------

SELECT nimi, synniaasta
FROM laps
WHERE synniaasta >= 2005
ORDER by nimi;

------------------------------------------------------------------------
	-- näitab ainult üks kordus -> DISTINCT
------------------------------------------------------------------------

SELECT DISTINCT synniaasta
FROM laps
WHERE synniaasta > 2000;

------------------------------------------------------------------------
	-- lapsed mis on sünd (2000-2005) -> BETWEEN
------------------------------------------------------------------------

SELECT nimi, synniaasta
FROM laps
WHERE synniaasta >= 2000 AND synniaasta <= 2005
-- =
SELECT nimi, synniaasta
FROM laps
WHERE synniaasta BETWEEN 2000 AND 2005

------------------------------------------------------------------------
	-- näita lapsed, kelle nimi algab K -> LIKE
	-- '%' -> kõik sümb
	-- sisaldab K täht -> '%K%'
------------------------------------------------------------------------

SELECT nimi
FROM laps
WHERE nimi like '%K%';

------------------------------------------------------------------------
	-- täpsem määratud tähtede arv _ 
------------------------------------------------------------------------

SELECT nimi
FROM laps
WHERE nimi like '_a__';

------------------------------------------------------------------------
	-- AND/OR
------------------------------------------------------------------------

SELECT nimi, synnilinn
FROM laps
WHERE nimi like '%K%'
OR synnilinn LIKE 'Moscow';

------------------------------------------------------------------------
	-- Agregaatfunktsioonud -> SUM, AVG, MIN, MAX, COUNT
------------------------------------------------------------------------

SELECT COUNT(nimi) AS lasteArv
FROM laps;

SELECT AVG(pikkus) AS 'summarne pikkus'
FROM laps
WHERE synnilinn = 'Tallinn';

------------------------------------------------------------------------
	-- näita keskmine pikkus linnade järgi -> GROUP by
------------------------------------------------------------------------

SELECT AVG(pikkus) AS 'keskmine pikkus', synnilinn
FROM laps
GROUP by synnilinn

------------------------------------------------------------------------
	-- näita laste arv, mis on sünd konkret synniaasta -> COUNT
------------------------------------------------------------------------

SELECT synniaasta, COUNT(*) AS lasteArv
FROM laps
GROUP BY synniaasta;

------------------------------------------------------------------------
	-- keskmine pikkus iga synnast -> HAVING - ogranichenie dlja grup znachenij
------------------------------------------------------------------------

SELECT synniaasta, AVG(pikkus) AS ekskmine
FROM laps
GROUP BY synniaasta
HAVING AVG(pikkus)>150;

SELECT synniaasta, AVG(pikkus) AS ekskmine
FROM laps
WHERE NOT synniaasta = 2001
GROUP BY synniaasta

------------------------------------------------------------------------
	-- seotud tabel
------------------------------------------------------------------------

CREATE TABLE loom(
loomID int PRIMARY KEY identity(1,1),
loomNimi varchar(50),
lapsID int, 
FOREIGN KEY (lapsID) REFERENCES laps(lapsID)
);

INSERT INTO loom(loomNimi, lapsID)
values
('Kass Barsik', 1),
('Koer Sharik', 1),
('Koer Tuzik', 2),
('Siga Hohol', 3),
('Kass SIIIIIIIIIIMAAAAAAAAAA', 3),
('Kass Murka', 5),
('Koer Bobik', 6),
('Siga Kotik', 7),
('Koer Rex', 10),
('Kass Vaska', 9),
('Koer Rembi', 8),
('Siga Pushok', 15),
('Kass Tom', 11),
('Koer Zhuzha', 12),
('Siga Malish', 13);

SELECT * FROM loom;

SELECT * FROM loom, laps -- ei äita õiged vastused

SELECT * FROM loom
INNER JOIN laps
ON loom.lapsID=laps.lapsID;

------------------------------------------------------------------------
	-- lihtne vaade
------------------------------------------------------------------------

SELECT l.loomNimi, la.nimi, la.synniaasta
FROM loom l, laps la
where l.lapsID=la.lapsID;


