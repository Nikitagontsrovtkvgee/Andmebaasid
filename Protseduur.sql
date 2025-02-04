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

