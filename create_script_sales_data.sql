-- select * from sales_data;

drop table if exists sales_data;

create table sales_data
(
	product_id varchar,
	product_name varchar,
	category varchar,
	discounted_price varchar,
	actual_price varchar,
	discount_percentage varchar,
	rating varchar,
	number_of_ratings varchar,
	about_product varchar,
	user_id varchar,
	user_names varchar,
	review_id varchar,
	review_title varchar,
	review_content varchar,
	image_link varchar,
	product_link varchar
)

-- select * from sales_data;

COPY sales_data
	FROM 'D:\timepass\data\FAANG\amazon_sales.csv'
DELIMITER ','
NULL as 'null'
CSV HEADER;

-- select * from sales_data;