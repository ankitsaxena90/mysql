mysql> create database knowledge;
Query OK, 1 row affected (0.00 sec)

mysql> grant all privileges on knowledge.* to admin@localhost identified by 'knowledge123';
Query OK, 0 rows affected (0.00 sec)

mysql> use knowledge;
Database changed

mysql> create table users (author_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, author varchar(20), user_type varchar(10));
Query OK, 0 rows affected (0.12 sec)
mysql> insert into users (author,user_type) values ('user1', 'local'),('user2', 'admin'),('user3','local'),('user4','admin');
Query OK, 4 rows affected (0.04 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> select * from users;
+-----------+--------+-----------+
| author_id | author | user_type |
+-----------+--------+-----------+
|         1 | user1  | local     |
|         2 | user2  | admin     |
|         3 | user3  | local     |
|         4 | user4  | admin     |
+-----------+--------+-----------+
4 rows in set (0.00 sec)



mysql> create table articles (author_id int, article_name varchar(20), category varchar(20));
Query OK, 0 rows affected (0.11 sec)

mysql> insert into articles values (1,'Olympics','Sports'),('2','Learning MySql','Education'),(3,'Android vs iphone','Technology'),(2,'Global Warming','Environment'),(3,'Green Energy','Environment'),(2,'Cancer','Medical'),(3,'Gesture Recognition','Technology');
Query OK, 7 rows affected (0.03 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> select * from articles;
+-----------+---------------------+-------------+
| author_id | article_name        | category    |
+-----------+---------------------+-------------+
|         1 | Olympics            | Sports      |
|         2 | Learning MySql      | Education   |
|         3 | Android vs iphone   | Technology  |
|         2 | Global Warming      | Environment |
|         3 | Green Energy        | Environment |
|         2 | Cancer              | Medical     |
|         3 | Gesture Recognition | Technology  |
+-----------+---------------------+-------------+
7 rows in set (0.00 sec)





mysql> create table comments (author_id int, article_name varchar(20), comment varchar(50));
Query OK, 0 rows affected (0.13 sec)
mysql> insert into comments values (1,'Android vs iphone','Winner is Android'),(2,'Android vs iphone','Nice article'),(3,'Android vs iphone','my vote for iphone'),(1,'Android vs iphone','Jelly bean is superb'),(1,'Olympics','Good'),(2,'Olympics','Nice article'),(1,'Olympics','USA top the medal tally'),(3,'Global Warming','Need to be checked'),(1,'Green Energy','Good'),(2,'Green Energy','Save earth'),(2,'Green energy','5 star'),(3,'Cancer','asnkjan'),(1,'Cancer','3 star'),(3,'Cancer','Nice article'),(2,'Gesture Recognition','superlike');
Query OK, 14 rows affected (0.04 sec)
Records: 14  Duplicates: 0  Warnings: 0
mysql> select * from comments;
+-----------+---------------------+-------------------------+
| author_id | article_name        | comment_is              |
+-----------+---------------------+-------------------------+
|         1 | Android vs iphone   | Winner is Android       |
|         2 | Android vs iphone   | Nice article            |
|         3 | Android vs iphone   | my vote for iphone      |
|         1 | Android vs iphone   | Jelly bean is superb    |
|         1 | Olympics            | Good                    |
|         2 | Olympics            | Nice article            |
|         1 | Olympics            | USA top the medal tally |
|         3 | Global Warming      | Need to be checked      |
|         1 | Green Energy        | Good                    |
|         2 | Green Energy        | Save earth              |
|         2 | Green energy        | 5 star                  |
|         3 | Cancer              | asnkjan                 |
|         1 | Cancer              | 3 star                  |
|         3 | Cancer              | Nice article            |
|         2 | Gesture Recognition | superlike               |
+-----------+---------------------+-------------------------+
15 rows in set (0.00 sec)


(i) select all articles whose author is user3. 
mysql> select article_name from articles where author_id = (select author_id from users where author = 'user3');
+---------------------+
| article_name        |
+---------------------+
| Android vs iphone   |
| Green Energy        |
| Gesture Recognition |
+---------------------+
3 rows in set (0.00 sec)





(ii). For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query
mysql> select c.article_name, c.comment_is from comments c 
where c.article_name =ANY (select a.article_name from articles a, users u where a.author_id = u.author_id and u.author = 'user3');
+---------------------+----------------------+
| article_name        | comment_is           |
+---------------------+----------------------+
| Android vs iphone   | Winner is Android    |
| Android vs iphone   | Nice article         |
| Android vs iphone   | my vote for iphone   |
| Android vs iphone   | Jelly bean is superb |
| Green Energy        | Good                 |
| Green Energy        | Save earth           |
| Green energy        | 5 star               |
| Gesture Recognition | superlike            |
+---------------------+----------------------+
8 rows in set (0.00 sec)





(iii). Write a query to select all articles which do not have any comments
mysql> select a.article_name from articles a left join comments c on a.article_name = c.article_name where c.article_name is null;
+----------------+
| article_name   |
+----------------+
| Learning MySql |
+----------------+
1 row in set (0.00 sec)





(iv). Write a query to select article which has maximum comments
mysql> select article_name, count(article_name) as No_of_Comments from comments x group by article_name order by count(article_name) desc limit 1;
+-------------------+----------------+
| article_name      | No_of_Comments |
+-------------------+----------------+
| Android vs iphone |              4 |
+-------------------+----------------+
1 row in set (0.00 sec)





(v). Write a query to select article which does not have more than one comment by the same user ( do this using left join and also do it using group by )
mysql> select article_name, count(article_name) as No_of_Comments from comments group by article_name having count(article_name) < 2;
+---------------------+----------------+
| article_name        | No_of_Comments |
+---------------------+----------------+
| Gesture Recognition |              1 |
| Global Warming      |              1 |
+---------------------+----------------+
2 rows in set (0.00 sec)



