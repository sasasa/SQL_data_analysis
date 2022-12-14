-- ［リスト7-4-1］ 移動平均を求める
SELECT
    item_category,
    item_name,
    action_date,
    price,
    AVG(price) OVER(
        ORDER BY action_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM
    item_purchase_log_date
;
-- ［リスト7-4-2］ 行を指定しない場合は現在の行（CURRENT ROW）になる
SELECT
    item_category,
    item_name,
    action_date,
    price,
    AVG(price) OVER(
        ORDER BY action_date 
        ROWS 2 PRECEDING
    ) AS moving_avg
FROM
    item_purchase_log_date
;
-- ［リスト7-4-3 範囲をずらして移動平均を求める
SELECT
    item_category,
    item_name,
    action_date,
    price,
    AVG(price) OVER(
        ORDER BY
            action_date 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg
FROM
    item_purchase_log_date
;
-- ［リスト7-4-4］ 直近の最新のアクション日を求める
SELECT
    action_date AS current_action_date,
    MIN(action_date) OVER(
        ORDER BY
            action_date ASC 
        ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
    ) AS latest_date
FROM
    item_purchase_log_date
;
-- ［リスト7-4-5］ 直近の最新のアクション日とその時の価格を求める
SELECT
    action_date AS current_action_date,
    price AS current_price,
    MIN(action_date) OVER(
        ORDER BY
            action_date ASC 
        ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
    ) AS latest_date,
    MIN(price) OVER(
        ORDER BY
            action_date ASC 
        ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
    ) AS latest_price
FROM
    item_purchase_log_date
;
-- ［リスト7-4-6］ RANGEを用いて前日の日付と価格を求める
SELECT
    action_date AS current_action_date,
    price AS current_action_price,
    MIN(action_date) OVER(
        ORDER BY
            action_date ASC 
        RANGE 
            BETWEEN interval '1' day PRECEDING 
            AND interval '1' day PRECEDING
    ) AS day1_before,
    MIN(price) OVER(
        ORDER BY
            action_date ASC 
        RANGE 
            BETWEEN interval '1' day PRECEDING 
            AND interval '1' day PRECEDING
    ) AS price_day1_before
FROM
    item_purchase_log_date
;
