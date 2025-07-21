-- SQL KEYWORD 
select*from sales; 
select*from products; 
select*from customers;

-- 1. Buatlah query untuk memunculkan jenis produk yang memiliki kuantitas penjualan yang lebih besar dari rerata penjualan
WITH total_per_product AS (
    SELECT 
        p.product_name, 
        SUM(s.quantity) AS total_quantity
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    GROUP BY p.product_name
),
avg_sales AS (
    SELECT AVG(total_quantity) AS avg_quantity
    FROM total_per_product
)

-- 2. Dengan menggunakan RANK() tentukan customer dengan total amount terbanyak pada setiap kota
SELECT 
    t.product_name, 
    t.total_quantity, 
    a.avg_quantity
FROM total_per_product t
CROSS JOIN avg_sales a
WHERE t.total_quantity > a.avg_quantity;

-- 3. Buat kategori customer berdasarkan total quantity dan amountnya sebagai berikut :
-- Low 	: total quantity 1-2 dan total amount <=100
-- Medium 	: total quantity 3-5 dan total amount 101-300
-- High	: total quantity >5 dan total amount >300

SELECT *
FROM (
    SELECT 
        c.customer_name,
        c.country,
        SUM(s.total_amount) AS total_amount,
        RANK() OVER (PARTITION BY c.country ORDER BY SUM(s.total_amount) DESC) AS rank_by_country
    FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
    GROUP BY c.customer_name, c.country
) AS ranked
WHERE rank_by_country = 1;

-- 4. Buatlah query dengan SELECT, SUM(), and the window function SUM() OVER () untuk menghitung kontribusi penjualan per produk terhadap keseluruhan penjualan, baik dari segi kuantitas maupun amount.

SELECT 
    c.customer_name,
    SUM(s.quantity) AS total_quantity,
    SUM(s.total_amount) AS total_amount,
    CASE 
        WHEN SUM(s.quantity) BETWEEN 1 AND 2 AND SUM(s.total_amount) <= 100 THEN 'Low'
        WHEN SUM(s.quantity) BETWEEN 3 AND 5 AND SUM(s.total_amount) BETWEEN 101 AND 300 THEN 'Medium'
        WHEN SUM(s.quantity) > 5 AND SUM(s.total_amount) > 300 THEN 'High'
        ELSE 'Uncategorized'
    END AS customer_category
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name;


-- Langkah 1: Agregasi per produk
SELECT 
    product_name,
    total_quantity,
    total_amount,
    SUM(total_quantity) OVER () AS overall_quantity,
    SUM(total_amount) OVER () AS overall_amount,
    ROUND(100.0 * total_quantity / SUM(total_quantity) OVER (), 2) AS quantity_contribution_percent,
    ROUND(100.0 * total_amount / SUM(total_amount) OVER (), 2) AS amount_contribution_percent
FROM (
    SELECT 
        p.product_name,
        SUM(s.quantity) AS total_quantity,
        SUM(s.total_amount) AS total_amount
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    GROUP BY p.product_name
) AS product_summary;


