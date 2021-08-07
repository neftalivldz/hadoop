wget https://github.com/selva86/datasets/raw/master/BostonHousing.csv


# Bases de datos
create database hola;
show databases;
describe database extended hola;
drop database hola;
show databases like 'hola*';

# Si tienen tablas
drop database hola cascade;

# Managed Tables - Schema & Data
CREATE TABLE hola.customers
(custid INT, fName STRING, lName STRING, city STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

DESCRIBE FORMATTED customers;

select * from hola.customers;

LOAD DATA LOCAL INPATH '/usr/local/customer-hive' overwrite into
table 'customers';

select * from customers limit 5;
describe formatted customers;

hdfs dfs -ls /user/hive/customers;
hdfs dfs -ls /usr/local/customer-hive;

drop table customers;

hdfs dfs -ls /user/hive/cusromers;
hdfs dfs -ls /usr/local/customer-hive;

## External table
CREATE EXTERNAL TABLE customers
(custId INT, fName STRING, lName String, city STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/user/cloudera/customer-hive';

select * from customes limit 5;

drop table customers;

hdfs dfs -ls /usr/local/customer-hive;

CREATE EXTERNAL TABLE curso
(name String, Students INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/cloudera/curso.txt';

CREATE TABLE curso
(name String, Students INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/user/cloudera/curso_pipe.txt';


vi curso.txt
Literatura,10
Matemáticas,22
Inglés,14
Física,14
Cómputo,15

LOAD DATA LOCAL INPATH '/home/cloudera/curso.txt' INTO TABLE curso;

select * from curso;

INSERT INTO curso values(Biología, 30);

CREATE EXTERNAL customer_data
(name STRING, ciudad STRING);

DESCRIBE customer_data;

select * from customer_new limit 5;

INSERT INTO customer_new select fname, city from customer_new;

CREATE EXTERNAL table customer_brownsville
(fname String, lname String, city String);

insert into customer_brownsville select fname, lname, city from customer;

insert overwrite into customer_brownsville select fname, lname, city from customer;

decribe table customer_temp;

Alter table customer_temp add columns (age Int, email String);

describe table customer_temp;

select * from customer_temp limit 5;

decribe customer_temp;

alter table customer_temp
change column id customer_id int;

describe customer_temp;

alter table customer_temp rename to customer_detail;

describe customer_temp;

describe customer_detail;

DESCRIBE FORMATTED customer_detail;

Alter table customer_detail
set TBLPROPERTIES('auto.purge'='true');

DESCRIBE FORMATTED customer_detail;

alter table customer_detail
set fileformat avro;

DESCRIBE FORMATTED customer_detail;

alter table customer_detail
set location '/user/cloudera/customers';

DESCRIBE FORMATTED customer_detail;


# Math Functions
ceil floor
select rand();
select sqrt(12);
select power(2,3)


## Joins
select m.movie_name, rm.rating
from movie m join movie_rating mr
on (m.movieid = mr.movieid);

SET HIVE.AUTO.CONVERT.JOIN = FALSE;

select m.movie_name, rm.rating
from movie m LEFT OUTER JOIN movie_rating mr
on (m.movieid = mr.movieid);

RIGHT
FULL
MULTI
/*+ STREAMTABLES(user) */



Map Side Joins
hive.auto.convert.join=true
set hive.mapjoin.smalltable.filesize=30000000

select /*+ MAPJOIN(b) */ a.key, a.value from a join b on a.key = b.key;


#Parquet

create table customer_parquet stored as Parquet location '/user/local/customer'
as select * from customers;


hiveset parquet.com.compression=SNAPPY;
set.exec.compress.output;
set.exec.compress.output = true;

set parquet.compression=GZIP;

create table customer_parquet_snappy
stored as parquetas select * from customer;

describe formatted customer_parquet_snappy;

## Regular Expression
create external table employee_fixed
(empid int, name string, age int)
row format serde'org.apache.hadoop.hive.serde2.RegexSerDe'
wiht SERDEPROPERTIES('input.regex'=(.{4})(.{10})(.{2}))
location '/user/clu/eployee-fixed';


## Partition
create external table employee_fixed
(ordid int, date string, custid int)
Partitioned by (status STRING)
row format serde'org.apache.hadoop.hive.serde2.RegexSerDe'
fields TERMINATEDby ',';

set hive.exec.dynamic.partition;
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insrte overwrite table orders_partitioned
partition (status)
select orderod, date, custid, status from orders;

show partitions orders_partitioned;


# Bucketing
create external table orders_bucketed
(orderid INT, date STRING, custid INT, status STRING)
CLUSTERED BY (custid) into 10 BUCKETS
ROW FORMAT DELIMITED FIELS TERMINATED BY ',';

set hive.enforce.bucketing;
set hive.enforce.bucketing = true;

# Sólo overwrite
insert overwrite table orders_bucketed
select ordid, date, custid, status from orders;

## Views

create view customer_las_vegas as select * from customer_new
where city = "Las Vegas";

select * from customer_las_vegas;

describe formatted customer_las_vegas;
# -- Table Type

drop view customer_las_vegas;

# Lateral view /explode - Arrays
describe actors;
select actor_name, movie
from actors
lateral view explote(movies_name) tbl2 as movie;

# Analysis
# count(*), max(*),


select city, count(*)
from customers
group by city
order by city
limit 100;

count(*)

select city, count(*)
from customers
group by city having count(*)> 200
order by city
limit 100;

select city, if(count(*)>50,1,0) as bigCity
from customers
group by city;

min, max, sum, avg

# Windowing
select product_name, category, price, rank()
over (partition by category order by price desc) as product_rank,
dense_rank() over (partition by category order by price) as product_dense_rank;

# Lead/ Lag

lead(salary) over (partition by role order by salary desc) as lead_salary,
lag(salary) over (partition by role order by salary desc) as lag_salary

select * from employee_salary;

describe employee_salary;

select emp_name, role, salary,
lead(salary) over (partition by role order by salary desc) as lead_salary,
lag(salary) over (partition by role order by salary desc) as lag_salary
from employee_salary;

select product_name, category, price,
count(*) over (partition by category) as count,
min(price) over (partition by category) as min,
max(price) over (partition by category) as max,
sum(price) over (partition by category) as sum
from products;
 
## Windows Specifications

select emp_name, role, salary,
min(salary) over (partition by role rows between current row and unbounded following) as min_salary
from employee_salary;

select emp_name, role, salary,
max(salary) over (partition by role rows between current row and 1 following) as min_salary
from employee_salary;

rows between current row and unbounded following
rows between current row and n following
rows between unbounded preceding row and current row
rows between unbounded preceding and n following
rows between unbounded row and unbounded following
rows between n preceding and n following

