-- JOIN & UNION 
select*from transactions; 
select*from customers;
-- JENIS JOIN 
select*from transactions inner join customers on transactions.customer_id = customers.customer_id; 
select*from transactions right join customers on transactions.customer_id = customers.customer_id; 
select*from transactions cross join customers;

-- UNION THEORY
SELECT * FROM transactions UNION SELECT * FROM customers;
SELECT * FROM transactions UNION ALL SELECT * FROM customers;
SELECT * FROM transactions EXCEPT SELECT * FROM customers;

-- STUDY CASE---
create database SC5;
select*FROM product;
describe product;

select*from orders; 
describe orders;
alter table orders modify column order_date varchar(200); 
alter table orders add order_data_backup datetime;
UPDATE orders SET order_data_backup = STR_TO_DATE(order_date, '%m/%d/%y %H:%i') LIMIT 1000;
alter table orders drop column order_date;
alter table orders change column order_data_backup order_date datetime;

select*from customers; 
describe customers;

select*from order_items; 
describe order_items; 

-- 1. Buatlah query dengan menggunakan subquery untuk mencari customer 
-- yang melakukan pembelian pertama pada tanggal 25-27 Februari 2024
select customers.customer_id, customers.customer_name, customers.email, orders.order_id, orders.order_date 
from customers inner join orders on customers.customer_id = orders.customer_id 
where orders.order_date = (
select min(order_date) 
from orders where customers.customer_id = orders.customer_id) 
and orders.order_date between '2024-02-25 08:00:00' and '2024-02-27 14:20:00';  

-- 2. Buatlah subquery untuk menampilkan order_id yang memiliki lebih dari 1 jenis produk.
select product.product_id, product.product_name, product.price, product.category_id, order_items.order_id, order_items.quantity
from product inner join order_items on product.product_id = order_items.product_id 
where order_items.order_id in (
 select order_id from order_items 
 group by order_id having count(distinct product_id)>1);
  
  -- 3. Buatlah subquery untuk menampilkan customer dengan total pembelanjaan (total price)
select customers.customer_name, product.product_name, product.price, order_items.quantity, (product.price * order_items.quantity) as total_price
from orders 
inner join customers on customers.customer_id = orders.customer_id 
inner join order_items ON orders.order_id = order_items.order_id
inner join  product ON order_items.product_id = product.product_id
order by (product.price * order_items.quantity) DESC;

 -- 4. Buatlah subquery untuk menampilkan customer dengan total pembelanjaan (total price) paling banyak. 
SELECT customers.customer_name, SUM(order_items.quantity * product.price) AS total_belanja
FROM orders 
JOIN customers ON customers.customer_id = orders.customer_id 
JOIN order_items ON orders.order_id = order_items.order_id
JOIN product ON order_items.product_id = product.product_id 
GROUP BY customers.customer_name ORDER BY total_belanja DESC;


-- 5. Buatlah subquery untuk menampilkan jenis produk yang memiliki harga 2x lipat lebih tinggi dari harga Smartphone.
SELECT product_name, price
FROM product
WHERE price > 2* (
    SELECT price 
    FROM product 
    WHERE product_name = 'Smartphone'
);
