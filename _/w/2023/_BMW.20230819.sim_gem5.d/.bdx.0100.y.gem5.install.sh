#!/bin/bash

manual_install__gem5()
{
	_GEM5_URL="gem5.googlesource.com"
	_NUM_OF_CPU_CORES="$( lscpu | grep "^CPU(s)" | awk '{ print $2 }' )"
	#
	sudo apt install libboost-all-dev
	sudo apt install scons
	sudo apt install m4 automake
	sudo apt install libprotobuf-dev protobuf-compiler libgoogle-perftools-dev libprotoc-dev libprotoc23 protobuf-c-compiler protobuf-compiler protobuf-compiler-grpc protobuf-compiler-grpc-java-plugin
	sudo apt install grpc-proto libgrpc++-dev libgrpc++1 libgrpc-dev libgrpc-java libgrpc10 python3-grpc-tools python3-grpcio 
	sudo apt install hdf5-tools libhdf5-dev libhdf5-doc libhdf5-hl-100 libhdf5-hl-cpp-100 libhdf5-hl-fortran-100 hdf5-helpers hdf5-plugin-lzf libhdf5-103 libhdf5-cpp-103
	sudo apt install libtcmalloc-minimal4
	#
	if [ -d gem5 ]; then
		echo ">>> gem5 directory exists";
		( cd gem5;
		git pull;
		)
	else
		echo ">>> gem5 directory does not exists";
		( cd .bxd/src; 
		git clone https://${_GEM5_URL}/public/gem5;
		)
	fi
	cd gem5;
	scons build/X86/gem5.opt -j ${_NUM_OF_CPU_CORES}
	#
	pip install gem5
	pip install gem5.benchmarks.gpt3
	#
	echo " build/X86/gem5.opt configs/learning_gem5/part1/simple.py "
}

manual_install__gem5;
