
DROP TABLE IF EXISTS user_browser;
CREATE TABLE user_browser
(
   user_id          VARCHAR(255),
   create_date    VARCHAR(255),
   create_browser  INT
);
INSERT INTO user_browser (user_id,create_date,create_browser) 
VALUES
  ('U00001','2019-04-26',1),
  ('U00002','2019-04-26',2),
  ('U00003','2019-04-27',3);


DROP TABLE IF EXISTS user_place;
CREATE TABLE user_place (
    user_id   varchar(255)
  , pref_name varchar(255)
  , city_name varchar(255)
);

INSERT INTO user_place
VALUES
    ('U00001', '東京都', '中央区')
  , ('U00002', '東京都', '世田谷'  )
  , ('U00003', '福岡県', '福岡市')
, ('U00004', '東京都', '渋谷区'  )
, ('U00005', '神奈川県', '横浜市')
;

-- p42
DROP TABLE IF EXISTS ad_stats_imp_clic;
CREATE TABLE ad_stats_imp_clic (
    dt          varchar(255)
  , ad_id       varchar(255)
  , imps integer
  , clicks      integer
);

INSERT INTO ad_stats_imp_clic
VALUES
    ('2019-05-01', '00001', 10000,  300)
  , ('2019-05-01', '00002', 12000,  120)
  , ('2019-05-01', '00003', 500000, 10000)
  , ('2019-05-02', '00001',      0,     0)
  , ('2019-05-02', '00002', 13000,  140)
  , ('2019-05-02', '00003', 620000, 15000)
;

DROP TABLE IF EXISTS fact_web_access_log ;
CREATE TABLE fact_web_access_log (
    access_timestamp    varchar(255)
  , referrer text
  , target_url      text
);

INSERT INTO fact_web_access_log 
VALUES
    ('2019-04-26 00:07:00', 'http://www.another-example.com/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/one/detail?ref_id=001')
  , ('2019-04-26 00:07:01', 'http://www.another-test.net/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/one#ref'          )
  , ('2019-04-26 00:07:01', 'https://www.another-example.com/'                               , 'http://www.example.com/book/detail?ref_id=002' )
;

 DROP TABLE IF EXISTS user_birth_date;
CREATE TABLE user_birth_date (
    user_id        varchar(255)
  , create_stamp varchar(255)
  , birth_date     varchar(255)
);

INSERT INTO user_birth_date
VALUES
    ('U00001', '2016-02-28 08:00:00', '1996-02-28')
  , ('U00002', '2016-02-29 08:00:00', '1996-02-29')
  , ('U00003', '2016-03-01 08:00:00', '1996-03−01')
, ('U00004', '2016-03-03 08:00:00', '1996-02-29')
, ('U00005', '2016-03-10 08:00:00', '1996-02-29')
;

 DROP TABLE IF EXISTS purchase_log_coupon;
CREATE TABLE purchase_log_coupon (
    purchase_id varchar(255)
  , price      integer
  , coupon      integer
);

INSERT INTO purchase_log_coupon
VALUES
    ('100001', 2280, NULL)
  , ('100002', 7650,  300)
  , ('100003', 4870, NULL)
;

DROP TABLE IF EXISTS monthly_sale_log;
CREATE TABLE monthly_sale_log
(
   year_period  INT,
   m1    INT,
   m2    INT,
   m3    INT,
   m4    INT
);
INSERT INTO monthly_sale_log
VALUES
  (2015,4200000,4300000,7400000,4300000),
  (2016,4500000,4500000,4000000,4100000),
(2017,5430000,4530000,6130000,7630000),
(2018,3260000,4570000,53550000,6340000),
    (2019,2570000,8720000,NULL,NULL)
;
