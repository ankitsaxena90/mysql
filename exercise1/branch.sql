mysql> create table branch (bcode varchar(5), librarian varchar(20), address varchar(20));
Query OK, 0 rows affected (0.12 sec)

mysql> insert into branch values ('B1','John Smith','2 Anglesea Rd'),('B2','Marry Jones','34 Pearse St'),('B3','Francis Owens','Grange X');
Query OK, 3 rows affected (0.04 sec)
Records: 3  Duplicates: 0  Warnings: 0
mysql> select * from branch ;
+-------+---------------+---------------+
| bcode | librarian     | address       |
+-------+---------------+---------------+
| B1    | John Smith    | 2 Anglesea Rd |
| B2    | Marry Jones   | 34 Pearse St  |
| B3    | Francis Owens | Grange X      |
+-------+---------------+---------------+
3 rows in set (0.00 sec)


mysql> create table titles (title varchar(20), author varchar(20), publisher varchar(20));
Query OK, 0 rows affected (0.12 sec)

mysql> insert into titles values ('Susannah','Ann Brown','Macmillan'),('How to Fish','Amy Fly','Stop Press'),('A History of Dustbin','David Little','Wiley'),('Computers','Blaise Pascal','Applewoods'),('The Wife','Ann Brown','Macmillan');
Query OK, 5 rows affected (0.05 sec)
Records: 5  Duplicates: 0  Warnings: 0
mysql> select * from titles ;
+----------------------+---------------+------------+
| title                | author        | publisher  |
+----------------------+---------------+------------+
| Susannah             | Ann Brown     | Macmillan  |
| How to Fish          | Amy Fly       | Stop Press |
| A History of Dustbin | David Little  | Wiley      |
| Computers            | Blaise Pascal | Applewoods |
| The Wife             | Ann Brown     | Macmillan  |
+----------------------+---------------+------------+
5 rows in set (0.00 sec)


mysql> create table holdings (branch varchar(5), title varchar(20), copies int);
Query OK, 0 rows affected (0.11 sec)

mysql> insert into holdings values ('B1','Susannah',3),('B1','How to',2),('B1','A hist',1),('B2','How to',4),('B2','Computers',2),('B2','The Wife',3),('B3','A hist ..',1),('B3','Computers',4),('B3','Susannah',3),('B3','The Wife',1);
Query OK, 10 rows affected (0.04 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> select * from holdings;
+--------+-----------+--------+
| branch | title     | copies |
+--------+-----------+--------+
| B1     | Susannah  |      3 |
| B1     | How to    |      2 |
| B1     | A hist    |      1 |
| B2     | How to    |      4 |
| B2     | Computers |      2 |
| B2     | The Wife  |      3 |
| B3     | A hist .. |      1 |
| B3     | Computers |      4 |
| B3     | Susannah  |      3 |
| B3     | The Wife  |      1 |
+--------+-----------+--------+
10 rows in set (0.00 sec)





(i). The names of all library books published by Macmillan. 
mysql> select title from titles where publisher = 'Macmillan';
+----------+
| title    |
+----------+
| Susannah |
| The Wife |
+----------+
2 rows in set (0.00 sec)





(ii). branches that hold any books by Ann Brown (using a nested subquery).
 select distinct branch from holdings where title IN (select title from titles where author = 'Ann Brown');
+--------+
| branch |
+--------+
| B1     |
| B2     |
| B3     |
+--------+
3 rows in set (0.00 sec)





(iii). Branches that hold any books by Ann Brown (without using a nested subquery).
mysql> select distinct h.branch from holdings h, titles t where h.title = t.title and t.author = 'Ann Brown';
+--------+
| branch |
+--------+
| B1     |
| B2     |
| B3     |
+--------+
3 rows in set (0.00 sec)





(iv).the total number of books held at each branch. 
mysql> select branch, count(branch) from holdings group by branch;
+--------+---------------+
| branch | count(branch) |
+--------+---------------+
| B1     |             3 |
| B2     |             3 |
| B3     |             4 |
+--------+---------------+
3 rows in set (0.00 sec)


