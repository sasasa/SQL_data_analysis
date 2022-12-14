-- ［リスト4-2-1］四則演算の例
SELECT
    7 + 5 AS result1,
    7 / 5 AS result2
;
-- ［リスト4-2-2］PostgreSQLでは整数の扱いに注意する
SELECT
    7.0 + 5 AS result1,
    7.0 / 5 AS result2
;
-- ［リスト4-2-3］月次ごとの売上増減を確認する
SELECT
    year_period,
    m1,
    m2,
    CASE
        WHEN m1 < m2 THEN '前月比増'
        WHEN m1 = m2 THEN '増減なし'
        ELSE '前月比減'
    END AS 前月比増減,
    m2 - m1 AS 差分
FROM
    monthly_sale_log
ORDER BY
    year_period
;
-- ［リスト4-2-4］最大売上・最小売上を取得する
SELECT
    year_period,
    GREATEST(m1, m2, m3, m4) AS 最大売上,
    LEAST(m1, m2, m3, m4) AS 最小売上
FROM
    monthly_sale_log 
ORDER BY
    year_period
;
-- ［リスト4-2-5］加算で平均売上を求める
SELECT
    year_period,
    (m1 + m2 + m3 + m4) / 4 AS 平均
FROM
    monthly_sale_log
ORDER BY
    year_period
;
-- ［リスト4-2-6］ 整数型のデータの除算を行う
SELECT
    dt,
    ad_id,
    clicks / imps AS CTR,
    100.0 * clicks / imps AS CTR2
FROM
    ad_stats_imp_clic
ORDER BY
    dt,
    ad_id
;
-- ［リスト4-2-7］CASE式で分母が0の場合を分岐して、除算を避ける方法
SELECT
    dt,
    ad_id,
    CASE
        WHEN imps > 0 THEN 100.0 * clicks / imps
    END AS CTR3
FROM
    ad_stats_imp_clic
ORDER BY
    dt,
    ad_id
;
