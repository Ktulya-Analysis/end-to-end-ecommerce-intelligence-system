-- =====================================================
-- DIMENSION TABLE : DIM CUSTOMERS
--
-- Purpose:
-- Store customer descriptive attributes
-- and behavioral characteristics.
--
-- Business Problems Supported:
-- 1. Customer Analysis
-- 2. Customer Segmentation
-- 3. Customer Geography Analysis
-- 4. Customer Retention Analysis
-- =====================================================

DROP TABLE IF EXISTS analytics.dim_customers;

CREATE TABLE analytics.dim_customers AS

SELECT

-- =====================================================
-- CUSTOMER IDENTIFIERS
-- =====================================================

c.customer_id,
c.customer_unique_id,

-- =====================================================
-- GEOGRAPHIC ATTRIBUTES
-- =====================================================

c.customer_zip_code_prefix,
c.customer_city,
c.customer_state,

-- =====================================================
-- CUSTOMER BEHAVIOR ATTRIBUTES
-- =====================================================

cb.customer_order_count,
cb.repeat_customer_flag,
cb.customer_lifetime_days

FROM intermediate.int_customers c

LEFT JOIN intermediate.int_customer_behavior cb
    ON c.customer_unique_id = cb.customer_unique_id;



-- =====================================================
-- CUSTOMER BEHAVIOR ATTRIBUTES
-- =====================================================

SELECT COUNT(*) AS total_customers
FROM analytics.dim_customers;