-- =====================================================
-- DELIVERY METRICS
--
-- Purpose:
-- Official logistics KPI definitions
-- used across dashboards and reporting.
-- =====================================================


-- =====================================================
-- KPI 1 : AVERAGE DELIVERY DAYS
-- =====================================================

SELECT

    ROUND(
        AVG(delivery_days),
        2
    ) AS avg_delivery_days

FROM analytics.fact_sales;


-- =====================================================
-- KPI 2 : LATE DELIVERY RATE
-- =====================================================

SELECT

    ROUND(

        COUNT(
            CASE
                WHEN late_delivery_flag = 'Late'
                THEN 1
            END
        ) * 100.0

        /

        NULLIF(
            COUNT(*),
            0
        ),

        2

    ) AS late_delivery_rate

FROM analytics.fact_sales;


-- =====================================================
-- KPI 3 : ON-TIME DELIVERY RATE
-- =====================================================

SELECT

    ROUND(

        COUNT(
            CASE
                WHEN late_delivery_flag = 'On Time'
                THEN 1
            END
        ) * 100.0

        /

        NULLIF(
            COUNT(*),
            0
        ),

        2

    ) AS on_time_delivery_rate

FROM analytics.fact_sales;


-- =====================================================
-- KPI 4 : AVERAGE DELIVERY DELAY
-- =====================================================

SELECT

    ROUND(
        AVG(delivery_delay_days),
        2
    ) AS avg_delivery_delay_days

FROM analytics.fact_sales;