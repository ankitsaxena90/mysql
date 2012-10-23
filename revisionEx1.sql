mysql> select * from tags;
+---------+--------+
| post_id | tag_id |
+---------+--------+
|       1 |      2 |
|       1 |      3 |
|       1 |      1 |
|       2 |      1 |
|       2 |      2 |
+---------+--------+
5 rows in set (0.00 sec)


(i) Write a query to select post_ids that have both 1 and 3 as tag_ids
mysql> select post_id from tags where post_id IN (select post_id from tags where tag_id = 1) and tag_id =3;
+---------+
| post_id |
+---------+
|       1 |
+---------+
1 row in set (0.00 sec)
