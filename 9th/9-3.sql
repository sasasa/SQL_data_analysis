-- ［リスト9-3-1］ バスケット分析のクエリ
-- ③ここから
-- 「商品が同時に購入される頻度を算出する」
SELECT
    combi_count.item_name,
    combi_count.item_name2,
    -- 信頼度を求める
    CAST(combi_count.order_count AS UNSIGNED) / item_count.order_count AS confidence
FROM
    -- ②ここから
    -- 「商品ごとの購入回数」を求める
    (
        SELECT
            item_name,
            COUNT(DISTINCT sales_date) AS order_count
        FROM
            sales_log
        GROUP BY
            item_name
    ) item_count
    -- ②ここまで
    INNER JOIN
        -- ①ここから
        -- 「商品の組み合わせと購入回数」を求める
        (
            SELECT
                shl.item_name,
                shr.item_name AS item_name2,
                COUNT(DISTINCT shl.sales_date) AS order_count
            FROM
                sales_log AS shl
                INNER JOIN
                    sales_log shr
                ON  shl.sales_date = shr.sales_date
                AND shl.item_name <> shr.item_name
            GROUP BY
                shl.item_name,
                shr.item_name
        ) combi_count
    -- ①　ここまで
ON  combi_count.item_name = item_count.item_name
 -- ③ここまで
;
-- ［リスト9-3-2］ 商品の組み合わせと購入回数のクエリ
SELECT
    shl.item_name,
    shr.item_name AS item_name2,
    COUNT(DISTINCT shl.sales_date) AS order_count
-- (a)
FROM
    sales_log AS shl
INNER JOIN
    sales_log shr
ON  shl.sales_date = shr.sales_date
AND shl.item_name <> shr.item_name
-- (b)
GROUP BY
    shl.item_name,
    shr.item_name
;
-- ［リスト9-3-3］ 信頼度を求める
SELECT
    item_name,
    COUNT(DISTINCT sales_date) AS order_count
FROM
    sales_log
GROUP BY
    item_name

;
-- ［リスト9-3-4］ バスケット分析のクエリ
--  ③ここから
-- 「商品が同時に購入される頻度を算出する」
SELECT
    combi_count.item_name,
    combi_count.item_name2,
    -- 信頼度を求める
    CAST(combi_count.order_count AS UNSIGNED) / item_count.order_count AS confidence
FROM
    -- ②
    INNER JOIN
        -- ①
ON  combi_count.item_name = item_count.item_name
 -- ③ここまで
;

-- ［リスト9-3-5］ 2つのサブクエリのJOIN結果の確認
SELECT
    *
FROM
    (
        -- ②ここから
        /*②*/
        SELECT
            item_name,
            COUNT(DISTINCT sales_date) AS order_count
        FROM
            sales_log
        GROUP BY
            item_name
    ) item_count
    -- ②ここまで
JOIN
    (
        -- ①ここから
        -- 商品の組み合わせと購入回数
        SELECT
            shl.item_name,
            shr.item_name AS item_name2,
            COUNT(DISTINCT shl.sales_date) AS order_count
        FROM
            sales_log AS shl
            /*①-(a)*/
            INNER JOIN
                sales_log shr
            ON  shl.sales_date = shr.sales_date
            AND shl.item_name <> shr.item_name
        /*①-(b)*/
        GROUP BY
            shl.item_name,
            shr.item_name
    ) combi_count
ON  combi_count.item_name = item_count.item_name
;
