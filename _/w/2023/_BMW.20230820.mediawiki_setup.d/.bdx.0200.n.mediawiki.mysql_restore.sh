#!/bin/bash


_sql_dump_dir="bxd_obj_mediawiki";

_sql_file_for_prep=".tmp.mysql_restore.prep.sql";
cat > $_sql_file_for_prep << EOF
drop database matrix_radiohead;
create database matrix_radiohead;
EOF
#drop matrix_radiohead;
#create database matrix_radiohead;

echo "1. Prep";
echo "____________";
cat $_sql_file_for_prep;
echo "____________";
read -p "Do you want to execute this SQL commands? [Y|n] " _answer;
if [ "X$_answer" = "Xy" ]; then
	echo "mysql -p -u neo < $_sql_file_for_prep > result.log";
	mysql -p -u neo < $_sql_file_for_prep > result.log
else
	echo "Nothing happened"
fi


echo "2. Main (restore DB with SQL dump file)";
echo "____________";
ls -alF ${_sql_dump_dir}/;
echo "____________";
_sql_dumpfile_for_restore=$(cd $_sql_dump_dir; ls -1t mediawiki_db_dump.*.sql | head -1);
echo $_sql_dumpfile_for_restore;
echo "____________";
read -p "Do you want to restore DB with SQL dump file above? [Y|n] " _answer;
if [ "X$_answer" = "Xy" ]; then
	echo "mysql -p -u neo < ${_sql_dump_dir}/${_sql_dumpfile_for_restore} > result.log";
	mysql -p -u neo < ${_sql_dump_dir}/${_sql_dumpfile_for_restore} > result.log
else
	echo "Nothing happened"
fi


