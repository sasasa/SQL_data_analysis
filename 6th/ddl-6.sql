
DROP TABLE IF EXISTS mst_user_jpn;
CREATE TABLE mst_user_jpn (
    user_id   varchar(255)
  , user_name varchar(255)
  , email varchar(255)
);

INSERT INTO mst_user_jpn
VALUES
 ('UID0001', 'yamauchi', 'yamauchi@sample.com')
, ('UID0002', 'kimura', 'kimura@sample.com')
;


DROP TABLE IF EXISTS mst_user_us;
CREATE TABLE mst_user_us (
    user_id   varchar(255)
  , user_name varchar(255)
  , sns_id varchar(255)
);
INSERT INTO mst_user_us
VALUES
 ('UID0001', 'smith', '@jsith105')
, ('UID0002', 'jobs', '@ss5jj')
;


DROP TABLE IF EXISTS mst_stock;
CREATE TABLE mst_stock(
   item_name     VARCHAR(8)
  ,item_category VARCHAR(8)
  ,stock         INTEGER 
);
INSERT INTO mst_stock(item_name,item_category,stock) VALUES
 ('コーヒー','beverage',80)
,('緑茶','food',49)
,('メイプルシロップ','food',5)
,('ティーカップ','zakka',5)
,('砂糖','food',100)
,('ティースプーン','zakka',NULL);

DROP TABLE IF EXISTS mst_item_category;
CREATE TABLE mst_item_category(
   item_id       VARCHAR(7)
  ,item_name     VARCHAR(8)
  ,item_category VARCHAR(8)
);
INSERT INTO mst_item_category(item_id,item_name,item_category) VALUES
 ('IID0001','コーヒー','beverage')
,('IID0002','緑茶','food')
,('IID0003','メイプルシロップ','food')
,('IID0004','ティーカップ','zakka')
,('IID0005','砂糖','food')
,('IID0006','ティースプーン','zakka')
,('IID0007','ハチミツ','food')
,('IID0008','紅茶','beverage');

DROP TABLE IF EXISTS mst_sample_a;
CREATE TABLE mst_sample_a(
   item_name VARCHAR(6)
);
INSERT INTO mst_sample_a(item_name) VALUES
 ('アップル')
,('パイナップル');

DROP TABLE IF EXISTS mst_sample_b;
CREATE TABLE mst_sample_b(
   item_name VARCHAR(6)
);
INSERT INTO mst_sample_b(item_name) VALUES
 ('アップル')
,('ペン')
,('サングラス');

DROP TABLE IF EXISTS log_purchace;
CREATE TABLE log_purchace(
   item_id     VARCHAR(7)
  ,user_id     VARCHAR(7)
  ,action_date DATE 
  ,price       INTEGER 
);
INSERT INTO log_purchace(item_id,user_id,action_date,price) VALUES
 ('IID0001','UID0001','2019-01-29',280)
,('IID0002','UID0001','2019-01-29',280)
,('IID0002','UID0004','2019-01-30',200)
,('IID0001','UID0004','2019-01-30',750)
,('IID0005','UID0011','2019-01-30',200)
,('IID0001','UID0011','2019-01-30',750)
,('IID0003','UID0011','2019-02-01',450)
,('IID0003','UID0011','2019-02-02',450)
,('IID0004','UID0002','2019-02-03',980)
,('IID0005','UID0006','2019-02-04',280);
