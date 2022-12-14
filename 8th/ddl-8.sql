DROP TABLE IF EXISTS master_age;
CREATE TABLE master_age(
   age INTEGER 
  ,sex VARCHAR(1)
);
INSERT INTO master_age(age,sex) VALUES
 (45,'M')
,(31,'M')
,(22,'M')
,(25,'W')
,(36,'W')
,(40,'W');

DROP TABLE IF EXISTS master_customer;
create table master_customer(
user_id char(008),
age int,
sex char(008),
user_place char(016)
);
insert into master_customer values
('UID0001',45,'M','Kanagawa'),
('UID0002',31,'M','Osaka'),
('UID0003',22,'M','Tokyo'),
('UID0004',25,'W','Tokyo'),
('UID0005',36,'W','Tokyo'),
('UID0006',40,'W','Kanagawa'),
('UID0007',34,'M','Kanagawa'),
('UID0008',24,'W','Tokyo'),
('UID0009',30,'M','Tokyo'),
('UID0010',25,'W','Osaka'),
('UID0011',20,'W','Tokyo'),
('UID0012',31,'W','Osaka')
;


DROP TABLE IF EXISTS item_purchase_anlytics;
create table item_purchase_anlytics(
item_name char(16),
item_category char(16),
action_date date,
place char(8),
user_id char(8),
price int
);
insert into item_purchase_anlytics values
  ('サバ','food','2019-03-29','Store A','UID0001',280),
  ('しょう油','food','2019-03-29','Store A','UID0001',280),
  ('サバ','food','2019-03-30','Store A','UID0001',350),
  ('サバ','food','2019-03-30','Store A','UID0001',350),
  ('卵','food','2019-03-30','Store A','UID0001',200),
  ('しょう油','food','2019-03-30','Store A','UID0001',200),
  ('鶏肉','food','2019-04-01','Store A','UID0001',450),
  ('卵','food','2019-04-04','Store A','UID0001',280),
  ('卵','food','2019-04-06','Store A','UID0001',280),
  ('卵','food','2019-04-09','Store A','UID0001',280),
  ('サバ','food','2019-04-10','Store A','UID0004',280),
  ('しょう油','food','2019-04-10','Store A','UID0001',280),
  ('卵','food','2019-04-10','Store A','UID0001',280),
  ('卵','food','2019-04-12','Store A','UID0001',280),
  ('卵','food','2019-04-12','Store A','UID0001',280),
  ('鶏肉','food','2019-04-12','Store A','UID0001',450),
  ('サバ','food','2019-04-13','Store A','UID0001',280),
  ('しょう油','food','2019-04-13','Store A','UID0001',280),
  ('深皿','zakka','2019-04-14','Store A','UID0003',780),
  ('しょう油','food','2019-04-14','Store A','UID0003',280),
  ('深皿','zakka','2019-04-14','Store A','UID0003',980),
  ('卵','food','2019-04-15','Store A','UID0001',280),
  ('サバ','food','2019-04-17','Store A','UID0001',280),
  ('サバ','food','2019-04-18','Store A','UID0001',280),
  ('深皿','zakka','2019-04-23','Store A','UID0002',980);
