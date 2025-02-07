(localdb) \mssqllocaldb
--SQL salvestatud protseduur - ?
mis käivitab serveris 


  
create database protseduurTARpv24;

use protseduurTARpv24;
Create table linn(
linnId int Primary Key identity(1,1),
linnNimi varchar(30),
rahvaArv int
);
Select * from linn;
Insert into linn(linnNimi, rahvaArv)
Values ('Tallinn', 60000)
--Protseduuri loomine
--protseduur, mis lisab uus linn ja kohe näitab tabelis

CREATE PROCEDURE lisaLinn 
    @lnimi VARCHAR(30), 
    @rArv INT
AS
BEGIN
    INSERT INTO linn (linnNimi, rahvaArv)  
    VALUES (@lnimi, @rArv);
    
    SELECT * FROM linn;
END;

--protseduuri kutse
EXEC lisaLinn @lnimi = 'Tartu', @rArv = 1256;
EXEC lisaLinn 'Tartu2', 1256;

Delete from linn WHERE linnID=3;
Select * from linn;

IF OBJECT_ID('dbo.kustutaLinn', 'P') IS NOT NULL  
    DROP PROCEDURE dbo.kustutaLinn;

CREATE PROCEDURE kustutaLinn  
    @deleteID INT
AS  
BEGIN  
--kirje kustutamine
    DELETE FROM linn WHERE linnID = @deleteID;  

    SELECT * FROM linn;  
END;


EXEC kustutaLinn 4;
--Protseduur, mis otsib linn esimese tähte jaärgi
CREATE PROCEDURE linnaOtsing
@taht char(1)
AS
BEGIN
SELECT * from linn
WHERE linnNimi LIKE @taht + '%';
--% - kõik teised tähed
END;
--kutse
EXEC linnaOtsing T;

------------------------------------------------------------------------------------------------------------------------------
kasutame XAMPP / localhost

Create table linn(
linnId int Primary Key AUTO_INCREMENT,
linnNimi varchar(30),
rahvaArv int
);

Insert into linn(linnNimi, rahvaArv)
Values ('Tallinn', 60000)

------------------------------------------------------------------------------------------------------------------------------

use protseduurTARpv24;
CREATE TABLE linn (
linnId int Primary Key identity(1,1),
linnNimi varchar(30),
rahvaArv int
);

Insert into linn(linnNimi, rahvaArv)
Values ('Tallinn', 60000)

SELECT * FROM linn;
-- uue veeru lisamine 
ALTER TABLE  linn ADD test int;
--veeru kustutamine
ALTER TABLE linn DROP COLUMN test;

CREATE PROCEDURE veeruLisaKustuta
@valik varchar(20),
@veerunimi varchar(20),
@tyyp varchar(20) =null

AS
BEGIN
DecLare @sqltegevus as varchar (max)
set @sqltegevus=case
when @valik='add' then concat('ALTER TABLE linn ADD ', @veerunimi, ' ', @tyyp)
when @valik='drop' then concat('ALTER TABLE linn DROP COLUMN ', @veerunimi)
END;
print @sqltegevus;
begin
EXEC (@sqltegevus);
END;
END;


--kutse
EXEC veeruLisaKustuta @valik='add', @veerunimi='test3', @tyyp='int';
SELECT * FROM linn;

CREATE PROCEDURE veeruLisaKustutaTabelis
@valik varchar(20),
@tabelnimi varchar(20),
@veerunimi varchar(20),
@tyyp varchar(20) =null

AS
BEGIN
DecLare @sqltegevus as varchar (max)
set @sqltegevus=case
when @valik='add' then concat('ALTER TABLE ', @tabelnimi, ' ADD ' , @veerunimi, ' ', @tyyp)
when @valik='drop' then concat('ALTER TABLE ' @tabelnimi, ' DROP COLUMN ', @veerunimi)
END;
print @sqltegevus;
begin
EXEC (@sqltegevus);
END;
END;

EXEC veeruLisaKustutaTabelis @valik='add', @tabelnimi='linn', @veerunimi='tekst3', @tyyp='int';
SELECT * FROM linn;

EXEC veeruLisaKustutaTabelis @valik='drop', @tabelnimi='linn', @veerunimi='tekst3';
SELECT * FROM linn;

--protseduur tingimusega
CREATE PROCEDURE rahvaHinnang
@piir int

AS
BEGIN
SELECT linnNimi, IIF(rahvaArv<@piir, 'väike linn', 'suur linn') as Hinnang
FROM linn;

END;

DROP PROCEDURE rahvaHinnang;

EXEC rahvaHinnang 2000;
--Agregaat funktsioonid: sum(), AVG(), MIN(), MAX(), COUNT()

CREATE PROCEDURE kokkuRahvaArv

AS
BEGIN
SELECT SUM(rahvaArv) AS 'kokkuArv', AVG(rahvaArv) AS 'keskmine rahvaArv', COUNT(*) AS 'linnade arv'
FROM linn;
END;

EXEC kokkuRahvaArv;
