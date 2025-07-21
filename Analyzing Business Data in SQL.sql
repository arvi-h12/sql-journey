-- Analyzing Business Data in SQL




-- STUDY CASE 
create database sc9; 
select*from categories;
select*from region; 
select*from product;
select*from sales;
describe sales; 
alter table sales modify column sale_date varchar(200);
alter table sales add column sale_date_backup date;
update sales set sale_date_backup = str_to_date ( sale_date, '%Y-%m-%d') limit 1000;
alter table sales drop column sale_date;
alter table sales change column sale_date_backup sale_date date;

-- 1. Buatlah query untuk menghitung cost, revenue dan profit per product!
-- 2. Buatlah query untuk membandingkan Average Revenue per User (ARPU) setiap bulan!
-- 3. Buatlah query untuk menghitung Daily Active User dan Monthly Active User! 
-- 4. Buatlah query untuk menghitung komponen berikut ini dari jumlah oder (total quantity sold) per customer 
----- a) Min 
----- b) Quartile 1 (Q1)
----- c) Quartile 2 (Q2)
----- d)Quartile 3 (Q3)
----- e)Max 


 