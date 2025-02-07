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

------------------------------------------------------------------------------------------------------------------------------
Vigane kood
CREATE TABLE oppimine(
aine varchar(10),
aasta int,
opetaja text,
opilaneID foreign key references ,
hinne char(1)
)

------------------------------------------------------Protseduurid------------------------------------------------------------

--rida kustutamine, kus on opilaneID=2
CREATE PROCEDURE kustutaOpilane
@deleteID INT
AS
BEGIN
DELETE FROM opilane WHERE opilaneID = @deleteID;
SELECT * FROM opilane;
END
  
EXEC kustutaOpilane 3;

--andmete uuendamine
CREATE PROCEDURE andmeteUuendamine
@stip int
AS
BEGIN
SELECT * FROM opilane;
UPDATE opilane
SET stip = @stip
WHERE opilaneID=3;
END

EXEC andmeteUuendamine 0;

--Otsi õpilasi aadressi järgi
CREATE PROCEDURE opilaneAadressOtsing
@aadress NVARCHAR(50)
AS
BEGIN
SELECT * FROM opilane WHERE aadress = @aadress;
END

EXEC opilaneAadressOtsing 'Tartu';

------------------------------------------------------Protseduurid------------------------------------------------------------

CREATE TABLE etteVõtteTulud (
etteVõtteTuludId int Primary Key identity(1,1),
saadudRahaSumma varchar(15),
töötajaPalk char (6),
rendiKulu varchar (12),
kindlustusKulu char (8),
tuluMaks float,
käibeMaks char(8),
etteVõttePuhasKasum varchar (15));
SELECT * FROM etteVõtteTulud;

Insert into ettevõtteTulud(saadudRahaSumma, töötajaPalk, rendikulu, kindlustusKulu, tuluMaks, käibeMaks, ettevõttePuhasKasum)
Values (3699999, '1200', '20000', '12625', '5600', '23442.62', '130000')


CREATE PROCEDURE andmeteUuendamine
@saadudRahaSumma VARCHAR(15),
@töötajaPalk CHAR(6),
@rendikulu VARCHAR(12),
@kindlustusKulu CHAR(8),
@tuluMaks FLOAT,
@käibeMaks CHAR(8),
@etteVottePuhasKasum VARCHAR(15),
@etteVotteTuluId INT
AS
BEGIN
UPDATE ettevõtteTulud  
SET saadudRahaSumma = @saadudRahaSumma,
töötajaPalk = @töötajaPalk,
rendikulu = @rendikulu,
kindlustusKulu = @kindlustusKulu,
tuluMaks = @tuluMaks,
käibeMaks = @käibeMaks,
ettevõttePuhasKasum = CAST(@etteVottePuhasKasum AS VARCHAR(15))
WHERE ettevõtteTuludId = @etteVotteTuluId;  
END;

EXEC andmeteUuendamine
@etteVotteTuluId = 1,
@saadudRahaSumma = '325869',
@töötajaPalk = '3769',
@rendikulu = '1345',
@kindlustusKulu = '638',
@tuluMaks = 1120.5,
@käibeMaks = '1436',
@etteVottePuhasKasum = '3748';


CREATE PROCEDURE andmeteLisamine
@saadudRahaSumma VARCHAR(15),
@töötajaPalk CHAR(6),
@rendikulu VARCHAR(12),
@kindlustusKulu CHAR(8),
@tuluMaks FLOAT,
@käibeMaks CHAR(8),
@etteVottePuhasKasum VARCHAR(15)
AS
BEGIN
INSERT INTO ettevõtteTulud (saadudRahaSumma, töötajaPalk, rendikulu, kindlustusKulu, tuluMaks, käibeMaks, ettevõttePuhasKasum)
VALUES (@saadudRahaSumma, @töötajaPalk, @rendikulu, @kindlustusKulu, @tuluMaks, @käibeMaks, @etteVottePuhasKasum);
END;

EXEC andmeteLisamine
@saadudRahaSumma = '746896',
@töötajaPalk = '3648',
@rendikulu = '4578',
@kindlustusKulu = '857',
@tuluMaks = 6074.6,
@käibeMaks = '3526',
@etteVottePuhasKasum = '1685';

SELECT * FROM etteVõtteTulud;

CREATE PROCEDURE andmeteKustutamine

AS
BEGIN
