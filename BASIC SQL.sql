-- BASIC SQL
create database umkm;
select* from umkm_jabar; 

-- tunjukan data umkm di kota bandung!
select*from umkm_jabar where nama_kabupaten_kota = 'KOTA BANDUNG';

-- Tunjukan data umkm dari tahun 2019 dan disusun berdasarkan kategori_usaha! 
select*from umkm_jabar where tahun >= 2019 order by kategori_usaha, tahun; 

-- batasi row s.d. 10 
select*from umkm_jabar where tahun>= 2019 order by kategori_usaha, tahun limit 10;

-- kategori usaha apa saja yang tersedia didalam dataset! 
select distinct kategori_usaha from umkm_jabar;

-- tunjukan seluruh data hanya kategori_usaha fasion dan makanan
select*from umkm_jabar where kategori_usaha in ('FASHION', 'MAKANAN');
select*from umkm_jabar where kategori_usaha = 'FASHION' or kategori_usaha = 'MAKANAN';

-- tunjukan seluruh data dengan kategori usaha fashion di kabupaten karawang! 
select*from umkm_jabar where kategori_usaha ='FASHION' and nama_kabupaten_kota ='KABUPATEN KARAWANG';

-- tunjukan seluruh data selain kategori usaha kuliner makanan dan minuman! 
select*from umkm_jabar where kategori_usaha not in('KULINER', 'MAKANAN', 'MINUMAN');

-- dari tahun 2018 s.d 2020 bagaimana tren jumlah umkm dikabupaten tasikmalaya untuk kategori usaha batik! 
select nama_kabupaten_kota, kategori_usaha, jumlah_umkm, satuan, tahun from umkm_jabar 
where tahun <= 2020 and tahun >=2018 and nama_kabupaten_kota = 'KABUPATEN TASIKMALAYA' AND kategori_usaha = 'BATIK';

-- DIANTARA KOTA BANDUNG, KABUPATEN BANDUNG DAN KABUPATEN BANDUNG BARAT DIMANA UMKM KULINER TERPUSAT PAADA TAHUN 2021
select* from umkm_jabar where nama_kabupaten_kota like '%BANDUNG%' AND kategori_usaha ='kuliner'; 

-- kabupaten/kota mana saja yang memiliki angka 7 pada digit ke 3 (_ dua kali)  kode tersebut! 
select distinct kode_kabupaten_kota, nama_kabupaten_kota from umkm_jabar where kode_kabupaten_kota like '__7%';

-- STUDY CASE-- 
create database sc4; 
select*from students_performance; 
select race_or_ethnicity from students_performance order by race_or_ethnicity;
select*from students_performance where math_score = 0;
select*from students_performance where parental_level_of_education = "associate's degree" order by writing_score ASC;
select*from students_performance where race_or_ethnicity in ('group A', 'group B') order by writing_score asc;
-- nilai terendah group A = 15 dan grup B = 19 
select*from students_performance where math_score <= 65 and writing_score >= 80; 
select*from students_performance where reading_score >= 10 and reading_score <=25; 
-- querry A 
select*from students_performance where parental_level_of_education like '%high%' and race_or_ethnicity not in ('group A', 'Group B') AND reading_score < 35;  
-- querry B
select*from students_performance where parental_level_of_education like 'high%' and race_or_ethnicity not in ('group A', 'Group B') AND reading_score < 35;  
-- Bedannya querry A dan B terletak pada colom parental_level_of_education yang mana pada querry A berisi kalimat yang mengandung kata high sedangkan kalau querry B berisi kalimat awal high 
 