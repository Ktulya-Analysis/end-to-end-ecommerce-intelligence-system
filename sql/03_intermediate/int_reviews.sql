-- =====================================================
-- INTERMEDIATE : REVIEWS
-- Purpose:
-- Create cleaned reviews dataset
-- with sentiment-oriented features
-- =====================================================

DROP TABLE IF EXISTS intermediate.int_reviews;


CREATE TABLE intermediate.int_reviews AS

SELECT

-- Review identifiers
review_id,
order_id,

-- Review score
review_score,

-- Review timestamps
review_creation_date,
review_answer_timestamp,

-- =====================================================
-- Standardized Review Text
-- =====================================================

LOWER(TRIM(review_comment_title))
AS review_comment_title,

LOWER(TRIM(review_comment_message))
AS review_comment_message,

-- =====================================================
-- Sentiment Classification
-- =====================================================

CASE

    WHEN review_score >= 4
    THEN 'positive'

    WHEN review_score = 3
    THEN 'neutral'

    ELSE 'negative'

END AS sentiment_category

FROM staging.olist_order_reviews_dataset;