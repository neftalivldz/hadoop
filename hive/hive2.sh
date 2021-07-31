
sqoop import \
  --connect jdbc:mysql://localhost/retail_db \
  --username retail_dba \
  --password cloudera \
  --table customers \
  --warehouse-dir /user/cloudera/retail_db


CREATE TABLE curso.customers
(customer_id INT, customer_fname STRING, customer_lname STRING, customer_email STRING, customer_password STRING, customer_street STRING, customer_city STRING, customer_state STRING, customer_zipco STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

## desde unix
cd /home/cloudera/
hdfs dfs -copyToLocal /user/cloudera/retail_db/customers customers
ls

## desde hive
LOAD DATA LOCAL INPATH '/home/cloudera/customers/part-m-00000' overwrite into
table customers;