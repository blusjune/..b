#!/bin/bash
# ddb: "dot dot b" (or "double dot b")
# ddb.pkg: ddb package
# ddb.pkg.sh: ddb package management script

_ddb_pkg_d=".ddb.pkg.d";
_ddb_pkg_radix=".ddb.pkg";
_ts="date +%Y%m%d_%H%M%S";

_ddb_pkg_target="_";
_ddb_pkg_file="${_ddb_pkg_radix}.${_ddb_pkg_target}.$($_ts).tar.gz";

if [ ! -d ${_ddb_pkg_d} ]; then
	mkdir -p ${_ddb_pkg_d};
fi
tar cf - ${_ddb_pkg_target} | gzip -c > ${_ddb_pkg_d}/${_ddb_pkg_file};
echo ">>> created: $_ddb_pkg_file";