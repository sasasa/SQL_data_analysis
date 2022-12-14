-- ［リスト8−5-1］ 料金を追加し全体の把握
SELECT
    DATEDIFF('2019/05/01', MAX(action_date)) AS recency,
    -- PostgreSQL
    -- ('2019/05/01' - MAX(action_date)) AS recency,
    COUNT(action_date) AS frequency,
    SUM(price) AS monetary
FROM
    item_purchase_anlytics
;
-- ［リスト8−5-2］ ユーザーごとで求める
SELECT
    user_id,
    DATEDIFF('2019/05/01', MAX(action_date)) AS recency,
    -- PostgreSQL
    -- ('2019/05/01' - MAX(action_date)) AS recency,
    COUNT(action_date) AS frequency,
    SUM(price) AS monetary
FROM
    item_purchase_anlytics
GROUP BY
    user_id
;
-- ［リスト8−5-3］3指標のランクを求める
SELECT
    user_id,
    recency,
    frequency,
    monetary,
    CASE
        WHEN recency < 19 THEN 3
        WHEN recency < 26 THEN 2
        ELSE 1
    END AS r_rank,
    CASE
        WHEN frequency >= 10 THEN 3
        WHEN frequency >= 5 THEN 2
        WHEN frequency >= 1 THEN 1
    END AS f_rank,
    CASE
        WHEN monetary >= 50 THEN 3
        WHEN monetary >= 10 THEN 2
        ELSE 1
    END AS m_rank
FROM
    (
        SELECT
            user_id,
            DATEDIFF('2019/05/01', MAX(action_date)) AS recency,
            -- PostgreSQL
            -- ('2019/05/01' - MAX(action_date)) AS recency,
            COUNT(action_date) AS frequency,
            SUM(price) AS monetary
        FROM
            item_purchase_anlytics
        GROUP BY
            user_id
    ) AS user_rfm
;
-- ［リスト8−5-4］CASE式のしきい値を微調整
SELECT
    user_id,
    recency,
    frequency,
    monetary,
    CASE
        WHEN recency < 19 THEN 3
        WHEN recency < 26 THEN 2
        ELSE 1
    END AS r_rank,
    CASE
        WHEN frequency >= 10 THEN 3
        WHEN frequency >= 5 THEN 2
        WHEN frequency >= 1 THEN 1
    END AS f_rank,
    CASE
        WHEN monetary >= 5000 THEN 3
        WHEN monetary >= 1000 THEN 2
        ELSE 1
    END AS m_rank
FROM
    (
        SELECT
            user_id,
            DATEDIFF('2019/05/01', MAX(action_date)) AS recency,
            -- PostgreSQL
            -- ('2019/05/01' - MAX(action_date)) AS recency,
            COUNT(action_date) AS frequency,
            SUM(price) AS monetary
        FROM
            item_purchase_anlytics
        GROUP BY
            user_id
    ) AS user_rfm
;
-- ［リスト8−5-5］ 連番テーブルの作成
SELECT
    1 AS rfm_index
UNION ALL
SELECT
    2 AS rfm_index
UNION ALL
SELECT
    3 AS rfm_index
;
-- ［リスト8−5-6］ RFM分析　RANK2
WITH user_rank_table AS(
    SELECT
        user_id,
        recency,
        frequency,
        monetary,
        CASE
            WHEN recency < 19 THEN 3
            WHEN recency < 26 THEN 2
            ELSE 1
        END AS r_rank,
        CASE
            WHEN frequency >= 10 THEN 3
            WHEN frequency >= 5 THEN 2
            WHEN frequency >= 1 THEN 1
        END AS f_rank,
        CASE
            WHEN monetary >= 5000 THEN 3
            WHEN monetary >= 1000 THEN 2
            ELSE 1
        END AS m_rank
    FROM
        (
            SELECT
                user_id,
                DATEDIFF('2019/05/01', MAX(action_date)) AS recency,
                -- PostgreSQL
                -- ('2019/05/01' - MAX(action_date)) AS recency,
                COUNT(action_date) AS frequency,
                SUM(price) AS monetary
            FROM
                item_purchase_anlytics
            GROUP BY
                user_id
        ) AS user_rfm
),
index_table AS(
    SELECT
        1 AS rfm_index
    UNION ALL
    SELECT
        2 AS rfm_index
    UNION ALL
    SELECT
        3 AS rfm_index
)
SELECT
    index_table.rfm_index,
    CASE
        WHEN index_table.rfm_index = user_rank_table.r_rank THEN 1
        ELSE 0
    END AS r_flag,
    CASE
        WHEN index_table.rfm_index = user_rank_table.f_rank THEN 1
        ELSE 0
    END AS f_flag,
    CASE
        WHEN index_table.rfm_index = user_rank_table.m_rank THEN 1
        ELSE 0
    END AS m_flag
FROM
    index_table CROSS
    JOIN
        user_rank_table
;
-- ［リスト8−5-7］ 3指標の集計値を求める
WITH user_rank_table AS(
    SELECT
        user_id,
        recency,
        frequency,
        monetary,
        CASE
            WHEN recency < 19 THEN 3
            WHEN recency < 26 THEN 2
            ELSE 1
        END AS r_rank,
        CASE
            WHEN frequency >= 10 THEN 3
            WHEN frequency >= 5 THEN 2
            WHEN frequency >= 1 THEN 1
        END AS f_rank,
        CASE
            WHEN monetary >= 5000 THEN 3
            WHEN monetary >= 1000 THEN 2
            ELSE 1
        END AS m_rank
    FROM
        (
            SELECT
                user_id,
                DATEDIFF('2019/05/01', MAX(action_date)) AS recency,
                -- PostgreSQL
                -- ('2019/05/01' - MAX(action_date)) AS recency,
                COUNT(action_date) AS frequency,
                SUM(price) AS monetary
            FROM
                item_purchase_anlytics
            GROUP BY
                user_id
        ) AS user_rfm
),
index_table AS(
    SELECT
        1 AS rfm_index
    UNION ALL
    SELECT
        2 AS rfm_index
    UNION ALL
    SELECT
        3 AS rfm_index
),
rfm_flag AS(
    SELECT
        index_table.rfm_index,
        CASE
            WHEN index_table.rfm_index = user_rank_table.r_rank THEN 1
            ELSE 0
        END AS r_flag,
        CASE
            WHEN index_table.rfm_index = user_rank_table.f_rank THEN 1
            ELSE 0
        END AS f_flag,
        CASE
            WHEN index_table.rfm_index = user_rank_table.m_rank THEN 1
            ELSE 0
        END AS m_flag
    FROM
        index_table CROSS
        JOIN
            user_rank_table
)
SELECT
    rfm_index AS rfm_rank,
    SUM(r_flag) AS r_sum,
    SUM(f_flag) AS f_sum,
    SUM(m_flag) AS m_sum
FROM
    rfm_flag
GROUP BY
    rfm_index
ORDER BY
    rfm_index DESC
;
