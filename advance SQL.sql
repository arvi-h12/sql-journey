-- SQL Advance: Group By & Agregat
select*from umkm_jabar; 
--  1. berapa jumlah baris dari tabel umkm_jabar 
select count(*) as jumlah_baris from umkm_jabar;

-- 2. berapa jumlah umkm di kabupaten bekasi pada tahun 2017 
select sum(jumlah_umkm) as jumlah_umkm_kab_bekasi_2017 from umkm_jabar 
where nama_kabupaten_kota = 'KABUPATEN BEKASI' and tahun = 2017;  

-- 3. bagaimana tren jumlah umkm di kabupaten karawang dari tahun 2017 s.d 2021 
select tahun, sum(jumlah_umkm) from umkm_jabar where 
nama_kabupaten_kota = 'KABUPATEN KARAWANG' and tahun >= 2017 and tahun <= 2021 group by tahun; 

-- 4. berapa jumlah rata rata umkm setiap kategori usaha di setiap kabupaten/kota di jawa barat dari tahun ke tahun 
select tahun, kategori_usaha, avg(jumlah_umkm) as rerata_jumlah_umkm from umkm_jabar 
where tahun = 2021 group by tahun, kategori_usaha order by kategori_usaha;

-- 5. nilai minimumn dan maksimum dari kolom jumlah_umkm
select min(jumlah_umkm) as jumlah_umkm_min, max(jumlah_umkm) as jumlah_umkm_max from umkm_jabar; 

-- 6. kabupaten atau kota apa yang memiliki jumlah umkm kurang dari 100.000 pada tahun 2020 
select nama_kabupaten_kota, sum(jumlah_umkm) as jumlah_umkm_tahun_2020 from umkm_jabar 
where tahun = 2020 group by nama_kabupaten_kota having jumlah_umkm_tahun_2020 < 100000; 

-- STUDY CASE -- 
select * from students_performance; 
select count(*) as jumlah_baris from students_performance;
select gender, avg(reading_score) as avg_reading_score from students_performance group by gender;
select parental_level_of_education, min(math_score) as min_math_score, max(math_score) as max_math_score from students_performance group by parental_level_of_education; 
select parental_level_of_education, avg(writing_score) as avg_wriring_score from students_performance where parental_level_of_education = 'high school' or parental_level_of_education = 'some high school' group by parental_level_of_education; 
SELECT AVG(writing_score) AS avg_writing_score FROM students_performance WHERE parental_level_of_education LIKE '%high school%';
select gender, race_or_ethnicity, test_preparation_course, avg(math_score) as avg_math_score, avg(reading_score) as avg_reading_score, avg(writing_score) as avg_writing_score from students_performance group by gender, race_or_ethnicity, test_preparation_course order by gender, race_or_ethnicity, test_preparation_course;
select gender, race_or_ethnicity, test_preparation_course, avg(math_score) as avg_math_score, avg(reading_score) as avg_reading_score, avg(writing_score) as avg_writing_score from students_performance group by gender, race_or_ethnicity, test_preparation_course having avg_math_score > 70 order by gender, race_or_ethnicity, test_preparation_course;
