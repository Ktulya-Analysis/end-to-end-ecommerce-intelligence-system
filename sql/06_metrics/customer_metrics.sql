-- =====================================================
-- CUSTOMER METRICS
--
-- Purpose:
-- Official customer KPI definitions
-- used across dashboards and reporting.
-- =====================================================


-- =====================================================
-- KPI 1 : TOTAL CUSTOMERS
-- =====================================================

SELECT

    COUNT(DISTINCT customer_unique_id)
    AS total_customers

FROM analytics.dim_customers;


-- =====================================================
-- KPI 2 : REPEAT CUSTOMERS
-- =====================================================

SELECT

    COUNT(DISTINCT customer_unique_id)
    AS repeat_customers

FROM analytics.dim_customers

WHERE repeat_customer_flag =
      'Repeat Customer';


-- =====================================================
-- KPI 3 : REPEAT CUSTOMER RATE
-- =====================================================

SELECT

    ROUND(

        COUNT(
            DISTINCT CASE
                WHEN repeat_customer_flag =
                     'Repeat Customer'
                THEN customer_unique_id
            END
        ) * 100.0

        /

        NULLIF(
            COUNT(DISTINCT customer_unique_id),
            0
        ),

        2

    ) AS repeat_customer_rate

FROM analytics.dim_customers;


-- =====================================================
-- KPI 4 : AVERAGE CUSTOMER LIFETIME
-- =====================================================

SELECT

    ROUND(
        AVG(customer_lifetime_days),
        2
    ) AS avg_customer_lifetime_days

FROM analytics.dim_customers;