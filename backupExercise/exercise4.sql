---BACKUP---
vijay@vijay-laptop:~$ mysqldump -u admin -psandwich123 sandwich > sandwich.sql;



---RESTORE---
vijay@vijay-laptop:~$ mysql -u root -p123456 restored < sandwich.sql;
vijay@vijay-laptop:~$ mysql -h localhost -u restored_admin -p restored
mysql> show tables;
+--------------------+
| Tables_in_restored |
+--------------------+
| branch             |
| holdings           |
| locations          |
| sandwiches         |
| tastes             |
| titles             |
+--------------------+
6 rows in set (0.00 sec)

