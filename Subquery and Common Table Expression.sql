-- Subquery and Common Table Expression



-- STUDY CASE -- 
create DATABASE	SC7;
create table product (
id integer, 
nama_product varchar(200), 
harga integer, 
jual integer);
 insert into product values 
 ('1', 'sabun mandi', '10000', '100'), 
 ('2', 'pasta gigi', '15000', '80'),
 ('3', 'sampo', '20000', '120'),
 ('4', 'detergen', '25000', '90');
 select*from product;
 
 create table product2 (
 id integer, 
 id_pelanggan integer,
 tanggal date, 
 total_pembelian integer); 
 insert into product2 values 
 ('1', '1', '2023-11-01', '100000'),
  ('2', '2', '2023-11-02', '150000'),
  ('3', '1', '2023-11-03', '200000'),
   ('4', '3', '2023-11-04', '250000');
   select*from product2;
   
 -- 1. Dari tabel orders berikut, dengan menggunakan Common Table Expression, 
 -- temukan total pembelian untuk setiap pelanggan dan urutkan berdasarkan total pembelian dari tertinggi ke terendah!
 select nama_product, (harga*jual) harga_jual from product 
 where harga*jual > (select avg(harga*jual) from product); 
 
 -- Dari tabel orders berikut, dengan menggunakan Common Table Expression, 
 -- temukan total pembelian untuk setiap pelanggan dan urutkan berdasarkan total pembelian dari tertinggi ke terendah!
with total_pembelian_perpelanggan as 
(select id_pelanggan, sum(total_pembelian) as total_amount from product2 group by id_pelanggan) 
select id_pelanggan, total_amount from total_pembelian_perpelanggan order by total_amount desc; 
 
 