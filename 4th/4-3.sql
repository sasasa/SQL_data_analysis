--［リスト4-3-1］現在の日付とタイムスタンプを取得する
SELECT
    CURRENT_DATE AS 日付,
    CURRENT_TIMESTAMP AS タイムスタンプ
;
--［リスト4-3-2］特定の日付を取得する
SELECT
    CAST('2019-05-01' AS DATE) AS dt,
    CAST('2019-05-01 7:00:00' AS DATETIME) AS stamp
    -- PostgreSQL
    -- CAST('2019-05-01 7:00:00' AS DATE) AS stamp
;
-- ［リスト4-3-3］現在のタイムスタンプから年月日時分秒をそれぞれ取り出す
SELECT
    CURRENT_TIMESTAMP,
    EXTRACT(
        YEAR FROM CURRENT_TIMESTAMP
    ) AS current_year,
    EXTRACT(
        MONTH FROM CURRENT_TIMESTAMP
    ) AS current_month,
    EXTRACT(
        DAY FROM CURRENT_TIMESTAMP
    ) AS current_day,
    EXTRACT(
        HOUR FROM CURRENT_TIMESTAMP
    ) AS current_hour,
    EXTRACT(
        MINUTE FROM CURRENT_TIMESTAMP
    ) AS current_minute,
    EXTRACT(
        SECOND FROM CURRENT_TIMESTAMP
    ) AS current_second
;

-- ［リスト4-3-4］　年齢の算出
SELECT
    birth_date, 20160229 AS benchmark_date,
    CAST(REPLACE(birth_date, '-', '') AS UNSIGNED) AS int_birth_date,
    FLOOR((20160229 - CAST(REPLACE(birth_date, '-', '') AS UNSIGNED)) / 10000) AS age
FROM
    user_birth_date
;
-- ［リスト4-3-5］指定の時間の足し算引き算
SELECT
    user_id,
    -- CAST(create_stamp AS datetime) AS stamp,
    -- CAST(create_stamp AS datetime) + INTERVAL 1 HOUR AS after_1_hour,
    -- CAST(create_stamp AS datetime) - INTERVAL 30 MINUTE AS beforez_30min
    -- PostgreSQL
    CAST(create_stamp AS DATE) AS stamp,
    CAST(create_stamp AS DATE) + INTERVAL '1 HOUR' AS after_1_hour,
    CAST(create_stamp AS DATE) - INTERVAL '30 MINUTE' AS beforez_30min
FROM
    user_birth_date
;
