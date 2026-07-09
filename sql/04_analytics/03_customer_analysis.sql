-- =====================================================
-- CUSTOMER ANALYSIS
-- KPI 1
-- TOTAL UNIQUE CUSTOMERS
--
-- Business Question:
-- How many unique customers
-- have purchased from the marketplace?
-- =====================================================

SELECT

    COUNT(DISTINCT customer_unique_id)
    AS total_customers

FROM intermediate.int_customers;

-- =====================================================
-- KPI 1
-- TOTAL UNIQUE CUSTOMERS
--
-- Result:
-- 96,096 customers
--
-- Interpretation:
-- The marketplace served 96,096 unique
-- customers during the analysis period.
--
-- Business Value:
-- Measures marketplace reach and
-- customer acquisition scale.
-- =====================================================



-- =====================================================
-- KPI 2
-- REPEAT CUSTOMER DISTRIBUTION
--
-- Business Question:
-- How many customers are repeat customers
-- versus one-time customers?
--
-- Purpose:
-- Measure customer retention foundation.
-- =====================================================

SELECT

    repeat_customer_flag,

    COUNT(*) AS customers,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM intermediate.int_customer_behavior

GROUP BY repeat_customer_flag

ORDER BY customers DESC;

-- =====================================================
-- KPI 2
-- REPEAT CUSTOMER DISTRIBUTION
--
-- Result:
-- One-Time Customer : 93,099 (96.88%)
-- Repeat Customer   : 2,997 (3.12%)
--
-- Interpretation:
-- The vast majority of customers
-- make only one purchase.
--
-- Customer retention is low,
-- indicating opportunity for
-- loyalty and retention strategies.
-- =====================================================


-- =====================================================
-- KPI 3
-- AVERAGE ORDERS PER CUSTOMER
--
-- Business Question:
-- How frequently do customers purchase?
--
-- Purpose:
-- Measure customer engagement
-- and purchasing behavior.
-- =====================================================

SELECT

    ROUND(
        AVG(customer_order_count),
        2
    ) AS avg_orders_per_customer

FROM intermediate.int_customer_behavior;


-- =====================================================
-- KPI 4
-- CUSTOMER LIFETIME ANALYSIS
--
-- Business Question:
-- How long do customers remain active?
--
-- Purpose:
-- Understand customer retention duration
-- and customer lifecycle behavior.
-- =====================================================

SELECT

    MIN(customer_lifetime_days)
    AS min_lifetime_days,

    ROUND(
        AVG(customer_lifetime_days),
        2
    ) AS avg_lifetime_days,

    MAX(customer_lifetime_days)
    AS max_lifetime_days

FROM intermediate.int_customer_behavior;



-- =====================================================
-- KPI 5
-- TOP CUSTOMER STATES
--
-- Business Question:
-- Which states contribute the largest
-- customer base?
--
-- Purpose:
-- Support geographic expansion and
-- regional customer analysis.
-- =====================================================

SELECT

    customer_state,

    COUNT(*) AS total_customers

FROM intermediate.int_customers

GROUP BY customer_state

ORDER BY total_customers DESC

LIMIT 10;