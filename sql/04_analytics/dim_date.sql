-- =====================================================
-- DIMENSION TABLE : DIM DATE
--
-- Purpose:
-- Central calendar dimension supporting
-- sales, customer, seller, payment,
-- delivery and future analytics.
--
-- Enterprise Approach:
-- Reusable calendar dimension
-- independent of any single fact table.
-- =====================================================

DROP TABLE IF EXISTS analytics.dim_date;

CREATE TABLE analytics.dim_date AS

SELECT

    calendar_date AS date_key,

    EXTRACT(YEAR FROM calendar_date)
    AS year,

    EXTRACT(QUARTER FROM calendar_date)
    AS quarter,

    EXTRACT(MONTH FROM calendar_date)
    AS month,

    TO_CHAR(calendar_date, 'Month')
    AS month_name,

    EXTRACT(DAY FROM calendar_date)
    AS day,

    TO_CHAR(calendar_date, 'Day')
    AS weekday_name,

    CASE

        WHEN EXTRACT(ISODOW FROM calendar_date)
             IN (6,7)
        THEN 'Weekend'

        ELSE 'Weekday'

    END AS day_type

FROM (

    SELECT

        generate_series(
            DATE '2016-01-01',
            DATE '2020-12-31',
            INTERVAL '1 day'
        )::DATE AS calendar_date

) d;