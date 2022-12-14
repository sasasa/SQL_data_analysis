-- ［リスト9-2-1］ 四分位を求めるクエリを読む
 -- ③ここから
SELECT
    store_id,
    sales,
    ranking,
    -- CASE式にて四分位に振り分ける
    CASE
        WHEN sa1.ranking <= 0.25 * (
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 1 
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
    END AS 四分位
FROM
 -- ②ここから
 -- 相関サブクエリと組み合わせてランキングを算出する
    (
        SELECT
            S1.store_id,
            S1.sales,
             -- ①ここから
             -- 自分以上の売上の店舗数をかぞえる相関サブクエリ
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
     -- ③ここまで
;
-- ［リスト9-2-2］ 自分以上の売上の店舗数をかぞえる
SELECT
    COUNT(S2.sales) -- (b)
FROM
    store_sales AS S2
WHERE
    S2.sales >= S1.sales -- (a)
;
-- ［リスト9-2-3］ 相関サブクエリと組み合わせてランキングを算出するクエリ
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
    store_sales AS S1 -- (a)
;
-- ［リスト9-2-4］全体の数を数えるスカラサブクエリ
SELECT
    COUNT(*)
FROM
    store_sales
;
-- ［リスト9-2-5］ 一番外側のクエリを読む
-- ③ここから
SELECT
    store_id,
    sales,
    ranking,
    -- CASE式にて四分位に振り分ける
    CASE
        WHEN sa1.ranking <= 0.25 * ( 
            SELECT
                COUNT(*)
            FROM
                store_sales
        ) THEN 1 
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
    END AS 四分位
FROM
 -- ②ここから
    (
-- ［リスト9-2-3］
    ) sa1
     -- ②ここまで
     -- ③ここまで
;
