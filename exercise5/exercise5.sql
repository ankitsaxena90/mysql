--Q.(1)
+----+-------------+----------+------+---------------+------+---------+------+------+-------+
| id | select_type | table    | type | possible_keys | key  | key_len | ref  | rows | Extra |
+----+-------------+----------+------+---------------+------+---------+------+------+-------+

--Column		Meaning						Possible Values--
id		The SELECT identifier			sequential number of the SELECT(can be null)-0,1,2,3,4

select_type	The SELECT type				Simple(without subquery), Primary, Union(any select statement is union)

table		The table for the output row		<unionM,N> union of rows with id values of M and N, <derivedN> derived table 								result for the row with an id value of N
partitions	The matching partitions			NULL for nonpartitioned tables

type		The join type				system(table has only one row (= system table), const(is used to compare all parts 								of a PRIMARY KEY or UNIQUE index to constant, eq_ref(One row is read from this 								table for each combination of rows from the previous tables)
							values), ref(All rows with matching index values are read)

possible_keys	The possible indexes to choose		for e.g:author_id_index,name_index (user assigned index to column author_id & name)

key		The index actually chosen		for e.g: author_id_index (index chosen in select query)

key_len		The length of the chosen key		25,28 (28 bytes are used from the key by mysql)

ref		The columns compared to the index	Null,constt(constants are compared to the index named in the key column)

rows		Estimate of rows to be examined		1,2 (number of rows scanned to compute the query)

Extra		Additional information			using where, using join(retieve info from indexed columns only0 ,using 								filesort(retrieve the rows in sorted order), using index



mysql> explain select article_name from articles;
+----+-------------+----------+------+---------------+------+---------+------+------+-------+
| id | select_type | table    | type | possible_keys | key  | key_len | ref  | rows | Extra |
+----+-------------+----------+------+---------------+------+---------+------+------+-------+
|  1 | SIMPLE      | articles | ALL  | NULL          | NULL | NULL    | NULL |    7 |       |
+----+-------------+----------+------+---------------+------+---------+------+------+-------+
1 row in set (0.00 sec)



--Q.(2)--
mysql> EXPLAIN SELECT * FROM comments WHERE user_id = 41;

+-------------+------+---------------+---------+----------+-------------+
| select_type | type | key | key_len | ref     | rows     | Extra 	|
+-------------+------+---------------+---------+----------+-------------+
| SIMPLE      | ALL  | NULL| NULL    | NULL    | 1002345  | Using where |
+-------------+------+---------------+---------+-------+---------+------+

mysql> SELECT count(id) FROM comments;

+-----------+
| count(id) |
+-----------+
| 1002345   |
+-----------+
The value under 'rows' column in the output of EXPLAIN query is the number of rows scanned to find the row in which user_id = 1. In other words, the explain query has search down the whole table to find the row containing user_id = 1.
	Whereas the SELECT query returns the number of values of the column 'id'(number of times the column 'id' is not null). The explain query can be optimized by adding index on column 'user_id' and the count query can be optimized by adding an auto_increment field to the table.




--Q.(3)--
mysql> select * from comments where article_name = 'Android vs iphone' and author_id = 1;
+-----------+-------------------+----------------------+
| author_id | article_name      | comment_is           |
+-----------+-------------------+----------------------+
|         1 | Android vs iphone | Winner is Android    |
|         1 | Android vs iphone | Jelly bean is superb |
+-----------+-------------------+----------------------+

mysql> explain select * from comments where article_name = 'Android vs iphone' and author_id = 1;
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
| id | select_type | table    | type | possible_keys | key  | key_len | ref  | rows | Extra       |
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
|  1 | SIMPLE      | comments | ALL  | NULL          | NULL | NULL    | NULL |   15 | Using where |
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
1 row in set (0.00 sec)


--ADDING INDEX TO author_id and article_name--
mysql> alter table comments add index author_art_index (author_id, article_name);
Query OK, 0 rows affected (0.22 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> explain select * from comments where article_name = 'Android vs iphone' and author_id = 1;
+----+-------------+----------+------+------------------+------------------+---------+-------------+------+-------------+
| id | select_type | table    | type | possible_keys    | key              | key_len | ref         | rows | Extra       |
+----+-------------+----------+------+------------------+------------------+---------+-------------+------+-------------+
|  1 | SIMPLE      | comments | ref  | author_art_index | author_art_index | 28      | const,const |    2 | Using where |
+----+-------------+----------+------+------------------+------------------+---------+-------------+------+-------------+
1 row in set (0.00 sec)




--Q.(4.1) Using join--
mysql> select a.* from users u inner join articles a on u.author_id = a.author_id where u.author = 'user2';
+-----------+----------------+-------------+
| author_id | article_name   | category    |
+-----------+----------------+-------------+
|         2 | Learning MySql | Education   |
|         2 | Global Warming | Environment |
|         2 | Cancer         | Medical     |
+-----------+----------------+-------------+
3 rows in set (0.00 sec)

mysql> explain select a.* from users u inner join articles a on u.author_id = a.author_id where u.author = 'user2';
+----+-------------+-------+------+---------------+------+---------+------+------+--------------------------------+
| id | select_type | table | type | possible_keys | key  | key_len | ref  | rows | Extra                          |
+----+-------------+-------+------+---------------+------+---------+------+------+--------------------------------+
|  1 | SIMPLE      | a     | ALL  | NULL          | NULL | NULL    | NULL |    7 |                                |
|  1 | SIMPLE      | u     | ALL  | PRIMARY       | NULL | NULL    | NULL |    4 | Using where; Using join buffer |
+----+-------------+-------+------+---------------+------+---------+------+------+--------------------------------+
2 rows in set (0.00 sec)

mysql> alter table users add index author_index (author);
Query OK, 0 rows affected (0.19 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table articles add index author_id_index (author_id);
Query OK, 0 rows affected (0.19 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> explain select a.* from users u inner join articles a on u.author_id = a.author_id where u.author = 'user2';
--After adding indexes on author column of users table and author_id column of articles table--
+----+-------------+-------+------+----------------------+-----------------+---------+-----------------------+------+-------------+
| id | select_type | table | type | possible_keys        | key             | key_len | ref                   | rows | Extra       |
+----+-------------+-------+------+----------------------+-----------------+---------+-----------------------+------+-------------+
|  1 | SIMPLE      | u     | ref  | PRIMARY,author_index | author_index    | 23      | const                 |    1 | Using where |
|  1 | SIMPLE      | a     | ref  | author_id_index      | author_id_index | 5       | knowledge.u.author_id |    1 | Using where |
+----+-------------+-------+------+----------------------+-----------------+---------+-----------------------+------+-------------+
2 rows in set (0.00 sec)





--Q.(4.2) without using joins (Using subquery)--
mysql> explain select * from articles where author_id = (select author_id from users where author = 'user2');
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
| id | select_type | table    | type | possible_keys | key  | key_len | ref  | rows | Extra       |
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
|  1 | PRIMARY     | articles | ALL  | NULL          | NULL | NULL    | NULL |    7 | Using where |
|  2 | SUBQUERY    | users    | ALL  | NULL          | NULL | NULL    | NULL |    4 | Using where |
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
2 rows in set (0.00 sec)

mysql> alter table users add index author_index (author);
Query OK, 0 rows affected (0.18 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table articles add index author_id_index (author_id);
Query OK, 0 rows affected (0.19 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> explain select * from articles where author_id = (select author_id from users where author = 'user2');
+----+-------------+----------+------+-----------------+--------------+---------+------+------+--------------------------+
| id | select_type | table    | type | possible_keys   | key          | key_len | ref  | rows | Extra                    |
+----+-------------+----------+------+-----------------+--------------+---------+------+------+--------------------------+
|  1 | PRIMARY     | articles | ALL  | author_id_index | NULL         | NULL    | NULL |    7 | Using where              |
|  2 | SUBQUERY    | users    | ref  | author_index    | author_index | 23      |      |    1 | Using where; Using index |
+----+-------------+----------+------+-----------------+--------------+---------+------+------+--------------------------+
2 rows in set (0.00 sec)

The query using inner join is faster than the query using a subquery because while using inner join only one row of 'articles' table is compared with one row of the 'users' table. In case of subquery, seven rows from 'articles' table is compared with one row of the 'users' table.
