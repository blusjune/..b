#!/bin/bash
# .bdx.0100.y.bdx.exec_all_subdir_bdx_files.sh
# 20230831_224542

_this_file_name="$( basename $( echo $0 ) )";
_bdx_file_list=$( find $(pwd) -mindepth 2 -type l -name '.bdx.*.y.*.sh' );
for _i in $_bdx_file_list; do
	_bdx_file="$( basename $_i )";
	_bdx_dir="$( dirname $_i )";
	(cd $_bdx_dir; ./$_bdx_file;);
done
