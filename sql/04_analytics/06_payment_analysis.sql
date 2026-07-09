-- =====================================================
-- PAYMENT ANALYSIS
--
-- Business Problem:
-- Payment Behavior Analysis
--
-- Objective:
-- Understand how customers pay,
-- installment usage,
-- and payment value patterns.
-- =====================================================



-- =====================================================
-- KPI 1
-- TOTAL PAYMENT VALUE
--
-- Business Question:
-- What is the total payment value
-- processed by the marketplace?
--
-- Purpose:
-- Measure overall payment volume.
-- =====================================================

SELECT

    ROUND(
        SUM(payment_value),
        2
    ) AS total_payment_value

FROM intermediate.int_payments;

-- =====================================================
-- KPI 2
-- PAYMENT METHOD DISTRIBUTION
--
-- Business Question:
-- Which payment methods are
-- most commonly used?
--
-- Purpose:
-- Understand customer payment
-- preferences.
-- =====================================================

SELECT

    payment_method_group,

    COUNT(*) AS total_payments,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM intermediate.int_payments

GROUP BY payment_method_group

ORDER BY total_payments DESC;

-- =====================================================
-- KPI 3
-- INSTALLMENT DISTRIBUTION
--
-- Business Question:
-- How dependent are customers
-- on installment payments?
--
-- Purpose:
-- Understand financing behavior
-- and affordability patterns.
-- =====================================================

SELECT

    installment_category,

    COUNT(*) AS total_payments,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM intermediate.int_payments

GROUP BY installment_category

ORDER BY total_payments DESC;


-- =====================================================
-- KPI 4
-- HIGH VALUE PAYMENT DISTRIBUTION
--
-- Business Question:
-- How many transactions are
-- high-value purchases?
--
-- Purpose:
-- Identify premium spending behavior.
-- =====================================================

SELECT

    payment_value_segment,

    COUNT(*) AS total_payments,

    ROUND(
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM intermediate.int_payments

GROUP BY payment_value_segment

ORDER BY total_payments DESC;


-- =====================================================
-- KPI 5
-- AVERAGE INSTALLMENTS
--
-- Business Question:
-- How many installments are used
-- on average per payment?
--
-- Purpose:
-- Measure overall financing dependency.
-- =====================================================

SELECT

    MAX(payment_installments)
    AS max_installments,

    ROUND(
        AVG(payment_installments),
        2
    ) AS avg_installments

FROM intermediate.int_payments;