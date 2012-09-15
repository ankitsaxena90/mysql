mysql> create database demo2;
Query OK, 1 row affected (0.00 sec)
mysql> grant all privileges on demo2.* to demo2Admin@localhost identified by 'demo123';
Query OK, 0 rows affected (0.00 sec)


---CREATING NEW TABLE-TESTING_TABLE----
mysql>create table testing_table (name varchar(20), contact_name varcha(20), roll_no varchar(10));
mysql> describe testing_table;
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| name         | varchar(20) | YES  |     | NULL    |       |
| contact_name | varchar(20) | YES  |     | NULL    |       |
| roll_no      | varchar(10) | YES  |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)


---DELETE COLUMN-NAME---
mysql> alter table testing_table drop name;
Query OK, 0 rows affected (0.22 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> describe testing_table;
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| contact_name | varchar(20) | YES  |     | NULL    |       |
| roll_no      | varchar(10) | YES  |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)



---RENAME CONTACT_NAME TO USERNAME---
mysql> alter table testing_table change contact_name username varchar(20);
Query OK, 0 rows affected (0.24 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> describe testing_table;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| username | varchar(20) | YES  |     | NULL    |       |
| roll_no  | varchar(10) | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)




----ADDING TWO COLUMNS-FIRST_NAME AND LAST_NAME---
mysql> alter table testing_table add first_name varchar(20) after username;
Query OK, 0 rows affected (0.35 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table testing_table add last_name varchar(20) after first_name;
Query OK, 0 rows affected (0.23 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> describe testing_table;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| username   | varchar(20) | YES  |     | NULL    |       |
| first_name | varchar(20) | YES  |     | NULL    |       |
| last_name  | varchar(20) | YES  |     | NULL    |       |
| roll_no    | varchar(10) | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)




---MODIFY ROLL_NO FROM VARCHAR TO INT---
mysql> alter table testing_table modify column roll_no int;
Query OK, 0 rows affected (0.23 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> describe testing_table;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| username   | varchar(20) | YES  |     | NULL    |       |
| first_name | varchar(20) | YES  |     | NULL    |       |
| last_name  | varchar(20) | YES  |     | NULL    |       |
| roll_no    | int(11)     | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
4 rows in set (0.01 sec)



