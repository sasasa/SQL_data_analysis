-- ［リスト7-1-1］ ウィンドウ関数のRANK関数の利用例
SELECT
    item_name,
    item_category,
    price,
    RANK() OVER(ORDER BY price) AS ranking
FROM
    item_purchase_log
;
-- ［リスト7-1-2］ ウィンドウ関数でフレーム句を用いる構文
SELECT
    item_category,
    action_date,
    price,
    AVG(price) OVER(
        PARTITION BY item_category 
        ORDER BY action_date 
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM
    item_purchase_log_date
;
-- ［リスト7-1-3］ ウインドウをWINDOW句で明記する
SELECT
    item_name,
    item_category,
    price,
    RANK() OVER W AS ranking
FROM
    item_purchase_log 
WINDOW W AS(ORDER BY price)
;
