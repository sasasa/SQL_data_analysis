-- ［リスト8−1-1］ 指標とディメンションの利用の例
SELECT
    COUNT(*),
    AVG(age)
FROM
    master_age
GROUP BY
    sex
;
