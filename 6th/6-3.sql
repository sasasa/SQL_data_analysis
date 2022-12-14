-- ［リスト6-3-1］ 同じpriceで、商品名が違う行を探す 
SELECT DISTINCT
    ipl1.item_name,
    ipl1.price
FROM
    item_purchase_log ipl1
    INNER JOIN
        item_purchase_log ipl2
    ON  ipl1.price = ipl2.price
    AND ipl1.item_name <> ipl2.item_name
ORDER BY
    ipl1.price
;
-- ［リスト6-3-2］ クロス結合で2つのテーブルの総当たりの組み合わせを得る
SELECT
    *
FROM
    mst_sample_a CROSS
JOIN
    mst_sample_b
;
-- ［リスト6-3-3］ 集計結果をカラムとして追加する
SELECT
    item_name,
    item_category,
    price,
    sq.*
FROM
    item_purchase_log
CROSS JOIN
    (/* ① */
        SELECT
            SUM(price) AS goukei
        FROM
            item_purchase_log
    ) AS sq
;
