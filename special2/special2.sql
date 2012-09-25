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

select city, count(city) as N0_of_People from data group by city order by count(city) desc Limit 1;

mysql> select  x.city, x.No_of_People from (select e.city, count(e.city) as No_of_People from data e group by  e.city) x
where  x.No_of_People = (select max(x2.No_of_People) from (select e2.city, count(e2.city) as No_of_People from data e2 group by         e2.city) x2)
+----------+--------------+
| city     | N0_of_People |
+----------+--------------+
|  Chennai |           42 |
+----------+--------------+
1 row in set (0.00 sec)





(iV) What all email citys did people respond from?
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





(v) Which is the most popular email city among the respondents ?
mysql> select substring_index (x.email,'@',-1), x.No_of_Users
from  (select    substring_index(e.email,'@',-1), 
    count(substring_index(e.email,'@',-1)) as No_of_Users
  from data e
  group by substring_index(e.email,'@',-1)) x
where x.No_of_Users = 
    (select  max(x2.No_of_Users)
    from (select substring_index(e2.email,'@',-1) ,
         count(substring_index (e2.email,'@',-1)) as No_of_Users
      from data e2
      group by 
        substring_index(e2.email,'@',-1)) x2)
+---------------+-------------+
| Email_citys 	| No_of_Users |
+---------------+-------------+
| yahoo.com     |          51 |
| me.com        |          51 |
+---------------+-------------+
2 rows in set (0.00 sec)


