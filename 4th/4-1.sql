-- ［リスト4-1-1］
SELECT
    user_id,
    CASE
        WHEN create_browser = 1 THEN 'IE'
        WHEN create_browser = 2 THEN 'SAFARI'
        WHEN create_browser = 3 THEN 'CHROME'
    END AS ブラウザ名
FROM
    user_browser
;
-- ［リスト4-1-2］単純CASE式でコード値をラベルに置き換える
SELECT
    user_id,
    CASE create_browser
        WHEN 1 THEN 'IE'
        WHEN 2 THEN 'SAFARI'
        WHEN 3 THEN 'CHROME'
END AS ブラウザ名
FROM
    user_browser
;
-- ［リスト4-1-3］
WITH qaurt_table AS(
    SELECT
        CURRENT_TIMESTAMP,
        EXTRACT(
            MONTH
            FROM
                CURRENT_TIMESTAMP
        ) AS MONTH
)
SELECT
    CURRENT_TIMESTAMP,
    CASE
        WHEN 1 <= MONTH
    AND MONTH <= 3 THEN '第1四半期'
        WHEN 4 <= MONTH
    AND MONTH <= 6 THEN '第2四半期'
        WHEN 7 <= MONTH
    AND MONTH <= 9 THEN '第3四半期'
        ELSE '第4四半期'
    END AS 四半期
FROM
    qaurt_table
;
-- ［リスト4-1-4］　MySQL
SELECT
    CAST('2019' AS UNSIGNED)
;
-- ［リスト4-1-5］
SELECT
    CAST(2019 AS CHAR)
;
-- -- ［リスト4-1-6］
-- PostgreSQL
-- SELECT
--     CAST('2019' AS INT)
-- ;
-- -- ［リスト4-1-7］
-- SELECT
--     CAST(2019 AS TEXT)
-- ;
-- ［リスト4-1-8］
SELECT
    purchase_id,
    price,
    coupon,
    price - coupon AS discount_price1,
    price - COALESCE(coupon, 0) AS discount_price2
FROM
    purchase_log_coupon
;
