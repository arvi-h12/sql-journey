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
        'A0000000001',
        'Adi',
        '1234133',
        1,
        '2022-10-10',
        '2022-10-17',
        NULL
    ),
    (
        'A0000000002',
        'Firman',
        '1234133',
        1,
        '2022-10-12',
        '2022-10-19',
        NULL
    ),
    (
        'A0000000003',
        'Tina',
        '1773364',
        1,
        '2022-10-09',
        '2022-10-16',
        '2022-10-12'
    );