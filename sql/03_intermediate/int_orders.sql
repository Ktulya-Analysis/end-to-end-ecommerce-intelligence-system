
-- INTERMEDIATE : ORDERS
--
-- Business Problem:
-- Delivery Performance Analysis
--
-- Purpose:
-- Create analytics-ready orders dataset
-- with standardized order attributes,
-- date dimensions, and delivery performance
-- features required for operational KPI tracking,
-- SLA monitoring, and logistics analysis.
--
-- Business Questions:
-- 1. How long do customers wait for delivery?
-- 2. How many deliveries are late?
-- 3. What is the average delivery delay?
-- 4. Which deliveries are fast, standard, or slow?
-- 5. Which regions may have logistics bottlenecks?
--
-- Downstream Usage:
-- fact_sales
-- delivery_performance_mart
-- regional_logistics_mart
-- delivery_metrics
-- dashboard layer
-- =====================================================

DROP TABLE IF EXISTS intermediate.int_orders;

CREATE TABLE intermediate.int_orders AS

SELECT

-- =====================================================
-- ORDER IDENTIFIERS
-- =====================================================

order_id,
customer_id,

-- =====================================================
-- ORDER STATUS
-- =====================================================

LOWER(TRIM(order_status)) AS order_status,

-- =====================================================
-- ORIGINAL ORDER TIMESTAMPS
-- =====================================================

order_purchase_timestamp,
order_approved_at,
order_delivered_carrier_date,
order_delivered_customer_date,
order_estimated_delivery_date,

-- =====================================================
-- DATE DIMENSION FEATURES
-- Purpose:
-- Support time-series analysis,
-- monthly KPIs, quarterly reporting,
-- seasonality analysis, and dashboards.
-- =====================================================

DATE(order_purchase_timestamp)
AS purchase_date,

EXTRACT(YEAR FROM order_purchase_timestamp)
AS purchase_year,

EXTRACT(MONTH FROM order_purchase_timestamp)
AS purchase_month,

EXTRACT(DAY FROM order_purchase_timestamp)
AS purchase_day,

EXTRACT(QUARTER FROM order_purchase_timestamp)
AS purchase_quarter,

TO_CHAR(order_purchase_timestamp, 'Day')
AS purchase_weekday,

-- =====================================================
-- DELIVERY PERFORMANCE FEATURES
--
-- Purpose:
-- Support Delivery Performance Analysis
-- and Regional Logistics Analysis
-- =====================================================

-- Actual customer wait time
(
    DATE(order_delivered_customer_date)
    - DATE(order_purchase_timestamp)
)
AS delivery_days,

-- Promised delivery duration
(
    DATE(order_estimated_delivery_date)
    - DATE(order_purchase_timestamp)
)
AS estimated_delivery_days,

-- Difference between actual and promised delivery
(
    DATE(order_delivered_customer_date)
    - DATE(order_estimated_delivery_date)
)
AS delivery_delay_days,

-- Delivery SLA status
CASE
    WHEN order_delivered_customer_date >
         order_estimated_delivery_date
    THEN 'Late'

    ELSE 'On Time'

END AS late_delivery_flag,


-- =====================================================
-- DELIVERY STATUS
--
-- Purpose:
-- Classify deliveries as Early,
-- On Time, or Late based on
-- promised delivery date.
-- =====================================================

CASE

    WHEN DATE(order_delivered_customer_date)
         < DATE(order_estimated_delivery_date)
    THEN 'Early'

    WHEN DATE(order_delivered_customer_date)
         = DATE(order_estimated_delivery_date)
    THEN 'On Time'

    ELSE 'Late'

END AS delivery_status,

-- =====================================================
-- DELAY BUCKET
--
-- Purpose:
-- Group delayed deliveries into
-- operational SLA buckets for
-- logistics performance reporting.
-- =====================================================

CASE

    WHEN (
        DATE(order_delivered_customer_date)
        - DATE(order_estimated_delivery_date)
    ) <= 0
    THEN 'On Time / Early'

    WHEN (
        DATE(order_delivered_customer_date)
        - DATE(order_estimated_delivery_date)
    ) <= 3
    THEN '1-3 Days Late'

    WHEN (
        DATE(order_delivered_customer_date)
        - DATE(order_estimated_delivery_date)
    ) <= 7
    THEN '4-7 Days Late'

    ELSE '7+ Days Late'

END AS delay_bucket,

-- Delivery speed category
CASE

    WHEN (
        DATE(order_delivered_customer_date)
        - DATE(order_purchase_timestamp)
    ) <= 3
    THEN 'Fast'

    WHEN (
        DATE(order_delivered_customer_date)
        - DATE(order_purchase_timestamp)
    ) <= 7
    THEN 'Standard'

    ELSE 'Slow'

END AS shipping_speed_category

FROM staging.olist_orders_dataset;




--Validation Query
SELECT
delivery_status,
COUNT(*) AS total_orders
FROM intermediate.int_orders
GROUP BY delivery_status
ORDER BY total_orders DESC;





--Validation Query
SELECT
delay_bucket,
COUNT(*) AS total_orders
FROM intermediate.int_orders
GROUP BY delay_bucket
ORDER BY total_orders DESC;