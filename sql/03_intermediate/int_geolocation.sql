-- =====================================================
-- INTERMEDIATE : GEOLOCATION
-- Purpose:
-- Create cleaned geolocation dataset
-- with standardized city values
-- =====================================================

DROP TABLE IF EXISTS intermediate.int_geolocation;


CREATE TABLE intermediate.int_geolocation AS

SELECT

-- Geographic identifiers
geolocation_zip_code_prefix,

-- Coordinates
geolocation_lat,
geolocation_lng,

-- Standardized city names
LOWER(
    TRIM(
        TRANSLATE(
            geolocation_city,
            'áàâãäéèêëíìîïóòôõöúùûüç',
            'aaaaaeeeeiiiiooooouuuuc'
        )
    )
) AS geolocation_city,

-- State
geolocation_state

FROM staging.olist_geolocation_dataset;