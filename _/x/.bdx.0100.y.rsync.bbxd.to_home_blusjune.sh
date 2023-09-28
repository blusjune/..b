#!/bin/bash
# .bdx.0100.y.rsync.bbxd.to_home_blusjune.sh
# 20230912_220510


source /_b/x/.blib.rsync.sh;
_tstamp=$($_ts);


_list_to_rsync="..b";
_rsync_target_dir_root="/home/blusjune/.rsync.d/${_tstamp}";
_rsync_opt="-v --delete";
rsync_exec;
(cd $_rsync_target_dir_root/..; rm -f _LATEST; ln -s $_tstamp _LATEST;)


_list_to_rsync="..bxd  .bigfiles.d";
_rsync_target_dir_root="/home/blusjune";
_rsync_opt="-v --delete";
rsync_exec;


