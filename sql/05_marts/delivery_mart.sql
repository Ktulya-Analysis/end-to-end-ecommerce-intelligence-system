-- =====================================================
-- MART : DELIVERY MART
--
-- Purpose:
-- Business-ready dataset for
-- logistics and delivery reporting.
--
-- Supports:
-- 1. Delivery Performance Analysis
-- 2. Late Delivery Monitoring
-- 3. Shipping Speed Analysis
-- =====================================================

DROP TABLE IF EXISTS analytics.delivery_mart;

CREATE TABLE analytics.delivery_mart AS

SELECT

    shipping_speed_category,

    late_delivery_flag,

    COUNT(*) AS total_orders,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage_orders,

    ROUND(
        AVG(delivery_days),
        2
    ) AS avg_delivery_days,

    ROUND(
        AVG(delivery_delay_days),
        2
    ) AS avg_delay_days

FROM analytics.fact_sales

GROUP BY

    shipping_speed_category,
    late_delivery_flag

ORDER BY

    total_orders DESC;