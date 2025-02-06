
CREATE DATABASE TARgvKonkin;

use TARgvKonkin;
create table film(
filmID int primary key AUTO_INCREASE,,
filmNimetus varchar(30) not null,
aasta int,
eelarveHind decimal(7,1)
);
select * from film;

-- kustutamine -> drop table film;

insert into film(filmNimetus, aasta, eelarveHind)
values('', 2024, 26485.5)

create table zanr(
zanrID int primary key AUTO_INCREASE,,
zanrNimetus varchar(20) unique
)

insert into zanr(zanrNimetus)
values ('draama'), ('detektiiv'), ('humor'), ('treiler'),('uzastik');
select * from zanr;

-- tabeli film muutmine struktur --> uue stolbets lisamine
alter table film add zanrID int;
select * from film;
-- tabeli film muutmine struktur --> FK lisamine mis on seotud tabeliga zanr(zanrID)
alter table film add constraint fk_zanr
foreign key (zanrID) references zanr(zanrID);

select * from film;
select * from zanr;
update film set zanrID=2 where filmID=3

create table rezisoor(
rezID int primary key identity(1,1),
nimi varchar(30) not null,
synniaeg int,
riik varchar(20)
);

insert into rezisoor(nimi, synniaeg, riik)
values ('Andrei Tarkovski', 1932, 'USSR')

select * from rezisoor;
select * from film;

alter table film add rezID int;
-- /////////////////////////////////////
alter table film add constraint fk_rez
foreign key (rezID) references rezisoor(rezID);

update film set rezID=3

-- /////////////////////////////////////

create table kinokava(
kkID int primary key identity(1,1),
aeg datetime
);

alter table kinokava add filmID int;
alter table kinokava add zanrID int;
alter table kinokava add rezID int;

alter table kinokava add constraint kino
foreign key (filmID) references film(filmID);

insert into kinokava(aeg)
values ('2025-01-12 20:10:00')

update kinokava set filmID=1 where kkID=1
update kinokava set filmID=2 where kkID=2
update kinokava set filmID=3 where kkID=3
update kinokava set filmID=4 where kkID=4
-- --------------------------------------
update kinokava set zanrID=1 where kkID=1
update kinokava set zanrID=4 where kkID=2
update kinokava set zanrID=5 where kkID=3
update kinokava set zanrID=2 where kkID=4
-- --------------------------------------
update kinokava set rezID=2 where kkID=1
update kinokava set rezID=3 where kkID=2
update kinokava set rezID=2 where kkID=3
update kinokava set rezID=1 where kkID=4

select * from kinokava
select * from zanr

drop table kinokava



---------------------------------------------------------------------------------------
ДЗ

create database RK;

use RK;
CREATE TABLE Raamad(
raamatudID int PRIMARY KEY identity (1,1),
autor varchar(500),
nimetus varchar(500),
keel varchar (200),
zanr varchar(200),
)

-------------------------------------------------------------------
SELECT * FROM Raamad;
DROP TABLE Raamad;
DROP PROCEDURE lisaRaamad;
-------------------------------------------------------------------

INSERT INTO Raamad(
autor, nimetus, keel, zanr)
VALUES(
'Lev Nikolajevitch Tolstoi', 'Sõda ja rahu', 'Vene keel', 'Romaan Sõjaromaan');

-------------------------------------------------------------------


CREATE PROCEDURE lisaRaamad

@uusRam varchar(500),
@keel varchar(500),
@autor varchar (250),
@zanr varchar(200)

AS
BEGIN
INSERT INTO Raamad(
autor, nimetus, keel, zanr)
VALUES(
@autor, @uusRam, @keel, @zanr);

END;

-------------------------------------------------------------------
	-- kutse prots
-------------------------------------------------------------------

EXEC lisaRaamad 'Ernest Hemingway', '"Kellele lüüakse hingekella"', 'Inglise keel', 'Romaan, Väljamõeldis, sõjaromaan';

exec lisaRaamad
@autor = 'Ernest Hemingway',
@uusRam = 'Kellele lüüakse hingekella',
@keel = 'Inglise keel',
@zanr = 'Romaan, Väljamõeldis, sõjaromaan';
-------------------------------------------------------------------
	-- kustutamine tabelist id järgi
-------------------------------------------------------------------

CREATE PROCEDURE kustRaam

@id int

AS
BEGIN
SELECT * FROM Raamad;
DELETE FROM Raamad WHERE raamatudID = @id;
SELECT * FROM Raamad;

END;

-------------------------------------------------------------------
	-- kutse
-------------------------------------------------------------------
SELECT * FROM Raamad;
EXEC kustRaam 2;
EXEC kustRaam @id=4;

-------------------------------------------------------------------
	-- protseduur mis otsib ja näitab uudist esimese tähte järgi
-------------------------------------------------------------------

CREATE PROCEDURE otsingRaamad
@taht char(1)
AS
BEGIN
SELECT * FROM Raamad
WHERE autor Like @taht +'%';
END;

-------------------------------------------------------------------
	-- kutse
-------------------------------------------------------------------

EXEC otsingRaamad 'L';
