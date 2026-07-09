-- =====================================================
-- INTERMEDIATE : PAYMENTS
-- Purpose:
-- Create cleaned payments dataset
-- with analytics-ready payment features
-- =====================================================

DROP TABLE IF EXISTS intermediate.int_payments;


CREATE TABLE intermediate.int_payments AS

SELECT

-- Order linkage
order_id,

-- Payment sequencing
payment_sequential,

-- Standardized payment type
LOWER(TRIM(payment_type)) AS payment_type,

-- Installments
payment_installments,

-- Payment value
payment_value,

-- =====================================================
-- Derived Business Features
-- =====================================================

-- Installment category
CASE

    WHEN payment_installments = 1
    THEN 'single_payment'

    WHEN payment_installments BETWEEN 2 AND 6
    THEN 'medium_installments'

    ELSE 'high_installments'

END AS installment_category,

-- High-value payment flag
CASE

    WHEN payment_value >= 500
    THEN 'high_value'

    ELSE 'regular_value'

END AS payment_value_segment



-- Payment method grouping
CASE

    WHEN payment_type = 'credit_card'
    THEN 'Card'

    WHEN payment_type = 'boleto'
    THEN 'Boleto'

    WHEN payment_type = 'voucher'
    THEN 'Voucher'

    ELSE 'Other'

END AS payment_method_group

FROM staging.olist_order_payments_dataset;


SELECT
installment_category,
COUNT(*) AS total_payments
FROM intermediate.int_payments
GROUP BY installment_category
ORDER BY total_payments DESC;


-- =====================================================
-- installment_category
-- =====================================================

-- single_payment:
-- Customer paid full amount immediately.
-- Usually indicates lower financing dependency
-- and potentially stronger immediate purchasing power.


-- medium_installments:  (2 or 6)
-- Customer used moderate financing.
-- Indicates balanced payment flexibility behavior.


-- high_installments: ( 7 or more)
-- Customer heavily financed the purchase.
-- May indicate:
-- higher product affordability pressure,
-- expensive purchases,
-- or preference for long-term installment plans.

-- =====================================================
-- payment_value_segment
-- =====================================================

-- regular_value:
-- Standard transaction amount.
-- Represents normal day-to-day customer purchases.


-- high_value:
-- High-spending transaction category.
-- Useful for:
-- premium customer analysis,
-- revenue concentration studies,
-- and high-value customer segmentation.