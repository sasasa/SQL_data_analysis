-- [3-1-1]
SELECT
    user_id,
    country
FROM
    web_access_os_country
;
-- [3-1-2]
SELECT DISTINCT
    country
FROM
    web_access_os_country
;
-- [3-1-3]
SELECT
    COUNT(*)
FROM
    web_access_os_country
;
-- [3-1-4]
SELECT
    country,
    -- 集約関数以外のものがあるとエラーになる      　　
    MIN(user_id)
FROM
    web_access_os_country
;
-- [3-1-5]
SELECT
    AVG(price)
FROM
    item_price_list
;
