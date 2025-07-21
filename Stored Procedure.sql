-- Stored Procedure
select*from umkm_jabar;
 
-- 1. mebuat stored procedure sederha 
DELIMITER $$
CREATE PROCEDURE getAllData () 
BEGIN  
SELECT*FROM umkm.umkm_jabar; 
END $$ 
DELIMITER ; 

-- 2. memanggil stored procedure 
CALL getAllData(); 

-- 3. mengecek stored procedure 
SHOW procedure status;

-- 4. menghapus stored procedure 
DROP PROCEDURE getAllData; 

-- 5. Membuat stored prodecure dengan parameter 
-- a) parameter IN 
DELIMITER //
CREATE PROCEDURE GetDataUMKM
(
	IN Nama_Kab varchar(100)
)
BEGIN 
SELECT*FROM umkm_jabar WHERE nama_kabupaten_kota = Nama_kab; 
END //
DELIMITER ; 

CALL getDataUMKM('KABUPATEN GARUT');

-- b) parameter OUT  
-- variabel digunakan untuk menyimpan/menampung nilai yang diberikan oleh stored procedure 
DELIMITER $$ 
CREATE PROCEDURE GetTotalRow 
(
	 OUT Jumlah_row INT 
)
BEGIN 
	 SELECT COUNT(*) INTO Jumlah_row FROM umkm_jabar; 
END $$ 
DELIMITER ; 

CALL GetTotalRow(@jumlah_row); 
SELECT @Jumlah_Row;

-- c) parameter INOUT
DELIMITER // 
CREATE PROCEDURE GetTotalRow2
(
	INOUT Kode_kab INT 
)
BEGIN 
	SELECT COUNT(*) INTO Kode_kab FROM umkm_jabar WHERE kode_kabupaten_kota = kode_kab; 
END //
DELIMITER ; 

SET @Kode_kab_kota = 3201; 
CALL getTotalRow2(@kode_kab_kota); 
SELECT @kode_kab_kota; 
SELECT COUNT(*) FROM umkm_jabar WHERE kode_kabupaten_kota = 3201;

-- 6. looping 
CREATE TABLE id_mahasiswa (id INT); 
Select*From id_mahasiswa; 
INSERT INTO id_mahasiswa VALUES (0); 

DELIMITER $$ 
CREATE PROCEDURE buatIDMahasiswa() 
BEGIN 
	DECLARE counter INT; 
	SET counter = 1; 
    WHILE counter <=10 DO 
		INSERT INTO Id_mahasiswa VALUES (counter); 
    SET counter = counter +1; 
    END WHILE; 
END $$ 
DELIMITER ; 

CALL buatIDMahasiswa(); 
select*from id_mahasiswa; 

-- 7. conditional (if then) 
DELIMITER // 
CREATE PROCEDURE test
(
	IN bilangan INT, 
    OUT hasil VARCHAR(100)
)
BEGIN 
	IF bilangan >50 THEN SET hasil = 'lebih dari 50';
    ELSE SET hasil = 'kurang dari sama dengan 50';
    END IF; 
END // 
DELIMITER ; 

CALL test(20, @hasil_test); 
SELECT @hasil_test; 

-- STUDY CASE
SELECT*FROM sc4.students_performance;
-- 1. query untuk membuat stored procedure yang menampilkan seluruh data pada tabel ds.studenstsperformance?
DELIMITER // 
CREATE PROCEDURE AllStudents_performance
() 
BEGIN
	SELECT*FROM sc4.students_performance; 
END // 
DELIMITER ; 

CALL AllStudents_performance; 
SHOW procedure status;

-- 2. modifikasilah query agar dapat menampilkan data pada tabel ds.studenstsperformance untuk grup ras tertentu saja!
DELIMITER // 
CREATE PROCEDURE get_all_data_by_race
(
	IN race_group VARCHAR(100)
) 
BEGIN
	SELECT*FROM sc4.students_performance where race_or_ethnicity = race_group;
END // 
DELIMITER ; 

SET @race = 'group A';
CALL get_all_data_by_race(@race);

DELIMITER $$ 
CREATE PROCEDURE get_all_data_by_ethnicity 
(
	IN data_group2 VARCHAR(200)
)
BEGIN 
	SELECT*FROM sc4.students_performance WHERE race_or_ethnicity = data_group2; 
END $$ 
DELIMITER ;
DROP procedure get_all_data_by_ethnicity; 

DELIMITER // 
CREATE PROCEDURE get_all_data_by_ethnicity 
(
	IN grup_ethnicity VARCHAR(100)
) 
BEGIN 
	SELECT*FROM sc4.students_performance WHERE race_or_ethnicity = grup_ethnicity ; 
END // 
DELIMITER ; 
 SET @enthnicity = 'group B';
 CALL get_all_data_by_ethnicity(@enthnicity); 
 
-- 3.a) Buatlah stored procedure untuk memberikan nilai math rata-rata seluruh data!
DELIMITER // 
CREATE PROCEDURE get_math_score_avg 
( OUT Math_score_avg float
)
BEGIN 
	SELECT AVG(sc4.students_performance.math_score) INTO Math_score_avg FROM students_performance; 
END // 
DELIMITER ; 
call get_math_score_avg(@rerata_nilai_math); 
select @rerata_nilai_math; 

-- 3.b) menampilkan seluruh data yang memiliki nilai math lebih dari rata-rata menggunakan output jawaban 3.a.? Buatlah query tersebut!
SELECT * FROM sc4.students_performance WHERE reading_score > @rerata_nilai_math;

-- 4. Buatlah query yang menghasilkan rata-rata nilai matematika
DELIMITER $$ 
CREATE PROCEDURE get_gend_math_score_avg 
(
	IN gender_male VARCHAR(200), OUT math_score_avg FLOAT
)
BEGIN 
	SELECT AVG(sc4.students_performance.math_score) INTO math_score_avg 
    from sc4.students_performance where gender = gender_male; 
END $$ 
DELIMITER ; 

SET @jenis_gender = 'male'; 
call get_gend_math_score_avg (@jenis_gender, @rerata_nilai_math); 
select @jenis_gender, @rerata_nilai_math; 

-- 5. 
CREATE TABLE id_buku (id INT);
DELIMITER $$
CREATE PROCEDURE buatidbuku()
BEGIN
DECLARE Counter Int ;
SET
Counter = 0;
WHILE Counter <= 5 DO
INSERT INTO
id_buku (id)
VALUES
(Counter);
SET
Counter = Counter + 1;

END WHILE;
END $$
DELIMITER ;
CALL buatidbuku();
SELECT * FROM id_buku;

-- 6. Kita akan membuat stored procedure untuk menghitung luas segitiga dan persegi panjang.
-- Stored procedure ini akan memiliki 4 parameter, yaitu:
-- a. jenis bangun datar (IN) (string), yaitu jenis bangun datar yang akan dihitung; saat ini kita hanya akan menghitung segitiga dan persegi panjang saja
-- b. x (IN) (float), yaitu jika jenis bangun datar segitiga, x adalah alas dan jika persegi panjang, x adalah panjang
-- c. y (IN) (float), yaitu jika jenis bangun datar segitiga, y adalah tinggi dan jika persegi panjang, y adalah lebar
-- d. luas (OUT) (float), yaitu luas bangun datar yang dihitung
-- e. keterangan (OUT) (string), yaitu keterangan apakah perhitungan berhasil dilakukan
DELIMITER // 
CREATE PROCEDURE hitung_luas( 
IN jenis VARCHAR (200), 
IN x FLOAT, 
IN y FLOAT, 
OUT hasil FLOAT, 
OUT keterangan VARCHAR(200)
) 
BEGIN
	CASE 
    WHEN jenis = 'segitiga' THEN SET hasil = 0.5 * x * y , keterangan = 'perhitungan berhasil!'; 
    WHEN jenis = 'Persegi panjang' THEN SET hasil = x * y, keterangan = 'perhitungan berhasil!'; 
    ELSE SET hasil = Null ; SET keterangan = 'perhitungan gagal, bangun datar tidak di dukung'; 
    END CASE;
END // 
DELIMITER ; 

Set @jenis_bangun_datar = 'segitiga';
set @x = 10;
set @y = 20;
CALL hitung_luas(@jenis_bangun_datar, @x, @y, @luas, @keterangan);
SELECT @jenis_bangun_datar, @x, @y, @luas, @keterangan;

Set @jenis_bangun_datar = 'persegi panjang';
set @x = 10;
set @y = 20;
CALL hitung_luas(@jenis_bangun_datar, @x, @y, @luas, @keterangan);
SELECT @jenis_bangun_datar, @x, @y, @luas, @keterangan;
