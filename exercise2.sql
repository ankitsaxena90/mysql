mysql> create database vtapp;
Query OK, 1 row affected (0.00 sec)

mysql> create user 'vtapp_user'@'localhost' identified by 'vtapp123';
Query OK, 0 rows affected (0.00 sec)

mysql> grant all privileges on vtapp.* to vtapp_user identified by 'vtapp123';
Query OK, 0 rows affected (0.00 sec)

mysql> use vtapp;
Database changed

