#!/bin/bash
# 20230820_235813




_db_dump_dir="bxd_obj_mediawiki";
_db_user="neo";
_db_name="matrix_radiohead";
_db_dump_prefix="mediawiki_db_dump";
_db_dump_file_with_tstamp="${_db_dump_prefix}.${_db_name}.$(..ts).sql";
_db_dump_file_latest="${_db_dump_prefix}.${_db_name}.latest.sql";
_db_dump_file_latest_dir=".files.d/wiki_db_dump";




function _wiki_db_dump()
{
	mysqldump -u $_db_user -p --databases $_db_name > ${_db_dump_dir}/${_db_dump_file_with_tstamp} ;
	cp -p ${_db_dump_dir}/${_db_dump_file_with_tstamp} ${_db_dump_file_latest_dir}/${_db_dump_file_latest} ;
	(cd ${_db_dump_file_latest_dir} ; ln -s ${_db_dump_file_latest} ${_db_dump_file_with_tstamp} ;)
}




function _wiki_db_load()
{
	_sql_file_for_prep=".tmp.mysql_load.prep.sql";
	cat > $_sql_file_for_prep << EOF
	drop database $_db_name;
	create database $_db_name;
EOF


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
	_sql_dumpfile_for_load=$(cd $_db_dump_dir; ls -1t mediawiki_db_dump.*.sql | head -1);
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




read -p "### ASK:  (1) DB dump?  (2) DB load?  [1|2] " _answer;
case $_answer in
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
	*)
		echo "=============================================================";
		echo "-------------------------------------------------------------";
		echo "### INF:  wrong input - it will do nothing";
		echo "-------------------------------------------------------------";
		echo "=============================================================";
		exit 0;
		;;
esac




