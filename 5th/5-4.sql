-- ［リスト5-4-1］ 日別で延べユーザーアクション数を求める
SELECT
    action_date AS 日付,
    COUNT(user_id) AS アクション数
FROM
    simple_log
GROUP BY
    action_date
ORDER BY
    action_date
;
-- ［リスト5-4-2］ 日別でユニークユーザー数を求める
SELECT
    action_date AS 日付,
    COUNT(DISTINCT(user_id)) AS ユニークユーザー数
FROM
    simple_log
GROUP BY
    action_date
ORDER BY
    action_date
;
-- ［リスト5-4-3］ 日別で新規登録数を求める
SELECT
    first_action_date AS 新規登録日,
    COUNT(user_id) AS 新規ユーザー数
FROM
    (
        SELECT
            user_id,
            MIN(action_date) AS first_action_date
        FROM
            simple_log
        GROUP BY
            user_id
    ) AS t
GROUP BY
    first_action_date
ORDER BY
    first_action_date
;
-- ［リスト5-4-4］ ユーザーの継続期間を求める
SELECT
    action_term 継続期間,
    COUNT(user_id) AS ユニークユーザー数
FROM
    (
        SELECT
            user_id,
            DATEDIFF(MAX(action_date), MIN(action_date)) AS action_term
            -- PostgreSQL
            -- MAX(action_date) - MIN(action_date) AS action_term
            
        FROM
            simple_log
        GROUP BY
            user_id
    ) AS t
GROUP BY
    action_term
ORDER BY
    action_term
;
-- ［リスト5-4-5］ アクション数が3回以上のユーザーリスト
SELECT
    user_id,
    action_count AS アクション数
FROM
    (
        SELECT
            user_id,
            COUNT(user_id) AS action_count
        FROM
            simple_log
        GROUP BY
            user_id
    ) AS t
WHERE
    action_count >= 3
;
-- ［リスト5-4-6］ 直近7日間でアクション数が3回以上のユーザーリスト
SELECT
    user_id,
    action_count AS アクション数
FROM
    (
        SELECT
            user_id,
            COUNT(user_id) AS action_count
        FROM
            simple_log
        WHERE
            DATEDIFF('2019-06-8', action_date) <= 7
            -- PostgreSQL
            -- '2019-06-8' - action_date <= 7
        GROUP BY
            user_id
    ) AS t
WHERE
    action_count >= 3
;
