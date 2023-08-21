#!/bin/bash
#.bx.bmw.sh (bmw: b's management of work)
# 20230814_203318


### assuming that /_b -> /home/blusjune/b/
_progname="bmw";
_progdescr="b's management of work";
_progname_called="$( echo $0 | sed -e 's/.*\/\(.*\)/\1/g' )";
_basedir="/_b/w"; # _basedir="${HOME}/..b/_/w";
_shortcut_dir="${_basedir}/x";
_prefix="_BMW";
_tstamp="date +%Y%m%d";
#_tstamp="date +%Y%m%d_%H%M%S";


function _print_help()
{
	echo "$_progname ($_progdescr)"
	echo "	-h           : help";
	echo "	-c <keyword> : create a work directory";
	echo "	-f <keyword> : find work directories with a keyword in the directory name";
	echo "	-l           : list all work directories";
}

function _bmw_create()
{
	#echo ">>> ${_progname}.create";
	if [ "X$_keyword" = "X" ]; then
		echo "ERROR(18): _keyword should be specified -- EXIT ";
		exit 18;
	fi
	read -p "Description: " _descr;
	# BEGIN: function _set_work_dir_name()
	if [ "X${_descr}" != "X" ]; then
		_fn_descr="${_keyword}_$( echo $_descr | sed -e 's/ /_/g' )"
	else
		_fn_descr="${_keyword}";
	fi
	_dname="${_prefix}.$(${_tstamp}).${_fn_descr}.d";
	_dpath="${_basedir}/$(date +%Y)/${_dname}";
	# END: function _set_work_dir_name()
	mkdir -p $_dpath;
	(cd $_dpath;
		touch ..README..${_dname};
		mkdir -p .files.d;
		if [ ! -L .bxd ]; then
			ln -s ${HOME}/..bxd/_ .bxd;
		fi
	)
	if [ ! -d $_shortcut_dir ]; then
		mkdir -p $_shortcut_dir;
	fi
	(cd $_shortcut_dir;
		if [ ! -L $_dname ]; then
			ln -s $_dpath $_dname;
		fi
		if [ -L latest ]; then
			rm latest ;
		fi
		ln -s $_dname latest ;
	)
	echo "$_dpath";
}

function _bmw_find()
{
	#echo ">>> ${_progname}.find";
	if [ "X$_keyword" = "X" ]; then
		echo "ERROR(18): _keyword should be specified -- EXIT";
		exit 18;
	fi
	(cd $_basedir;
		find $_basedir -type d -name "${_prefix}.*.d" | grep $_keyword | sort | more;
	)
}

function _bmw_list()
{
	#echo ">>> ${_progname}.list";
	(cd $_basedir;
		find $_basedir -type d -name "${_prefix}.*.d" | sort | more;
	)
}




if [ $# -eq 0 ]; then
	if [ $_progname_called = "${_progname}" ]; then
		_print_help;
		exit 111;
	fi
fi
case $_progname_called in
	"bmwc")
		_keyword=$1;
		_bmw_create;
		;;
	"bmwf")
		_keyword=$1;
		_bmw_find;
		;;
	"bmwl")
		_bmw_list;
		;;
	"bmw")
		while getopts "hc:f:l" _opt; do
			case $_opt in
			h)
				_print_help;
				;;
			c)
				_keyword=${OPTARG};
				_bmw_create;
				;;
			f)
				_keyword=${OPTARG};
				_bmw_find;
				;;
			l)
				_bmw_list;
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




