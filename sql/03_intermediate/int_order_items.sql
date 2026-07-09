-- =====================================================
-- INTERMEDIATE : ORDER ITEMS
-- Purpose:
-- Create cleaned transactional sales dataset
-- with revenue-oriented business features
-- =====================================================

DROP TABLE IF EXISTS intermediate.int_order_items;


CREATE TABLE intermediate.int_order_items AS

SELECT

-- Transaction identifiers
order_id,
order_item_id,
product_id,
seller_id,

-- Shipping deadline
shipping_limit_date,

-- Pricing
price,
freight_value,

-- =====================================================
-- Derived Revenue Features
-- =====================================================

-- Total item transaction value
(price + freight_value)
AS total_item_value,



-- =====================================================
-- REVENUE ANALYTICS FEATURES
--
-- Purpose:
-- Support sales performance analysis,
-- revenue contribution analysis,
-- and order value segmentation.
-- =====================================================

-- Freight as percentage of transaction value
ROUND(
    (
        freight_value
        /
        NULLIF((price + freight_value), 0)
    ) * 100,
    2
) AS freight_percentage,

-- Revenue segmentation
CASE

    WHEN (price + freight_value) < 50
    THEN 'Low Value'

    WHEN (price + freight_value) < 200
    THEN 'Medium Value'

    ELSE 'High Value'

END AS revenue_bucket,

-- Shipping cost classification
CASE

    WHEN freight_value = 0
    THEN 'free_shipping'

    WHEN freight_value <= 20
    THEN 'low_shipping'

    ELSE 'high_shipping'

END AS shipping_category


-- =====================================================
-- SHIPPING COST ANALYTICS
--
-- Purpose:
-- Identify transactions with unusually
-- expensive shipping costs.
-- =====================================================

CASE

    WHEN freight_value > price
    THEN 'High Freight Impact'

    ELSE 'Normal Freight Impact'

END AS high_freight_flag

FROM staging.olist_order_items_dataset;



SELECT
revenue_bucket,
COUNT(*) AS transactions
FROM intermediate.int_order_items
GROUP BY revenue_bucket
ORDER BY transactions DESC;


SELECT
high_freight_flag,
COUNT(*) AS transactions
FROM intermediate.int_order_items
GROUP BY high_freight_flag;


SELECT
MIN(freight_percentage) AS min_freight_pct,
AVG(freight_percentage) AS avg_freight_pct,
MAX(freight_percentage) AS max_freight_pct
FROM intermediate.int_order_items;




-- =====================================================
-- BUSINESS PROBLEM #3
-- SALES PERFORMANCE ANALYSIS
--
-- Objective:
-- Understand transaction value,
-- freight impact,
-- and revenue distribution.
--
-- Business Questions:
-- 1. Which transactions generate most revenue?
-- 2. How many low/medium/high value transactions exist?
-- 3. How much revenue is consumed by freight?
-- 4. Which transactions have unusually high freight costs?
-- =====================================================



-- =====================================================
-- VALIDATION RESULT #1
-- REVENUE BUCKET DISTRIBUTION
-- =====================================================
--
-- Output:
--
-- Medium Value : 71,167 transactions
-- Low Value    : 23,312 transactions
-- High Value   : 18,171 transactions
--
-- Interpretation:
--
-- Most transactions belong to the
-- Medium Value segment.
--
-- Approximately 63% of all transactions
-- fall between ₹50 and ₹200 equivalent value.
--
-- Only about 16% of transactions
-- belong to the High Value segment.
--
-- Business Insight:
--
-- Revenue growth opportunities may come
-- from converting Medium Value customers
-- into High Value customers.
--
-- =====================================================



-- =====================================================
-- VALIDATION RESULT #2
-- HIGH FREIGHT IMPACT ANALYSIS
-- =====================================================
--
-- Output:
--
-- Normal Freight Impact : 108,526 transactions
-- High Freight Impact   : 4,124 transactions
--
-- Interpretation:
--
-- Freight cost exceeds product value
-- in 4,124 transactions.
--
-- Business Insight:
--
-- These transactions may reduce
-- profitability and should be reviewed.
--
-- Possible causes:
--
-- • Long-distance shipping
-- • Bulky products
-- • Inefficient logistics routes
-- • Seller-specific shipping issues
--
-- =====================================================



-- =====================================================
-- VALIDATION RESULT #3
-- FREIGHT PERCENTAGE ANALYSIS
-- =====================================================
--
-- Output:
--
-- Minimum Freight Percentage : 0.00%
-- Average Freight Percentage : 21.33%
-- Maximum Freight Percentage : 96.33%
--
-- Interpretation:
--
-- On average, shipping consumes
-- approximately 21.33% of transaction value.
--
-- Example:
--
-- For every ₹100 earned:
-- ₹21.33 is spent on freight.
--
-- Business Insight:
--
-- Some transactions spend nearly all
-- revenue on shipping costs.
--
-- Transactions approaching 100%
-- freight contribution should be
-- investigated for profitability.
--
-- =====================================================



-- =====================================================
-- SALES PERFORMANCE ANALYSIS
-- STATUS
-- =====================================================
--
-- Features Created:
--
--  total_item_value
--  freight_percentage
--  revenue_bucket
--  shipping_category
--  high_freight_flag


-- =====================================================