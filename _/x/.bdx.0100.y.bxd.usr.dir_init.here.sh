#!/bin/bash
# .bdx.0100.y.bxd.usr.dir_init.here.sh
# 20231007_085839

_progname=$(echo $0);
_action=$(echo $_progname | awk -F'.' '{ print $(NF-1) }');

function _create_bxd_usr()
{
	_list_of_dir="
	bin
	etc
	include
	lib
	sbin
	share
	src
	tmp
	var
	";

	for _i in $_list_of_dir; do
		echo "### INF: mkdir -p $_i";
		mkdir -p $_i;
	done
	ls -alF;
	echo "### _____________________________________";
	echo "### INF: bxd_usr dir hierarchy created at $(pwd)";
	echo "### _____________________________________";
}

function _create_bxd_usr_at_home()
{
	# create ~/..bxd/_/usr
	mkdir -p ~/..bxd/_/usr
	(cd ~/..bxd/_/usr;
		_create_bxd_usr;
	)
	
	# create ~/bxd ( so that ~/..bxd/_/usr can be ~/bxd/usr )
	(cd ~;
		if [ ! -L bxd ]; then
			echo "### INF: ln -s ..bxd/_ bxd";
			ln -s ..bxd/_ bxd;
		fi
	)
}




#set -x;
case $_action in
	"here")
		_create_bxd_usr;
		;;
	"home")
		_create_bxd_usr_at_home;
		;;
	*)
		_create_bxd_usr;
		;;
esac
#set +x;




