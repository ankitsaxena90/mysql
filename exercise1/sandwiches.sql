mysql> create database sandwich;
Query OK, 1 row affected (0.01 sec)

mysql> grant all privileges on sandwich.* to admin@localhost identified by 'sandwich123';
Query OK, 0 rows affected (0.00 sec)
mysql> use sandwich
Database changed

mysql> create table tastes (name varchar(10), filling varchar(20));
Query OK, 0 rows affected (0.11 sec)
mysql> insert into tastes values  ('Brown', 'Turkey'), ('Brown', 'Beef'), ('Brown', 'Ham'), ('Jones', 'Cheese'), ('Green', 'Beef'), ('Green', 'Turkey'), ('Green', 'Cheese');
Query OK, 7 rows affected (0.05 sec)
Records: 7  Duplicates: 0  Warnings: 0
mysql> select * from tastes;
+-------+---------+
| name  | filling |
+-------+---------+
| Brown | Turkey  |
| Brown | Beef    |
| Brown | Ham     |
| Jones | Cheese  |
| Green | Beef    |
| Green | Turkey  |
| Green | Cheese  |
+-------+---------+
7 rows in set (0.00 sec)

insert into sandwiches values ('Lincoln','Rye','Ham',1.25), ("O'Neill's", 'White','Cheese',1.20), ("O'Neill's", 'Whole','Ham',1.25), ('Old Nag','Rye','Beef',1.35), ('Buttery','White','Cheese',1.00),("O'Neill's",'White','Turkey',1.35), ('Buttery', 'White', 'Ham',1.10), ('Lincoln', 'Rye','Beef',1.35),('Lincoln','White','Ham',1.30), ('Old Nag', 'Rye','Ham',1.40);
Query OK, 10 rows affected (0.07 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> select * from sandwiches;
+-----------+-------+---------+-------+
| location  | bread | filling | price |
+-----------+-------+---------+-------+
| Lincoln   | Rye   | Ham     |  1.25 |
| O'Neill's | White | Cheese  |  1.20 |
| O'Neill's | Whole | Ham     |  1.25 |
| Old Nag   | Rye   | Beef    |  1.35 |
| Buttery   | White | Cheese  |  1.00 |
| O'Neill's | White | Turkey  |  1.35 |
| Buttery   | White | Ham     |  1.10 |
| Lincoln   | Rye   | Beef    |  1.35 |
| Lincoln   | White | Ham     |  1.30 |
| Old Nag   | Rye   | Ham     |  1.40 |
+-----------+-------+---------+-------+
10 rows in set (0.00 sec)


mysql> create table locations (lname varchar(20), phone varchar(15), address varchar(20));
Query OK, 0 rows affected (0.13 sec)
mysql> insert into locations values ('Lincoln','6834523','Lincoln Place'), ("O'Neill's",'6742134','Pearse St'), ('Old Nag','7678132','Dame St'),('Buttery','7023421','College St');
Query OK, 4 rows affected (0.04 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> select * from locations;
+-----------+---------+---------------+
| lname     | phone   | address       |
+-----------+---------+---------------+
| Lincoln   | 6834523 | Lincoln Place |
| O'Neill's | 6742134 | Pearse St     |
| Old Nag   | 7678132 | Dame St       |
| Buttery   | 7023421 | College St    |
+-----------+---------+---------------+
4 rows in set (0.01 sec)



(i) places where Jones can eat (using a nested subquery). 
mysql> select location from sandwiches where filling = (select filling from tastes where name = 'Jones')
+-----------+
| location  |
+-----------+
| O'Neill's |
| Buttery   |
+-----------+
2 rows in set (0.00 sec)





(ii). Places where Jones can eat (without using a nested subquery). 
mysql> select s.location from sandwiches s, tastes t where s.filling = t.filling and t.name = 'Jones';
+-----------+
| location  |
+-----------+
| O'Neill's |
| Buttery   |
+-----------+
2 rows in set (0.00 sec)



(iii) for each location the number of people who can eat there
select count(distinct name) as No_of_People from tastes where filling = ANY (select filling from sandwiches where location = 'Lincoln');
+--------------+
| No_of_People |
+--------------+
|            2 |
+--------------+
1 row in set (0.00 sec)

 select count(distinct name) as No_of_People from tastes where filling = ANY (select filling from sandwiches where location = "O'Neill's");
+--------------+
| No_of_People |
+--------------+
|            3 |
+--------------+
1 row in set (0.00 sec)

mysql> select count(distinct name) as No_of_People from tastes where filling = ANY (select filling from sandwiches where location = 'Buttery');
+--------------+
| No_of_People |
+--------------+
|            3 |
+--------------+
1 row in set (0.00 sec)

mysql> select count(distinct name) as No_of_People from tastes where filling = ANY (select filling from sandwiches where location = 'Old Nag');
+--------------+
| No_of_People |
+--------------+
|            2 |
+--------------+
1 row in set (0.00 sec)



