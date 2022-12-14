DROP TABLE IF EXISTS sales_log;
create table sales_log(
item_name char(12),
item_category char(12 ),
sales_date date,
store_place char(8),
user_id char(8),
price int
);

insert into sales_log values
('まぐろ','food','2019/3/29','Store A','UID0001','250'),
('しょう油','food','2019/3/29','Store A','UID0001','250'),
('しょう油','food','2019/3/30','Store A','UID0001','200'),
('まぐろ','food','2019/3/30','Store A','UID0001','350'),
('卵','food','2019/3/30','Store A','UID0001','200'),
('まぐろ','food','2019/3/30','Store A','UID0001','350'),
('とり肉','food','2019/4/1','Store A','UID0001','450'),
('とり肉','food','2019/4/2','Store A','UID0001','450'),
('深皿','zakka','2019/4/3','Store A','UID0001','980'),
('ジャガイモ','food','2019/4/4','Store A','UID0001','250'),
('しょう油','food','2019/4/4','Store A','UID0001','250'),
('ジャガイモ','food','2019/4/5','Store A','UID0001','250'),
('ジャガイモ','food','2019/4/6','Store A','UID0001','250')
;

DROP TABLE IF EXISTS action_log;
create table action_log(
item_name char(16),
item_category char(16 ),
action_category char(16 ),
action_date date,
user_id char(8)
);

insert into action_log values
('ハーブティー','food','tagging','2019/5/29','UID0001'),
('紅茶','food','tagging','2019/5/29','UID0001'),
('紅茶','food','review','2019/5/30','UID0001'),
('ハーブティー','food','purchase','2019/5/30','UID0001'),
('シロップ','food','purchase','2019/5/30','UID0001'),
('ハーブティー','food','tagging','2019/5/30','UID0001'),
('レモン','food','tagging','2019/6/1','UID0001'),
('レモン','food','tagging','2019/6/2','UID0001'),
('マグカップ','zakka','review','2019/6/3','UID0002'),
('シロップ','food','tagging','2019/6/4','UID0001'),
('紅茶','food','tagging','2019/6/4','UID0003'),
('シロップ','food','purchase','2019/6/5','UID0001'),
('シロップ','food','tagging','2019/6/6','UID0001'),
('ハーブティー','food','tagging','2019/6/7','UID0001'),
('ハーブティー','food','tagging','2019/6/8','UID0001')
;
