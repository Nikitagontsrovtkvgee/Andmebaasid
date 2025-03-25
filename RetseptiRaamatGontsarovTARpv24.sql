CREATE TABLE kasutaja(
kasutaja_id int primary key identity(1,1),
eesnimi varchar (50),
perenimi varchar (50),
email varchar (150));
Insert into kasutaja(eesnimi, perenimi, email)
Values ('Medik', 'Iz TF2', 'medik.TF2@edu.ee'),
('Mark', 'Mark', 'mark@tthk.ee'),
('Roman', 'Roman', 'roman@tthk.ee'),
('Lenin', 'Lenin', 'lenin.grazdanskajaoborona@edu.ee'),
('MOP', 'MOPOB', 'BOPOBODOB.MOP@email.com')

CREATE TABLE toiduAine(
toiduaine_Id int primary key identity(1,1),
toiduaine_nimi varchar (100));
INSERT INTO toiduAine(toiduaine_nimi)
VALUES ('vorst'), ('kurk'), ('liha'), ('blink'), ('pipar')

CREATE TABLE kategooria(
kategooria_id int primary key identity(1,1),
kategooria_nimi varchar(50));
INSERT INTO kategooria(kategooria_nimi)
VALUES ('majustused'), ('joogid'), ('köök'), ('külmikud'), ('praadi');


CREATE TABLE retsept(
retsept_id int primary key identity(1,1),
retsepti_nimi varchar(100),
kirjeldus varchar(200),
juhend varchar(500),
sisestatud_kp date,
kasutaja_id int,
foreign key (kasutaja_id) references kasutaja(kasutaja_id),
kategooria_id int,
foreign key (kategooria_id) references kategooria(kategooria_id));
INSERT INTO retsept(
retsepti_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
VALUES ('Grill', 'nii soola', 'Kasuta Aerogrill', '2003-12-9', 4, 2),
('Mesi', 'liiga magus', 'varusta mesilased', '1914-6-25', 2, 3),
('Praed', 'vürtsikas', 'sea tapmine', '1936-3-30', 1, 2),
('külmik', 'külm', 'võtke siga rasva maha', '2008-8-10', 4, 1),
('cola', 'gaseeritud', 'muutunud diabeetiliseks', '1995-12-31', 2, 3);


CREATE TABLE yhik(
yhik_id int primary key identity(1,1),
yhik_nimi varchar(100));
INSERT INTO yhik(yhik_nimi)
VALUES ('mg'), ('g'), ('kg'), ('t'), ('c');


CREATE TABLE koostis(
koostis_id int Primary Key identity(1,1),
kogus int,
retsept_retsept_id int,
foreign key (retsept_retsept_id) references retsept(retsept_id),
toiduaine_id int,
foreign key (toiduaine_id) references toiduaine(toiduaine_id),
yhik_id int,
foreign key (yhik_id) references yhik(yhik_id));
INSERT INTO koostis
VALUES
(747, 1, 2, 2), (743, 2, 3, 3), (759, 3, 1, 4), (876, 4, 4, 1), (524, 5, 1, 2);


CREATE TABLE tehtud(tehtud_kp date, retsept_id int,
foreign key (retsept_id) references retsept(retsept_id));
INSERT INTO tehtud
VALUES ('1957-6-4', 3), ('7561-8-12', 5), ('2759-8-26', 4), ('1946-10-27', 1), ('6863-4-9', 2)

CREATE PROCEDURE addkoostis
@kogus int,
@retsept_retsept_id int,
@toiduaine_id int,
@yhik_id int
AS
BEGIN
INSERT INTO koostis (kogus, retsept_retsept_id, toiduaine_id, yhik_id)
Values (@kogus, @retsept_retsept_id, @toiduaine_id, @yhik_id)
END;
EXEC addkoostis @kogus=2, @retsept_retsept_id=3, @toiduaine_id=3, @yhik_id=3

CREATE PROCEDURE addtehtud
@tehtud_kp date,
@retsept_id int
AS
BEGIN
INSERT INTO tehtud(tehtud_kp, retsept_id)
VALUES(@tehtud_kp, @retsept_id)
END;

EXEC addtehtud @tehtud_kp='6863-4-9', @retsept_id=4

CREATE PROCEDURE addyhik
    @yhik_nimi VARCHAR(100)
AS
BEGIN
    INSERT INTO yhik (yhik_nimi)
    VALUES (@yhik_nimi);
END;

CREATE PROCEDURE addretsept
    @retsepti_nimi VARCHAR(100),
    @kirjeldus VARCHAR(200),
    @juhend VARCHAR(500),
    @sisestatud_kp DATE,
    @kasutaja_id INT,
    @kategooria_id INT
AS
BEGIN
    INSERT INTO retsept (retsepti_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
    VALUES (@retsepti_nimi, @kirjeldus, @juhend, @sisestatud_kp, @kasutaja_id, @kategooria_id);
END;

CREATE PROCEDURE addtoiduaine
    @toiduaine_nimi VARCHAR(100)
AS
BEGIN
    INSERT INTO toiduAine (toiduaine_nimi)
    VALUES (@toiduaine_nimi);
END;


CREATE TABLE hinnad(
hinnad_id int primary key identity(1,1),
hind float,
retsept_id int foreign key(retsept_id) references retsept(retsept_id));
INSERT INTO hinnad
VALUES(1.89, 2), (9.88, 4), (4.99, 1), (3.39, 3), (0.99, 5)


CREATE PROCEDURE hindlisamine
    @hind FLOAT,
    @retsept_id INT
AS
BEGIN
    INSERT INTO hinnad (hind, retsept_id)
    VALUES (@hind, @retsept_id);
END;

CREATE PROCEDURE delete_from_table
    @table_name NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'DELETE FROM ' + QUOTENAME(@table_name);
    EXEC sp_executesql @sql;
END;

CREATE PROCEDURE hind_uuendamine
    @hinnad_id INT,
    @new_hind FLOAT
AS
BEGIN
    UPDATE hinnad
    SET hind = @new_hind
    WHERE hinnad_id = @hinnad_id;
END;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA dbo TO manager;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA dbo TO manager;
DENY INSERT ON toiduaine TO manager;
DENY INSERT ON kasutaja TO manager;
GRANT ALL PRIVILEGES ON dbo.koostis TO manager;
GRANT ALL PRIVILEGES ON dbo.retsept TO manager;

GRANT SELECT, INSERT ON toiduAine TO staff;
GRANT SELECT, INSERT ON kategooria TO staff;
GRANT SELECT ON kasutaja TO staff;
DENY UPDATE, DELETE ON toiduAine TO staff;
DENY UPDATE, DELETE ON kategooria TO staff;
DENY UPDATE, DELETE ON kasutaja TO staff;

GRANT SELECT, INSERT, UPDATE, DELETE ON koostis TO manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON retsept TO manager;
GRANT SELECT, UPDATE, DELETE ON toiduAine TO manager;
GRANT SELECT, UPDATE, DELETE ON kasutaja TO manager;
DENY INSERT ON toiduAine TO manager;
DENY INSERT ON kasutaja TO manager;

CREATE LOGIN staff WITH PASSWORD = '12345', CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF;
CREATE LOGIN manager WITH PASSWORD = '12345', CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF;

USE [Retsepti Raamat Nikita Gontsarov];
CREATE USER staff FOR LOGIN staff;
CREATE USER manager FOR LOGIN manager;

SELECT * FROM fn_my_permissions(NULL, 'DATABASE');
EXEC sp_helprotect NULL, 'staff';
EXEC sp_helprotect NULL, 'manager';
