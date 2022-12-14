-- ［リスト6-4-1］ 2つのテーブルを縦につなげる
SELECT
    "JPAN" AS エリア,
    user_id,
    user_name,
    email
FROM
    mst_user_jpn
UNION ALL
SELECT
    "USA" AS エリア,
    user_id,
    user_name,
    NULL AS email
FROM
    mst_user_us
;
-- ［リスト6-4-2］priceごとに商品数を数える
SELECT
    price,
    COUNT(item_name) AS item_name_count
FROM
    item_purchase_log
GROUP BY
    price
;
-- ［リスト6-4-3］ 合計行をつける
SELECT
    price,
    COUNT(item_name) AS item_name_count
FROM
    item_purchase_log
GROUP BY
    price
UNION ALL
SELECT
    SUM(price) AS price,
    COUNT(item_name) AS item_name_count
FROM
    item_purchase_log
;


-- ［リスト6-4-4］ 性別を表す疑似テーブルを作成する
WITH mock_sex AS(
    SELECT
        0 AS sex_code,
        "不明" AS sex_text
    UNION ALL
    SELECT
        1 AS sex_code,
        "男性" AS sex_text
    UNION ALL
    SELECT
        2 AS sex_code,
        "女性" AS sex_text
)
SELECT
    *
FROM
    mock_sex
;
