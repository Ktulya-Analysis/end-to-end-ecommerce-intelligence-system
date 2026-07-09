-- =====================================================
-- DIMENSION TABLE : DIM PRODUCTS
--
-- Purpose:
-- Store product descriptive attributes
-- and catalog quality characteristics.
--
-- Business Problems Supported:
-- 1. Product Analysis
-- 2. Category Analysis
-- 3. Catalog Quality Analysis
-- 4. Logistics Analysis
-- =====================================================

DROP TABLE IF EXISTS analytics.dim_products;

CREATE TABLE analytics.dim_products AS

SELECT

-- =====================================================
-- PRODUCT IDENTIFIER
-- =====================================================

product_id,

-- =====================================================
-- PRODUCT CATEGORY
-- =====================================================

product_category_name,

-- =====================================================
-- PRODUCT ATTRIBUTES
-- =====================================================

product_name_lenght,
product_description_lenght,
product_photos_qty,

-- =====================================================
-- CATALOG QUALITY ATTRIBUTES
-- =====================================================

product_name_quality,
description_quality,
image_quality,

-- =====================================================
-- PHYSICAL ATTRIBUTES
-- =====================================================

product_weight_g,
product_length_cm,
product_height_cm,
product_width_cm

FROM intermediate.int_products;