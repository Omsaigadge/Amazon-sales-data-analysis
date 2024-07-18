-- Query 1: top-rated products by rating for each category
-- select * from sales3;

SELECT 
    main_category,
    product_name,
    rating,
    new_number_of_ratings
FROM (
    SELECT 
        main_category,
        product_name,
        rating,
        new_number_of_ratings,
        ROW_NUMBER() OVER (PARTITION BY main_category ORDER BY rating DESC) AS rank
    FROM sales3
) ranked
WHERE rank = 1;

--2. Average discount percentage by category
select main_category,avg(new_discount_percentage) 
from sales3
group by main_category;

--3.price range analysis ie minimum, maximum and average discount price for each category
select main_category, max(new_discounted_price),min(new_discounted_price), avg(new_discounted_price)
from sales3
group by main_category;

--4.products with most number of reviews
SELECT 
    main_category,
    product_name,
    new_number_of_ratings
FROM (
    SELECT 
        main_category,
        product_name,
        new_number_of_ratings,
        ROW_NUMBER() OVER (PARTITION BY main_category ORDER BY new_number_of_ratings DESC) AS rank
    FROM sales3
) ranked
WHERE rank = 1;

--5.brand performance analysis
SELECT 
    brand_name,
    AVG(rating) AS avg_rating,
    SUM(new_number_of_ratings) AS total_reviews
FROM sales3
GROUP BY brand_name
ORDER BY avg_rating DESC, total_reviews DESC;

--6.products with highest discount
SELECT 
    main_category,
    product_name,
    new_discount_percentage
FROM (
    SELECT 
        main_category,
        product_name,
        new_discount_percentage,
        ROW_NUMBER() OVER (PARTITION BY main_category ORDER BY new_discount_percentage) AS rank
    FROM sales3
) ranked
WHERE rank = 1;

--7.average rating by sub-category
select sub_category,avg(new_discount_percentage) 
from sales3
group by sub_category;

--8.correlation between price and rating
SELECT 
    new_discounted_price,
    rating
FROM sales3;

--9.most reviewd product in sub_categories
SELECT 
    sub_category,
    product_name,
    new_number_of_ratings
FROM (
    SELECT 
        sub_category,
        product_name,
        new_number_of_ratings,
        ROW_NUMBER() OVER (PARTITION BY sub_category ORDER BY new_number_of_ratings DESC) AS rank
    FROM sales3
) ranked
WHERE rank = 1;

--10. products with the best ratings and discount
SELECT 
    product_name,
    rating,
    new_discount_percentage,
    new_discounted_price
FROM sales3
WHERE 
    rating >= 4.5 AND 
    new_discount_percentage >= 50
ORDER BY rating DESC, new_discount_percentage DESC;

--11. sub_sub_category wise sales performance
SELECT 
    sub_sub_category,
    AVG(new_discounted_price) AS avg_discounted_price,
    SUM(new_number_of_ratings) AS total_ratings
FROM sales3
GROUP BY sub_sub_category
ORDER BY total_ratings DESC;

--12.products with low ratings and high prices
SELECT 
    product_name,
    rating,
    new_discounted_price
FROM sales3
WHERE 
    rating <= 4 AND 
    new_discounted_price >= (SELECT AVG(new_discounted_price) FROM sales3)
ORDER BY rating ASC, new_discounted_price DESC;

--13. Customer sales analysis
SELECT 
    product_name,
    review_title,
    CASE
        WHEN review_title ILIKE '%good%' OR review_title ILIKE '%great%' OR review_title ILIKE '%excellent%' THEN 'Positive'
        WHEN review_title ILIKE '%bad%' OR review_title ILIKE '%poor%' OR review_title ILIKE '%terrible%' THEN 'Negative'
        ELSE 'Neutral'
    END AS sentiment
FROM sales3;

--14. check how changes in price affect rating count, providing insights
SELECT 
    main_category,
    new_discounted_price,
    AVG(new_number_of_ratings) AS avg_number_of_ratings
FROM sales3
GROUP BY main_category, new_discounted_price
ORDER BY main_category, new_discounted_price;


--15. which products are normally bought together
SELECT 
    a.product_id AS product_a,
    b.product_id AS product_b,
    COUNT(*) AS review_count
FROM sales_data a
JOIN sales_data b ON a.review_id = b.review_id AND a.product_id != b.product_id
GROUP BY a.product_id, b.product_id
ORDER BY review_count DESC
LIMIT 10;

--16. Customer who are frequently buying products
SELECT 
    user_names,
    COUNT(DISTINCT product_id) AS number_of_reviews
FROM sales_data
GROUP BY user_names
HAVING COUNT(DISTINCT product_id) > 1
ORDER BY number_of_reviews DESC;

--17.Compare average ratings and prices between top brands within a main category
SELECT 
    main_category,
    brand_name,
    AVG(rating) AS avg_rating,
    AVG(new_discounted_price) AS avg_price
FROM sales3
WHERE main_category = 'Electronics'  
GROUP BY brand_name, main_category
ORDER BY avg_rating DESC;


--18.Identifying outliers
WITH stats AS (
    SELECT 
        AVG(new_discounted_price) AS avg_price,
        STDDEV(new_discounted_price) AS stddev_price,
        AVG(rating) AS avg_rating,
        STDDEV(rating) AS stddev_rating
    FROM sales3
)
SELECT 
    product_name,
    new_discounted_price,
    rating,
    (new_discounted_price - stats.avg_price) / stats.stddev_price AS price_z_score,
    (rating - stats.avg_rating) / stats.stddev_rating AS rating_z_score
FROM sales3, stats
WHERE ABS((new_discounted_price - stats.avg_price) / stats.stddev_price) > 2
    OR ABS((rating - stats.avg_rating) / stats.stddev_rating) > 2
ORDER BY price_z_score DESC, rating_z_score DESC;

--19. Product popularity across category
SELECT 
    product_name,
    COUNT(DISTINCT sub_category) AS num_sub_categories,
    SUM(new_number_of_ratings) AS total_ratings
FROM sales3
GROUP BY product_name
HAVING COUNT(DISTINCT sub_category) > 1
ORDER BY total_ratings DESC, num_sub_categories DESC
LIMIT 10;

-- therefore no products in the given data are cross category

--20. Products with low sales but moderate popularity
SELECT 
    product_name,
    new_number_of_ratings,
    new_discounted_price
FROM sales3
WHERE new_number_of_ratings < (SELECT AVG(new_number_of_ratings) FROM sales3)
ORDER BY new_number_of_ratings DESC
LIMIT 10;

