-- CLEANING DATASET
-- 1. Customer table preview 
SELECT
  *
FROM deepp-495012.shopping_cart_database.customers
LIMIT 10


-- 2. Row count
SELECT 
  COUNT(*) as total_rows
FROM deepp-495012.shopping_cart_database.customers


-- 3. Ruplicate check
SELECT 
  customer_id
  , COUNT(*) as duplicate_count
FROM deepp-495012.shopping_cart_database.customers
GROUP BY 1
HAVING COUNT(*) > 1


-- 4. Missing value check  
SELECT
  COUNT(*) as total_rows
  , COUNT (customer_id) as customer_id_filled
  , COUNT (customer_name) as customer_name_filled
  , COUNT (gender) as gender_filled
  , COUNT (age) as age_filled
  , COUNT (home_address) as home_address_filled
  , COUNT (zip_code) as zip_code_filled
  , COUNT (city) as city_filled
  , COUNT (state) as state_filled
  , COUNT (country) as country_filled
FROM deepp-495012.shopping_cart_database.customers


-- 5. Cek typo categorycal
SELECT
  gender
  , COUNT (*) as total
FROM deepp-495012.shopping_cart_database.customers
GROUP BY 1
ORDER BY 2


-- 6. Make gender in 3 group
SELECT
  CASE
    WHEN gender IN ('Male', 'Female') THEN gender
    ELSE 'Other'
  END AS gender_group
  , COUNT(*) as total
FROM deepp-495012.shopping_cart_database.customers
GROUP BY 1
ORDER BY 2


-- 7. Outlier age check
SELECT
  MIN (age) as min_age
  , MAX (age) as max_age
  , AVG (age) as avg_age
FROM deepp-495012.shopping_cart_database.customers


-- 8. zip_code check
SELECT
  zip_code
FROM deepp-495012.shopping_cart_database.customers
LIMIT 10


-- 9. State normalization 
SELECT
  state
  , COUNT(*) as total
FROM deepp-495012.shopping_cart_database.customers
GROUP BY 1
ORDER BY 2



-- CLEANING DATASET ORDERS
-- 1. Orders table preview 
SELECT
  *
FROM deepp-495012.shopping_cart_database.orders
LIMIT 10


-- 2. Row count
SELECT 
  COUNT(*) as total_rows
FROM deepp-495012.shopping_cart_database.orders


-- 3. Duplicate check
SELECT 
  order_id
  , COUNT(*) as duplicate_count
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1
HAVING COUNT(*) > 1


-- 4. Missing value check  
SELECT
  COUNT(*) as total_rows
  , COUNT (order_id) as order_id_filled
  , COUNT (customer_id) as customer_id_filled
  , COUNT (payment) as payment_filled
  , COUNT (order_date) as order_date_filled
  , COUNT (delivery_date) as delivery_date_filled
FROM deepp-495012.shopping_cart_database.orders


-- 5. FK validation
SELECT
  o.customer_id
FROM deepp-495012.shopping_cart_database.orders o
LEFT JOIN deepp-495012.shopping_cart_database.customers c
  ON  
    o.customer_id = c.customer_id
WHERE
  c.customer_id IS NULL


-- 6. Date validation
SELECT
  *
FROM deepp-495012.shopping_cart_database.orders
WHERE delivery_date < order_date


-- 7. Payment validation
SELECT
  MIN (payment) as min_payment
  , MAX (payment) as max_payment
  , AVG (payment) as avg_payment
FROM deepp-495012.shopping_cart_database.orders


-- 8. Invalid payment check
SELECT
  *
FROM deepp-495012.shopping_cart_database.orders
WHERE payment <= 0


-- 9. Outlier delivery check
WITH 
  delivery_check AS (
    SELECT
      order_id
      , DATE_DIFF(delivery_date, order_date, DAY) as delivery_days
    FROM deepp-495012.shopping_cart_database.orders
  )
SELECT
  *
FROM delivery_check
WHERE delivery_days < 0
OR delivery_days > 30



-- CLEANING DATASET PRODUCTS
-- 1. Products table preview 
SELECT
  *
FROM deepp-495012.shopping_cart_database.products
LIMIT 10


-- 2. Row count
SELECT 
  COUNT(*) as total_rows
FROM deepp-495012.shopping_cart_database.products


-- 3. Duplicate check
SELECT 
  product_id
  , COUNT(*) as duplicate_count
FROM deepp-495012.shopping_cart_database.products
GROUP BY 1
HAVING COUNT(*) > 1


-- 4. Missing value check  
SELECT
  COUNT(*) as total_rows
  , COUNT (product_id) as product_id_filled
  , COUNT (product_type) as product_type_filled
  , COUNT (product_name) as product_name_filled
  , COUNT (size) as size_filled
  , COUNT (colour) as colour_filled
  , COUNT (price) as price_filled
  , COUNT (quantity) as quantitu_filled
  , COUNT (description) as desc_filled
FROM deepp-495012.shopping_cart_database.products


-- 5. product_type validation
SELECT
  product_type
  , COUNT(*) as total
FROM deepp-495012.shopping_cart_database.products
GROUP BY 1
ORDER BY 2


-- 6. Size validation
SELECT
  size
  , COUNT(*) as total
FROM deepp-495012.shopping_cart_database.products
GROUP BY 1
ORDER BY 2


-- 7. Colour validation
SELECT
  colour
  , COUNT(*) as total
FROM deepp-495012.shopping_cart_database.products
GROUP BY 1
ORDER BY 2


-- 8. Price validation
SELECT
  MIN(price) as min_price
  , MAX(price) as max_price
  , AVG(price) as avg_price
FROM deepp-495012.shopping_cart_database.products

-- Invalid price check
SELECT
  *
FROM deepp-495012.shopping_cart_database.products
WHERE price <= 0


-- 9. Quantity validation
SELECT
  MIN(quantity) as min_qty
  , MAX(quantity) as max_qty
  , AVG(quantity) as avg_qty
FROM deepp-495012.shopping_cart_database.products

-- Invalid quantity check
SELECT
  *
FROM deepp-495012.shopping_cart_database.products
WHERE quantity <= 0


-- 10. Description validation
SELECT
  *
FROM deepp-495012.shopping_cart_database.products
WHERE description IS NULL



-- CLEANING DATASET SALES
-- 1. Sales table preview 
SELECT
  *
FROM deepp-495012.shopping_cart_database.sales
LIMIT 10


-- 2. Row count
SELECT 
  COUNT(*) as total_rows
FROM deepp-495012.shopping_cart_database.sales


-- 3. Duplicate check
SELECT 
  sales_id
  , COUNT(*) as duplicate_count
FROM deepp-495012.shopping_cart_database.sales
GROUP BY 1
HAVING COUNT(*) > 1


-- 4. Missing value check  
SELECT
  COUNT(*) as total_rows
  , COUNT (sales_id) as sales_id_filled
  , COUNT (order_id) as order_id_filled
  , COUNT (product_id) as product_id_filled
  , COUNT (price_per_unit) as price_per_unit_filled
  , COUNT (quantity) as quantity_filled
  , COUNT (total_price) as total_price_filled
FROM deepp-495012.shopping_cart_database.sales


-- 5. FK validation - orders
SELECT
  s.order_id
FROM deepp-495012.shopping_cart_database.sales s
LEFT JOIN deepp-495012.shopping_cart_database.orders o
  ON  
    s.order_id = o.order_id
WHERE
  o.order_id IS NULL


-- 6. FK validation - products
SELECT
  s.product_id
FROM deepp-495012.shopping_cart_database.sales s
LEFT JOIN deepp-495012.shopping_cart_database.products p
  ON  
    s.product_id = p.product_id
WHERE
  p.product_id IS NULL


-- 7. price_per_unit validation
SELECT
  MIN(price_per_unit) as min_price
  , MAX(price_per_unit) as max_price
  , AVG(price_per_unit) as avg_price
FROM deepp-495012.shopping_cart_database.sales

-- Invalid price_per_unit check
SELECT
  *
FROM deepp-495012.shopping_cart_database.sales
WHERE price_per_unit <= 0


-- 8. Quantity validation
SELECT
  MIN(quantity) as min_qty
  , MAX(quantity) as max_qty
  , AVG(quantity) as avg_qty
FROM deepp-495012.shopping_cart_database.sales

-- Invalid quantity check
SELECT
  *
FROM deepp-495012.shopping_cart_database.sales
WHERE quantity <= 0


-- 9. total_price validation
SELECT
  *
FROM deepp-495012.shopping_cart_database.sales
WHERE total_price != (price_per_unit * quantity)


-- 10. Outlier detection - total_price
SELECT
  MIN(total_price) as min_total_price
  , MAX(total_price) as max_total_price
  , AVG(total_price) as avg_total_price
FROM deepp-495012.shopping_cart_database.sales

-- Find outlier in other way
-- a. Calculate quartiles
WITH
  stats AS (
    SELECT 
      APPROX_QUANTILES(total_price, 4) as q
    FROM deepp-495012.shopping_cart_database.sales
  )
SELECT
  q[OFFSET(1)] as Q1
  , q[OFFSET(3)] as Q3
FROM stats


-- b. Detect outliers
WITH
  stats AS (
    SELECT 
      APPROX_QUANTILES(total_price, 4) as q
    FROM deepp-495012.shopping_cart_database.sales
  )
  , bounds as (
  SELECT
    q[OFFSET(1)] as Q1
    , q[OFFSET(3)] as Q3
    , (q[OFFSET(3)] - q[OFFSET(1)]) AS IQR
  FROM stats
  )
SELECT
  *
FROM deepp-495012.shopping_cart_database.sales
, bounds
WHERE total_price < (Q1 - 1.5 * IQR)
OR total_price > (Q3 + 1.5 * IQR)







-- ANALYSIS

-- Transaction Analysis
-- 1. Calculate total Spending per customer 
SELECT
  customer_id
  , SUM(payment) as total_spending
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1


-- a. average spending total user
SELECT
  AVG (total_spending) as avg_total_spending
FROM (
  SELECT
    customer_id
    , SUM(payment) as total_spending
  FROM deepp-495012.shopping_cart_database.orders
  GROUP BY 1
)


-- 2. Calculate Purchase Frequency
SELECT
  customer_id
  , COUNT(order_id) as purchase_frequency
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1

-- a. Calculate the overall average across all customers
SELECT
  AVG (purchase_frequency) as avg_purchase_frequency
FROM (
  SELECT
    customer_id
    , COUNT(order_id) as purchase_frequency
  FROM deepp-495012.shopping_cart_database.orders
  GROUP BY 1
) AS frequency_table

-- b. Combine purchase_frequency and total_spending
SELECT 
  customer_id
  , SUM(payment) as total_spending
  , COUNT(order_id) as purchase_frequency
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1


-- 3. Group customer based on spending and purchase_frequency (spending category)
SELECT 
  customer_id
  , SUM(payment) as total_spending
  , COUNT(order_id) as purchase_frequency
  , CASE
      WHEN SUM(payment) > 100000 THEN 'High Spender'
      WHEN SUM(payment) BETWEEN 50000 and 100000 THEN 'Medium Spender'
      ELSE 'Low Spender'
    END as spending_category
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1


-- 4. Add segmentation based on purchase frequency (frequency category)
SELECT 
  customer_id
  , SUM(payment) as total_spending
  , COUNT(order_id) as purchase_frequency
  , CASE
      WHEN COUNT(order_id) > 3 THEN 'Frequent Customer'
      ELSE 'Occasional Customer'
    END as frequency_category
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1


-- 5. Combine spending and frequency segments
SELECT 
  customer_id
  , SUM(payment) as total_spending
  , COUNT(order_id) as purchase_frequency
  , CASE
      WHEN SUM(payment) > 100000 THEN 'High Spender'
      WHEN SUM(payment) BETWEEN 50000 and 100000 THEN 'Medium Spender'
      ELSE 'Low Spender'
    END as spending_category
  , CASE
      WHEN COUNT(order_id) > 3 THEN 'Frequent Customer'
      ELSE 'Occasional Customer'
    END as frequency_category
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1

-- a. Customer Distribution by Spending Category
WITH customer_segmentation AS (
SELECT
  customer_id
  , SUM(payment) as total_spending
  , COUNT(order_id) as purchase_frequency
  , CASE
      WHEN SUM(payment) > 100000 THEN 'High Spender'
      WHEN SUM(payment) BETWEEN 50000 and 100000 THEN 'Medium Spender'
      ELSE 'Low Spender'
    END as spending_category
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1
)
SELECT
  spending_category
  , COUNT(customer_id) as total_customers
FROM customer_segmentation
GROUP BY 1
ORDER BY 2 DESC


-- b.Customer Distribution by frequency category
WITH customer_segmentation AS (
SELECT
  customer_id
  , SUM(payment) as total_spending
  , COUNT(order_id) as purchase_frequency
  , CASE
      WHEN SUM(payment) > 100000 THEN 'High Spender'
      WHEN SUM(payment) BETWEEN 50000 and 100000 THEN 'Medium Spender'
      ELSE 'Low Spender'
    END as spending_category
  , CASE
      WHEN COUNT(order_id) > 3 THEN 'Frequent Customer'
      ELSE 'Occasional Customer'
    END as frequency_category
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1
)
SELECT
  spending_category
  , frequency_category
  , COUNT(customer_id) as total_customers
FROM customer_segmentation
GROUP BY 1,2
ORDER BY 3 DESC





-- Add Time Feature
-- 1. Month from order_date
SELECT
  *
  , EXTRACT(MONTH FROM order_date) as order_month
FROM deepp-495012.shopping_cart_database.orders


-- show the month name
SELECT
  *
  , FORMAT_DATE('%B', order_date) as order_month
FROM deepp-495012.shopping_cart_database.orders



-- 2. Day of the week from order_date
SELECT
  *
  , EXTRACT(DAYOFWEEK FROM order_date) as order_day
FROM deepp-495012.shopping_cart_database.orders


-- show the day name
SELECT
  *
  , FORMAT_DATE('%A', order_date) as order_day
FROM deepp-495012.shopping_cart_database.orders


-- 3. Year from order_date
SELECT
  *
  , EXTRACT(YEAR FROM order_date) as order_year
FROM deepp-495012.shopping_cart_database.orders


-- 4. Calculate delivery time
SELECT
  *
  , DATE_DIFF(delivery_date, order_date, DAY) as delivery_time_days
FROM deepp-495012.shopping_cart_database.orders


-- 5. Identify whether the order date falls on a weekend
SELECT
  *
  , CASE
      WHEN EXTRACT(DAYOFWEEK FROM order_date) IN (1,7)
      THEN 'Weekend'
      ELSE 'Weekday'
    END as order_type
FROM deepp-495012.shopping_cart_database.orders


-- 6. Quarter order_date
SELECT 
  *
  , CASE 
      WHEN EXTRACT(MONTH FROM order_date) IN (1, 2, 3) THEN 'Q1'
      WHEN EXTRACT(MONTH FROM order_date) IN (4, 5, 6) THEN 'Q2'
      WHEN EXTRACT(MONTH FROM order_date) IN (7, 8, 9) THEN 'Q3'
      WHEN EXTRACT(MONTH FROM order_date) IN (10, 11, 12) THEN 'Q4'
    END AS order_quarter
FROM deepp-495012.shopping_cart_database.orders


-- 7. Combine time feature
SELECT 
  *
  , DATE_DIFF(delivery_date, order_date, DAY) AS delivery_time_days
  , FORMAT_DATE('%B', order_date) as order_month
  , FORMAT_DATE('%A', order_date) as order_day
  , EXTRACT(YEAR FROM order_date) AS order_year
  , CASE 
      WHEN EXTRACT(MONTH FROM order_date) IN (1, 2, 3) THEN 'Q1'
      WHEN EXTRACT(MONTH FROM order_date) IN (4, 5, 6) THEN 'Q2'
      WHEN EXTRACT(MONTH FROM order_date) IN (7, 8, 9) THEN 'Q3'
      WHEN EXTRACT(MONTH FROM order_date) IN (10, 11, 12) THEN 'Q4'
    END AS order_quarter
  , CASE 
      WHEN EXTRACT(DAYOFWEEK FROM order_date) IN (1, 7)
      THEN 'Weekend'
       ELSE 'Weekday'
    END AS order_type
FROM deepp-495012.shopping_cart_database.orders


-- a. Purchase frequency weekday vs weekend
SELECT
  order_type
  , COUNT(order_id) as total_orders
FROM (
  SELECT
    order_id
    , CASE
        WHEN EXTRACT(DAYOFWEEK FROM order_date) IN (1, 7)
        THEN 'Weekend'
        ELSE 'Weekday'
      END as order_type
  FROM deepp-495012.shopping_cart_database.orders
)
GROUP BY 1
ORDER BY 2 DESC


-- b. Monthly Purchase Trend
SELECT
  FORMAT_DATE('%B', order_date) as order_month
  , COUNT(order_id) as total_orders
  , SUM(payment) as total_revenue
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1
ORDER BY total_orders DESC


-- c. Average Delivery Time
SELECT
  ROUND(AVG(DATE_DIFF(delivery_date, order_date, DAY)), 2) 
  as avg_delivery_time_days
FROM deepp-495012.shopping_cart_database.orders


-- d. Top Customer Contribution to Total Revenue
WITH customer_revenue AS (
SELECT
  customer_id
  , SUM(payment) as total_spending
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1
)
SELECT
  customer_id
  , total_spending
FROM customer_revenue
ORDER BY total_spending DESC
LIMIT 10

-- e. Contribution Percentage
WITH customer_revenue AS (
SELECT
  customer_id
  , SUM(payment) as total_spending
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1
)
  , total_sales AS (
    SELECT
      SUM(payment) as overall_revenue
    FROM deepp-495012.shopping_cart_database.orders
    )
    SELECT
      customer_id
      , total_spending
      , ROUND(
        (total_spending / overall_revenue) * 100, 2
      ) as contribution_percentage
FROM customer_revenue, total_sales
ORDER BY total_spending DESC
LIMIT 10





-- Demographics Analysis
-- 1. Calculate total customer per gender

-- a. Select all gender
SELECT
  gender
  , COUNT(customer_id) as total_customers
FROM deepp-495012.shopping_cart_database.customers
GROUP BY 1
ORDER BY 2


-- b. Group gender in 3 category
SELECT
  CASE
    WHEN gender = 'Male' THEN 'Male'
    WHEN gender = 'Female' THEN 'Female'
    ELSE 'Other'
  END as gender_group
  , COUNT(customer_id) as total_customers
FROM deepp-495012.shopping_cart_database.customers
GROUP BY 1
ORDER BY 2


-- 2. Average spending per age
SELECT
  age
  , ROUND(AVG (payment),2) as avg_spending
FROM deepp-495012.shopping_cart_database.orders
JOIN deepp-495012.shopping_cart_database.customers
  ON orders.customer_id = customers.customer_id
GROUP BY 1
ORDER BY 1 DESC

-- average spending per gender
SELECT
  CASE
    WHEN gender = 'Male' THEN 'Male'
    WHEN gender = 'Female' THEN 'Female'
    ELSE 'Other'
  END as gender_group
  , ROUND(AVG(payment), 2) as avg_spending
FROM deepp-495012.shopping_cart_database.orders
JOIN deepp-495012.shopping_cart_database.customers
  ON orders.customer_id = customers.customer_id
GROUP BY 1
ORDER BY 2 DESC


-- 3. Customer segmentation based on age
SELECT
  CASE 
    WHEN age < 13 THEN 'Child'
    WHEN age BETWEEN 13 AND 20 THEN 'Teenager'
    WHEN age BETWEEN 21 AND 35 THEN 'Young Adult'
    WHEN age BETWEEN 36 AND 50 THEN 'Adult'
    ELSE 'Senior'
  END as age_group
  , COUNT(customers.customer_id) as total_customers
  , SUM(payment) as total_spending
FROM deepp-495012.shopping_cart_database.orders
JOIN deepp-495012.shopping_cart_database.customers
  ON orders.customer_id = customers.customer_id
GROUP BY 1
ORDER BY 3 DESC





-- Geographics
-- 1. Total revenue per state
SELECT 
  state
  , SUM(payment) as total_revenue
FROM deepp-495012.shopping_cart_database.orders
JOIN deepp-495012.shopping_cart_database.customers
  ON orders.customer_id = customers.customer_id
GROUP BY 1
ORDER BY 2 DESC


-- 2. Average total spending per state
SELECT
  state
  , ROUND(AVG (payment),2) as avg_spending
  , COUNT(customers.customer_id) as total_customers
FROM deepp-495012.shopping_cart_database.orders
JOIN deepp-495012.shopping_cart_database.customers
  ON orders.customer_id = customers.customer_id
GROUP BY 1
ORDER BY 2 DESC


-- 3. Group customer based on spending and state
SELECT 
  state
  , SUM(payment) as total_spending
  , COUNT(order_id) as purchase_frequency
  , CASE
      WHEN SUM(payment) > 4500000 THEN 'High Spender'
      WHEN SUM(payment) BETWEEN 4000000 and 4500000 THEN 'Medium Spender'
      ELSE 'Low Spender'
    END as spending_category
    , COUNT(customers.customer_id) as total_customers
FROM deepp-495012.shopping_cart_database.orders
JOIN deepp-495012.shopping_cart_database.customers
  ON orders.customer_id = customers.customer_id
GROUP BY 1
ORDER BY 2 DESC


-- Calculate Spending
-- 1. Spending per item
SELECT
  ROUND(SUM(total_price) / SUM(quantity), 2) as spending_per_item
FROM deepp-495012.shopping_cart_database.sales


-- 2. Spending per item by gender
SELECT
  CASE
    WHEN customers.gender = 'Male' THEN 'Male'
    WHEN customers.gender = 'Female' THEN 'Female'
    ELSE 'Other'
  END as gender_group
  , ROUND(SUM(sales.total_price) / SUM(sales.quantity), 2) as spending_per_item
FROM deepp-495012.shopping_cart_database.orders orders
JOIN deepp-495012.shopping_cart_database.customers customers
  ON orders.customer_id = customers.customer_id
JOIN deepp-495012.shopping_cart_database.sales sales
  ON orders.order_id = sales.order_id
GROUP BY 1
ORDER BY 2 DESC


-- 3. Spending analysis by age group
SELECT
  CASE
    WHEN age BETWEEN 13 AND 19 THEN 'Teenager'
    WHEN age BETWEEN 20 AND 35 THEN 'Young Adult'
    WHEN age BETWEEN 36 AND 55 THEN 'Adult'
    ELSE 'Senior'
  END as age_group
  , COUNT(DISTINCT orders.customer_id) as total_customers
  , ROUND(SUM(payment), 2) as total_spending
  , ROUND(AVG(payment), 2) as avg_order_value
FROM deepp-495012.shopping_cart_database.orders orders
JOIN deepp-495012.shopping_cart_database.customers customers
  ON orders.customer_id = customers.customer_id
GROUP BY 1
ORDER BY 3 DESC


-- 4. Spending analysis by state
SELECT
  state
  , COUNT(DISTINCT orders.customer_id) as total_customers
  , ROUND(SUM(payment), 2) as total_spending
  , ROUND(AVG(payment), 2) as avg_order_value
FROM deepp-495012.shopping_cart_database.orders orders
JOIN deepp-495012.shopping_cart_database.customers customers
  ON orders.customer_id = customers.customer_id
GROUP BY 1
ORDER BY 3 DESC



-- Average Order Value (AOV)
-- 1. Overall AOV
SELECT
  ROUND(SUM(payment) / COUNT(order_id),2) AS avg_order_value
FROM deepp-495012.shopping_cart_database.orders


-- 2. AOV per customer
SELECT
  customer_id
  , ROUND(SUM(payment) / COUNT(order_id),2) AS avg_order_value
FROM deepp-495012.shopping_cart_database.orders
GROUP BY 1
ORDER BY 2 DESC


-- 3. AOV per state
SELECT
  state
  , ROUND(SUM(payment) / COUNT(order_id),2) AS avg_order_value
FROM deepp-495012.shopping_cart_database.orders
JOIN deepp-495012.shopping_cart_database.customers
  ON orders.customer_id = customers.customer_id
GROUP BY 1
ORDER BY 2 DESC


-- 4. AOV per age group
SELECT
  CASE 
    WHEN age < 13 THEN 'Child'
    WHEN age BETWEEN 13 AND 20 THEN 'Teenager'
    WHEN age BETWEEN 21 AND 35 THEN 'Young Adult'
    WHEN age BETWEEN 36 AND 50 THEN 'Adult' 
    ELSE 'Senior'
  END as age_group
  , ROUND(SUM(payment) / COUNT(order_id),2) AS avg_order_value
FROM deepp-495012.shopping_cart_database.orders
JOIN deepp-495012.shopping_cart_database.customers
  ON orders.customer_id = customers.customer_id
GROUP BY 1
ORDER BY 2 DESC


-- 5. Top product purchased by teenager
WITH customer_age_group AS(
SELECT
  customer_id
  , CASE 
      WHEN age < 13 THEN 'Child'
      WHEN age BETWEEN 13 AND 20 THEN 'Teenager'
      WHEN age BETWEEN 21 AND 35 THEN 'Young Adult'
      WHEN age BETWEEN 36 AND 50 THEN 'Adult' 
      ELSE 'Senior'
    END as age_group
FROM deepp-495012.shopping_cart_database.customers
)
SELECT 
  age_group
  , products.product_type
  , COUNT(orders.order_id) as total_order
FROM deepp-495012.shopping_cart_database.orders
JOIN customer_age_group
  ON orders.customer_id = customer_age_group.customer_id
JOIN deepp-495012.shopping_cart_database.sales
  ON orders.order_id = sales.order_id
JOIN deepp-495012.shopping_cart_database.products
  ON sales.product_id = products.product_id
WHERE age_group = 'Teenager'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1



-- 6. Product category contribution
SELECT
  products.product_type
  , ROUND(SUM(sales.total_price), 2) as total_revenue
  , COUNT(DISTINCT sales.order_id) as total_orders
  , ROUND(AVG(sales.total_price), 2) as avg_order_value
FROM deepp-495012.shopping_cart_database.sales sales
JOIN deepp-495012.shopping_cart_database.products products
  ON sales.product_id = products.product_id
GROUP BY 1
ORDER BY 2 DESC


