-- =========================================================
-- DATA QUALITY VALIDATION SUITE
-- =========================================================

-- Dataset: Orders
-- Purpose: Validate imported order data before downstream use


-- =========================================================
-- ORDERS : VOLUME VALIDATION
-- =========================================================
SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT order_id) AS unique_orders,
COUNT(DISTINCT customer_id) AS unique_customers
FROM staging.olist_orders_dataset;


-- =====================================
-- ORDERS : NULL VALIDATION
-- =====================================

SELECT
COUNT(*) AS null_order_ids
FROM staging.olist_orders_dataset
WHERE order_id IS NULL;


SELECT
COUNT(*) AS null_customer_ids
FROM staging.olist_orders_dataset
WHERE customer_id IS NULL;

-- =========================================================
-- ORDERS : DUPLICATE VALIDATION
-- =========================================================
SELECT
order_id,
COUNT(*) AS duplicate_count
FROM staging.olist_orders_dataset
GROUP BY order_id
HAVING COUNT(*) > 1;

-- =========================================================
-- ORDERS : DOMAIN VALIDATION
-- =========================================================

SELECT
order_status,
COUNT(*) AS total_orders
FROM staging.olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;


-- ===============================================
-- ORDERS : RELATIONSHIP VALIDATION
-- ===============================================

-- Verify all order customer_ids exist in customer table
-- Detect orphan records

SELECT
COUNT(*) AS missing_customer_links
FROM staging.olist_orders_dataset o
LEFT JOIN staging.olist_customers_dataset c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;



-- =========================================================
-- ORDERS : BUSINESS RULE VALIDATION
-- =========================================================

-- Purpose:
-- Detect impossible timelines
-- Delivery cannot happen before purchase

SELECT
COUNT(*) AS invalid_delivery_timelines
FROM staging.olist_orders_dataset
WHERE order_delivered_customer_date
<
order_purchase_timestamp;

-- Check 2:
-- Approval date cannot occur before purchase


SELECT
COUNT(*) AS invalid_approval_timelines
FROM staging.olist_orders_dataset
WHERE order_approved_at
<
order_purchase_timestamp;



-- Check 3:
-- Estimated delivery date should not be before purchase date

SELECT
COUNT(*) AS invalid_estimated_delivery_dates
FROM staging.olist_orders_dataset
WHERE order_estimated_delivery_date
<
order_purchase_timestamp;


-- Expected: 0
-- Meaning : Company cannot promise delivery before order was placed


-- Dataset: Customers


-- =====================================
-- CUSTOMERS : VOLUME VALIDATION
-- =====================================



SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT customer_id) AS unique_customer_ids,
COUNT(DISTINCT customer_unique_id) AS unique_real_customers
FROM staging.olist_customers_dataset;


-- =========================================================
-- CUSTOMERS : NULL VALIDATION
-- =========================================================

SELECT
COUNT(*) AS null_customer_ids
FROM staging.olist_customers_dataset
WHERE customer_id IS NULL;


SELECT
COUNT(*) AS null_customer_unique_ids
FROM staging.olist_customers_dataset
WHERE customer_unique_id IS NULL;





-- =========================================================
-- CUSTOMERS : DUPLICATE VALIDATION
-- Purpose:
-- Detect duplicate customer identifiers
-- =========================================================

SELECT
customer_id,
COUNT(*) AS duplicate_count
FROM staging.olist_customers_dataset
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:


-- =========================================================
-- CUSTOMERS : DOMAIN VALIDATION
-- Purpose:
-- Validate state values
-- =========================================================

SELECT
customer_state,
COUNT(*) AS total_customers
FROM staging.olist_customers_dataset
GROUP BY customer_state
ORDER BY total_customers DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:

-- =========================================================
-- CUSTOMERS : RELATIONSHIP VALIDATION
-- Purpose:
-- Identify customers with no linked orders
-- =========================================================

SELECT
COUNT(*) AS customers_without_orders
FROM staging.olist_customers_dataset c
LEFT JOIN staging.olist_orders_dataset o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;



---- =========================================================
--what we discovered earlier:
--customer_id = transaction/account instance
--customer_unique_id = real customer
--The output was : 
--99,441 customer_id
--96,096 customer_unique_id
-- Meaning:
--Some people appear multiple times.


-- =========================================================
-- CUSTOMERS : BUSINESS VALIDATION 1
-- Purpose:
-- Identify repeat customers
-- =========================================================

SELECT
customer_unique_id,
COUNT(*) AS total_accounts
FROM staging.olist_customers_dataset
GROUP BY customer_unique_id
HAVING COUNT(*) > 1
ORDER BY total_accounts DESC;


-- FINDINGS:
-- =====================================================

-- Result:
-- A small subset of customers repeatedly purchase
-- from the platform.

-- Interpretation:
-- Customer purchasing behavior follows a long-tail pattern.
-- Majority customers purchase once,
-- while a very small segment shows high repeat activity.

-- Business Impact:
-- High-frequency buyers can be classified as loyal customers.
-- They can be targeted through loyalty programs,
-- personalized offers, subscriptions, and retention campaigns.





-- =========================================================
-- CUSTOMERS : BUSINESS VALIDATION 2
-- Purpose:
-- Understand repeat customer behavior
-- (How frequently customers purchase items)
-- =========================================================

SELECT
total_accounts,
COUNT(*) AS number_of_customers
FROM
(
    SELECT
    customer_unique_id,
    COUNT(*) AS total_accounts
    FROM staging.olist_customers_dataset
    GROUP BY customer_unique_id
) t
GROUP BY total_accounts
ORDER BY total_accounts;


-- FINDINGS:
-- =====================================================

-- Result:
-- Majority customers purchased only once.

-- Interpretation:
-- Customer base is highly skewed toward one-time buyers.
-- Small repeat customer segment exists.

-- Business Impact:
-- Customer retention opportunity exists.
-- Marketing campaigns can target repeat purchase behavior.





-- =========================================================
-- CUSTOMERS : BUSINESS EVALUATION 3
-- Purpose:
-- Identify geographic concentration
-- =========================================================

SELECT
customer_state,
COUNT(*) AS customers
FROM staging.olist_customers_dataset
GROUP BY customer_state
ORDER BY customers DESC
LIMIT 10;


-- FINDINGS:
-- =====================================================

-- Result:
-- São Paulo dominates the customer base, followed by Rio de Janeiro and Minas Gerais.

-- Interpretation:
-- Customer concentration is heavily skewed toward a few regions.

-- Business Impact:
-- Marketing, logistics and warehouse placement
-- should prioritize high-density states.

-- =========================================================
-- CUSTOMERS : BUSINESS EVALUATION 5
-- Purpose:
-- Identify cities with least customer concentration
-- =========================================================

SELECT
customer_city,
COUNT(*) AS total_customers
FROM staging.olist_customers_dataset
GROUP BY customer_city
ORDER BY total_customers ASC
LIMIT 10;


-- FINDINGS:
-- =====================================================

-- Result:
-- Several cities contain only a single customer record.

-- Interpretation:
-- Customer distribution is highly uneven across cities.
-- A long-tail geographic pattern exists where a few cities contribute large customer volumes while many cities contribute extremely small numbers.

-- Business Impact:
-- These low-density cities may indicate:
-- limited market penetration,
-- niche demand,
-- or future expansion opportunities.

-- =========================================================
-- CUSTOMERS : BUSINESS EVALUATION 6
-- Purpose:
-- Identify states with least customer concentration
-- =========================================================

SELECT
customer_state,
COUNT(*) AS total_customers
FROM staging.olist_customers_dataset
GROUP BY customer_state
ORDER BY total_customers ASC
LIMIT 10;

-- FINDINGS:
-- =====================================================

-- Result:
-- RR, AP, and AC contain the lowest customer volumes.

-- Interpretation:
-- Customer distribution across states is highly concentrated.
-- Several states contribute very small customer populations.

-- Business Impact:
-- Low-customer states may indicate:
-- weak market penetration,
-- lower population density,
-- logistics limitations,
-- or untapped growth opportunities.

-- Marketing teams may evaluate whether targeted campaigns
-- are required in these regions.


-- =========================================================
-- DATASET: PRODUCTS 
-- =========================================================



-- =====================================================
-- PRODUCTS : VOLUME VALIDATION
-- Purpose:
-- Verify imported row count and uniqueness
-- =====================================================

SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT product_id) AS unique_products
FROM staging.olist_products_dataset;


-- FINDINGS:
-- =====================================================

-- Result:
-- Total imported rows and unique product identifiers
-- are equal.

-- Interpretation:
-- No duplicate product_id values detected.
-- Each row represents one unique product.

-- Business Impact:
-- Product entity integrity is maintained.
-- Product-level analytics, joins, and inventory analysis can be performed reliably.

-- =====================================================
-- PRODUCTS : NULL VALIDATION
-- Purpose:
-- Validate critical product identifiers
-- =====================================================

SELECT
COUNT(*) AS null_product_ids
FROM staging.olist_products_dataset
WHERE product_id IS NULL;


SELECT
COUNT(*) AS null_product_categories
FROM staging.olist_products_dataset
WHERE product_category_name IS NULL;


-- FINDINGS:
-- =====================================================

-- Result:
-- Product identifiers contain no missing values.
-- 610 products have missing category values.

-- Interpretation:
-- Product identity integrity is maintained.
-- However, category information is incomplete
-- for a small subset of products.

-- Business Impact:
-- Category-based analytics, product segmentation,
-- and reporting may be partially affected.
-- These products may appear as unclassified items.

-- Recommendation:
-- Missing categories can be replaced with 'Unknown'
-- or enriched during the data cleaning stage.

-- =====================================================
-- PRODUCTS : DUPLICATE VALIDATION
-- Purpose:
-- Detect duplicate product identifiers
-- =====================================================

SELECT
product_id,
COUNT(*) AS duplicate_count
FROM staging.olist_products_dataset
GROUP BY product_id
HAVING COUNT(*) > 1;

-- FINDINGS:
-- =====================================================

-- Result:
-- No duplicate product identifiers detected.

-- Interpretation:
-- Each product_id appears exactly once.

-- Business Impact:
-- Product joins and product-level reporting
-- can be performed reliably.

-- =====================================================
-- PRODUCTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze product category distribution
-- =====================================================

SELECT
product_category_name,
COUNT(*) AS total_products
FROM staging.olist_products_dataset
GROUP BY product_category_name
ORDER BY total_products DESC;


-- FINDINGS:
-- =====================================================

-- Result:
-- Product categories show highly uneven distribution.
-- Top categories include:
-- cama_mesa_banho,
-- esporte_lazer,
-- moveis_decoracao.

-- 610 products contain missing category values.

-- Interpretation:
-- Product inventory follows a long-tail distribution.
-- A few categories dominate inventory volume,
-- while many categories contain very few products.

-- Business Impact:
-- Revenue and customer activity may be concentrated
-- in a small number of categories.
-- Missing categories can affect category-based
-- reporting and recommendation systems.

-- =====================================================
-- PRODUCTS : RELATIONSHIP VALIDATION
-- Purpose:
-- Identify products never sold
-- =====================================================

SELECT
COUNT(*) AS products_without_sales
FROM staging.olist_products_dataset p
LEFT JOIN staging.olist_order_items_dataset oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


-- FINDINGS:
-- =====================================================

-- Result:
-- No products without sales detected.

-- Interpretation:
-- Every product exists in transaction activity.

-- Business Impact:
-- Product catalog and sales data are fully linked.
-- Product analytics can be trusted.

-- =====================================================
-- PRODUCTS : BUSINESS VALIDATION
-- Purpose:
-- Identify most common product categories
-- =====================================================

SELECT
product_category_name,
COUNT(*) AS total_products
FROM staging.olist_products_dataset
GROUP BY product_category_name
ORDER BY total_products DESC
LIMIT 10;

-- =====================================================
-- FINDINGS
-- =====================================================

-- Result:
-- Top product categories are:
-- cama_mesa_banho (3029),
-- esporte_lazer (2867),
-- moveis_decoracao (2657),
-- beleza_saude (2444),
-- utilidades_domesticas (2335)

-- Interpretation:
-- Product inventory is concentrated around home/lifestyle, sports, and health categories.

-- Business Impact:
-- These categories likely contribute heavily
-- to customer activity and sales volume.
-- Inventory planning and recommendation systems
-- may prioritize these categories.

-- =====================================================
-- PRODUCTS : BUSINESS VALIDATION 2
-- Purpose:
-- Analyze product physical dimensions
-- =====================================================

SELECT
ROUND(AVG(product_weight_g),2) AS avg_weight,
ROUND(AVG(product_length_cm),2) AS avg_length,
ROUND(AVG(product_height_cm),2) AS avg_height,
ROUND(AVG(product_width_cm),2) AS avg_width
FROM staging.olist_products_dataset;

-- =====================================================
-- FINDINGS
-- =====================================================

-- Result:
-- Average product weight: 2276.47 g
-- Average length: 30.82 cm
-- Average height: 16.94 cm
-- Average width: 23.20 cm

-- Interpretation:
-- Products are generally medium-sized and moderately heavy.
-- Inventory appears dominated by household and lifestyle products.

-- Business Impact:
-- Product dimensions directly affect:
-- shipping cost,
-- warehouse storage allocation,
-- packaging strategy,
-- and delivery optimization.




-- =====================================================
-- DATASET = SELLERS  
-- =====================================================


-- SELLERS : VOLUME VALIDATION
-- Purpose:
-- Verify imported row count and uniqueness


SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT seller_id) AS unique_sellers
FROM staging.olist_sellers_dataset;


-- FINDINGS:
-- =====================================================

-- Result:
-- Total imported rows and unique seller identifiers
-- are equal.

-- Interpretation:
-- No duplicate seller identifiers detected.
-- Each row represents one unique seller entity.

-- Business Impact:
-- Seller-level analytics and marketplace analysis
-- can be performed reliably.

-- =====================================================
-- SELLERS : NULL VALIDATION
-- Purpose:
-- Validate critical seller identifiers
-- =====================================================

SELECT
COUNT(*) AS null_seller_ids
FROM staging.olist_sellers_dataset
WHERE seller_id IS NULL;


SELECT
COUNT(*) AS null_seller_city
FROM staging.olist_sellers_dataset
WHERE seller_city IS NULL;


SELECT
COUNT(*) AS null_seller_state
FROM staging.olist_sellers_dataset
WHERE seller_state IS NULL;

-- FINDINGS:
-- =====================================================

-- Result:
-- No missing values detected in seller identifiers,
-- city, or state fields.

-- Interpretation:
-- Seller identity and geographic information
-- are complete.

-- Business Impact:
-- Geographic analysis, seller segmentation,
-- logistics studies, and regional reporting
-- can be performed reliably.

-- =====================================================
-- SELLERS : DUPLICATE VALIDATION
-- Purpose:
-- Detect duplicate seller identifiers
-- =====================================================

SELECT
seller_id,
COUNT(*) AS duplicate_count
FROM staging.olist_sellers_dataset
GROUP BY seller_id
HAVING COUNT(*) > 1;


-- FINDINGS:
-- =====================================================

-- Result:
-- No duplicate seller identifiers detected.

-- Interpretation:
-- Each seller record represents a unique marketplace seller.

-- Business Impact:
-- Seller-level metrics and performance analysis
-- can be performed reliably.

-- =====================================================
-- SELLERS : DOMAIN VALIDATION
-- Purpose:
-- Analyze seller state distribution
-- =====================================================

SELECT
seller_state,
COUNT(*) AS total_sellers
FROM staging.olist_sellers_dataset
GROUP BY seller_state
ORDER BY total_sellers DESC;


-- FINDINGS:
-- =====================================================

-- Result:
-- Seller distribution is highly concentrated in a few states.
-- São Paulo (SP) dominates with 1849 sellers,
-- followed by Paraná (PR), Minas Gerais (MG),
-- and Santa Catarina (SC).

-- Interpretation:
-- Marketplace supply is geographically concentrated.
-- Seller participation follows a long-tail pattern:
-- a few states contribute most sellers,
-- while many states contribute very few.

-- Business Impact:
-- Seller ecosystem depends heavily on SP and southern regions.
-- Logistics infrastructure, delivery performance,
-- and marketplace resilience may be strongly influenced
-- by these high-density seller regions.

-- =====================================================
-- SELLERS : RELATIONSHIP VALIDATION
-- Purpose:
-- Identify sellers without transactions
-- =====================================================

SELECT
COUNT(*) AS sellers_without_sales
FROM staging.olist_sellers_dataset s
LEFT JOIN staging.olist_order_items_dataset oi
ON s.seller_id = oi.seller_id
WHERE oi.seller_id IS NULL;


-- FINDINGS:
-- =====================================================

-- Result:
-- No sellers without transaction activity detected.

-- Interpretation:
-- Every seller in the marketplace has participated
-- in at least one order transaction.

-- Business Impact:
-- Seller catalog and transaction data
-- are fully linked.
-- Seller performance metrics can be trusted.

-- =====================================================
-- SELLERS : BUSINESS VALIDATION
-- Purpose:
-- Identify top seller cities
-- =====================================================

SELECT
seller_city,
COUNT(*) AS total_sellers
FROM staging.olist_sellers_dataset
GROUP BY seller_city
ORDER BY total_sellers DESC
LIMIT 10;

-- FINDINGS:
-- =====================================================

-- Result:
-- São Paulo dominates seller activity with 694 sellers,
-- followed by Curitiba (127),
-- Rio de Janeiro (96),
-- and Belo Horizonte (68).

-- Interpretation:
-- Seller ecosystem is highly concentrated
-- in a few metropolitan cities.
-- Marketplace supply follows a long-tail pattern.

-- Business Impact:
-- Major cities act as seller hubs and likely drive:
-- inventory availability,
-- delivery efficiency,
-- and marketplace growth.

-- Seller acquisition strategies may focus on
-- underrepresented regions to diversify supply.




-- =====================================================
     DATASET : ORDER PAYMENTS
-- =====================================================

-- =====================================================
-- PAYMENTS : VOLUME VALIDATION
-- Purpose:
-- Verify imported row count and uniqueness
-- =====================================================

SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT order_id) AS unique_orders
FROM staging.olist_order_payments_dataset;


-- FINDINGS:
-- =====================================================

-- Result:
-- Total payment rows = 103,886
-- Unique orders = 99,440

-- Interpretation:
-- Payment records exceed unique order count,
-- indicating that some orders contain multiple
-- payment transactions.

-- Business Impact:
-- Customers may use split payments,
-- multiple payment methods,
-- or installment-based transactions.


-- =====================================================
-- PAYMENTS : BUSINESS INVESTIGATION
-- Purpose:
-- Analyze number of payment records per order
-- =====================================================

SELECT
payment_count,
COUNT(*) AS total_orders
FROM
(
SELECT
order_id,
COUNT(*) AS payment_count
FROM staging.olist_order_payments_dataset
GROUP BY order_id
)t
GROUP BY payment_count
ORDER BY payment_count;

-- FINDINGS:
-- =====================================================

-- Result:
-- Total payment rows exceed unique orders.

-- Interpretation:
-- Multiple payment records may exist
-- for a single order.

-- Business Impact:
-- Indicates possible installment or
-- split-payment behavior.

-- =====================================================
-- PAYMENTS : NULL VALIDATION
-- Purpose:
-- Validate critical payment identifiers
-- =====================================================

SELECT
COUNT(*) AS null_order_ids
FROM staging.olist_order_payments_dataset
WHERE order_id IS NULL;


SELECT
COUNT(*) AS null_payment_type
FROM staging.olist_order_payments_dataset
WHERE payment_type IS NULL;


SELECT
COUNT(*) AS null_payment_value
FROM staging.olist_order_payments_dataset
WHERE payment_value IS NULL;


-- FINDINGS:
-- =====================================================

-- Result:
-- No missing values detected in payment identifiers,
-- payment type, or payment amount fields.

-- Interpretation:
-- Payment records are complete and contain all
-- critical transactional information.

-- Business Impact:
-- Revenue analysis, payment behavior analysis,
-- and transaction reporting can be performed reliably.

-- =====================================================
-- PAYMENTS : DUPLICATE VALIDATION
-- Purpose:
-- Detect exact duplicate payment records
-- =====================================================

SELECT
order_id,
payment_sequential,
COUNT(*) AS duplicate_count
FROM staging.olist_order_payments_dataset
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;


-- FINDINGS:
-- =====================================================

-- Result:
-- No duplicate payment records detected.

-- Interpretation:
-- Combination of order_id and payment_sequential
-- uniquely identifies payment transactions.

-- Business Impact:
-- Payment transaction integrity is maintained.
-- Revenue aggregation and payment analytics
-- can be performed reliably.


-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- Result:
--
-- Interpretation:
--
-- Business Impact:
--
-- Status:-- =====================================================
-- PAYMENTS : DOMAIN VALIDATION
-- Purpose:
-- Analyze payment type distribution
-- =====================================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- FINDINGS:
-- =====================================================

-- Result:
-- Credit card transactions dominate payment behavior
-- with 76,795 transactions.
-- Boleto is the second most used payment method,
-- followed by vouchers and debit cards.

-- Interpretation:
-- Customers strongly prefer card-based payments.
-- Alternative payment methods are used at
-- significantly lower rates.

-- Business Impact:
-- Marketplace revenue flow depends heavily
-- on credit card infrastructure.
-- Payment-provider stability and card-processing
-- reliability become business critical.

-- =====================================================
-- PAYMENTS : RELATIONSHIP VALIDATION
-- Purpose:
-- Detect orphan payment transactions
-- =====================================================

SELECT
COUNT(*) AS orphan_payments
FROM staging.olist_order_payments_dataset p
LEFT JOIN staging.olist_orders_dataset o
ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- FINDINGS:
-- =====================================================

-- Result:
-- No orphan payment transactions detected.

-- Interpretation:
-- Every payment record is linked
-- to an existing order.

-- Business Impact:
-- Revenue transactions maintain
-- referential integrity.
-- Financial reporting and payment analysis
-- can be trusted.

-- =====================================================
-- PAYMENTS : BUSINESS VALIDATION
-- Purpose:
-- Analyze installment usage pattern
-- =====================================================

SELECT
payment_installments,
COUNT(*) AS total_transactions
FROM staging.olist_order_payments_dataset
GROUP BY payment_installments
ORDER BY total_transactions DESC
LIMIT 15;

-- FINDINGS:
-- =====================================================

-- Result:
-- Majority transactions use a single payment installment
-- (52,546 transactions).
-- However, a significant number of customers use
-- multiple installments:
-- 2, 3, 4, 5, 8, and even up to 24 installments.

-- Interpretation:
-- While one-time payment behavior dominates,
-- installment-based purchasing is widely adopted.
-- Customers appear comfortable spreading payments
-- across multiple periods.

-- Business Impact:
-- Installment options may contribute to higher
-- purchase conversion and increased order values.
-- Financing flexibility appears to be an important
-- marketplace behavior pattern.

-- =====================================================
-- REVIEWS : VOLUME VALIDATION
-- Purpose:
-- Verify imported row count and uniqueness
-- =====================================================

SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT review_id) AS unique_reviews,
COUNT(DISTINCT order_id) AS unique_orders
FROM staging.olist_order_reviews_dataset;

-- FINDINGS:
-- =====================================================

-- Result:
-- Total review rows differ from both
-- unique review identifiers and unique orders.

-- Interpretation:
-- Review behavior may contain one-to-many
-- or many-to-one relationships requiring investigation.

-- Business Impact:
-- Review aggregation and customer sentiment
-- analysis may be affected if review structure
-- assumptions are incorrect.

-- =====================================================
-- REVIEWS : BUSINESS INVESTIGATION
-- Purpose:
-- Check repeated review identifiers
-- =====================================================

SELECT
review_id,
COUNT(*) AS repeat_count
FROM staging.olist_order_reviews_dataset
GROUP BY review_id
HAVING COUNT(*) > 1
ORDER BY repeat_count DESC;

-- FINDINGS:
-- =====================================================

-- Result:
-- Total rows = 99,224
-- Unique review IDs = 98,410
-- Unique orders = 98,673

-- Interpretation:
-- Investigation revealed certain review identifiers
-- are associated with multiple orders.

-- Business Impact:
-- Review entities do not follow a strict
-- one-review-per-order assumption.
-- Customer sentiment aggregation should account
-- for review reuse behavior.

-- =====================================================
-- REVIEWS : NULL VALIDATION
-- Purpose:
-- Validate critical review fields
-- =====================================================

SELECT
COUNT(*) AS null_review_ids
FROM staging.olist_order_reviews_dataset
WHERE review_id IS NULL;


SELECT
COUNT(*) AS null_order_ids
FROM staging.olist_order_reviews_dataset
WHERE order_id IS NULL;


SELECT
COUNT(*) AS null_review_scores
FROM staging.olist_order_reviews_dataset
WHERE review_score IS NULL;



-- FINDINGS:
-- =====================================================

-- Result:
-- No missing values detected in review identifiers,
-- order identifiers, or review scores.

-- Interpretation:
-- Critical review information is complete.
-- Each review record contains the minimum
-- fields required for sentiment analysis.

-- Business Impact:
-- Customer satisfaction metrics,
-- review analytics,
-- and quality reporting can be performed reliably.



-- =====================================================
-- REVIEWS : DUPLICATE VALIDATION
-- Purpose:
-- Detect exact duplicate review records
-- =====================================================

SELECT
review_id,
order_id,
COUNT(*) AS duplicate_count
FROM staging.olist_order_reviews_dataset
GROUP BY review_id, order_id
HAVING COUNT(*) > 1;

-- FINDINGS:
-- =====================================================

-- Result:
-- No duplicate review-order combinations detected.

-- Interpretation:
-- Although review IDs may repeat across orders,
-- no exact duplicate review records exist.

-- Business Impact:
-- Review integrity is maintained and customer
-- sentiment calculations remain reliable.

-- =====================================================
-- REVIEWS : DOMAIN VALIDATION
-- Purpose:
-- Analyze review score distribution
-- =====================================================

SELECT
review_score,
COUNT(*) AS total_reviews
FROM staging.olist_order_reviews_dataset
GROUP BY review_score
ORDER BY review_score;


-- FINDINGS:
-- =====================================================

-- Result:
-- Review scores contain only expected values
-- ranging from 1 to 5.

-- Interpretation:
-- Review rating values follow the defined
-- business rules and expected scoring scale.

-- Business Impact:
-- Customer satisfaction analysis,
-- sentiment measurement,
-- and KPI calculations can be trusted.

-- =====================================================
-- REVIEWS : RELATIONSHIP VALIDATION
-- Purpose:
-- Detect orphan reviews
-- =====================================================

SELECT
COUNT(*) AS orphan_reviews
FROM staging.olist_order_reviews_dataset r
LEFT JOIN staging.olist_orders_dataset o
ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- FINDINGS:
-- =====================================================

-- Result:
-- No orphan review records detected.

-- Interpretation:
-- Every review is linked to an existing order.
-- Review and transaction data maintain
-- referential integrity.

-- Business Impact:
-- Customer feedback analysis can be safely tied
-- to order behavior and purchase history.

-- =====================================================
-- REVIEWS : BUSINESS VALIDATION
-- Purpose:
-- Analyze customer satisfaction pattern
-- =====================================================

SELECT
review_score,
COUNT(*) AS total_reviews
FROM staging.olist_order_reviews_dataset
GROUP BY review_score
ORDER BY total_reviews DESC;


-- FINDINGS:
-- =====================================================

-- Result:
-- Five-star reviews dominate customer feedback,
-- followed by four-star reviews.
-- One-star reviews appear as the third most frequent
-- rating category.

-- Interpretation:
-- Overall customer sentiment is positive,
-- indicating generally satisfactory shopping experiences.
-- However, a notable number of extremely dissatisfied
-- customers also exist.

-- Business Impact:
-- Marketplace performance appears strong overall,
-- but severe dissatisfaction cases should be investigated
-- to identify operational issues such as:
-- delivery delays,
-- damaged products,
-- seller quality problems,
-- or customer expectation mismatch.




-- =====================================================
--DATASET : GEOLOCATION
-- =====================================================

-- =====================================================
-- GEOLOCATION : VOLUME VALIDATION
-- Purpose:
-- Verify imported row count and uniqueness
-- =====================================================

SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT geolocation_zip_code_prefix) AS unique_zip_codes
FROM staging.olist_geolocation_dataset;


-- FINDINGS:
-- =====================================================

-- Result:
-- Total rows = 1,000,163
-- Unique ZIP code prefixes = 19,015

-- Interpretation:
-- Multiple geolocation records exist for
-- individual ZIP code prefixes.

-- Business Impact:
-- Geolocation data appears to capture
-- multiple coordinate points within ZIP regions,
-- enabling more granular regional analysis.

-- =====================================================
-- GEOLOCATION : NULL VALIDATION
-- Purpose:
-- Validate critical geolocation fields
-- =====================================================

SELECT
COUNT(*) AS null_zip_codes
FROM staging.olist_geolocation_dataset
WHERE geolocation_zip_code_prefix IS NULL;


SELECT
COUNT(*) AS null_latitudes
FROM staging.olist_geolocation_dataset
WHERE geolocation_lat IS NULL;


SELECT
COUNT(*) AS null_longitudes
FROM staging.olist_geolocation_dataset
WHERE geolocation_lng IS NULL;


-- FINDINGS:
-- =====================================================

-- Result:
-- No missing values detected in ZIP codes,
-- latitude, or longitude fields.

-- Interpretation:
-- Critical geographic information is complete.
-- Every location record contains coordinate data.

-- Business Impact:
-- Geographic analysis, regional clustering,
-- delivery intelligence, and location mapping
-- can be performed reliably.

-- =====================================================
-- GEOLOCATION : DOMAIN VALIDATION
-- Purpose:
-- Validate state distribution and categories
-- =====================================================

SELECT
geolocation_state,
COUNT(*) AS total_records
FROM staging.olist_geolocation_dataset
GROUP BY geolocation_state
ORDER BY total_records DESC;

-- FINDINGS:
-- =====================================================

-- Result:
-- Geolocation state values contain only expected
-- state abbreviations.

-- Interpretation:
-- Geographic categories follow standardized
-- state naming conventions with no anomalous values.

-- Business Impact:
-- Regional analysis, state-level KPIs,
-- delivery heatmaps, and geographic segmentation
-- can be performed reliably.

-- =====================================================
-- GEOLOCATION : RELATIONSHIP VALIDATION
-- Purpose:
-- Detect customer ZIP codes missing from geolocation
-- =====================================================

SELECT
COUNT(*) AS missing_customer_zip_mappings
FROM staging.olist_customers_dataset c
LEFT JOIN staging.olist_geolocation_dataset g
ON c.customer_zip_code_prefix =
g.geolocation_zip_code_prefix
WHERE g.geolocation_zip_code_prefix IS NULL;


-- FINDINGS:
-- =====================================================

-- Result:
-- 278 customer ZIP code prefixes were not found
-- in the geolocation reference dataset.

-- Interpretation:
-- A small subset of customer locations
-- lacks corresponding geographic mapping data.

-- Business Impact:
-- Geographic analysis for these customers
-- may fail or produce incomplete location-based insights.
-- City/state enrichment and regional dashboards
-- could exclude these records.

-- Action:
-- Investigate missing ZIP mappings during
-- transformation layer processing.
-- Consider assigning "Unknown Location"
-- or applying enrichment rules.

-- =====================================================
-- GEOLOCATION : BUSINESS VALIDATION
-- Purpose:
-- Identify customer concentration regions
-- =====================================================

SELECT
geolocation_city,
COUNT(*) AS total_locations
FROM staging.olist_geolocation_dataset
GROUP BY geolocation_city
ORDER BY total_locations DESC
LIMIT 10;

-- FINDINGS:
-- =====================================================

-- Result:
-- Sao Paulo dominates geolocation records.
-- However, city naming inconsistency was detected:
-- "sao paulo" and "são paulo" appear separately.

-- Interpretation:
-- Geographic text fields contain formatting
-- inconsistencies caused by accent variations.

-- Business Impact:
-- City-level reporting and aggregation may become
-- fragmented, producing inaccurate regional insights.

-- Action:
-- Standardize city names during transformation layer
-- using text normalization rules.
