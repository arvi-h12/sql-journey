-- Data Driven Decisions Making 
create database d3; 
select*from area;
select*from orders; 
alter table orders modify column order_date varchar(200); 
alter table orders add column order_date_backup date;
update orders set order_date_backup = str_to_date(order_date, '%Y-%m-%d') LIMIT 100;
alter table orders drop column order_date; 
alter table orders change column order_date_backup order_date date;

select extract(year from order_date) year, count(distinct order_id) total_order from orders group by 1;
select extract(year from order_date) year, sum(if(is_fixed_price = 1,1,0)) fixed_price, sum(if(is_fixed_price = 0,1,0)) non_fixed_price from orders group by 1; 
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(IF(is_fixed_price = 1 AND status = 'Cancel', 1, 0)) / 
        SUM(IF(is_fixed_price = 1, 1, 0)) AS order_fixed_price_cancel_rate,
        
    SUM(IF(is_fixed_price = 0 AND status = 'Cancel', 1, 0)) / 
        SUM(IF(is_fixed_price = 0, 1, 0)) AS non_fixed_price_cancel_rate
FROM orders
GROUP BY year;

SELECT EXTRACT(year FROM order_date) year,
  cancel_reason,
  COUNT(DISTINCT order_id) total_order
FROM orders
WHERE is_fixed_price=1
GROUP BY 1,2

SELECT 
  c.city,
  COUNT(DISTINCT o.order_id) AS total_order
FROM orders o
LEFT JOIN city c ON o.city_id = c.city_id
WHERE o.cancel_reason = 'lokasi driver terlalu jauh'
GROUP BY c.city;
