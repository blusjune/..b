#!/bin/bash

_sql_cmd_file=".tmp.mysql_restore.sql";
cat > $_sql_cmd_file << EOF
show databases;
show tables from matrix;
EOF
#drop matrix;
#create database matrix;

echo "____________";
cat $_sql_cmd_file;
echo "____________";
read -p "Do you want to execute this SQL statements? [Y|n] " _answer;
if [ "X$_answer" = "Xy" ]; then
	echo "mysql -p -u neo < $_sql_cmd_file > result.log";
	mysql -p -u neo < $_sql_cmd_file > result.log
else
	echo "Nothing happened"
fi


