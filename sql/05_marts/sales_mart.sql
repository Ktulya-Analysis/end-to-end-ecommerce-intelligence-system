-- =====================================================
-- MART : SALES MART
--
-- Purpose:
-- Business-ready dataset for
-- executive sales reporting.
--
-- Supports:
-- 1. Revenue Trend Analysis
-- 2. Order Trend Analysis
-- 3. Average Order Value Analysis
-- 4. Monthly / Quarterly / Yearly KPIs
-- =====================================================

DROP TABLE IF EXISTS analytics.sales_mart;

CREATE TABLE analytics.sales_mart AS

SELECT

-- =====================================================
-- TIME DIMENSIONS
-- =====================================================

    d.year,
    d.quarter,
    d.month,
    d.month_name,

-- =====================================================
-- SALES KPIs
-- =====================================================

    COUNT(DISTINCT fs.order_id)
    AS total_orders,

    ROUND(
        SUM(fs.total_item_value),
        2
    ) AS total_revenue,

    ROUND(
        SUM(fs.total_item_value)
        /
        NULLIF(COUNT(DISTINCT fs.order_id), 0),
        2
    ) AS avg_order_value,

    ROUND(
        SUM(fs.freight_value),
        2
    ) AS total_freight

FROM analytics.fact_sales fs

INNER JOIN analytics.dim_date d
    ON fs.purchase_date = d.date_key

GROUP BY

    d.year,
    d.quarter,
    d.month,
    d.month_name

ORDER BY

    d.year,
    d.month;



-- =====================================================
-- VALIDATION QUERY 1
-- =====================================================

    SELECT COUNT(*) AS rows
FROM analytics.sales_mart;


-- =====================================================
-- VALIDATION QUERY 2
-- =====================================================

SELECT *
FROM analytics.sales_mart
LIMIT 5;