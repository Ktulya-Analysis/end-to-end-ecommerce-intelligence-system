-- =====================================================
-- INTERMEDIATE : SELLERS
--
-- Business Problem:
-- Seller Performance Analysis
--
-- Purpose:
-- Create analytics-ready seller dataset
-- with standardized geographic values
-- and seller activity metrics for
-- marketplace participation analysis.
--
-- Business Questions:
-- 1. Which sellers are most active?
-- 2. How many products does each seller offer?
-- 3. How many orders does each seller participate in?
-- 4. Which sellers are large, medium, or small?
-- 5. Which regions have the most active sellers?
-- =====================================================

DROP TABLE IF EXISTS intermediate.int_sellers;

CREATE TABLE intermediate.int_sellers AS

WITH seller_performance AS (

    SELECT

        seller_id,

        COUNT(DISTINCT product_id)
        AS seller_product_count,

        COUNT(DISTINCT order_id)
        AS seller_order_count

    FROM intermediate.int_order_items

    GROUP BY seller_id

)

SELECT

-- =====================================================
-- SELLER IDENTIFIER
-- =====================================================

s.seller_id,

-- =====================================================
-- GEOGRAPHIC INFORMATION
-- =====================================================

s.seller_zip_code_prefix,

LOWER(
    TRIM(
        TRANSLATE(
            s.seller_city,
            'áàâãäéèêëíìîïóòôõöúùûüç',
            'aaaaaeeeeiiiiooooouuuuc'
        )
    )
) AS seller_city,

s.seller_state,

-- =====================================================
-- SELLER PERFORMANCE FEATURES
--
-- Purpose:
-- Support Seller Performance Analysis
-- and Marketplace Participation Analysis.
-- =====================================================

COALESCE(
    sp.seller_product_count,
    0
) AS seller_product_count,

COALESCE(
    sp.seller_order_count,
    0
) AS seller_order_count,

CASE

    WHEN COALESCE(sp.seller_order_count,0) < 50
    THEN 'Small Seller'

    WHEN COALESCE(sp.seller_order_count,0) < 500
    THEN 'Medium Seller'

    ELSE 'Large Seller'

END AS seller_size_category

FROM staging.olist_sellers_dataset s

LEFT JOIN seller_performance sp
    ON s.seller_id = sp.seller_id;



-- =====================================================
-- VALIDATION 1
-- SELLER SIZE DISTRIBUTION
-- =====================================================

SELECT

    seller_size_category,

    COUNT(*) AS sellers

FROM intermediate.int_sellers

GROUP BY seller_size_category

ORDER BY sellers DESC;



-- =====================================================
-- VALIDATION 2
-- SELLER ORDER STATISTICS
-- =====================================================

SELECT

    MAX(seller_order_count)
    AS max_orders,

    AVG(seller_order_count)
    AS avg_orders

FROM intermediate.int_sellers;



-- =====================================================
-- VALIDATION 3
-- SELLER PRODUCT STATISTICS
-- =====================================================

SELECT

    MAX(seller_product_count)
    AS max_products,

    AVG(seller_product_count)
    AS avg_products

FROM intermediate.int_sellers;