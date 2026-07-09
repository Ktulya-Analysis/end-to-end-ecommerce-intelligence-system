-- =====================================================
-- SALES METRICS
--
-- Purpose:
-- Official KPI definitions used across
-- dashboards and business reporting.
-- =====================================================


-- =====================================================
-- KPI 1 : TOTAL REVENUE
-- =====================================================

SELECT

    ROUND(
        SUM(total_item_value),
        2
    ) AS total_revenue

FROM analytics.fact_sales;


-- =====================================================
-- KPI 2 : TOTAL ORDERS
-- =====================================================

SELECT

    COUNT(DISTINCT order_id)
    AS total_orders

FROM analytics.fact_sales;


-- =====================================================
-- KPI 3 : AVERAGE ORDER VALUE (AOV)
-- =====================================================

SELECT

    ROUND(
        SUM(total_item_value)
        /
        NULLIF(
            COUNT(DISTINCT order_id),
            0
        ),
        2
    ) AS avg_order_value

FROM analytics.fact_sales;


-- =====================================================
-- KPI 4 : TOTAL FREIGHT
-- =====================================================

SELECT

    ROUND(
        SUM(freight_value),
        2
    ) AS total_freight

FROM analytics.fact_sales;


-- =====================================================
-- KPI 5 : AVERAGE FREIGHT PER ORDER
-- =====================================================

SELECT

    ROUND(
        SUM(freight_value)
        /
        NULLIF(
            COUNT(DISTINCT order_id),
            0
        ),
        2
    ) AS avg_freight_per_order

FROM analytics.fact_sales;