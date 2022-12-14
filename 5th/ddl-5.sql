
DROP TABLE IF EXISTS store_sales;
CREATE TABLE store_sales
(store_id   VARCHAR(16)  ,
 sales INTEGER );
INSERT INTO store_sales
VALUES
('A',	4350)
,('B',	550)
,('C',	400)
,('D',	420)
,('E',	450)
,('F',	420)
,('G',	400)
,('H',	320)
,('I',	320)
,('J',	400)
;

  

DROP TABLE IF EXISTS mst_user_place;
CREATE TABLE mst_user_place (
    user_id   varchar(255)
  , pref_name varchar(255)
  , city_name varchar(255)
);

INSERT INTO mst_user_place
VALUES
('UID0001', '東京都', '中央区')
, ('UID0002', '東京都', '世田谷')
, ('UID0003', '福岡県', '福岡市')
, ('UID0004', '東京都', '渋谷区')
, ('UID0005', '神奈川県', '横浜市')
, ('UID0006', '愛知県', '名古屋市')
, ('UID0007', '東京都', '北区')
, ('UID0008', '福岡県', '北九州市')
, ('UID0009', '東京都', '渋谷区')
, ('UID0010', '愛知県', '名古屋市')
, ('UID0011', '神奈川県', '川崎市')
;

  
DROP TABLE IF EXISTS simple_log;
CREATE TABLE simple_log(
   user_id     VARCHAR(7) NOT NULL
  ,action_date DATE  NOT NULL
);
INSERT INTO simple_log(user_id,action_date) VALUES
 ('UID0001','2019/5/24')
,('UID0001','2019/5/24')
,('UID0002','2019/5/25')
,('UID0001','2019/5/26')
,('UID0003','2019/5/27')
,('UID0001','2019/5/28')
,('UID0004','2019/5/29')
,('UID0001','2019/5/30')
,('UID0005','2019/5/30')
,('UID0001','2019/5/30')
,('UID0001','2019/5/30')
,('UID0001','2019/6/1')
,('UID0001','2019/6/2')
,('UID0002','2019/6/3')
,('UID0002','2019/6/3')
,('UID0001','2019/6/4')
,('UID0003','2019/6/4')
,('UID0001','2019/6/5')
,('UID0003','2019/6/6')
,('UID0004','2019/6/7');
  
