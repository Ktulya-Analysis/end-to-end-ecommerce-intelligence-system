-- =====================================================
-- INTERMEDIATE : PRODUCTS
-- Purpose:
-- Create cleaned product dataset
-- =====================================================

DROP TABLE IF EXISTS intermediate.int_products;


CREATE TABLE intermediate.int_products AS

SELECT

-- Primary Key
product_id,

-- Replace NULL category values
COALESCE(
    product_category_name,
    'Unknown'
) AS product_category_name,

-- Product attributes
product_name_lenght,
product_description_lenght,
product_photos_qty,



-- =====================================================
-- CATALOG QUALITY FEATURES
--
-- Purpose:
-- Support Product Performance Analysis
-- and Catalog Quality Assessment.
-- =====================================================

-- Product name quality
CASE

    WHEN product_name_lenght < 20
    THEN 'Short Name'

    WHEN product_name_lenght < 50
    THEN 'Standard Name'

    ELSE 'Long Name'

END AS product_name_quality,

-- Product description quality
CASE

    WHEN product_description_lenght < 100
    THEN 'Poor Description'

    WHEN product_description_lenght < 500
    THEN 'Standard Description'

    ELSE 'Rich Description'

END AS description_quality,

-- Product image quality
CASE

    WHEN product_photos_qty <= 1
    THEN 'Low Image Coverage'

    WHEN product_photos_qty <= 3
    THEN 'Medium Image Coverage'

    ELSE 'High Image Coverage'

END AS image_quality

-- Physical dimensions
product_weight_g,
product_length_cm,
product_height_cm,
product_width_cm

FROM staging.olist_products_dataset;


-- =====================================================
-- VERIFY TRANSFORMATION
-- =====================================================

SELECT
COUNT(*) AS unknown_categories
FROM intermediate.int_products
WHERE product_category_name='Unknown';

--EXPECTED OUTPUT : 610



-- =====================================================
-- VALIDATION:
-- DESCRIPTION QUALITY DISTRIBUTION
-- =====================================================

SELECT

    description_quality,

    COUNT(*) AS products

FROM intermediate.int_products

GROUP BY description_quality

ORDER BY products DESC;


-- =====================================================
-- VALIDATION:
-- IMAGE QUALITY DISTRIBUTION
-- =====================================================

SELECT

    image_quality,

    COUNT(*) AS products

FROM intermediate.int_products

GROUP BY image_quality

ORDER BY products DESC;



-- =====================================================
-- VALIDATION:
-- PRODUCT NAME QUALITY DISTRIBUTION
-- =====================================================

SELECT

    product_name_quality,

    COUNT(*) AS products

FROM intermediate.int_products

GROUP BY product_name_quality

ORDER BY products DESC;