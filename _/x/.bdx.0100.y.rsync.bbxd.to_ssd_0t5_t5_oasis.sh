#!/bin/bash
# .bdx.0100.y.rsync.bbxd.to_ssd_0t5_t5_oasis.sh
# 20230912_220510


source /_b/x/.blib.rsync.sh;


_list_to_rsync="..b ..bxd .bigfiles.d";
_rsync_target_dir_root="/mnt/media.blusjune/.ssd_0t5_t5_oasis/..__ROOT__";
_rsync_opt="-v --delete";
rsync_exec;


_list_to_rsync=".config";
_rsync_target_dir_root="/mnt/media.blusjune/.ssd_0t5_t5_oasis/..__ROOT__/home.blusjune.$(hostname)";
_rsync_opt="-v --delete";
rsync_exec;


