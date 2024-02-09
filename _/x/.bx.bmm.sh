#!/bin/bash
#.bx.bmm.sh (bmm: b's management of memo)
# 20230814_203318


### assuming that /_b -> /home/blusjune/b/
_progname="bmm";
_progdescr="b's management of memo";
_progname_called="$( echo $0 | sed -e 's/.*\/\(.*\)/\1/g' )";
_basedir="/_b/m"; # _basedir="${HOME}/..b/_/m";
_prefix="_BMM";
_tstamp="date +%Y%m%d";
#_tstamp="date +%Y%m%d_%H%M%S";


function _print_help()
{
	echo "$_progname ($_progdescr)"
	echo "	-h           : help";
	echo "	-c <keyword> : create a memo file with keyword";
	echo "	-e <keyword> : edit a memo file of which name has keyword";
	echo "	-f <keyword> : find memo files with keyword in the file name";
	echo "	-g <keyword> : grep memo files with keyword";
	echo "	-l           : list all the memo files";
	echo "	-p <keyword> : print the contents of the memo file of which name has keyword";
	exit 114;
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
		_target_file="$( ls -1 ${_prefix}.*.txt | grep -i $_keyword | tail -1 )";
		if [ "X$_target_file" != "X" ]; then
			read -p "Edit the file '${_target_file}'? [Y|n] " _answer;
			if [ "X${_answer}" != "Xn" ]; then
				vi ${_target_file};
			fi
		else
			# echo "ERROR(28): No memo files found with $_keyword";
			:
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
		#grep -nriHT $_keyword ${_prefix}.*.txt;
		# $ bmmg aerosmith
		# _BMM.20230817.bnet_router_setup_LinkSys_E9450.txt:   3: aerosmith: 10.123.1.1
		# _BMM.20230817.bnet_router_setup_LinkSys_E9450.txt:  30: aerosmith b02
		find $_basedir -type f -name "${_prefix}.*.txt" -exec grep -nriHT "$_keyword" {} \;
		# $ bmmg aerosmith
		# /home/blusjune/..b/_/m/_BMM.20230817.bnet_router_setup_LinkSys_E9450.txt:   3:  aerosmith: 10.123.1.1
		# /home/blusjune/..b/_/m/_BMM.20230817.bnet_router_setup_LinkSys_E9450.txt:  30:  aerosmith b02
	)
}

function _bmm_list()
{
	#echo ">>> ${_progname}.list";
	if [ "X$_keyword" = "X" ]; then
		(cd $_basedir;
			ls -1 ${_prefix}.*.txt | more;
		)
	else
		(cd $_basedir;
			ls -1 ${_prefix}.*.txt | grep -i $_keyword | more;
		)
	fi
}

function _bmm_print()
{
	#echo ">>> ${_progname}.print";
	if [ "X$_keyword" = "X" ]; then
		echo "ERROR(18): _keyword should be specified -- EXIT";
		exit 18;
	fi
	(cd $_basedir;
		ls -1 ${_prefix}.*.txt | grep -i $_keyword | more;
		_target_file="$( ls -1 ${_prefix}.*.txt | grep -i $_keyword | tail -1 )";
		if [ "X$_target_file" != "X" ]; then
			read -p "Print the contents of the file '${_target_file}'? [Y|n] " _answer;
			if [ "X${_answer}" != "Xn" ]; then
				echo "#-------- BMM_PRINT { --------";
				echo "";
				cat ${_target_file};
				echo "";
				echo "#-------- } BMM_PRINT --------";
			fi
		else
			# echo "ERROR(28): No memo files found with $_keyword";
			:
		fi
	)
}

function _bmm_print_y()
{
	#echo ">>> ${_progname}.print.y";
	if [ "X$_keyword" = "X" ]; then
		echo "#ERROR(18): _keyword should be specified -- EXIT";
		exit 18;
	fi
	(cd $_basedir;
		#ls -1 ${_prefix}.*.txt | grep -i $_keyword | more;
		ls -1 ${_prefix}.*.txt | grep -i $_keyword | sed -e 's/^/#/g';
		_target_file="$( ls -1 ${_prefix}.*.txt | grep -i $_keyword | tail -1 )";
		if [ "X$_target_file" != "X" ]; then
			echo "#Print the contents of the file '${_target_file}'";
			echo "#-------- BMM_PRINT { --------";
			echo "";
			cat ${_target_file};
			echo "";
			echo "#-------- } BMM_PRINT --------";
		else
			# echo "ERROR(28): No memo files found with $_keyword";
			:
		fi
	)
}




###
### Main code begins
###
if [ $# -eq 0 ]; then
	if [ $_progname_called = "${_progname}" ]; then
		_print_help;
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
		_keyword=$1;
		_bmm_list;
		;;
	"bmmp")
		_keyword=$1;
		_bmm_print;
		;;
	"bmmpy")
		_keyword=$1;
		_bmm_print_y;
		;;
	"bmm")
		while getopts "hc:e:f:g:lp:" _opt; do
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
			p)
				_keyword=${OPTARG};
				_bmm_print;
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
exit 0;




