#!/bin/bash
# 20231025_004114

_src_d="/mnt/media.blusjune/H16T0_metallica/..__ROOT__";
_dst_d="/mnt/media.blusjune/H05T0_pinkfloyd/..__ROOT__";

if [ -d $_src_d -a -d $_dst_d ]; then
	rsync -a  ${_src_d}/_BData_/  ${_dst_d}/_BData_ ;
fi

