事务.sql

mysql中，事务是一个最小的不可分割的工作单元，事务能保证一个业务的完整性。

比如银行转账：

  a -> -100(a账户转出100)
	update user set money = money-100 where name = 'a';

  b -> +100(b账户将会收到100)
  	update user set money = money+100 where name = 'b';

 --但是实际中，很有可能二者的不会同时成功，则会出现差错。
 --导致前后数据不一致。
	
	update user set money = money-100 where name = 'a';
	update user set money = money-100 where name = 'b';

--多条sql语句，要么同时成功，要么同时失败。
--这就是事务

---mysql中如何控制事务？
1、mysql默认是开启事务的（自动提交）。
select @@autocommit;

+--------------+
| @@autocommit |
+--------------+
|            1 |
+--------------+
1 row in set (0.00 sec)

--默认事务开启的作用？
--当我们去执行一个sql语句时，效果会立即体现出来，其不能回滚。

create database bank;

create table user(
	id int primary key,
	name varchar(20),
	money float(10,2)   #浮点类型
);
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
| money | float(10,2) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)


insert into user values(1, 'a', 1000.1);
insert into user values(2, 'b', 1200.5);


--事务回滚： 撤销sql语句执行效果。
rollback;
+----+------+---------+
| id | name | money   |
+----+------+---------+
|  1 | a    | 1000.10 |
|  2 | b    | 1200.50 |
+----+------+---------+
2 rows in set (0.00 sec)

执行回滚语句后，内容并没与更改，所以事务默认是开启的。

--设置mysql自动提交为false，即关闭事务。

set autocommit = 0;  #关闭mysql的自动提交

mysql> set autocommit = 0;
Query OK, 0 rows affected (0.00 sec)

则可以使用
rollback;
撤销sql语句。

insert into user values(3,'c',1001.6);
	+----+------+---------+
| id | name | money   |
+----+------+---------+
|  1 | a    | 1000.10 |
|  2 | b    | 1200.50 |
|  3 | c    | 1001.60 |
+----+------+---------+
3 rows in set (0.01 sec)

rollback;
mysql> select * from user;
+----+------+---------+
| id | name | money   |
+----+------+---------+
|  1 | a    | 1000.10 |
|  2 | b    | 1200.50 |
+----+------+---------+
2 rows in set (0.00 sec)

结果就撤销了。（相当于插入的数据放入了一张虚拟表上，可以使用rollback回滚、撤销）

插入之后，如果使用命令
commit;
则会提交，，并且不能回滚了。

--插入数据
mysql> insert into user values(3,'c',1001.6);
Query OK, 1 row affected (0.00 sec)

--手动提交数据、不可撤销
mysql> commit;
Query OK, 0 rows affected (0.01 sec)

mysql> select * from user;
+----+------+---------+
| id | name | money   |
+----+------+---------+
|  1 | a    | 1000.10 |
|  2 | b    | 1200.50 |
|  3 | c    | 1001.60 |
+----+------+---------+
3 rows in set (0.00 sec)

--不可撤销，（事务的持久性）
mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+---------+
| id | name | money   |
+----+------+---------+
|  1 | a    | 1000.10 |
|  2 | b    | 1200.50 |
|  3 | c    | 1001.60 |
+----+------+---------+
3 rows in set (0.00 sec)

--事务的自动提交
--手动提交
--回滚

--对于转账：

update user set money = money-500 where name = 'a';
update user set money = money+500 where name = 'b';

+----+------+---------+
| id | name | money   |
+----+------+---------+
|  1 | a    |  500.10 |
|  2 | b    | 1700.50 |
|  3 | c    | 1001.60 |
+----+------+---------+
3 rows in set (0.00 sec)

--事务给我们提供了一个返回的效果。

 != 手动开启事务：（我觉得至少关闭事务，使得有反悔的可能）
begin; 
update user set money = money-100 where name = 'a';

 或者
start transaction;



---事务的四大特征ACID

A 原子性（Atomicity）  :事务是最小的单位，不可分割
C 一致性（Consistency）:事务要求，同一事务的sql语句，必须保证同时成功或同时失败
I 隔离性（Isolation）  :事务1和事务2具有隔离性。
D 持久性（Durability） :事务一旦结束(commit, rollback)，就不可以返回

事务开启：
	1、修改默认提交 set autocommit = 0;
	2、begin;
	3、start transaction;

事务手动提交：
	commit;

事务手动回滚：
	rollback;




-===-事务的隔离性：

1、read uncommitted; 读未提交的
2、read committed;   读已提交的
3、repeatable read;	 可以重复读
4、serializable;		 串行化



1、read uncommitted; 读未提交的
	事务的a和事务b：事务a对数据进行操作，尚未提交，但b可以看见a操作的结果。

bank数据库 user表
insert into user values(4, '小明', 15000);
insert into user values(5, '淘宝店', 1000);

select * from user;

+----+-----------+----------+
| id | name      | money    |
+----+-----------+----------+
|  1 | a         |   500.10 |
|  2 | b         |  1700.50 |
|  3 | c         |  1001.60 |
|  4 | 小明      | 15000.00 |
|  5 | 淘宝店    |  1000.00 |
+----+-----------+----------+
5 rows in set (0.00 sec)

--如何查看数据库的隔离级别？
!= 系统级别
select @@global.transaction_isolation;  #默认事务级别
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| REPEATABLE-READ                |
+--------------------------------+
1 row in set (0.00 sec)

+= 会话级别
select @@transaction_isolation;


--如何修改隔离级别？
set global transaction isolation level read uncommitted; #系统级别的
set transaction iolation level read uncomitted; #会话级别的

start transaction; #开启事务
update user set money=money-200 where name = '小明';

--如果两个不同的地方，都在进行操作，如果事务a开启之后，他的数据能够被别人读到。
--这样就会出现（脏读）
====  --脏读：一个事务读到另一个未提交的事务的数据。


2、read committed;   读已提交的

--修改隔离级别
set global transaction isolation level read committed;

--虽然可以读到另外一个事务提交的数据，但还是会出现问题。
--读同一个表的数据， 发现前后不一致。
--不可重复读现象：read committed;


3、repeatable read;	 可以重复读
修改隔离级别：
set global transaction isolation level repeatable read;

出现的问题： 
幻读 ：一方已经提交数据，但另一方不能查看，但是不能插入相同的primary key数据
事务的a和事务b，同时操作一张表，事务a提交的数据，也不能被事务b所读到，就造成了幻读



4、serializable;		 串行化
修改隔离级别：set global transaction isolation level serializable;

--当user表被另外一个事务操作时，其他事务的写入操作不可以进行，进入排队状态。
--进入排队状态（串行化）， 直到另外一个事务结束后（commit），写入操作才能进行。
--并且需要在没有超时的情况下。


--串行化问题：性能特差!!

read uncommitted  >  read committed   >  repeatable read   > serializable
--隔离级别越高，性能越差，但问题越少

--默认是repeatable read




























