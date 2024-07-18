-- Database: FAANG_Stocks

-- DROP DATABASE IF EXISTS "FAANG_Stocks";

-- CREATE DATABASE "FAANG_Stocks"
--     WITH
--     OWNER = postgres
--     ENCODING = 'UTF8'
--     LC_COLLATE = 'English_India.1252'
--     LC_CTYPE = 'English_India.1252'
--     LOCALE_PROVIDER = 'libc'
--     TABLESPACE = pg_default
--     CONNECTION LIMIT = -1
--     IS_TEMPLATE = False;

drop table if exists amazon;
drop table if exists google;
drop table if exists facebook;
drop table if exists apple;
drop table if exists netflix;

Create table amazon(
	stock_date date,
	market_open float(24),
	market_high float(24),
	market_low float(24),
	market_close float(24),
	market_adj_low float(24),
	stock_volume bigint
);

Create table facebook(
	stock_date date,
	market_open float(24),
	market_high float(24),
	market_low float(24),
	market_close float(24),
	market_adj_low float(24),
	stock_volume bigint
);

Create table apple(
	stock_date date,
	market_open float(24),
	market_high float(24),
	market_low float(24),
	market_close float(24),
	market_adj_low float(24),
	stock_volume bigint
);

Create table google(
	stock_date date,
	market_open float(24),
	market_high float(24),
	market_low float(24),
	market_close float(24),
	market_adj_low float(24),
	stock_volume bigint
);

Create table netflix(
	stock_date date,
	market_open float(24),
	market_high float(24),
	market_low float(24),
	market_close float(24),
	market_adj_low float(24),
	stock_volume bigint
);


-- select * from amazon;

COPY amazon(stock_date,market_open,market_high,market_low,market_close,market_adj_low,stock_volume)
FROM 'D:\timepass\data\FAANG\Amazon.csv'
DELIMITER ','
NULL as 'null'
CSV HEADER;

COPY apple(stock_date,market_open,market_high,market_low,market_close,market_adj_low,stock_volume)
FROM 'D:\timepass\data\FAANG\Apple.csv'
DELIMITER ','
NULL as 'null'
CSV HEADER;

COPY google(stock_date,market_open,market_high,market_low,market_close,market_adj_low,stock_volume)
FROM 'D:\timepass\data\FAANG\Google.csv'
DELIMITER ','
NULL as 'null'
CSV HEADER;

COPY facebook(stock_date,market_open,market_high,market_low,market_close,market_adj_low,stock_volume)
FROM 'D:\timepass\data\FAANG\Facebook.csv'
DELIMITER ','
NULL as 'null'
CSV HEADER;

COPY netflix(stock_date,market_open,market_high,market_low,market_close,market_adj_low,stock_volume)
FROM 'D:\timepass\data\FAANG\Netflix.csv'
DELIMITER ','
NULL as 'null'
CSV HEADER;


select * from amazon limit 100;