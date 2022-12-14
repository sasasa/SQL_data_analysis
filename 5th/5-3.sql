-- ［リスト5-3-1］平均/最大値/最小値を求める
SELECT
    AVG(sales),
    MAX(sales),
    MIN(sales)
FROM
    store_sales
;
 -- ［リスト5-3-2］ HAVING句とMAX関数で最頻値を求める
SELECT
    sales
FROM
    store_sales
GROUP BY
    sales
HAVING COUNT(*) >= ( -- 2
    SELECT
        MAX(group_count)
    FROM
        ( -- 1
            SELECT
                COUNT(*) AS group_count
            FROM
                store_sales
            GROUP BY
                sales
        ) AS sq　 -- 1/
)-- 2/
;
-- ［リスト5-3-3］ HAVING句で中央値を求める
SELECT
    AVG(DISTINCT sales)
FROM
    (
        SELECT
            sa1.sales
        FROM
            store_sales sa1,
            store_sales sa2
        GROUP BY
            sa1.sales
        HAVING 
            SUM(
                CASE
                    WHEN sa2.sales >= sa1.sales THEN 1
                    ELSE 0
                END
            ) >= COUNT(*) / 2
            AND SUM(
                    CASE
                        WHEN sa2.sales <= sa1.sales THEN 1
                        ELSE 0
                    END
            ) >= COUNT(*) / 2
    ) AS sq
;
-- ［リスト5-3-4］ SQLで四分位
SELECT
    store_id,
    sales,
    ranking,
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
    (
        SELECT
            S1.store_id,
            S1.sales,
            (
                SELECT
                    COUNT(S2.sales)
                FROM
                    store_sales AS S2
                WHERE
                    S2.sales >= S1.sales
            ) ranking
        FROM
            store_sales AS S1
    ) sa1
;
-- ［リスト5-3-5］ 分散を求める
SELECT
    ((COUNT(*) * SUM(sales * sales)) - (SUM(sales) * SUM(sales))) / (COUNT(*) * (COUNT(*) - 1)) AS variance
FROM
    store_sales
;
