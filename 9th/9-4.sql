-- ［リスト9-4-1］ 複数機能に対するユーザー行動集計をする
WITH
/* ① */
user_action AS(
    /* ① */
    SELECT
        user_id,
        SIGN(SUM(
                /* ①-(b) */
                CASE
                    WHEN action_category = 'tagging' THEN 1
                    ELSE 0
                END
                /* ①-(a) */
            )) AS has_tagging,
        SIGN(SUM(
                CASE
                    WHEN action_category = 'purchase' THEN 1
                    ELSE 0
                END
            )) AS has_purchase,
        SIGN(SUM(
                CASE
                    WHEN action_category = 'review' THEN 1
                    ELSE 0
                END
            )) AS has_review
    FROM
        action_log
    GROUP BY
        user_id
    ORDER BY
        user_id
),
action_diaglam AS(
    /* ①  */
    SELECT
        has_tagging,
        has_purchase,
        has_review,
        COUNT(*) AS user_count
    FROM
        user_action
    GROUP BY
        has_tagging,
        has_purchase,
        has_review
    -- 2 action
UNION ALL
SELECT
    NULL AS has_tagging,
    has_purchase,
    has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_purchase,
    has_review
UNION ALL
SELECT
    has_tagging,
    NULL AS has_purchase,
    has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_tagging,
    has_review
UNION ALL
SELECT
    has_tagging,
    has_purchase,
    NULL AS has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_tagging,
    has_purchase
-- 1action
UNION ALL
SELECT
    NULL AS has_tagging,
    NULL AS has_purchase,
    has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_review
UNION ALL
SELECT
    has_tagging,
    NULL AS has_purchase,
    NULL AS has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_tagging
UNION ALL
SELECT
    NULL AS has_tagging,
    has_purchase,
    NULL AS has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_purchase
-- all
UNION ALL
SELECT
    NULL AS has_tagging,
    NULL AS has_purchase,
    NULL AS has_review,
    COUNT(*) AS user_count
FROM
    user_action
)
SELECT
    /* ⑩ */
    CASE has_tagging
        /* ⑩-(a) */
        WHEN 1 THEN 'tagging'
        WHEN 0 THEN 'not tagging'
        ELSE 'all'
    END AS done_tagging,
    CASE has_purchase
        WHEN 1 THEN 'purchase'
        WHEN 0 THEN 'not purchase'
        ELSE 'all'
    END AS done_purchase,
    CASE has_review
        WHEN 1 THEN 'review'
        WHEN 0 THEN 'not review'
        ELSE 'all'
    END AS done_review,
    user_count,
    ROUND(100.0 * user_count / nullif(/* ⑩-(c) */
            SUM(
                CASE
                    WHEN has_tagging IS NULL
                /* ⑩-(b) */
            AND has_purchase IS NULL
            AND has_review IS NULL THEN user_count
                ELSE 0
            END
            ) over(), 0), 2) AS ratio
FROM
    action_diaglam
ORDER BY
    done_tagging,
    done_purchase,
    done_review
;
-- ［リスト9-4-2］ ユーザーごとのアクション有無
SELECT
    user_id,
    /* ①-(b) */
    -- SGIN関数で数値をまるめる
    SIGN(SUM(
            /* ①-(a) */
            -- CASE式で行動有無の判定
            CASE
                WHEN action_category = 'tagging' THEN 1
                ELSE 0
            END
        )) AS has_tagging,
    SIGN(SUM(
            CASE
                WHEN action_category = 'purchase' THEN 1
                ELSE 0
            END
        )) AS has_purchase,
    SIGN(SUM(
            CASE
                WHEN action_category = 'review' THEN 1
                ELSE 0
            END
        )) AS has_review
FROM
    action_history
GROUP BY
    user_id
ORDER BY
    user_id
;
-- ［リスト9-4-3］ 全てのアクションの組み合わせの集計
WITH user_action AS(
    /* ① */
    SELECT
        user_id,
        SIGN(SUM(
                /* ①-(b) */
                CASE
                    WHEN action_category = 'tagging' THEN 1
                    ELSE 0
                END
                /* ①-(a) */
            )) AS has_tagging,
        SIGN(SUM(
                CASE
                    WHEN action_category = 'purchase' THEN 1
                    ELSE 0
                END
            )) AS has_purchase,
        SIGN(SUM(
                CASE
                    WHEN action_category = 'review' THEN 1
                    ELSE 0
                END
            )) AS has_review
    FROM
        action_log
    GROUP BY
        user_id
    ORDER BY
        user_id
)
SELECT
    has_tagging,
    has_purchase,
    has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_tagging,
    has_purchase,
    has_review
-- 2 action
UNION ALL
SELECT
    NULL AS has_tagging,
    has_purchase,
    has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_purchase,
    has_review
UNION ALL
SELECT
    has_tagging,
    NULL AS has_purchase,
    has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_tagging,
    has_review
UNION ALL
SELECT
    has_tagging,
    has_purchase,
    NULL AS has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_tagging,
    has_purchase
-- 1action
UNION ALL
SELECT
    NULL AS has_tagging,
    NULL AS has_purchase,
    has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_review
UNION ALL
SELECT
    has_tagging,
    NULL AS has_purchase,
    NULL AS has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_tagging
UNION ALL
SELECT
    NULL AS has_tagging,
    has_purchase,
    NULL AS has_review,
    COUNT(*) AS user_count
FROM
    user_action
GROUP BY
    has_purchase
-- all
UNION ALL
SELECT
    NULL AS has_tagging,
    NULL AS has_purchase,
    NULL AS has_review,
    COUNT(*) AS user_count
FROM
    user_action
;

-- ［リスト9-4-4］集計したデータ整形をするクエリ

/* ⑩ */
-- 最後にデータを整形する
SELECT
    /* ⑩-(a) */
    -- CASE式でフラグから文字列への変換
    CASE has_tagging
        WHEN 1 THEN 'tagging'
        WHEN 0 THEN 'not tagging'
        ELSE 'all'
    END AS done_tagging,
    CASE has_purchase
        WHEN 1 THEN 'purchase'
        WHEN 0 THEN 'not purchase'
        ELSE 'all'
    END AS done_purchase,
    CASE has_review
        WHEN 1 THEN 'review'
        WHEN 0 THEN 'not review'
        ELSE 'all'
    END AS done_review,
    user_count,
    /* ⑩-(c) */
    -- NULLIF関数による集計
    ROUND(100.0 * user_count / NULLIF(
        /* ⑩-(b) */
        -- SUM関数(ウィンドウ関数)による集計
        SUM(
            CASE
                WHEN has_tagging IS NULL
                AND has_purchase IS NULL
                AND has_review IS NULL 
                THEN user_count
            ELSE 0
            END
        ) over(), 0), 2) AS ratio
FROM
    action_diaglam
ORDER BY
    done_tagging,
    done_purchase,
    done_review
;
-- ［リスト9-4-5］CUBE関数による方法
with/* ① */
user_action as (/* ② */

略

)
,action_diaglam as (/* ③ */
    SELECT
        has_tagging
        ,has_purchase
        ,has_review
        ,COUNT(*) as user_count
    FROM
        user_action
    GROUP BY CUBE(has_tagging, has_purchase, has_review) -- ③　
)
SELECT/* ⑩ */

略

;
