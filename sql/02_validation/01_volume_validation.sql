-- =========================================================
-- DATA QUALITY VALIDATION SUITE
-- =========================================================

-- Dataset: Orders
-- Purpose: Validate imported order data before downstream use


-- =========================================================
-- ORDERS : VOLUME VALIDATION
-- =========================================================
SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT order_id) AS unique_orders,
COUNT(DISTINCT customer_id) AS unique_customers
FROM staging.olist_orders_dataset;


-- =====================================
-- CUSTOMERS : VOLUME VALIDATION
-- =====================================



SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT customer_id) AS unique_customer_ids,
COUNT(DISTINCT customer_unique_id) AS unique_real_customers
FROM staging.olist_customers_dataset;