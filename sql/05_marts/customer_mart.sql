-- =====================================================
-- MART : CUSTOMER MART
--
-- Purpose:
-- Business-ready dataset for
-- customer reporting and dashboarding.
--
-- Supports:
-- 1. Customer Base Analysis
-- 2. Repeat Customer Analysis
-- 3. Customer Lifetime Analysis
-- 4. Geographic Customer Analysis
-- =====================================================

DROP TABLE IF EXISTS analytics.customer_mart;

CREATE TABLE analytics.customer_mart AS

SELECT

-- =====================================================
-- CUSTOMER GEOGRAPHY
-- =====================================================

    customer_state,

-- =====================================================
-- CUSTOMER KPIs
-- =====================================================

    COUNT(DISTINCT customer_unique_id)
    AS total_customers,

    COUNT(
        DISTINCT CASE
            WHEN repeat_customer_flag =
                 'Repeat Customer'
            THEN customer_unique_id
        END
    ) AS repeat_customers,

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
    ) AS repeat_customer_percentage,

    ROUND(
        AVG(customer_lifetime_days),
        2
    ) AS avg_customer_lifetime_days

FROM analytics.dim_customers

GROUP BY

    customer_state

ORDER BY

    total_customers DESC;








-- =====================================================
-- VALIDATION QUERY
-- =====================================================
SELECT *
FROM analytics.customer_mart
LIMIT 10;