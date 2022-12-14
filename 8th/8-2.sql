-- ［リスト8−2-1］ 時系列分析のクエリ
SELECT
    action_date,
    SUM(price) AS amount_price, -- 1/
    AVG(SUM(price)) OVER( -- 2/
        ORDER BY
            action_date 
        ROWS BETWEEN 6 preceding 
            AND CURRENT ROW
    ) AS moving_average
FROM
    item_purchase_anlytics
GROUP BY
    action_date
ORDER BY
    action_date
;
