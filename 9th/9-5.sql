-- ［リスト9-5-1］ ウィンドウ関数NTILE()による方法
SELECT
    store_id,
    sales,
    ntile(4) over(ORDER BY sales DESC) AS '四分位_window'
FROM
    store_sales
;
-- -- ［リスト9-5-xxx］ 結果比較用
-- SELECT
--     store_id,
--     sales,
--     ranking,
--     CASE
--         WHEN sa1.ranking <= 0.25 * (
--             -- ③ここから
--             SELECT
--                 COUNT(*)
--             FROM
--                 store_sales
--         ) THEN 1
--         -- ③ここまで
--         WHEN sa1.ranking <= 0.5 * (
--             SELECT
--                 COUNT(*)
--             FROM
--                 store_sales
--         ) THEN 2
--         WHEN sa1.ranking <= 0.75 * (
--             SELECT
--                 COUNT(*)
--             FROM
--                 store_sales
--         ) THEN 3
--         ELSE 4
--     END AS 四分位
-- FROM
--     -- ②ここから
--     (
--         SELECT
--             S1.store_id,
--             S1.sales,
--             -- ①ここから
--             (
--                 SELECT
--                     COUNT(S2.sales)
--                 FROM
--                     store_sales AS S2
--                 WHERE
--                     S2.sales >= S1.sales
--             ) ranking
--         -- ①ここまで
--         FROM
--             store_sales AS S1
--     ) sa1
-- -- ②ここまで
-- ORDER BY
--     ranking
-- ;

-- ［リスト9-5-2］ NTILE関数とRANK関数による算出
SELECT
    store_id,
    sales,
    rank() over(ORDER BY sales DESC) AS 'ranking_rank',
    ntile(4) over(ORDER BY sales DESC) AS '四分位_ntile'
FROM
    store_sales
;

-- ［リスト9-5-xxx］ 結果をならべて比較　用
SELECT
    store_id,
    sales,
    ranking,
    CASE
        WHEN sa1.ranking <= 0.25 * (
            -- ③ここから
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 1
        -- ③ここまで
        WHEN sa1.ranking <= 0.5 * (
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 2
        WHEN sa1.ranking <= 0.75 * (
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 3
        ELSE 4
    END AS 四分位,
    rank() over(ORDER BY sales DESC) AS 'ranking_rank',
    ntile(4) over(ORDER BY sales DESC) AS '四分位_ntile'
FROM
    -- ②ここから
    (
        SELECT
            S1.store_id,
            S1.sales,
            -- ①ここから
            (
                SELECT
                    COUNT(S2.sales)
                FROM
                    store_sales AS S2
                WHERE
                    S2.sales >= S1.sales
            ) ranking
        -- ①ここまで
        FROM
            store_sales AS S1
    ) sa1
-- ②ここまで
ORDER BY
    ranking
;
-- ［リスト9-5-4］ WITH句による整理
WITH sa1 AS
-- ②ここから
(
    SELECT
        S1.store_id,
        S1.sales,
        -- ①ここから
        (
            SELECT
                COUNT(S2.sales)
            FROM
                store_sales AS S2
            WHERE
                S2.sales >= S1.sales
        ) ranking
    -- ①ここまで
    FROM
        store_sales AS S1
)
SELECT
    store_id,
    sales,
    ranking,
    CASE
        WHEN sa1.ranking <= 0.25 * (
            -- ③ここから
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 1
        -- ③ここまで
        WHEN sa1.ranking <= 0.5 * (
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 2
        WHEN sa1.ranking <= 0.75 * (
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 3
        ELSE 4
    END AS 四分位,
    rank() over(ORDER BY sales DESC) AS 'ranking_rank',
    ntile(4) over(ORDER BY sales DESC) AS '四分位_window'
FROM
    sa1
;
-- ［リスト9-5-5］ ランキングをウィンドウ関数で求める
WITH sa1 AS
-- ②ここから
(
    SELECT
        store_id,
        sales,
        rank() over(ORDER BY sales DESC) AS 'ranking_rank'
    FROM
        store_sales
)
SELECT
    store_id,
    sales,
    ranking_rank,
    CASE
        WHEN ranking_rank <= 0.25 * (
            -- ③ここから
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 1
        -- ③ここまで
        WHEN ranking_rank <= 0.5 * (
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 2
        WHEN ranking_rank <= 0.75 * (
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 3
        ELSE 4
    END AS 四分位
FROM
    sa1
;

-- ［リスト9-5-6］ PERCENT_RANK関数を用いる
WITH sa1 AS
-- ②ここから
(
    SELECT
        store_id,
        sales,
        PERCENT_RANK() OVER(ORDER BY sales DESC) AS 'ranking_percent',
        CUME_DIST() OVER(ORDER BY sales DESC) AS 'ranking_cume'
    FROM
        store_sales
)
SELECT
    store_id,
    sales,
    ranking_percent,
    ranking_cume,
    CASE
        WHEN ranking_cume <= 0.25 * (
            -- ③ここから
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 1
        -- ③ここまで
        WHEN ranking_cume <= 0.5 * (
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 2
        WHEN ranking_cume <= 0.75 * (
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 3
        ELSE 4
    END AS 四分位_cume
FROM
    sa1
;
-- ［リスト9-5-7］ CUME_DIST関数によるランキング
WITH caunt_all AS(
    SELECT
        COUNT(*)
    FROM
        store_sales
),
sa1 AS
-- ②ここから
(
    SELECT
        store_id,
        sales,
        ((PERCENT_RANK() OVER(ORDER BY sales DESC)) * 10) AS 'ranking_percent',
        ((CUME_DIST() OVER(ORDER BY sales DESC)) * 10) AS 'ranking_cume'
    FROM
        store_sales
)
SELECT
    store_id,
    sales,
    ranking_percent,
    ranking_cume,
    CASE
        WHEN ranking_cume <= 0.25 * (
            -- ③ここから
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 1
        -- ③ここまで
        WHEN ranking_cume <= 0.5 * (
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 2
        WHEN ranking_cume <= 0.75 * (
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 3
        ELSE 4
    END AS 四分位_cume
FROM
    sa1
;
-- -- ［リスト9-5-8］ カウントのためのサブクエリもWITH句で整理、でエラー
-- -- Unknown column 'count_all' in 'field list'
-- WITH caunt_all AS(
--     SELECT
--         COUNT(*)
--     FROM
--         store_sales
-- ),
-- sa1 AS
-- -- ②ここから
-- (
--     SELECT
--         store_id,
--         sales,
--         rank() over(ORDER BY sales DESC) AS 'ranking_rank',
--         PERCENT_RANK() OVER(ORDER BY sales DESC) AS 'ranking_percent',
--         ((CUME_DIST() OVER(ORDER BY sales DESC)) * 10) AS 'ranking_cume'
--     FROM
--         store_sales
-- )
-- SELECT
--     store_id,
--     sales,
--     ranking_rank,
--     ranking_percent,
--     CASE
--         WHEN ranking_cume <= 0.25 * count_all THEN 1
--         -- ③ここまで
--         WHEN ranking_cume <= 0.5 * count_all THEN 2
--         WHEN ranking_cume <= 0.75 * count_all THEN 3
--         ELSE 4
--     END AS 四分位
-- FROM
--     sa1
-- ;
-- ［リスト9-5-9］ スカラサブクエリではなくテーブルとしてあつかう
WITH store_sales_count AS(
    SELECT
        COUNT(*)
    FROM
        store_sales
),
sa1 AS(
    SELECT
        store_id,
        sales,
        ((CUME_DIST() OVER(ORDER BY sales DESC)) * 10) AS 'ranking_cume',
        (
            SELECT
                *
            FROM
                store_sales_count
        ) AS count_all
    FROM
        store_sales
)
SELECT
    store_id,
    sales,
    ranking_cume,
    CASE
        WHEN ranking_cume <= 0.25 * count_all THEN 1
        WHEN ranking_cume <= 0.5 * count_all THEN 2
        WHEN ranking_cume <= 0.75 * count_all THEN 3
        ELSE 4
    END AS 四分位_cume
FROM
    sa1
;
-- ［リスト9-5-10］ 最終結果
WITH store_sales_count AS(
    SELECT
        COUNT(*)
    FROM
        store_sales
),
sa1 AS(
    SELECT
        store_id,
        sales,
        ((CUME_DIST() OVER(ORDER BY sales DESC)) * 10) AS 'ranking_cume',
        (
            SELECT
                *
            FROM
                store_sales_count
        ) AS count_all
    FROM
        store_sales
)
SELECT
    store_id,
    sales,
    ranking_cume as "ranking_改善後",
    CASE
        WHEN ranking_cume <= 0.25 * count_all THEN 1
        WHEN ranking_cume <= 0.5 * count_all THEN 2
        WHEN ranking_cume <= 0.75 * count_all THEN 3
        ELSE 4
    END AS 四分位_改善後
FROM
    sa1
;
-- ［リスト9-5-xxx］ 最終結果　並べる用
WITH store_sales_count AS(
    SELECT
        COUNT(*)
    FROM
        store_sales
),
sa1 AS
-- ②ここから
(
    SELECT
        S1.store_id,
        S1.sales,
        ((CUME_DIST() OVER(ORDER BY sales DESC)) * 10) AS 'ranking_cume',
        (
            SELECT
                *
            FROM
                store_sales_count
        ) AS count_all,
        -- ①ここから
        (
            SELECT
                COUNT(S2.sales)
            FROM
                store_sales AS S2
            WHERE
                S2.sales >= S1.sales
        ) ranking
    -- ①ここまで
    FROM
        store_sales AS S1
)
SELECT
    store_id,
    sales,
    ranking_cume as "ranking_改善後",
    CASE
        WHEN sa1.ranking <= 0.25 * count_all THEN 1
        -- ③ここまで
        WHEN sa1.ranking <= 0.5 * count_all THEN 2
        WHEN sa1.ranking <= 0.75 * count_all THEN 3
        ELSE 4
    END AS 四分位,
    CASE
        WHEN ranking_cume <= 0.25 * count_all THEN 1
        -- ③ここまで
        WHEN ranking_cume <= 0.5 * count_all THEN 2
        WHEN ranking_cume <= 0.75 * count_all THEN 3
        ELSE 4
    END AS 四分位_改善後
FROM
    sa1
    -- ②ここまで
;
