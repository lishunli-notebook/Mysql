##MYSQL
--一、如何登陆到MYSQL？
	进入终端输入：
	PATH="$PATH":/usr/local/mysql/bin mysql -uroot -pFORYOU52026.
--二、如何创建一个数据库？
	create database name; #创建数据库
	use name；#选中数据库
	show tables；#显示数据库中的内容
	create table name();
	create talbe dormitory(
		name varchar(20),
		home varchar(20),
		birth date,
		death data);#如何创建一个数据表
	describe name; #查看数据表
	select * from dormitory;#查看数据表中记录
	insert into name (指定字段) values () #添加数据记录
	delete from pet where name = ''#删除数据
	update pet set name = '旺旺财' where owner = '周星驰'#修改数据

--三、mySQl数据库数据类型？
	整数型
	浮点型
	日期类型：1999-10-10
	字符串类型
	***http://www.runoob.com/mysql/mysql-data-types.html***

--四、如何插入已知数据表到数据库
	一个一个插入


--五、mysql建表约束
	--1.主键约束
		主键约束在表中定义一个主键来唯一确定表中每一行数据的标识符.
		关键词：create table user(
			id int primary key,   #不能为空，确定唯一的记录
			name varchar(20))

	--联合主键-加起来不同即可
		create table user2(
			id int,   
			name varchar(20),
			password varchar(20),
			primary key (id, name));#不能为空


	--2.自增约束： 自动生成
		create table user3(
			id int primary key auto_increment,
			name varchar(20),
			years int
			);
		insert into user3 (name) values('张三'); #会自动生成
	--如何加入或删除主键
		alter table name1 add primary key(name2); #给name1中的name2加主键
		alter table name1 drop primary key;  #删除主键
		alter table name1 modify id int primary key;

	--3.外键约束:涉及到主表和附表
		#foreign key
		#班级：
		create table classes(
			id int primary key,
			name varchar(20)
			);
			mysql> desc classes;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+ 
		create table students(
			id int primary key,
			name varchar(20),
			class_id int,
			foreign key(class_id) references classes(id) 
			);
		mysql> describe students;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int(11)     | NO   | PRI | NULL    |       |
| name     | varchar(20) | YES  |     | NULL    |       |
| class_id | int(11)     | YES  | MUL | NULL    |       |
+----------+-------------+------+-----+---------+-------+
		insert into classes values(1, '一班');
		insert into classes values(2, '二班');
		insert into classes values(3, '三班');
		insert into classes values(4, '四班');
					+----+--------+
					| id | name   |
					+----+--------+
					|  1 | 一班   |
					|  2 | 二班   |
					|  3 | 三班   |
					|  4 | 四班   |
					+----+--------+
		insert into students values(1001, '张三', 1);
		insert into students values(1002, '张三', 2);
		insert into students values(1003, '张三', 4);
		insert into students values(1004, '张三', 3);
		insert into students values(1005, '张三', 5);  #将会报错
	--attention:
		--主表classss中没有的数据不能引用；
		--主表中的数据被附表引用，是不能被删除的
	delete from classes where name = '四班';#删除数据
		mysql> delete from classes where name = '四班';
		ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`lsl`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))





	--4.唯一约束:约束修饰字段的值不可以重复
		1. alter table name1 add unique(name2);#给表name1中的name2添加唯一约束
		2. create table name(
				id int ,
				name varchar(20) unique
				);
		3. create table name1(
			id int ,
			name varchar(20), 
			unique(name)
			);  #三种方法均可
		例子：
		create table user4(
			id int ,
			name varchar(20), 
			unique(id, name)  #两个键不重复就行
			);  
		删除唯一约束：
			alter table name1 drop index 变量名；
		添加唯一约束：
			alter table name1 modify 变量名 变量类型 unique;


	--5.非空约束:修饰的字段不能为空
	alter table user2 modify password varchar(20) not null;
			+----------+-------------+------+-----+---------+-------+
		| Field    | Type        | Null | Key | Default | Extra |
		+----------+-------------+------+-----+---------+-------+
		| id       | int(11)     | NO   | PRI | NULL    |       |
		| name     | varchar(20) | NO   | PRI | NULL    |       |
		| password | varchar(20) | NO   |     | NULL    |       |
		+----------+-------------+------+-----+---------+-------+
		3 rows in set (0.00 sec)



	--6.默认约束:如果传入值为空，则使用默认值
		create table user5(
			id int,
			name varchar(20),
			age int Default 18
			);
					+-------+-------------+------+-----+---------+-------+
			| Field | Type        | Null | Key | Default | Extra |
			+-------+-------------+------+-----+---------+-------+
			| id    | int(11)     | YES  |     | NULL    |       |
			| name  | varchar(20) | YES  |     | NULL    |       |
			| age   | int(11)     | YES  |     | 18      |       |
			+-------+-------------+------+-----+---------+-------+
			3 rows in set (0.01 sec)











