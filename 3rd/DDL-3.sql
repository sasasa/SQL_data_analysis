CREATE TABLE web_access_os_country
(
 user_id     CHAR(8) ,
 os_type    VARCHAR(32) ,
 os_version    VARCHAR(32) ,
 country VARCHAR(32) ,
 access_date      VARCHAR(32) 
);

INSERT INTO web_access_os_country 
VALUES
  ('U00001','ios','11','JP','2019−01-01'),
  ('U00001','ios','11','JP','2019−01-01'),
  ('U00002','Windows','8','JP','2019−01-01'),
  ('U00003','Windows','8','US','2019−01-01'),
  ('U00004','Windows','10','JP','2019−01-01'),
  ('U00005','Windows','10','US','2019−01-01'),
  ('U00006','ios','12','JP','2019−01-01'),
  ('U00007','ios','12','US','2019−01-01'),
  ('U00002','Windows','8','JP','2019−01-01');

CREATE TABLE item_price_list(
   item_name VARCHAR(4) NOT NULL
  ,price     INTEGER  NOT NULL
);
INSERT INTO item_price_list(item_name,price) VALUES
 ('コーヒー',280)
,('緑茶',280)
,('緑茶',200)
,('コーヒー',750)
,('砂糖',200);

CREATE TABLE item_purchase_log
(
   item_name      CHAR(16),
   item_category  CHAR(16),
   action_date    DATE,
   user_id        CHAR(8),
   price          INT
);

INSERT INTO item_purchase_log VALUES
  ('コーヒー','beverage','2019-01-29','UID0001',280),
  ('緑茶','food','2019-01-29','UID0001',280),
  ('緑茶','food','2019-01-30','UID0004',200),
  ('コーヒー','beverage','2019-01-30','UID0004',750),
  ('砂糖','food','2019-01-30','UID0011',200),
  ('コーヒー','beverage','2019-01-30','UID0011',750),
  ('メイプルシロップ','food','2019-02-01','UID0011',450),
  ('メイプルシロップ','food','2019-02-02','UID0011',450),
  ('ティーカップ','zakka','2019-02-03','UID0002',980),
  ('砂糖','food','2019-02-04','UID0006',280);
  
