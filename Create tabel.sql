-- Table Creating---

CREATE DATABASE SDM; 
CREATE TABLE Karyawan (
NIK VARCHAR(200), 
Nama_Karyawan VARCHAR(200), 
Level_Jabatan INTEGER,
Tanggal_Lahir DATE);
SELECT*FROM Karyawan;  

INSERT INTO SDM.Karyawan value(
'2134AS45', 
'Maryanto', 
'3', 
'2009-07-03'
);
INSERT INTO SDM.Karyawan values
(
'2134EWS5', 
'Anto', 
'2', 
'2009-07-03'
), 
(
'21342WS5', 
'Anti', 
'1', 
'2009-07-03'
);
SELECT*FROM SDM.Karyawan;
SELECT NIK FROM SDM.Karyawan; 
SELECT Nama_Karyawan FROM SDM.Karyawan; 
SELECT NIK AS Id_Karyawan FROM SDM.Karyawan; 

-- study case ---
CREATE DATABASE bimbel; 
CREATE TABLE siswa ( 
ID_Siswa VARCHAR(200) NOT NULL, 
Nama_Siswa VARCHAR(200) NOT NULL, 
Alamat_Siswa VARCHAR(200) NULL, 
Tanggal_Lahir_Siswa DATE NULL, 
Kelas_Siswa integer NOT NULL, 
Sekolah_Siswa VARCHAR(200) NULL
);
SELECT*FROM Siswa; 

INSERT INTO bimbel.siswa (
ID_Siswa, 
Nama_Siswa,
Alamat_Siswa,
Tanggal_Lahir_Siswa,
Kelas_Siswa,
Sekolah_Siswa)
VALUES (
'A2134D', 
'Dwiantara',
'Jl. mangga no1'  ,
'2014-04-02',
'12',
'SMA Triaksa'
), 
(
'A2132D', 
'Mawar',
'Jl. pegangsaan no1'  ,
NULL,
'12',
'SMA Mayoritas'
), 
(
'b1235D', 
'Agas ayunita',
'Jl. anggerek no12'  ,
NULL,
'12',
NULL 
), 
(
'A3214R', 
'sesar adi',
'Jl. Maung no12'  ,
'2018-04-02',
'12',
NULL 
); 
select*FROM bimbel.siswa;
