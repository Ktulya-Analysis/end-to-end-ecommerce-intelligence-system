-- =====================================================
-- MART : PRODUCT MART
--
-- Purpose:
-- Business-ready dataset for
-- product and catalog reporting.
--
-- Supports:
-- 1. Category Analysis
-- 2. Catalog Quality Analysis
-- 3. Product Portfolio Analysis
-- =====================================================

DROP TABLE IF EXISTS analytics.product_mart;

CREATE TABLE analytics.product_mart AS

SELECT

    product_category_name,

    COUNT(*) AS total_products,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS category_percentage,

    COUNT(
        CASE
            WHEN description_quality =
                 'Rich Description'
            THEN 1
        END
    ) AS rich_description_products,

    COUNT(
        CASE
            WHEN image_quality =
                 'High Image Coverage'
            THEN 1
        END
    ) AS high_image_products,

    COUNT(
        CASE
            WHEN product_name_quality =
                 'Long Name'
            THEN 1
        END
    ) AS long_name_products

FROM analytics.dim_products

GROUP BY

    product_category_name

ORDER BY

    total_products DESC;