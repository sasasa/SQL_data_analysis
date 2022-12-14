-- ［リスト5-2-1］ IN述語で都道府県を指定して、そのユーザーの購買商品を表示
SELECT
    item_name,
    price
FROM
    item_purchase_log
WHERE
    user_id IN(
        SELECT
            user_id
        FROM
            mst_user_place
        WHERE
            pref_name = '東京都'
    )
;

-- ［リスト5-2-2］ EXISTS述語で都道府県を指定して、そのユーザーの購買商品を表示
SELECT
    item_name,
    price
FROM
    item_purchase_log AS ipl
WHERE
    EXISTS(
        SELECT
            *
        FROM
            mst_user_place AS mup
        WHERE
            mup.pref_name = '東京都'
        AND mup.user_id = ipl.user_id
    )
;
-- ［リスト5-2-3］ NOTにより、逆の結果を求める
SELECT
    item_name,
    price
FROM
    item_purchase_log AS ipl
WHERE
    NOT EXISTS(
        SELECT
            *
        FROM
            mst_user_place AS mup
        WHERE
            mup.pref_name = '東京都'
        AND mup.user_id = ipl.user_id
    )
;
