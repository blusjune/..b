#!/bin/bash
# .bdx.0100.y.rsync.bbxd.to_home_blusjune.sh
# 20230912_220510


_ts="date +%Y%m%d_%H%M%S";
#set -x;
_rsync_target_dir_root="/home/blusjune";
_list_to_rsync="..b ..bxd";

if [ ! -d $_rsync_target_dir_root ]; then
	echo "### ERROR: no such directory ($_rsync_target_dir_root) -- EXIT 18";
	exit 18;
fi

echo "### =======================================================================";
echo "### _list_to_rsync: $_list_to_rsync";
echo "### _rsync_target_dir_root: $_rsync_target_dir_root";
for _i in $_list_to_rsync; do
	echo "### _________: $_i";
	$_ts;  rsync -a ${_i}/ ${_rsync_target_dir_root}/${_i};  $_ts;
done
echo "### =======================================================================";
