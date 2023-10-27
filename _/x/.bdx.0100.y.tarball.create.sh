#!/bin/bash
# 20231026_211049

_ts="date +%Y%m%d_%H%M%S";

read -p "### ASK:  change directory to [/] " _dir_to_move;
if [ "X$_dir_to_move" = "X" ]; then
	_dir_to_move="/";
fi

read -p "### ASK:  target directory to make tarball [.] " _dir_target;
if [ "X$_dir_target" = "X" ]; then
	_dir_target=".";
fi

if [ "X$_dir_target" = "X." ]; then
	_tarball_radix="$( echo $_dir_to_move | sed -e 's/^\///' | sed -e 's/\//./g' )..";
else
	_tarball_radix="$_dir_target";
fi
_tarball="${_tarball_radix}.$($_ts).tar.gz";
echo "_tarball: ($_tarball)";

#set -x;
(cd $_dir_to_move; tar cf - $_dir_target) | gzip -c > ${_tarball};
#set +x;

