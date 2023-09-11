#!/bin/bash
# .bdx.0100.y.rsync.bbxd.to_ssd_0t5_t5_oasis.sh
# 20230911_074234


_ts="date +%Y%m%d_%H%M%S";
#set -x;
_rsync_target_dir_root="/mnt/media.blusjune/.ssd_0t5_t5_oasis/..__ROOT__";
_list_to_rsync="..b ..bxd";


echo "### =======================================================================";
echo "### _list_to_rsync: $_list_to_rsync";
echo "### _rsync_target_dir_root: $_rsync_target_dir_root";
for _i in $_list_to_rsync; do
	echo "### _________: $_i";
	$_ts;  rsync -a ${_i}/ ${_rsync_target_dir_root}/${_i};  $_ts;
done
echo "### =======================================================================";
