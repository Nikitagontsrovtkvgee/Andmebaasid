--AB loomine
Create database MerkulevaBaas;

use MerkulevaBaas;
CREATE TABLE opilane(
OpilaneID int primary key identity(1,1),
Eesnimi varchar(25) not null,
Perenimi varchar(25) not null,
Synniaeg date,
Stip bit,
aadress text,
keskmine_hinne decimal(2,1)
)
select * from opilane;
--andmete lisamine tabelisse
INSERT INTO opilane(
eesnimi,
perenimi,
Synniaeg,
Stip,
keskmine_hinne)
VALUES(
'Nikita',
'Nikita',
'2000-12-12',
1,
4.5),
(
'Arnold',
'schwarzenegger',
'1947-7-30',
99999,
5),
(
'Bill',
'Gates',
'1955-10-28',
99999,
5),
(
'Kristofor',
'Kolumb',
'1855-11-4',
99999,
4),
(
'Harry',
'Potter',
'1980-3-13',
99999,
3.5)

--tabeli kustutamine
drop table opilane;
--rida kustutamine, kus on opilaneID=2
DELETE FROM opilane WHERE opilaneID=2;
select * from opilane;

--andmete uuendamine
UPDATE opilane SET aadress='Tartu'
WHERE opilaneID=3

CREATE TABLE Language
(
ID int NOT NULL PRIMARY KEY,
Code char(3) NOT NULL,
Language varchar(50) NOT NULL,
IsOfficial bit,
Percentage smallint,
);
SElect * from Language

INSERT INTO Language(ID, Code, Language)
Values(1, 'EST', 'Eesti'), (2, 'RUS', 'Vene'),
(3, 'ENG', 'Inglise'), (4, 'G', 'Saksa')

CREATE TABLE keeleValik(
keeleValikID int primary key identity(1,1),
valikuNimetus varchar(10) not null,
opilaneID int,
Foreign key (opilaneID) references opilane(opilaneID),
Language int,
Foreign key (Language) references Language(ID)
)
select * from keelevalik;
select * from Language;
select * from opilane;

INSERT INTO keelevalik(valikuNimetus, opilaneID, Language)
Values ('valik A', 1, 1),
('valik B', 2, 3),
('valik A', 3, 2)

SELECT *
FROM opilane, Language, keelevalik
WHERE opilane.opilaneID=keelevalik.opilaneID
AND Language.ID=keelevalik.Language
