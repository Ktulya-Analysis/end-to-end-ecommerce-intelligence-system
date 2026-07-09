-- =====================================================
-- DIMENSION TABLE : DIM SELLERS
--
-- Purpose:
-- Store seller descriptive attributes
-- and seller performance characteristics.
--
-- Business Problems Supported:
-- 1. Seller Analysis
-- 2. Marketplace Participation Analysis
-- 3. Regional Seller Analysis
-- =====================================================

DROP TABLE IF EXISTS analytics.dim_sellers;

CREATE TABLE analytics.dim_sellers AS

SELECT

-- =====================================================
-- SELLER IDENTIFIER
-- =====================================================

seller_id,

-- =====================================================
-- GEOGRAPHIC ATTRIBUTES
-- =====================================================

seller_zip_code_prefix,
seller_city,
seller_state,

-- =====================================================
-- SELLER PERFORMANCE ATTRIBUTES
-- =====================================================

seller_product_count,
seller_order_count,
seller_size_category

FROM intermediate.int_sellers;



-- =====================================================
-- VALIDATION QUERY
-- =====================================================

SELECT COUNT(*) AS total_sellers
FROM analytics.dim_sellers;