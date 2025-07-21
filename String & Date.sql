-- String & Date 
create database sd;
 create table category (
 category_id varchar(200),
 category varchar(200), 
 items varchar(200),
 expied date
 );
 
 insert into category values
('123', 'fashion', 'top', '2023-02-12'), 
('00124', 'fashion', '   shirt', '2024-12-12'),
('125', 'fashi_on', 'hat', '2023-12-19'), 
('00456', 'food', 'milk', '2024-03-22'),
('467', 'food', 'fruits', '2023-06-12');
select*from category;

-- STRING FUNCTION 
SELECT*, CONCAT (category, items) as result from category;
select*, concat_ws('_', category_id, category) as result from category;
select category, upper(category) as result from category;
select items, lower(items) as reslut from category;
SELECT category,CONCAT(
    UPPER(LEFT(category, 1)),
    LOWER(SUBSTRING(category, 2))
  ) AS result FROM category;
select items, trim(items) as result from category;
select category, reverse(category) as result from category;
select category_id, LPAD(category_id, 10, '0') as result from category;
select category_id, RPAD(category_id, 10, '0') as result from category; 
select category, replace(category, 'fashi_on', 'fashion') as result from category;
select category, substring(category, 2, 4) as result from category;
  

-- date function 
select*, current_date() as result from category;
select*, current_timestamp() as result from category;
SELECT *, YEAR(expied) AS year, 
month(expied) as month, 
day(expied) as day, 
dayname(expied) as day_name from category;  
 
 
 
 
-- STUDY CASE-- 
create database sc6; 
select*from departments;
describe departments;

select*from employees;
describe employees;
alter table employees modify column employee_id integer; 
alter table employees modify column birth_date varchar(100); 
alter table employees add birth_date_backup date; 
UPDATE employees SET birth_date_backup = STR_TO_DATE(birth_date, '%m/%d/%Y') LIMIT 1000;
alter table employees drop column birth_date; 
alter table employees change column birth_date_backup birth_date date; 

alter table employees modify column hire_date varchar(100); 
alter table employees add hire_date_backup date; 
update employees set hire_date_backup = str_to_date(hire_date, '%m/%d/%Y') LIMIT 1000; 
alter table employees drop column hire_date; 
alter table employees change column hire_date_backup hire_date date; 

-- 1. Buatlah query untuk membuat kolom tahun dan bulan secara terpisah untuk setiap record.
select employee_id, first_name, last_name, salary, department_id,  
birth_date, 
year(birth_date) as birth_year, 
month(birth_date) as birth_month, 
day(birth_date) as birth_day,
hire_date, 
year(hire_date) as hire_year, 
month(hire_date) as hire_month, 
day(hire_date) as hire_day 
from employees;

-- 2. Buatlah query untuk memunculkan karyawan dengan masa kerja 5-10 tahun.
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    salary, 
    department_id,  
    birth_date, 
    hire_date, 
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_of_service
FROM employees
WHERE TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) BETWEEN 5 AND 10;

-- 3. Buatlah query untuk memunculkan nama dan department dari masing-masing karyawan dengan format
-- “Last Name, First Name_Department”
select* from employees;
select* from departments;
select employees.last_name, employees.first_name, departments.department_name
 from employees join departments on employees.department_id = departments.department_id; 
 
-- 4. Buatlah query untuk memunculkan karyawan yang berulang tahun pada bulan ini
SELECT* FROM employees WHERE EXTRACT(MONTH FROM birth_date) = EXTRACT(MONTH FROM CURRENT_DATE);




