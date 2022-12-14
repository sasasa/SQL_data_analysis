-- ［リスト5-1-1］FROM句にサブクエリを記述
SELECT
    item_name,
    item_category,
    price
FROM
    item_purchase_log
WHERE
    item_category = (
        SELECT
            item_category
        FROM
            item_purchase_log
        WHERE
            item_name = '緑茶'
        AND user_id = 'UID0004'
    )
;
-- ［リスト5-1-2］ サブクエリを入れ子にする
SELECT
    item_name,
    AVG(price)
FROM
    (
        SELECT
            item_name,
            item_category,
            action_date,
            price
        FROM
            item_purchase_log
        WHERE
            item_category = (
                SELECT
                    item_category
                FROM
                    item_purchase_log
                WHERE
                    item_name = '緑茶'
                AND user_id = 'UID0004'
            )
    ) AS special_list
GROUP BY
    item_name
HAVING AVG(price) > 300
;
-- ［リスト5-1-3］ WITH句でサブクエリを見やすく記述する
WITH special_list AS(
    SELECT
        item_name,
        item_category,
        action_date,
        price
    FROM
        item_purchase_log
    WHERE
        item_category = (
            SELECT
                item_category
            FROM
                item_purchase_log
            WHERE
                item_name = '緑茶'
            AND user_id = 'UID0004'
        )
)
SELECT
    item_name,
    AVG(price)
FROM
    special_list
GROUP BY
    item_name
HAVING AVG(price) > 300
;
-- ［リスト5-1-4］ WITH句で記述の順番を間違うとエラーになる
WITH category_summary2 AS(
    SELECT
        *
    FROM
        category_summary
    WHERE
        item_count = 3
),
category_summary AS(
    SELECT
        item_category,
        COUNT(*) AS item_count
    FROM
        item_purchase_log
    GROUP BY
        item_category
)
SELECT
    item_category,
    item_count
FROM
    category_summary2
;
-- ［リスト5-1-5］VIEWを作成するクエリ
CREATE VIEW special_list AS
SELECT
    item_name,
    item_category,
    price
FROM
    item_purchase_log
WHERE
    item_category = (
        SELECT
            item_category
        FROM
            item_purchase_log
        WHERE
            item_name = '緑茶'
        AND user_id = 'UID0004'
    )
;
-- ［リスト5-1-6］FROM句にVIEWを指定する
SELECT
    item_name,
    AVG(
        price
    )
FROM
    special_list
GROUP BY
    item_name
HAVING AVG(
    price
) > 300
;
-- ［リスト5-1-7］ WHERE句で比較演算子ともにスカラサブクエリを使う
SELECT
    item_name,
    price
FROM
    item_purchase_log
WHERE
    price > (
        SELECT
            AVG(price)
        FROM
            item_purchase_log
    )
;
-- ［リスト5-1-8］ SELECT句でスカラサブクエリを使う
SELECT
    item_name,
    price,
    (
        SELECT
            AVG(price)
        FROM
            item_purchase_log
    ) AS avg_price
FROM
    item_purchase_log
;
-- ［リスト5-1-9］ HAVING句でスカラサブクエリを使う
SELECT
    item_category,
    AVG(
        price
    )
FROM
    item_purchase_log
GROUP BY
    item_category
HAVING AVG(
    price
) > (
    SELECT
        AVG(price)
    FROM
        item_purchase_log
)
;
-- ［リスト5-1-10］返り値がスカラ値でないサブクエリなのでエラーになる
SELECT
    item_name,
    price
FROM
    item_purchase_log
WHERE
    price > (
        SELECT
            AVG(price)
        FROM
            item_purchase_log
        GROUP BY
            item_category
    )
;
-- ［リスト5-1-11］相関サブクエリ
SELECT
    item_category,
    item_name,
    price
FROM
    item_purchase_log AS ipl1
WHERE
    price > (
        SELECT
            AVG(price)
        FROM
            item_purchase_log AS ipl2
        WHERE
            ipl1.item_category = ipl2.item_category
        GROUP BY
            item_category
    )
;
