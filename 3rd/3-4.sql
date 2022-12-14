-- 3-4
-- ［リスト3-4-1］
SELECT
    item_category,
    COUNT(DISTINCT item_name) AS item_name_count
FROM 
    item_purchase_log
GROUP BY
    item_category
HAVING COUNT(DISTINCT item_name) >= 2
;

-- ［リスト3-4-2］
SELECT
    user_id,
    COUNT(item_name) AS item_name_count
FROM 
    item_purchase_log
WHERE
    user_id='UID0001'
GROUP BY
    user_id
;

-- ［リスト3-4-3］
SELECT
    user_id,
    COUNT(item_name) AS item_name_count
FROM 
    item_purchase_log
GROUP BY
    user_id
HAVING
    user_id='UID0001'
;
