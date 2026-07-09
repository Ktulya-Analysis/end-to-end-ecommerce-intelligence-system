-- =====================================================
-- MART : SELLER MART
--
-- Purpose:
-- Business-ready dataset for
-- seller reporting and dashboarding.
--
-- Supports:
-- 1. Seller Base Analysis
-- 2. Seller Size Analysis
-- 3. Seller Participation Analysis
-- 4. Regional Seller Analysis
-- =====================================================

DROP TABLE IF EXISTS analytics.seller_mart;

CREATE TABLE analytics.seller_mart AS

SELECT

-- =====================================================
-- SELLER GEOGRAPHY
-- =====================================================

    seller_state,

-- =====================================================
-- SELLER KPIs
-- =====================================================

    COUNT(DISTINCT seller_id)
    AS total_sellers,

    COUNT(
        CASE
            WHEN seller_size_category =
                 'Small Seller'
            THEN 1
        END
    ) AS small_sellers,

    COUNT(
        CASE
            WHEN seller_size_category =
                 'Medium Seller'
            THEN 1
        END
    ) AS medium_sellers,

    COUNT(
        CASE
            WHEN seller_size_category =
                 'Large Seller'
            THEN 1
        END
    ) AS large_sellers,

    ROUND(
        AVG(seller_product_count),
        2
    ) AS avg_products_per_seller,

    ROUND(
        AVG(seller_order_count),
        2
    ) AS avg_orders_per_seller

FROM analytics.dim_sellers

GROUP BY

    seller_state

ORDER BY

    total_sellers DESC;




-- =====================================================
-- VALIDATION QUERY
-- =====================================================
SELECT *
FROM analytics.seller_mart
LIMIT 10;