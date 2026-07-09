-- =====================================================
-- INTERMEDIATE : CUSTOMERS
-- Purpose:
-- Create cleaned customer dataset
-- with standardized geographic values
-- =====================================================

DROP TABLE IF EXISTS intermediate.int_customers;


CREATE TABLE intermediate.int_customers AS

SELECT

-- Customer identifiers
customer_id,
customer_unique_id,

-- ZIP code
customer_zip_code_prefix,

-- Standardized city names
LOWER(
    TRIM(
        TRANSLATE(
            customer_city,
            'áàâãäéèêëíìîïóòôõöúùûüç',
            'aaaaaeeeeiiiiooooouuuuc'
        )
    )
) AS customer_city,

-- State
customer_state

FROM staging.olist_customers_dataset;