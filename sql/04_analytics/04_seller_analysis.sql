-- =====================================================
-- KPI 1
-- TOTAL SELLERS
--
-- Business Question:
-- How many sellers participate
-- in the marketplace?
-- =====================================================

SELECT

    COUNT(*) AS total_sellers

FROM intermediate.int_sellers;

-- =====================================================
-- KPI 1
-- TOTAL SELLERS
--
-- Result:
-- 3,095 sellers
--
-- Interpretation:
-- The marketplace has 3,095 sellers
-- participating in product sales.
--
-- Business Value:
-- Measures marketplace supply-side size.
-- =====================================================


-- =====================================================
-- KPI 2
-- SELLER SIZE DISTRIBUTION
--
-- Business Question:
-- How many sellers are small,
-- medium, and large?
--
-- Purpose:
-- Understand marketplace seller
-- concentration and dependency.
-- =====================================================

SELECT

    seller_size_category,

    COUNT(*) AS sellers,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM intermediate.int_sellers

GROUP BY seller_size_category

ORDER BY sellers DESC;


-- =====================================================
-- KPI 3
-- AVERAGE ORDERS PER SELLER
--
-- Business Question:
-- How many orders does a seller
-- participate in on average?
--
-- Purpose:
-- Measure seller engagement and
-- marketplace activity.
-- =====================================================

SELECT

    ROUND(
        AVG(seller_order_count),
        2
    ) AS avg_orders_per_seller

FROM intermediate.int_sellers;

/*Sellers participate in an average
of 32.31 orders.
Most sellers have relatively
low order volumes. A small group of sellers
likely drives a significant
portion of marketplace activity.*/


-- =====================================================
-- KPI 4
-- AVERAGE PRODUCTS PER SELLER
--
-- Business Question:
-- How many products does a seller
-- offer on average?
--
-- Purpose:
-- Measure catalog size and seller
-- participation depth.
-- =====================================================

SELECT

    ROUND(
        AVG(seller_product_count),
        2
    ) AS avg_products_per_seller

FROM intermediate.int_sellers;

-- =====================================================
-- KPI 5
-- TOP SELLER STATES
--
-- Business Question:
-- Which states contribute the
-- largest seller base?
--
-- Purpose:
-- Understand seller concentration
-- and regional supply distribution.
-- =====================================================

SELECT

    seller_state,

    COUNT(*) AS total_sellers

FROM intermediate.int_sellers

GROUP BY seller_state

ORDER BY total_sellers DESC

LIMIT 10;