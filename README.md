# Amazon-sales-data-analysis
This project uses SQL for analyzing Amazon sales data. The project is divided into three main parts: creating the database and loading the data, cleaning and processing the data, and running queries which help in the analysis of the present data.

## Project Structure

### Data File
['amazon_sales.csv'](https://github.com/Omsaigadge/Amazon-sales-data-analysis/blob/main/amazon_sales.csv) file contains the raw data containing around 1500 records. This was downloaded from Kaggle, from a dataset named [Amazon-sales-dataset](https://www.kaggle.com/datasets/karkavelrajaj/amazon-sales-dataset) 

These are the columns present in the dataset
| 	Column name	 | 	Datatype	 | 
| 	:-----:	 | 	:-----:	 | 
| 	product_id	| 	varchar	| 
| 	product_name	| 	varchar	| 
| 	category	| 	varchar	| 
| 	discounted_price	| 	varchar	| 
| 	actual_price	| 	varchar	|
|   discount_percentage|varchar|
|   rating|varchar|
|   rating_count|varchar|
|   about_product|varchar|
|   user_name|varchar|
|   review_id|varchar|
|   review_title|varchar|
|   review_content|varchar|
|   img_link|varchar|
|   product_link|varchar|

### SQL Script
- ['create_script_sales_data.sql']() : Script for creating the database table and loading the data from amazon_sales.csv into it.
- [table_operations.sql](https://github.com/Omsaigadge/Amazon-sales-data-analysis/blob/main/table_operations.sql) : Script for cleaning, processing, and standardizing the data in the database.
- [sales_data_queries_and_analysis.sql](https://github.com/Omsaigadge/Amazon-sales-data-analysis/blob/main/sales_data_queries_and_analysis.sql) : Script containing various queries for analyzing the sales data.

## Database and Tools
- PostgreSQL (Any other suitable database can be used. This was used because it was open-source and I have worked on it previously). This can be downloaded here--[PostgreSQL](https://www.postgresql.org/download/)
- PgAdmin4

## Project explanation
- Creating the database
  - Run the file ['create_script_sales_data.sql']().
  - This creates the required table named 'sales_data', and loads data into the table.
- Cleaning and processing the data. Run the ['table_operations.sql'](https://github.com/Omsaigadge/Amazon-sales-data-analysis/blob/main/table_operations.sql) script to clean, process, and standardize the data. This script includes operations such as:
    - Removing duplicates
    - Removing null values and handling missing values
    - Removing unnecessary columns in the data
    - Changing the column datatypes of columns to required datatype
    - Merging columns
    - Extracting only relevant data from the columns
- Analyzing the data. Run the ['sales_data_queries_and_analysis.sql'](https://github.com/Omsaigadge/Amazon-sales-data-analysis/blob/main/sales_data_queries_and_analysis.sql), which contains a  collection of SQL queries designed to analyze the sales data.
 
## Key observations tracked in the analysis
- Total sales based on category of the products
- Top-selling products
- Customer purchase behaviour
- Impact of discounts on ratings and sales
- Customer demographics


