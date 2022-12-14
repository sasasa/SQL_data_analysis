DROP TABLE IF EXISTS item_purchase_log_date;
CREATE TABLE item_purchase_log_date(
   item_name     VARCHAR(8)
  ,item_category VARCHAR(8)
  ,action_date   DATE 
  ,price         INTEGER 
);
INSERT INTO item_purchase_log_date(item_name,item_category,action_date,price) VALUES
 ('コーヒー','beverage','2019/4/29',280)
,('緑茶','food','2019/4/29',280)
,('緑茶','food','2019/4/30',200)
,('コーヒー','beverage','2019/4/30',750)
,('砂糖','food','2019/4/30',200)
,('コーヒー','beverage','2019/4/30',750)
,('メイプルシロップ','food','2019/5/1',450)
,('メイプルシロップ','food','2019/5/2',450)
,('ティーカップ','zakka','2019/5/3',980)
,('砂糖','food','2019/5/4',280);
