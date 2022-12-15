
# Build REPL on https://replit.com/
# Design restaurant database 5 table
# Write SQL 3 queries analyze data 
# 1xFact , 4 x Dimensions
# 1 x subquery / with cluase


.mode markdown
.header on

--dim 1 memu
create table menu(
  menu_id varchar not null primary key,
  menu_name varchar ,
  price int,
  type_id varchar
);

  insert into menu values
  ('001','Fried rice',60,'A1'),
  ('002','Fried chicken over rice',89,'A1'),
  ('003','American fried rice',78,'A1'),
  ('004','Tom Yum Goong',139,'A1'),
  ('005','Clear Soup',55,'A1'),
  ('006','Papaya salad',70,'A1'),
  ('007','Beef steak',215,'A1'),
  ('008','Fried Pork',119,'A1'),
  ('009','Rice vermicelli salad',99,'A1'),
  ('010','Omelet',50,'A1'),
  ('011','Beer',70,'A3'),
  ('012','Water',25,'A3'),
  ('013','Soft drink',35,'A3'),
  ('014','Italian Soda',65,'A3'),
  ('015','Chicken nuggets',99,'A2'),
  ('016','French Fries',79,'A2'),
  ('017','Gyoza',69,'A2'),
  ('018','Grilled Seafood',499,'A4')
  ;

--dim 2 memu
create table menu_type(
  type_id varchar not null primary key,
  foodtype_desc varchar ,
  FOREIGN KEY (type_id) REFERENCES menu(type_id)
);

  insert into menu_type values
  ('A1','A la carte'),
  ('A2','Appetizers'),
  ('A3','Drinks & Beverages'),
  ('A4','Seafood');


--dim 3 customer
create table customers(
  customerID varchar not null primary key,
  customerName varchar,
  birthday date,
  gander varchar,
  phone_number varchar
);

insert into customers values
  (1,'Chaeyeon','1998-01-02','F','0840920921'),
  (2,'Daimond','1995-11-28','M','0874390281'),
  (3,'Pentor','1989-07-19','M','0982290923'),
  (4,'Mabell','2000-09-03','F','0639928932'),
  (5,'Zara','1994-08-13','F','0934867281'),
  (6,'Pimma','1997-10-23','F',''),
  (7,'Aof','1991-04-11','M',''),
  (8,'Beer','1994-07-10','M','0884567830'),
  (9,'Dodo','1996-12-31','M ',''),
  (10,'Noey','1997-09-09','F','0810928934')
  ;

--dim 4 customer
create table payments (
  payment_id varchar not null primary key,
  payment_channel varchar
  );

insert into payments values
  (1,'Cash'),
  (2,'Credit Card'),
  (3,'Mobile Banking'),
  (4,'TrueMoney Wallet'),
  (5,'Rabbit Line Pay') ;

--Fact 5 customer
create table orders (
  order_id varchar,
  order_date date,
  qty int,
  menu_id varchar,
  customerID varchar,
  payment_id varchar,
  FOREIGN KEY (menu_id) REFERENCES menu(menu_id),
  FOREIGN KEY (customerID) REFERENCES customers(customerID),
  FOREIGN KEY (payment_id) REFERENCES payments(payment_id)
);

insert into orders values
  (1,'2022-11-01',2,'007',3,1),
  (1,'2022-11-01',1,'004',3,1),
  (1,'2022-11-01',2,'011',3,1),
  (2,'2022-11-01',1,'018',5,2),
  (2,'2022-11-01',1,'007',5,2),
  (3,'2022-11-02',1,'008',8,1),
  (4,'2022-11-02',1,'015',10,3),
  (4,'2022-11-02',1,'013',10,3),
  (5,'2022-11-03',1,'010',7,1),
  (5,'2022-11-03',1,'012',7,1),
  (6,'2022-11-04',1,'012',2,1),
  (7,'2022-11-05',1,'018',4,1),
  (7,'2022-11-05',1,'001',4,1),
  (8,'2022-11-07',2,'006',9,1),
  (9,'2022-11-08',1,'018',5,2),
  (9,'2022-11-08',1,'007',5,2),
  (9,'2022-11-08',1,'008',8,3),
  (10,'2022-11-09',1,'003',6,5),
  (11,'2022-11-10',3,'011',1,3),
  (12,'2022-11-11',1,'018',8,1),
  (12,'2022-11-11',2,'012',8,2),
  (13,'2022-11-12',2,'016',2,1);


--1.อาหารที่ขายดีที่สุดในร้าน top 5
select
  menu_name,
  sum(qty * price) as total
from orders 
  join menu 
  on orders.menu_id =  menu.menu_id
group by menu_name
order by total desc
limit 5
;

--2.ลูกค้านิยมจ่ายเงินด้วยช่องทางใดมากที่สุด เรียงลำดับจาก
select 
  count(orders.payment_id) as counts,
  payment_channel
from orders 
  join payments
  on orders.payment_id = payments.payment_id
group by payment_channel;


--3.ใครบ้างที่ใช้จ่ายในช่วงวันที่ 1-7 วันที่ผ่านมา และจ่ายเงินด้วยช่องทางใด
select 
  customerName,
  payment_channel,
  sum(qty * price) as total
from orders 
  join payments
  on orders.payment_id = payments.payment_id
  join customers 
  on customers.customerID = orders.customerID
  join menu 
  on orders.menu_id =  menu.menu_id
where order_date between '2022-11-01' and '2022-11-07'
group by customerName, payment_channel
order by total desc;

--4.กลุ่มประเภทอาหารที่ลูกค้านิยมสั่งมากที่สุด
with menutype as (
select *
from menu
join menu_type
on menu.type_id = menu_type.type_id
)
select 
  count(a.menu_id) as results,
  foodtype_desc as food_type
from orders a
join menutype b
  on a.menu_id = b.menu_id 
group by foodtype_desc
order by results desc ;


--create view
create view FullDate as 
  select 
  order_id,
  order_date,
  qty,
  menu_name,
  foodtype_desc,
  price,
  customerName,
  payment_channel,
  sum(qty * price) as total
from orders 
  join payments
  on orders.payment_id = payments.payment_id
  join customers 
  on customers.customerID = orders.customerID
  join menu 
  on orders.menu_id =  menu.menu_id
  join menu_type
  on menu.type_id = menu_type.type_id
group by 2
order by order_date;


--5.อาหารที่ลูกค้าสั่งมากกว่า 1 qty
select 
  order_id,
  order_date,
  qty,
  menu_name,
  foodtype_desc as foodtype 
from FullDate
where qty > 1;
