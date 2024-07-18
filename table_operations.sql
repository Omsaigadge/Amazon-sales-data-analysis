
drop table if exists sales2;
drop table if exists sales3;

create table sales2
(like sales_data including defaults);

insert into sales2
select * from sales_data;

-- select * from sales_data;

delete from sales2
where product_id='product_id';

-- select * from sales2;

alter table sales2
drop column about_product,drop column user_names,drop column review_id,drop column image_link,drop column product_link, drop column user_id;

select * from sales2;


-- with duplicate_cte as 
-- (
select *,
ROW_NUMBER() over(
partition by product_id,product_name,category,discounted_price,actual_price,discount_percentage,rating,number_of_ratings,review_title,review_content) as row_num
from sales2;
-- )

with demo_cte as
(
	select *,
ROW_NUMBER() over(
partition by product_id,product_name,category,discounted_price,actual_price,discount_percentage,rating,number_of_ratings,review_title,review_content) as row_num
from sales2
)
select * from demo_cte
where row_num>1;

-- select *
-- from sales2
-- where sales2.product_id='B002PD61Y4';


create table sales3(
	product_id varchar,
	product_name varchar,
	category varchar,
	discounted_price varchar,
	actual_price varchar,
	discount_percentage varchar,
	rating varchar,
	number_of_ratings varchar,
	review_title varchar,
	review_content varchar,
	row_num int
)

-- select * from sales3;

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'sales3';

insert into sales3
select *,
ROW_NUMBER() over(
partition by product_id,product_name,category,discounted_price,actual_price,discount_percentage,rating,number_of_ratings,review_title,review_content) as row_num
from sales2;

delete from sales3
where row_num>1;

-- select * from sales3;

-- select product_id,count(*) from sales3
-- group by product_id;

-- select category,count(*) from sales3
-- group by category;

alter table sales3
drop column row_num;

-- select * from sales3;

alter table sales3
add main_category varchar;

-- update sales3
-- set main_category = case 
-- 					when category like 'Computers&Accessories%' then 'Computers&Accessories'
-- 					when category like 'Electronics%' then 'Electronics'

-- cast(split_part(column,'|',1) as text) as main_category;
-- CAST(sales3.category AS VARCHAR(100));

-- convert(varchar(50),sales3.category);

-- SELECT 
--     category,
--     SUBSTRING(
--         category,
--         LOCATE('|', category) + 1,
--         LOCATE('|', category, LOCATE('|', category) + 1) - LOCATE('|', category) - 1
--     ) AS main_category
-- FROM 
--     sales3;


--------------------------
alter table sales3
alter column category type text;

--------------------------
delete
from sales3
where rating like '%|%';

alter table sales3
alter column rating type float using (rating::float);

----------------------------
alter table sales3
add column new_discounted_price float;

UPDATE sales3
SET new_discounted_price = CAST(REPLACE(REPLACE(discounted_price, '₹', ''), ',', '') AS FLOAT);

-- select new_discounted_price from sales3;

---------------------------------
alter table sales3
add column new_actual_price float;

UPDATE sales3
SET new_actual_price = CAST(REPLACE(REPLACE(actual_price, '₹', ''), ',', '') AS FLOAT);

-- select new_actual_price from sales3;

--------------------------------------
alter table sales3
add column new_number_of_ratings float;

delete
from sales3
where number_of_ratings='';

UPDATE sales3
SET new_number_of_ratings = CAST(REPLACE(REPLACE(number_of_ratings, '₹', ''), ',', '') AS FLOAT);

-- select new_number_of_ratings from sales3;
-----------------------------------------
alter table sales3
add column new_discount_percentage float;

update sales3
	set new_discount_percentage=CAST(REPLACE(REPLACE(discount_percentage, '%', ''), ',', '') AS FLOAT);

-- alter table sales3
-- 	drop column discount_percentage;
-----------------------------------------
alter table sales3
drop column actual_price, drop column discounted_price, drop column number_of_ratings,drop column discount_percentage;


SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'sales3';
-----------------------------------------

-- select * from sales3;
select 
SPLIT_PART(category, '|', 1) AS main_category,
    SPLIT_PART(category, '|', 2) AS sub_category,
    SPLIT_PART(category, '|', 3) AS sub_sub_category
from sales3;

alter table sales3
add column sub_category text;

alter table sales3
add column sub_sub_category text;

alter table sales3
	add column sub_sub_sub_category text;

-- update sales3
-- sub_category=split_part(category,'|',1);
update sales3
	set main_category=SPLIT_PART(category, '|', 1),
    	sub_category=SPLIT_PART(category, '|', 2),
    	sub_sub_category=SPLIT_PART(category, '|', 3),
		sub_sub_sub_category=SPLIT_PART(category,'|',4);


-- select main_category,sub_category, sub_sub_category
-- from sales3;

alter table sales3
drop column category;

select * from sales3;

update sales3
set sub_sub_sub_category='NA'
where sub_sub_sub_category='';

select * from sales3
where sub_sub_sub_category='';

alter table sales3
drop column review_content;
-----------------------------------------
alter table sales3
add column brand_name varchar;

update sales3
set brand_name=SPLIT_PART(product_name, ' ', 1);

select brand_name,count(brand_name) as number_of_products
	from sales3
	group by brand_name
	having count(brand_name)>20
	order by count(brand_name);

-- alter table sales3
-- 	drop column product_name;
----------------------------------------

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'sales3';