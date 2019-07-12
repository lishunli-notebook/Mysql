四种连接查询.sql
--数据库名：testJoin

!= 不用外键就能求两个表的交集，并集等


内连接
inner join 或者 join 


外连接
1.左连接  left join 或者 left outer join


2.右连接 right join 或者 right outer join 


3.完全外连接 full join 或者 full outer join 

--创建两个表

--person 表
id,
name,
cardID

create table person(
	id int,
	name varchar(20),
	cardID int); 

--card表
id,
name

create table card(
	id int,
	name varchar(20)

);

insert into card values(1, '饭卡');
insert into card values(2, '建行卡');
insert into card values(3, '农行卡');
insert into card values(4, '工商卡');
insert into card values(5, '邮政卡');

+------+-----------+
| id   | name      |
+------+-----------+
|    1 | 饭卡      |
|    2 | 建行卡    |
|    3 | 农行卡    |
|    4 | 工商卡    |
|    5 | 邮政卡    |
+------+-----------+

insert into person values(1, '张三', 1);
insert into person values(2, '李四', 3);
insert into person values(3, '王五', 6);

+------+--------+--------+
| id   | name   | cardID |
+------+--------+--------+
|    1 | 张三   |      1 |
|    2 | 李四   |      3 |
|    3 | 王五   |      6 |
+------+--------+--------+
3 rows in set (0.00 sec)


--没有创建外键，但是二者却又一点的关系，但是由于6的出现导致无法使用外键
--1.inner join查询  （取二者交集）

select * from person inner join card on person.cardId = card.id;
或
select * from person join card on person.cardId = card.id;

+------+--------+--------+------+-----------+
| id   | name   | cardID | id   | name      |
+------+--------+--------+------+-----------+
|    1 | 张三   |      1 |    1 | 饭卡      |
|    2 | 李四   |      3 |    3 | 农行卡    |
+------+--------+--------+------+-----------+
--内联查询  内连接：将会导致两个表相互拼接在一起，某个字段相等，查询出相关记录


--2.left join (左外连接)  （取左边的集合）

select * from person left join card on person.cardId = card.id;
或者
select * from person left outer join card on person.cardId = card.id;
+------+--------+--------+------+-----------+
| id   | name   | cardID | id   | name      |
+------+--------+--------+------+-----------+
|    1 | 张三   |      1 |    1 | 饭卡      |
|    2 | 李四   |      3 |    3 | 农行卡    |
|    3 | 王五   |      6 | NULL | NULL      |
+------+--------+--------+------+-----------+
3 rows in set (0.00 sec)

--左外连接，将左边所有的数据取出来，右边有相等的就会显示，没有就显示null

--3.right join(右外连接)  (相当于右边的集合)
select * from person right join card on person.cardId = card.id;
+------+--------+--------+------+-----------+
| id   | name   | cardID | id   | name      |
+------+--------+--------+------+-----------+
|    1 | 张三   |      1 |    1 | 饭卡      |
|    2 | 李四   |      3 |    3 | 农行卡    |
| NULL | NULL   |   NULL |    2 | 建行卡    |
| NULL | NULL   |   NULL |    4 | 工商卡    |
| NULL | NULL   |   NULL |    5 | 邮政卡    |
+------+--------+--------+------+-----------+
5 rows in set (0.00 sec)
--右外连接，将右边所有的数据取出来，左边有相等的就会显示，没有就显示null


--4.full join(全)
 !=不支持全外连接
select * from person left join card on person.cardID = card.id
union
select * from person right join card on person.cardID = card.id;


+------+--------+--------+------+-----------+
| id   | name   | cardID | id   | name      |
+------+--------+--------+------+-----------+
|    1 | 张三   |      1 |    1 | 饭卡      |
|    2 | 李四   |      3 |    3 | 农行卡    |
|    3 | 王五   |      6 | NULL | NULL      |
| NULL | NULL   |   NULL |    2 | 建行卡    |
| NULL | NULL   |   NULL |    4 | 工商卡    |
| NULL | NULL   |   NULL |    5 | 邮政卡    |
+------+--------+--------+------+-----------+
6 rows in set (0.00 sec)


--full join   就是 A并B的意思

































