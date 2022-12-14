-- ［リスト8−3-1］ クロス集計のクエリ
WITH count_tmp AS( -- 1/
    SELECT
        sex,
        user_place,
        COUNT(user_id) AS user_count
    FROM
        master_customer
    GROUP BY
        user_place,
        sex
    ORDER BY
        user_place DESC
),
tmp AS( -- 2/
    SELECT
        *,
        ROW_NUMBER() OVER(
            PARTITION BY sex
            ORDER BY user_place
        ) AS sequence
    FROM
        count_tmp
)
SELECT -- 3/
    sex,
    MAX(CASE sequence WHEN 1 THEN user_count ELSE NULL END) AS Kanagawa,
    MAX(CASE sequence WHEN 2 THEN user_count ELSE NULL END) AS Osaka,
    MAX(CASE sequence WHEN 3 THEN user_count ELSE NULL END) AS Tokyo
FROM
    tmp
GROUP BY
    sex
;
-- ［リスト8−3-2］ 性別・地域ごとのユーザー数を求める
SELECT
    sex,
    user_place,
    COUNT(user_id) AS user_count -- 1/
FROM
    master_customer
GROUP BY
    user_place,
    sex -- 2/
ORDER BY
    user_place DESC
;
-- ［リスト8−3-3］ 地域に連番を付与するためのクエリ
SELECT
    *,
    ROW_NUMBER() OVER(
        PARTITION BY sex
        ORDER BY user_place -- 1/
    ) AS sequence
FROM
    count_tmp
;
-- ［リスト8−3-4］ 縦持ちテーブルを横持ちにするクエリ
SELECT
    sex,
    MAX(CASE sequence WHEN 1 THEN user_count ELSE NULL END) AS Kanagawa, -- 1/
    MAX(CASE sequence WHEN 2 THEN user_count ELSE NULL END) AS Osaka,
    MAX(CASE sequence WHEN 3 THEN user_count ELSE NULL END) AS Tokyo
FROM
    tmp
GROUP BY
    sex
;
