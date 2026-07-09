-- =====================================
-- ORDERS TABLE CREATION
-- =====================================

CREATE TABLE staging.olist_orders_dataset
(
order_id TEXT,
customer_id TEXT,
order_status TEXT,
order_purchase_timestamp TIMESTAMP,
order_approved_at TIMESTAMP,
order_delivered_carrier_date TIMESTAMP,
order_delivered_customer_date TIMESTAMP,
order_estimated_delivery_date TIMESTAMP
);


-- =====================================
-- CUSTOMERS TABLE CREATION
-- =====================================

CREATE TABLE staging.olist_customers_dataset
(
customer_id TEXT,
customer_unique_id TEXT,
customer_zip_code_prefix INT,
customer_city TEXT,
customer_state TEXT
);


-- =====================================================
-- PRODUCTS TABLE CREATION
-- =====================================================

CREATE TABLE staging.olist_products_dataset
(
product_id TEXT,
product_category_name TEXT,
product_name_lenght INT,
product_description_lenght INT,
product_photos_qty INT,
product_weight_g INT,
product_length_cm INT,
product_height_cm INT,
product_width_cm INT
);


-- =====================================================
-- ORDER ITEMS  TABLE CREATION
-- =====================================================

CREATE TABLE staging.olist_order_items_dataset
(
order_id TEXT,
order_item_id INT,
product_id TEXT,
seller_id TEXT,
shipping_limit_date TIMESTAMP,
price NUMERIC,
freight_value NUMERIC
);


-- =====================================================
-- SELLERS TABLE CREATION
-- =====================================================

CREATE TABLE staging.olist_sellers_dataset
(
seller_id TEXT,
seller_zip_code_prefix INT,
seller_city TEXT,
seller_state TEXT
);

-- =====================================================
-- PAYMENTS : TABLE CREATION
-- =====================================================

CREATE TABLE staging.olist_order_payments_dataset
(
order_id TEXT,
payment_sequential INT,
payment_type TEXT,
payment_installments INT,
payment_value NUMERIC
);


-- =====================================================
-- REVIEWS : TABLE CREATION
-- =====================================================

CREATE TABLE staging.olist_order_reviews_dataset
(
review_id TEXT,
order_id TEXT,
review_score INT,
review_comment_title TEXT,
review_comment_message TEXT,
review_creation_date TIMESTAMP,
review_answer_timestamp TIMESTAMP
);


-- =====================================================
-- GEOLOCATION : TABLE CREATION
-- =====================================================

CREATE TABLE staging.olist_geolocation_dataset
(
geolocation_zip_code_prefix INT,
geolocation_lat NUMERIC,
geolocation_lng NUMERIC,
geolocation_city TEXT,
geolocation_state TEXT
);