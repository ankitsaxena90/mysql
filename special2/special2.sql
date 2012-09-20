mysql> create table data (email varchar(30), phone_no varchar(10), city varchar(20));
Query OK, 0 rows affected (0.12 sec)

mysql> load data local infile 'email_subscribers.csv' into table data fields terminated by ',' lines terminated by '\n' (email,phone_no,city);
Query OK, 200 rows affected (0.08 sec)
Records: 200  Deleted: 0  Skipped: 0  Warnings: 0

(i) What all cities did people respond from?
mysql> select distinct city from data;
+-----------+
| city      |
+-----------+
|  Lucknow  |
|  Chennai  |
|  Kolkatta |
|  Delhi    |
|  Mumbai   |
+-----------+
5 rows in set (0.00 sec)




(ii) How many people responded from each city
mysql> select city, count(city) as N0_of_People from data group by city;
+-----------+--------------+
| city      | N0_of_People |
+-----------+--------------+
|  Chennai  |           42 |
|  Delhi    |           40 |
|  Kolkatta |           38 |
|  Lucknow  |           39 |
|  Mumbai   |           41 |
+-----------+--------------+
5 rows in set (0.00 sec)




(iii) Which city were the maximum respondents from?
mysql> select city, count(city) as N0_of_People from data group by city order by count(city) desc Limit 1;
+----------+--------------+
| city     | N0_of_People |
+----------+--------------+
|  Chennai |           42 |
+----------+--------------+
1 row in set (0.01 sec)





(iV) What all email domains did people respond from?
mysql> select distinct substring_index(email,'@',-1) as Email_Domains from data; 
+---------------+
| Email_Domains |
+---------------+
| hotmail.com   |
| yahoo.com     |
| me.com        |
| gmail.com     |
+---------------+
4 rows in set (0.01 sec)





(v) Which is the most popular email domain among the respondents ?
mysql> select distinct substring_index(email,'@',-1) as Email_Domains, count(substring_index(email,'@',-1)) as No_of_Users from data group by Email_domains order by Email_Domains desc Limit 2;
+---------------+-------------+
| Email_Domains | No_of_Users |
+---------------+-------------+
| yahoo.com     |          51 |
| me.com        |          51 |
+---------------+-------------+
2 rows in set (0.00 sec)


