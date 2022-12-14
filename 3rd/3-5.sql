-- 3-5
-- ［リスト3-5-1］
SELECT *
FROM
    item_purchase_log
ORDER BY
    user_id
;

-- ［リスト3-5-2］
SELECT *
FROM
    item_purchase_log
ORDER BY
    user_id,
    price
;
-- ［リスト3-5-3］
SELECT
    action_date,
    COUNT(DISTINCT item_name)
FROM
    item_purchase_log
GROUP BY
    action_date
ORDER BY
    action_date DESC
;

-- ［リスト3-5-4］
SELECT
    action_date,
    COUNT(DISTINCT item_name)
FROM
    item_purchase_log
GROUP BY
    action_date
ORDER BY
    COUNT(DISTINCT item_name) DESC
;

-- ［リスト3-5-5］
SELECT *
FROM
    item_purchase_log
;

-- ［リスト3-5-6］
SELECT *
FROM
    item_purchase_log
LIMIT 5
;
