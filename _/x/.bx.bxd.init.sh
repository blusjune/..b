#!/bin/bash
#.bx.bxd.init.sh
#20230901_014433

_bxd="..bxd";
_ddb_pkg_sh="${HOME}/..b/.ddb.pkg.sh";

function _mkdir_and_cd()
{
	if [ ! -d $_tgt_dir ]; then
		mkdir -p $_tgt_dir;
	fi
	cd $_tgt_dir;
}

set -x;

_tgt_dir="$_bxd"; _mkdir_and_cd; pwd;
if [ -f $_ddb_pkg_sh ]; then
	cp -p $_ddb_pkg_sh .;
fi

_tgt_dir="_"; _mkdir_and_cd; pwd;
mkdir -p log obj src wip;

set +x;

