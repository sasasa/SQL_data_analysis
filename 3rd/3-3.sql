-- 3-3
-- ［リスト3-3-1］
SELECT
    COUNT(DISTINCT item_name)
FROM
    item_purchase_log
;

-- ［リスト3-3-2］
SELECT
    item_category,
    COUNT(DISTINCT item_name)
FROM
    item_purchase_log
GROUP BY
    item_category
;

-- ［リスト3-3-3］
SELECT
    item_category,
    AVG(price) AS Heikin
FROM
    item_purchase_log
GROUP BY
    item_category
;
