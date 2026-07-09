-- =====================================================
-- PRODUCT ANALYSIS
--
-- Business Problem:
-- Product Performance Analysis
--
-- Objective:
-- Understand catalog quality,
-- product coverage,
-- and product portfolio characteristics.
-- =====================================================



-- =====================================================
-- KPI 1
-- TOTAL PRODUCTS
--
-- Business Question:
-- How many products exist
-- in the marketplace catalog?
--
-- Purpose:
-- Measure catalog size.
-- =====================================================

SELECT

    COUNT(*) AS total_products

FROM intermediate.int_products;


-- =====================================================
-- KPI 2
-- PRODUCT CATEGORY DISTRIBUTION
--
-- Business Question:
-- Which product categories
-- contain the most products?
--
-- Purpose:
-- Understand catalog composition
-- and category concentration.
-- =====================================================

SELECT

    product_category_name,

    COUNT(*) AS total_products

FROM intermediate.int_products

GROUP BY product_category_name

ORDER BY total_products DESC

LIMIT 10;

-- =====================================================
-- KPI 3
-- DESCRIPTION QUALITY DISTRIBUTION
--
-- Business Question:
-- How well documented are products?
--
-- Purpose:
-- Assess catalog quality and
-- product information completeness.
-- =====================================================

SELECT

    description_quality,

    COUNT(*) AS products,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM intermediate.int_products

GROUP BY description_quality

ORDER BY products DESC;

/* Product description quality is strong.

Nearly 60% of products contain rich descriptions,
while only 1.67% have poor descriptions.

The marketplace appears to maintain
high catalog information quality.*/

-- =====================================================
-- KPI 4
-- IMAGE QUALITY DISTRIBUTION
--
-- Business Question:
-- Do products have sufficient
-- image coverage?
--
-- Purpose:
-- Assess visual catalog quality.
-- =====================================================

SELECT

    image_quality,

    COUNT(*) AS products,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM intermediate.int_products

GROUP BY image_quality

ORDER BY products DESC;

/*Product image coverage represents
the primary catalog quality improvement opportunity.

Approximately half of all products
have low image coverage, while fewer
than 20% have high image coverage.

Increasing image coverage may improve
customer confidence and conversion rates.*/


-- =====================================================
-- KPI 5
-- PRODUCT NAME QUALITY
--
-- Business Question:
-- Are product titles sufficiently
-- descriptive?
--
-- Purpose:
-- Assess catalog discoverability
-- and product identification quality.
-- =====================================================

SELECT

    product_name_quality,

    COUNT(*) AS products,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM intermediate.int_products

GROUP BY product_name_quality

ORDER BY products DESC;