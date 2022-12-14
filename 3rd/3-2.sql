-- ［リスト3-2-1］
SELECT DISTINCT item_category
FROM item_purchase_log
;
-- ［リスト3-2-2］
SELECT
    item_name,
    item_category
FROM
    item_purchase_log
WHERE
    item_category = 'food'
;
-- ［リスト3-2-3］
SELECT
    item_name,
    item_category
FROM
    item_purchase_log
WHERE
    item_category != 'food'
;

-- ［リスト3-2-4］
SELECT
    item_name,
    item_category
FROM
    item_purchase_log
WHERE
    item_category IN( 'food',  'zakka')
;

-- ［リスト3-2-5］
SELECT
    item_name,
    item_category
FROM
    item_purchase_log
WHERE
    item_category = 'food' OR item_category = 'zakka'
;

-- ［リスト3-2-6］
SELECT
    item_name,
    item_category
FROM
    item_purchase_log
WHERE
    item_category LIKE 'f%'
;

-- ［リスト3-2-7］
SELECT
    item_name,
    item_category
FROM
    item_purchase_log
WHERE
    item_category LIKE 'f___'
;
