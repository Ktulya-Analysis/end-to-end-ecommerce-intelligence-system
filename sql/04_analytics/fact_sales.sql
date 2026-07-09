-- =====================================================
-- FACT TABLE : FACT SALES
--
-- Purpose:
-- Central business transaction table for
-- sales, customer, product, seller,
-- and delivery analytics.
--
-- Business Problems Supported:
-- 1. Sales Performance Analysis
-- 2. Customer Analysis
-- 3. Seller Analysis
-- 4. Product Analysis
-- 5. Delivery Performance Analysis
--
-- Grain:
-- One row per order item
-- =====================================================

DROP TABLE IF EXISTS analytics.fact_sales;

CREATE TABLE analytics.fact_sales AS

SELECT

-- =====================================================
-- BUSINESS KEYS
-- =====================================================

oi.order_id,
oi.order_item_id,

o.customer_id,

oi.product_id,
oi.seller_id,

-- =====================================================
-- DATE KEY
-- =====================================================

o.purchase_date,

-- =====================================================
-- ORDER ATTRIBUTES
-- =====================================================

o.order_status,

-- =====================================================
-- SALES MEASURES
-- =====================================================

oi.price,
oi.freight_value,
oi.total_item_value,

-- =====================================================
-- DELIVERY METRICS
-- =====================================================

o.delivery_days,
o.delivery_delay_days,

-- =====================================================
-- DELIVERY ATTRIBUTES
-- =====================================================

o.late_delivery_flag,
o.shipping_speed_category

FROM intermediate.int_order_items oi

INNER JOIN intermediate.int_orders o
    ON oi.order_id = o.order_id;



-- =====================================================
-- VERIFICATION QUERY
-- =====================================================


SELECT COUNT(*) AS total_rows
FROM analytics.fact_sales;


-- =====================================================
-- VERIFICATION CHECKS
-- =====================================================

--check 1

SELECT COUNT(*)
FROM intermediate.int_order_items;


--check 2
SELECT COUNT(*)
FROM analytics.fact_sales;


--check 3
SELECT

    ROUND(
        SUM(total_item_value),
        2
    ) AS revenue

FROM analytics.fact_sales;