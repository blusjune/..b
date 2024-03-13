#!/bin/bash
# 20230820_235813




_db_dump_dir="bxd_obj_mediawiki";
_db_user="neo";
_db_name="matrix_radiohead";
_db_dump_prefix="mediawiki_db_dump";
_db_dump_file_with_tstamp_radix="${_db_dump_prefix}.${_db_name}.tstamp";
_db_dump_file_with_tstamp="${_db_dump_file_with_tstamp_radix}.$(..ts).sql";
_db_dump_file_latest="${_db_dump_prefix}.${_db_name}.latest.sql";
_db_dump_file_latest_dir=".files.d/wiki_db_dump";




function _wiki_db_list()
{
	echo "### INF:  0. Check the SQL dump files we have";
	echo "____________";
	ls -alF ${_db_dump_dir}/;
	echo "____________";
	echo "";
	main_func;
}




function _wiki_db_dump()
{
	mysqldump -u $_db_user -p --databases $_db_name > ${_db_dump_dir}/${_db_dump_file_with_tstamp} ;
	( cd ${_db_dump_file_latest_dir} ; rm -f ${_db_dump_file_latest} ${_db_dump_file_with_tstamp_radix}.*.sql ; )
	cp -p  ${_db_dump_dir}/${_db_dump_file_with_tstamp}  ${_db_dump_file_latest_dir}/ ;
	( cd ${_db_dump_file_latest_dir} ; ln -s ${_db_dump_file_with_tstamp} ${_db_dump_file_latest} ; )
}




function _wiki_db_load()
{
	_sql_file_for_prep=".tmp.mysql_load.prep.sql";
	cat > $_sql_file_for_prep << EOF
	drop database $_db_name;
	create database $_db_name;
EOF


	echo "### INF:  0. Check the latest 10 SQL dump files";
	echo "____________";
	ls -alF ${_db_dump_dir}/ | tail -10;
	echo "____________";
	echo "";


	echo "### INF:  1. Prep";
	echo "____________";
	cat $_sql_file_for_prep;
	echo "____________";
	read -p "### ASK:  Do you want to execute this SQL commands? [Y|n] " _answer;
	if [ "X$_answer" = "Xy" ]; then
		set -x;
		mysql -p -u $_db_user < $_sql_file_for_prep # > db_load_result.log
		set +x;
	else
		echo "### INF:  Nothing happened"
	fi


	echo "### INF:  2. Main (load DB with SQL dump file)";
	echo "____________";
	ls -alF ${_db_dump_dir}/;
	echo "____________";
	_sql_dumpfile_for_load=$(cd $_db_dump_dir; ls -1t ${_db_dump_file_with_tstamp_radix}.*.sql | head -1);
	echo $_sql_dumpfile_for_load;
	echo "____________";
	read -p "### ASK:  Do you want to load DB with SQL dump file above? [Y|n] " _answer;
	if [ "X$_answer" = "Xy" ]; then
		set -x;
		mysql -p -u $_db_user < ${_db_dump_dir}/${_sql_dumpfile_for_load} # > db_load_result.log
		set +x;
	else
		echo "### INF:  Nothing happened"
	fi
}




function main_func()
{
read -p "### ASK:  (0) list?  (1) dump?  (2) load?  (9) exit?  [0|1|2|9] " _answer;
#read -p "### ASK:  (0) list files?  (1) DB dump?  (2) DB load?  (9) exit?  [0|1|2|9] " _answer;
case $_answer in
	"0"|"list"|"l"|"L")
		echo "=============================================================";
		echo "-------------------------------------------------------------";
		echo "### INF:  list DB SQL files";
		_wiki_db_list;
		echo "-------------------------------------------------------------";
		echo "=============================================================";
		;;
	"1"|"dump"|"d"|"D")
		echo "=============================================================";
		echo "-------------------------------------------------------------";
		echo "### INF:  dump the DB '$_db_name' to a file: Start";
		_wiki_db_dump;
		echo "### INF:  dump the DB '$_db_name' to a file: Finished";
		echo "-------------------------------------------------------------";
		echo "=============================================================";
		;;
	"2"|"load"|"l"|"L")
		echo "=============================================================";
		echo "-------------------------------------------------------------";
		echo "### INF:  load the DB '$_db_name' from a file: Start";
		_wiki_db_load;
		echo "### INF:  load the DB '$_db_name' from a file: Finished";
		echo "-------------------------------------------------------------";
		echo "=============================================================";
		;;
	"9"|"exit"|"e"|"E")
		echo "=============================================================";
		echo "-------------------------------------------------------------";
		echo "### INF:  exit this program:  $0";
		echo "-------------------------------------------------------------";
		echo "=============================================================";
		;;
	*)
		echo "=============================================================";
		echo "-------------------------------------------------------------";
		echo "### INF:  wrong input - it will do nothing";
		echo "-------------------------------------------------------------";
		echo "=============================================================";
		exit 0;
		;;
esac
}




main_func;
