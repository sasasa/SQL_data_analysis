-- ［リスト8-4-1］ テーブル全体をLIMITつきで把握
SELECT
    *
FROM
    item_purchase_anlytics
LIMIT 10
;
-- ［リスト8-4-2］ 集約関数によるテーブル全体の把握
SELECT
    COUNT(action_date) AS 日付カウント,
    SUM(price) AS 料金合計
FROM
    item_purchase_anlytics
;
-- ［リスト8-4-3］ 集約関数とグループ化を組み合わせる
SELECT
    user_id,
    COUNT(action_date) AS frequency,
    SUM(price) AS monetary
FROM
    item_purchase_anlytics
GROUP BY
    user_id
;
-- ［リスト8-4-4］ 購買頻度と直近の購買日を求める
SELECT
    user_id,
    MAX(action_date),
    COUNT(action_date) AS frequency
FROM
    item_purchase_anlytics
GROUP BY
    user_id
;
-- ［リスト8-4-5］ 直近の購買日と基準日を使った値の数値化
SELECT
    user_id,
    '2019/05/01' AS benchmark_date,
    MAX(action_date) AS recent_date,
    DATEDIFF('2019/05/01', MAX(action_date)) AS recency,
    -- PostgreSQL
    -- ('2019/05/01' - MAX(action_date)) AS recency,
    COUNT(action_date) AS frequency
FROM
    item_purchase_anlytics
GROUP BY
    user_id
;
-- ［リスト8-4-6］ ウィンドウ関数で2つの購買指標をランク付けするクエリ　
SELECT
    user_id,
    recency,
    frequency,
    NTILE(3) OVER(ORDER BY recency DESC) AS recency_rank,
    NTILE(3) OVER(ORDER BY frequency) AS frequency_rank
FROM
    (
        SELECT
            user_id,
            DATEDIFF('2019/05/01', MAX(action_date)) AS recency,
            -- PostgreSQL
            -- ('2019/05/01' - MAX(action_date)) AS recency,
            COUNT(action_date) AS frequency
        FROM
            item_purchase_anlytics
        GROUP BY
            user_id
    ) AS user_rfm
ORDER BY
    user_id
;
-- ［リスト8-4-7］ CASE式で2つの購買指標をランク付けするクエリ　
SELECT
    user_id,
    recency,
    frequency,
    CASE
        WHEN recency < 19 THEN 3
        WHEN recency < 26 THEN 2
        ELSE 1
    END AS recency_rank,
    CASE
        WHEN frequency >= 10 THEN 3
        WHEN frequency >= 5 THEN 2
        WHEN frequency >= 1 THEN 1
    END AS frequency_rank
FROM
    (
        SELECT
            user_id,
            DATEDIFF('2019/05/01', MAX(action_date)) AS recency,
            -- PostgreSQL
            -- ('2019/05/01' - MAX(action_date)) AS recency,
            COUNT(action_date) AS frequency
        FROM
            item_purchase_anlytics
        GROUP BY
            user_id
    ) AS user_rfm
ORDER BY
    user_id
;
-- ［リスト8−4-8］ 2つの指標をクロス集計する
WITH user_rank_table AS(
    SELECT
        user_id,
        recency,
        frequency,
        CASE
            WHEN recency < 19 THEN 3
            WHEN recency < 26 THEN 2
            ELSE 1
        END AS recency_rank,
        CASE
            WHEN frequency >= 10 THEN 3
            WHEN frequency >= 5 THEN 2
            WHEN frequency >= 1 THEN 1
        END AS frequency_rank
    FROM
        (
            SELECT
                user_id,
                DATEDIFF('2019/05/01', MAX(action_date)) AS recency,
                -- PostgreSQL
                -- ('2019/05/01' - MAX(action_date)) AS recency,
                COUNT(action_date) AS frequency
            FROM
                item_purchase_anlytics
            GROUP BY
                user_id
        ) AS user_rfm
)
SELECT
    concat('r_', recency_rank) AS ranks,
    /*①*/
    COUNT(
        CASE
            WHEN frequency_rank = 3 THEN 1
        END
    ) AS f_3,
    COUNT(
        CASE
            WHEN frequency_rank = 2 THEN 1
        END
    ) AS f_2,
    COUNT(
        CASE
            WHEN frequency_rank = 1 THEN 1
        END
    ) AS f_1
FROM
    user_rank_table
GROUP BY
    recency_rank
ORDER BY
    ranks DESC
;
