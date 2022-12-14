-- ［リスト6-2-1］ 顧客マスターテーブルとログテーブルを結合する
SELECT
    mup.user_id,
    mup.pref_name,
    mup.city_name,
    ipl.item_name,
    ipl.item_category,
    ipl.action_date,
    ipl.price
FROM
    mst_user_place AS mup
    INNER JOIN -- 1/
        item_purchase_log AS ipl
    ON  mup.user_id = ipl.user_id
;
-- ［リスト6-2-2］ テーブル名を明記しないと、エラーになる
SELECT
    user_id
FROM
    mst_user_place AS mup
    INNER JOIN
        item_purchase_log AS ipl
    ON  mup.user_id = ipl.user_id
;
-- ［リスト6-2-3］ 商品カテゴリマスターと購買履歴の外部結合を求める
SELECT
    mic.item_id,
    mic.item_name,
    mic.item_category,
    ipl.price
FROM
    mst_item_category AS mic
LEFT OUTER JOIN
    item_purchase_log AS ipl
ON  mic.item_name = ipl.item_name
;
-- ［リスト6-2-4］ 売れていない商品リストを求める
SELECT
    mic.item_id,
    mic.item_name,
    mic.item_category,
    ipl.price
FROM
    mst_item_category AS mic
LEFT OUTER JOIN
    item_purchase_log AS ipl
ON  mic.item_name = ipl.item_name
WHERE
    ipl.price IS NULL
;
-- ［リスト6-2-5］ 右外部結合により同様の結果を求める
SELECT
    mic.item_id,
    mic.item_name,
    mic.item_category,
    ipl.price
FROM
    item_purchase_log AS ipl
RIGHT OUTER JOIN
    mst_item_category AS mic
ON  mic.item_name = ipl.item_name
;
-- ［リスト6-2-6］ FULL JOINによる外部結合
SELECT
  *
FROM
    mst_item_category AS mic
FULL JOIN
    mst_stock AS ms
ON  mic.item_name = ms.item_name
;
-- ［リスト6-2-7］ UNIONを用いて、MySQLでFULL JOIN
SELECT
    *
FROM
    mst_item_category AS mic
LEFT JOIN /* ① */
    mst_stock AS ms
ON  mic.item_name = ms.item_name
UNION /* ③ */
SELECT
    *
FROM
    mst_item_category AS mic
RIGHT JOIN /* ② */
    mst_stock AS ms
ON  mic.item_name = ms.item_name
;
