CREATE DATABASE TARgvKonkin;

use TARgvKonkin;
create table film(
filmID int primary AUTO_INCREASE,
filmNimetus varchar(30) not null,
aasta int,
eelarveHind decimal(7,1)
);
select * from film;

-- kustutamine -> drop table film;

insert into film(filmNimetus, aasta, eelarveHind)
values('', 2024, 26485.5)

create table zanr(
zanrID int primary AUTO_INCREASE,
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
