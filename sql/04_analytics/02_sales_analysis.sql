-- =====================================================
-- SALES PERFORMANCE ANALYSIS
-- =====================================================

-- KPI #1: Total Revenue
-- Business Question:
-- What is the total revenue generated
-- by the marketplace?
-- =====================================================



SELECT

    ROUND(
        SUM(total_item_value),
        2
    ) AS total_revenue

FROM intermediate.int_order_items;


-- =====================================================
-- KPI #2 : AVERAGE ORDER VALUE (AOV)

-- Business Question:
-- How much does a customer spend
-- on average per order?
--
-- Why Important:
-- One of the most common sales KPIs.
-- Used to understand customer spending.
-- =====================================================

SELECT

    ROUND(
        SUM(total_item_value)
        /
        COUNT(DISTINCT order_id),
        2
    ) AS average_order_value

FROM intermediate.int_order_items;


-- =====================================================
-- KPI 3
-- REVENUE DISTRIBUTION
--
-- Business Question:
-- How are transactions distributed
-- across revenue segments?
--
-- Purpose:
-- Understand whether sales are driven
-- by low-value, medium-value,
-- or high-value purchases.
-- =====================================================

SELECT

    revenue_bucket,

    COUNT(*) AS transactions,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM intermediate.int_order_items

GROUP BY revenue_bucket

ORDER BY transactions DESC;

/* The marketplace is primarily driven by
medium-value transactions (63.18%).
High-value transactions contribute a
smaller portion of transaction volume
(16.13%), indicating a balanced sales
portfolio rather than dependence on
premium purchases.*/



-- =====================================================
-- KPI 4
-- HIGH FREIGHT IMPACT ANALYSIS
--
-- Business Question:
-- How many transactions have shipping
-- costs greater than the product value?
--
-- Purpose:
-- Identify potentially unprofitable
-- or logistics-heavy transactions.
-- =====================================================

SELECT

    high_freight_flag,

    COUNT(*) AS transactions,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM intermediate.int_order_items

GROUP BY high_freight_flag

ORDER BY transactions DESC;



-- =====================================================
-- KPI 5
-- MONTHLY REVENUE TREND
--
-- Business Question:
-- How does revenue vary over time?
--
-- Purpose:
-- Identify seasonality,
-- growth patterns,
-- and peak sales periods.
-- =====================================================

SELECT

    o.purchase_year,

    o.purchase_month,

    ROUND(
        SUM(oi.total_item_value),
        2
    ) AS monthly_revenue

FROM intermediate.int_order_items oi

JOIN intermediate.int_orders o
    ON oi.order_id = o.order_id

GROUP BY

    o.purchase_year,
    o.purchase_month

ORDER BY

    o.purchase_year,
    o.purchase_month;