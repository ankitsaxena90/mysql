mysql> create database vinsol_assets;
Query OK, 1 row affected (0.00 sec)

mysql> grant all privileges on vinsol_assets.* to vinsol_admin@localhost identified by 'vinsol123';
Query OK, 0 rows affected (0.00 sec)
mysql> use vinsol_assets;
Database changed

mysql> create table employees (emp_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, emp_name varchar(20));
Query OK, 0 rows affected (0.15 sec)

create table assets (asset_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, asset_name varchar(15), year varchar(5), model varchar(20), manufacturer varchar(20), date_of_purchase DATE, price float(15,2), warranty(yrs) int)

mysql> create table repair (asset_id int, type_of_defect varchar(30), cost float(7,4), warranty varchar(10));
Query OK, 0 rows affected (0.10 sec)

mysql> create table allocation (asset_id int, emp_id int, date_assignedFrom varchar(15), date_assignedUpto varchar(15),location varchar(20));
Query OK, 0 rows affected (0.10 sec)

--Inserting data into employees table--
mysql> insert into employees (emp_name) values ('Alice'),('Bob'),('Chris'),('Duke'),('Emily');
Query OK, 5 rows affected (0.05 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from employees;
+--------+----------+
| emp_id | emp_name |
+--------+----------+
|      1 | Alice    |
|      2 | Bob      |
|      3 | Chris    |
|      4 | Duke     |
|      5 | Emily    |
+--------+----------+
5 rows in set (0.00 sec)

mysql> insert into assets (asset_name, year, model, manufacturer, date_of_purchase, price) values ('laptopA',2008,'Pavalion','hp','2008-05-23',42000.00) ('laptopB',2009,'Inspiron','Dell','2009-09-18',40000.00), ('iphoneA',2011,'4s','Apple','2011-04-18',45000.00),('iphoneB',2011,'4s','Apple','2011-01-10',45000.00),('ProjectorA','2011','MK-30','Sony','2011-08-15',35000.00),('PrinterA','2011','LBP-3500','Canon','2011-08-15',12000.00), ('PrinterB',2011,'JMD-3500','Epson','2011-09-10',15000.00), ('laptopN1',2012,'ultrabook','hp','2008-05-23',55000.00), ('laptopN2',2012,'MacBook Pro','Apple','2008-05-23',95000.00);
Query OK, 9 rows affected (0.05 sec)
Records: 9  Duplicates: 0  Warnings: 0

mysql> select * from assets;
+----------+------------+------+-------------+--------------+------------------+----------+----------+
| asset_id | asset_name | year | model       | manufacturer | date_of_purchase | price    | warranty |
+----------+------------+------+-------------+--------------+------------------+----------+----------+
|        1 | laptopA    | 2008 | Pavalion    | hp           | 2008-05-23       | 42000.00 |        1 |
|        2 | laptopB    | 2009 | Inspiron    | Dell         | 2009-09-18       | 40000.00 |        1 |
|        3 | iphoneA    | 2011 | 4s          | Apple        | 2011-04-18       | 45000.00 |        1 |
|        4 | iphoneB    | 2011 | 4s          | Apple        | 2011-01-10       | 45000.00 |        1 |
|        5 | ProjectorA | 2011 | MK-30       | Sony         | 2011-08-15       | 35000.00 |        1 |
|        6 | PrinterA   | 2011 | LBP-3500    | Canon        | 2011-08-15       | 12000.00 |        1 |
|        7 | PrinterB   | 2011 | JMD-3500    | Epson        | 2011-09-10       | 15000.00 |        1 |
|        8 | laptopN1   | 2012 | ultrabook   | hp           | 2012-06-08       | 55000.00 |        1 |
|        9 | laptopN2   | 2012 | MacBook Pro | Apple        | 2012-08-25       | 95000.00 |        1 |
+----------+------------+------+-------------+--------------+------------------+----------+----------+
9 rows in set (0.00 sec)

--Inserting into allocation table--
mysql>insert into allocation values (1,1,'01/01/2011','31/12/2011','private'), (1,2,'01/01/2012','till_date','private'), (2,2,'01/01/2011','31/12/2011','private'),(2,null,null,null,'manager_cupboard'), (8,null,null,null,'hr_almirah'), (9,null,null,null,'hr_almirah'), (3,1,'04/2011','till_date','private'), (4,2,'01/2011','till_date','private');
Query OK, 8 rows affected (0.04 sec)
mysql> insert into allocation (asset_id, location) values (5,'meeting_room'), (6,'meeting_room'),(7,'manager_cupboard');
Query OK, 3 rows affected (0.07 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select * from allocation;
+----------+--------+-------------------+-----------------+------------------+
| asset_id | emp_id | date_assignedFrom |date_assignedUpto| location         |
+----------+--------+-------------------+-----------------+------------------+
|        1 |      1 | 01/01/2011        | 31/12/2011      | private          |
|        1 |      2 | 01/01/2012        | till_date       | private          |
|        2 |      2 | 01/01/2011        | 31/12/2011      | private          |
|        2 |   NULL | NULL              | NULL            | manager_cupboard |
|        8 |   NULL | NULL              | NULL            | hr_almirah       |
|        9 |   NULL | NULL              | NULL            | hr_almirah       |
|        3 |      1 | 04/2011           | till_date       | private          |
|        4 |      2 | 01/2011           | till_date       | private          |
|        5 |   NULL | NULL              | NULL            | meeting_room     |
|        6 |   NULL | NULL              | NULL            | meeting_room     |
|        7 |   NULL | NULL              | NULL            | manager_cupboard |
+----------+--------+-------------------+-----------------+------------------+
11 rows in set (0.00 sec)


(i). Find the name of the employee who has been alloted the maximum number of assets till date
mysql> select emp_id, emp_name from employees where emp_id = (select emp_id from allocation order by count(emp_id) desc Limit 1);
+--------+----------+
| emp_id | emp_name |
+--------+----------+
|      1 | Alice    |
+--------+----------+
1 row in set (0.00 sec)





(ii). Identify the name of the employee who currently has the maximum number of assets as of today
mysql> select emp_id, emp_name from employees where emp_id = (select emp_id from allocation where date_assignedUpto = 'till_date' group by emp_name);
+--------+----------+
| emp_id | emp_name |
+--------+----------+
|      2 | Bob      |
+--------+----------+
1 row in set (0.00 sec)





(iii). Find name and period of all the employees who have used a Laptop - let’s say laptop A - since it was bought by the company.
mysql> select e.emp_id,e.emp_name,a.asset_name, al.date_assignedFrom,al.date_assignedUpto from assets a, employees e, allocation al where e.emp_id = al.emp_id and a.asset_id=al.asset_id and al.asset_id in (1,2,8,9) and al.emp_id is not null;
+--------+----------+------------+-------------------+-------------------+
| emp_id | emp_name | asset_name | date_assignedFrom | date_assignedUpto |
+--------+----------+------------+-------------------+-------------------+
|      1 | Alice    | laptopA    | 01/01/2011        | 31/12/2011        |
|      2 | Bob      | laptopA    | 01/01/2012        | till_date         |
|      2 | Bob      | laptopB    | 01/01/2011        | 31/12/2011        |
+--------+----------+------------+-------------------+-------------------+
3 rows in set (0.00 sec)




(iv). Find the list of assets that are currently not assigned to anyone hence lying with the asset manage (HR)
mysql> select a.asset_name from assets a, allocation al where a.asset_id = al.asset_id and al.location != 'private';
+------------+
| asset_name |
+------------+
| laptopB    |
| laptopN1   |
| laptopN2   |
| ProjectorA |
| PrinterA   |
| PrinterB   |
+------------+
6 rows in set (0.00 sec)





(v). An employee say Bob is leaving the company, write a query to get the list of assets he should be returning to the company.
mysql> select a.asset_name from assets a, allocation al where a.asset_id = al.asset_id and al.date_assignedUpto = 'till_date' and al.emp_id = (select emp_id from employees where emp_name = 'Bob');
+------------+
| asset_name |
+------------+
| laptopA    |
| iphoneB    |
+------------+
2 rows in set (0.00 sec)





(vi). Write a query to find assets which are out of warranty
mysql> select asset_name as out_of_warranty_assets from assets where datediff(curdate(), date_of_purchase)> 365;
+------------------------+
| out_of_warranty_assets |
+------------------------+
| laptopA                |
| laptopB                |
| iphoneA                |
| iphoneB                |
| ProjectorA             |
| PrinterA               |
| PrinterB               |
+------------------------+
7 rows in set (0.00 sec)





(vii). Return a list of Employee Names who do not have any asset assigned to them.
mysql> select e.emp_id, e.emp_name from employees e left join allocation al on e.emp_id = al.emp_id where al.emp_id is null;
+--------+----------+
| emp_id | emp_name |
+--------+----------+
|      3 | Chris    |
|      4 | Duke     |
|      5 | Emily    |
+--------+----------+
3 rows in set (0.00 sec)

