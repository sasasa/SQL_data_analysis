-- ［リスト7-3-1］ ウィンドウ関数専用の関数で順序をあつかう
SELECT
    item_name,
    item_category,
    price,
    RANK() OVER(ORDER BY price) AS ranking,
    DENSE_RANK() OVER(ORDER BY price) AS dense_ranking,
    ROW_NUMBER() OVER(ORDER BY price) AS row_num
FROM
    item_purchase_log
;
-- ［リスト7-3-2］ ウィンドウ関数としての働きを確認するクエリ
SELECT
    item_name,
    item_category,
    price,
    AVG(price) OVER() AS avg,
    SUM(price) OVER() AS sum,
    COUNT(price) OVER() AS count,
    MAX(price) OVER() AS max
FROM
    item_purchase_log
ORDER BY 
    price
;
