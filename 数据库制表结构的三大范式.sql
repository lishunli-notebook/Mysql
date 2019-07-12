数据库制表结构的三大范式.sql
--第一范式： 数据表中的所有字段都是不可分割的原子值？
--每个字段都是唯一的，不可继续分割的, 列不可分割，设置越详细？（变量越多？）
create table students2(
	id int primary key,
	name varchar(20),
	country varchar(20),
	province varchar(20),
	city varchar(20),
	details varchar(20));

mysql> describe students2;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int(11)     | NO   | PRI | NULL    |       |
| name     | varchar(20) | YES  |     | NULL    |       |
| country  | varchar(20) | YES  |     | NULL    |       |
| province | varchar(20) | YES  |     | NULL    |       |
| city     | varchar(20) | YES  |     | NULL    |       |
| details  | varchar(20) | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
6 rows in set (0.01 sec)

insert into students2 values(1, 'lsl', 'China', 'Chongqing', 'Qijiang', 'datongzheng');
insert into students2 values(2, 'jsj', 'China', 'Chongqing', 'Qijiang', 'ganshuizhen');
insert into students2 values(3, 'lyh', 'China', 'Chongqing', 'Qijiang', 'daluba');

select * from students2;
mysql> select * from students2;
+----+------+---------+-----------+---------+-------------+
| id | name | country | province  | city    | details     |
+----+------+---------+-----------+---------+-------------+
|  1 | lsl  | China   | Chongqing | Qijiang | datongzheng |
|  2 | jsj  | China   | Chongqing | Qijiang | ganshuizhen |
|  3 | lyh  | China   | Chongqing | Qijiang | daluba      |
+----+------+---------+-----------+---------+-------------+
3 rows in set (0.00 sec)



--第二范式：
--满足第一范式的情况下，每个原子都仅依赖于唯一的主键，如果不满足，则拆表


--第三范式
--必须满足第二范式，除主键列的其他列之间不能有传递依赖关系。






















