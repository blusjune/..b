#!/bin/bash
#.bx.bmm.sh (bmm: b's management of memo)
# 20230814_203318


_progname="bmm";
_progdescr="b's management of memo";
_progname_called="$( echo $0 | sed -e 's/.*\/\(.*\)/\1/g' )";
_basedir="${HOME}/..b/_/m";
_prefix="_BMM";
_tstamp="date +%Y%m%d";
#_tstamp="date +%Y%m%d_%H%M%S";


function _print_help()
{
	echo "$_progname ($_progdescr)"
	echo "	-h           : help";
	echo "	-c <keyword> : create a memo file with keyword";
	echo "	-e <keyword> : edit a memo file of keyword";
	echo "	-f <keyword> : find memo files with keyword in the file name";
	echo "	-g <keyword> : grep keyword for memo files";
	echo "	-l           : list all the memo files";
}

function _bmm_create()
{
	#echo ">>> ${_progname}.create";
	if [ "X$_keyword" = "X" ]; then
		echo "ERROR(18): _keyword should be specified -- EXIT ";
		exit 18;
	fi
	read -p "Description: " _descr;
	# BEGIN: function _set_memo_file_name()
	if [ "X${_descr}" != "X" ]; then
		_fn_descr="${_keyword}_$( echo $_descr | sed -e 's/ /_/g' )"
	else
		_fn_descr="${_keyword}";
	fi
	_fname="${_prefix}.$(${_tstamp}).${_fn_descr}.txt";
	_fpath="${_basedir}/${_fname}";
	# END: function _set_memo_file_name()
	vi $_fpath;
}

function _bmm_edit()
{
	#echo ">>> ${_progname}.edit";
	if [ "X$_keyword" = "X" ]; then
		echo "ERROR(18): _keyword should be specified -- EXIT";
		exit 18;
	fi
	(cd $_basedir;
		ls -1 ${_prefix}.*.txt | grep -i $_keyword | more;
		_file_to_edit="$( ls -1 ${_prefix}.*.txt | grep -i $_keyword | tail -1 )";
		read -p "Edit the file '${_file_to_edit}'? [Y|n] " _answer;
		if [ "X${_answer}" != "Xn" ]; then
			vi ${_file_to_edit};
		fi
	)
}

function _bmm_find()
{
	#echo ">>> ${_progname}.find";
	if [ "X$_keyword" = "X" ]; then
		echo "ERROR(18): _keyword should be specified -- EXIT";
		exit 18;
	fi
	(cd $_basedir;
		ls -1 ${_prefix}.*.txt | grep -i $_keyword | more;
	)
}

function _bmm_grep()
{
	#echo ">>> ${_progname}.grep";
	if [ "X$_keyword" = "X" ]; then
		echo "ERROR(18): _keyword should be specified -- EXIT";
		exit 18;
	fi
	(cd $_basedir;
		grep -nri $_keyword ${_prefix}.*.txt;
	)
}

function _bmm_list()
{
	#echo ">>> ${_progname}.list";
	(cd $_basedir;
		ls -1 ${_prefix}.*.txt | more;
	)
}




if [ $# -eq 0 ]; then
	if [ $_progname_called = "${_progname}" ]; then
		_print_help;
		exit 111;
	fi
fi
case $_progname_called in
	"bmmc")
		_keyword=$1;
		_bmm_create;
		;;
	"bmme")
		_keyword=$1;
		_bmm_edit;
		;;
	"bmmf")
		_keyword=$1;
		_bmm_find;
		;;
	"bmmg")
		_keyword=$1;
		_bmm_grep;
		;;
	"bmml")
		_bmm_list;
		;;
	"bmm")
		while getopts "hc:e:f:g:l" _opt; do
			case $_opt in
			h)
				_print_help;
				;;
			c)
				_keyword=${OPTARG};
				_bmm_create;
				;;
			e)
				_keyword=${OPTARG};
				_bmm_edit;
				;;
			f)
				_keyword=${OPTARG};
				_bmm_find;
				;;
			g)
				_keyword=${OPTARG};
				_bmm_grep;
				;;
			l)
				_bmm_list;
				;;
			*)
				_print_help;
				;;
			esac
		done
		;;
	*)
		echo "($*)";
		;;
esac
exit 100;



