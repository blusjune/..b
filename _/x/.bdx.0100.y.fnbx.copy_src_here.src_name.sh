#!/bin/bash
# 20230831_215921

### fnbx: File Name Based eXecution
### file name format should be like this: ".bdx.0100.y.fnbx.copy_src_here.src_name.sh"
###                                       ".2  .3   .4.5   .6            .7       .8 "

_this_file_name="$( basename $( echo $0 ) )";
#_src="$( echo $_this_file_name | awk -F'.' '{ if ($4 == "y") { print $7 }}' )";
_src="$( echo $_this_file_name | awk -F'.y.fnbx.copy_src_here.' '{ print $2 }' | sed -e 's/\(.*\)\.sh/\1/g' )";
echo $_src;
if [ "X$_src" = "X" ]; then
	echo "ERROR:: empty _src"
	exit;
fi
_dir_base="$( pwd | awk -F'__ROOT__' '{ print $2 }' )";

set -x;
if [ -d $_src -o -f $_src ]; then
	if [ -d ${_src}.old -o -f ${_src}.old ]; then
		rm -fr ${_src}.old;
	fi
	mv ${_src} ${_src}.old;
fi

(cd $_dir_base; tar cf - $_src) | tar xf -;
set +x;
