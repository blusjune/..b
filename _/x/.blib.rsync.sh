# .blib.rsync.sh
# 20230927_210844


_ts="date +%Y%m%d_%H%M%S";


rsync_exec()
{
# 20230927_210452
#_list_to_rsync="..b ..bxd .bigfiles.d";
#_rsync_target_dir_root="/home/blusjune";
#_rsync_target_dir_root="/mnt/media.blusjune/.ssd_0t5_t5_oasis/..__ROOT__";
#_rsync_opt="-v --delete";
	if [ "X$_RSYNC_OPT_EXT" != "X" ]; then
		_rsync_opt="$_rsync_opt $_RSYNC_OPT_EXT";
	fi
	if [ ! -d $_rsync_target_dir_root ]; then
		echo "### WARNING: no such directory ($_rsync_target_dir_root)";
		echo "mkdir -p $_rsync_target_dir_root";
		mkdir -p $_rsync_target_dir_root;
	fi
	echo "### =======================================================================";
	echo "### _list_to_rsync: $_list_to_rsync";
	echo "### _rsync_target_dir_root: $_rsync_target_dir_root";
	echo "### _rsync_opt: ($_rsync_opt)";
	for _i in $_list_to_rsync; do
		echo "### ____________________________________";
		_tstamp_start=$($_ts);
		rsync -a $_rsync_opt ${_i}/ ${_rsync_target_dir_root}/${_i};
		_tstamp_end=$($_ts);
		echo "### ____________________________________";
		echo "$_i:  $_tstamp_start  ->  $_tstamp_end";
		echo "### ____________________________________";
	done
	echo "### =======================================================================";
}


