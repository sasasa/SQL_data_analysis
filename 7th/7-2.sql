
-- ［リスト7-2-1］ カテゴリごとに、ウィンドウを設定して購入金額合計を求める
SELECT
    item_name,
    item_category,
    price,
    SUM(price) OVER(PARTITION BY item_category) AS sum_category
FROM
    item_purchase_log
;

-- ［リスト7-2-2］ PARTITION BYを指定しない場合のウィンドウ関数
SELECT
    item_name,
    item_category,
    price,
    SUM(price) OVER() AS sum_all
FROM
    item_purchase_log
;
-- ［リスト7-2-3］ ORDER BYでウィンドウの順序付けを行う
SELECT
    item_name,
    item_category,
    price,
    RANK() OVER(ORDER BY price) AS ranking
FROM
    item_purchase_log
;
