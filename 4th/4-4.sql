-- ［リスト4-4-1］SUBSTRINGの使い方
SELECT
    SUBSTRING( 'PostgreSQL' FROM 1 FOR 4) AS from1to4,
    SUBSTRING( 'PostgreSQL' FROM 8) AS after8
;

-- ［リスト4-4-2］PostgreSQLの正規表現によるドメイン抽出
SELECT
    target_url,
    SPLIT_PART(SUBSTRING( target_url FROM '//([^?#]+)'
        ), '/', 1) AS domain_name
FROM
    fact_web_access_log
;
-- ［リスト4-4-3］MySQLのSUBSTRING_INDEXによるドメイン抽出
SELECT
    target_url,
    SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(target_url, '/', 3), '://', - 1), '/', 1), '?', 1) AS domain_name
FROM
    fact_web_access_log
;

-- ［リスト4-4-4］文字列を連結するクエリ
SELECT
    user_id,
    CONCAT(pref_name, city_name) AS 都道府県＋都市
FROM
    user_place
;
［リスト4-4-5］||による文字列連結
SELECT
user_id
,pref_name || city_name AS user_place 
FROM user_place;
