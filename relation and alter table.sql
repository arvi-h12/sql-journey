-- relation and alter tabel -- 
create database universitas;
create table dosen(
id_dosen varchar(200), 
nama_dosen varchar(200), 
program_studi varchar(200), 
primary key (id_dosen)
);

-- CARA LAIN UNTUK MELETAKAN PRIMARY KEY-- 
create table dosen(
id_dosen varchar(200) primary key,  
nama_dosen varchar(200), 
program_studi varchar(200) 
);
describe dosen; 
drop table dosen;

create table mahasiswa (
id_mahasiswa varchar(200), 
nama_mahasiswa varchar(200), 
program_studi varchar(200), 
id_dosen_wali varchar(200), 
foreign key (id_dosen_wali) references dosen(id_dosen)
);
describe mahasiswa;
select * from dosen;

INSERT INTO universitas.dosen(id_dosen,nama_dosen,program_studi)
values 
('12345A', 'SURIPTO', 'Pertanian'),
('12346B', 'AGUS','Matematika'), 
('21345W', 'BUNGA', 'Kedokteran'), 
('31427R', 'BIBUL', 'Teknik Sipil'), 
('213432Q', 'AHMAD', 'Kimia');

-- ALTER TABEL -- 
-- 1. MENAMBAHKAN KOLOM 
alter table dosen add golongan_darah varchar(200); 
 
 -- 2. MENGHAPUS KOLOM
 alter table dosen drop column golongan_darah; 
 
 -- 3. MENGUBAH NAMA KOLOM PADA TABEL 
 alter table dosen change column id_dosen nomer_induk_dosen varchar(200); 
 
 -- 4. MENGUBAH TYPE DATA KOLOM PADA TABEL 
 describe dosen; 
 alter table dosen modify column nama_dosen varchar(500); 
 
 -- STUDY CASE--
 CREATE DATABASE perpustakaan; 
 create table buku (
 id_buku varchar(100) not null primary key, 
 judul_buku varchar(100) not null, 
 nama_penulis varchar(100) null, 
 jumlah integer null); 
 select *from perpustakaan.buku; 
 describe buku; 
 alter table perpustakaan.buku add lokasi varchar(100);  
 
 create table peminjaman(
 no_peminjaman integer NOT NULL primary key, 
 nama_peminjam varchar(200) NOT NULL, 
 id_buku varchar(200) NOT NULL, 
 jumlah_buku integer NOT NULL, 
 tgl_pinjam date NULL, 
 tgl_ekspektasi_kembali date NULL, 
 tgl_actual_kembali date NULL, 
 foreign key (id_buku) references perpustakaan.buku(id_buku)); 
explain perpustakaan.peminjaman;
select*from perpustakaan.buku;
alter table peminjaman modify column no_peminjaman varchar(200); 
select*from perpustakaan.peminjaman; 

INSERT INTO
    perpustakaan.peminjaman (
no_peminjaman, 
nama_peminjam, 
id_buku, 
jumlah_buku, 
tgl_pinjam , 
tgl_ekspektasi_kembali, 
tgl_actual_kembali
    )
VALUES
    (
        'A0000000004',
        'Adi',
        'A234133',
        1,
        '2022-10-10',
        '2022-10-17',
        NULL
    );
-- keterangan: 
-- Query ditolak / data tidak berhasil masuk ke dalam tabel
-- Penyebabnya adalah karena id_buku yang dimasukkan tidak ada di tabel buku
-- id_buku itu sendiri merupakan foreign key yang merefer ke tabel buku pada kolom id_buku