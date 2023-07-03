#!/bin/bash
#.bx.bdx.sh (_BDX)
#


#_list_of_BDX_files=$(ls -1 .bdx.*.y.*.sh);
_list_of_BDX_files=$(ls -a1 | grep -e '^\.bdx\..*\.y\..*\.sh');
if [ "X$_list_of_BDX_files" = "X" ]; then
	#echo "[BDX] nothing to execute - Exit";
	exit 0;
fi

_BDX_RETURN_CODE__SUCCESS="0";
_BDX_RETURN_CODE__FAILURE="18";

_ts="date +%Y%m%d_%H%M%S";
if [ "X$_BDX_PROMPT" = "X" ]; then
	_BDX_PROMPT="[BDX:X]>"  export _BDX_PROMPT; # X: eXecution
else
	_BDX_PROMPT="${_BDX_PROMPT}>"  export _BDX_PROMPT;
fi

echo "[BDX:D]  $($_ts)  $(pwd)/"; # D: Directory
for _i in $_list_of_BDX_files; do
	_bdx_cmd_log="${_BDX_PROMPT}  $($_ts)";
	./${_i};
	_retval=$?;
	if [ "X$_retval" = "X0" ]; then
		echo "$_bdx_cmd_log  $($_ts)  ${_i}  :SUCCESS($_retval)";
	else
		echo "$_bdx_cmd_log  $($_ts)  ${_i}  :FAILURE($_retval)";
		exit $_BDX_RETURN_CODE__FAILURE;
	fi
done


