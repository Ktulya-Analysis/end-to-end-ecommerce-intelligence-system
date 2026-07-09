-- =====================================================
-- INTERMEDIATE : CUSTOMER BEHAVIOR
--
-- Business Problem:
-- Customer Purchase Behavior Analysis
--
-- Purpose:
-- Create customer-level behavioral features
-- for repeat purchase analysis,
-- retention analysis,
-- customer segmentation,
-- and customer value analytics.
--
-- Business Questions:
-- 1. How many orders has each customer placed?
-- 2. Who are repeat customers?
-- 3. Who are one-time customers?
-- 4. What is the foundation for retention analysis?
-- =====================================================

DROP TABLE IF EXISTS intermediate.int_customer_behavior;

CREATE TABLE intermediate.int_customer_behavior AS

SELECT

    -- =====================================================
    -- CUSTOMER IDENTIFIER
    -- =====================================================

    c.customer_unique_id,

    -- =====================================================
    -- PURCHASE FREQUENCY FEATURES
    --
    -- Purpose:
    -- Measure customer ordering behavior
    -- and identify repeat customers.
    -- =====================================================

    COUNT(DISTINCT o.order_id)
    AS customer_order_count,

    CASE

        WHEN COUNT(DISTINCT o.order_id) > 1
        THEN 'Repeat Customer'

        ELSE 'One-Time Customer'

    END AS repeat_customer_flag,

    -- =====================================================
    -- CUSTOMER LIFECYCLE FEATURES
    --
    -- Purpose:
    -- Support retention analysis,
    -- customer lifecycle analysis,
    -- and future RFM segmentation.
    -- =====================================================

    MIN(o.purchase_date)
    AS first_purchase_date,

    MAX(o.purchase_date)
    AS last_purchase_date,

    (
        MAX(o.purchase_date)
        -
        MIN(o.purchase_date)
    ) AS customer_lifetime_days

FROM intermediate.int_customers c

LEFT JOIN intermediate.int_orders o
    ON c.customer_id = o.customer_id

GROUP BY
    c.customer_unique_id;


--validation query
SELECT
repeat_customer_flag,
COUNT(*) AS customers
FROM intermediate.int_customer_behavior
GROUP BY repeat_customer_flag;


--validation query                       
SELECT
MAX(customer_order_count) AS max_orders,
AVG(customer_order_count) AS avg_orders
FROM intermediate.int_customer_behavior;


--Only about 3% of customers return for another purchase.
--Average orders per customer is only 1.03.
--Customer retention is weak.
--Business should focus on increasing repeat purchases.


-- =====================================================
-- VALIDATION:
-- Customer Lifecycle Statistics
--
-- Business Question:
-- How long do customers remain active?
-- =====================================================

SELECT

    MIN(customer_lifetime_days) AS min_lifetime_days,

    AVG(customer_lifetime_days) AS avg_lifetime_days,

    MAX(customer_lifetime_days) AS max_lifetime_days

FROM intermediate.int_customer_behavior;