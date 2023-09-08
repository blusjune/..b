#!/bin/bash
# AIWB: Artificial Intelligence Work Bench
# .bdx.0100.y.aiwb.nvidia.pkg.install.sh
# 20230906_222738
_corename="aiwb.nvidia.pkg.install";
_thisprog=".bdx.0100.y.${_corename}.sh";


echo "$_thisprog: install NVIDIA CUDA, TensorRT";
read -p "### Please do the following before going any further:

source .env/bin/activate;

### Are you ready to go? [Y|n] " _answer;
if [ "X$_answer" = "Xn" ]; then
	echo "### Come back again when you are ready";
	exit 0;
fi


set -x;


### Prerequisites

#sudo apt install dkms;
#sudo apt install cmake make;
#sudo apt install clang-format
#sudo apt install python3.10;
#sudo apt install pip;
#sudo apt install python3-pytest python3-pillow
#sudo apt install libonnx-dev
#sudo apt install python3-numpy python3-onnx python3-pycuda python-pycuda-doc;
#sudo apt install git pkg-config wget;

_APT_PKG_LIST="
dkms
cmake make
clang-format
python3.10
pip
python3-pytest python3-pillow
libonnx-dev
python3-numpy python3-onnx python3-pycuda python-pycuda-doc
git pkg-config wget
";
sudo apt install $_APT_PKG_LIST;


### NVIDIA 
_dir__files=".files.d";
_file__nv_cuda_tensorrt="nv-tensorrt-local-repo-ubuntu2204-8.6.1-cuda-11.8_1.0-1_amd64.deb";
if [ -f ${_dir__files}/${_file__nv_cuda_tensorrt} ]; then
	sudo dpkg -i ${_dir__files}/${_file__nv_cuda_tensorrt} ;
else
	echo "ERROR: no such file: $_file__nv_cuda_tensorrt  -- EXIT 18";
	exit 18;
fi


### NVIDIA CUDA Toolkit 12.2 Update 2 Downloads
_dir__files=".files.d";
_file__nv_cuda_run="cuda_12.2.2_535.104.05_linux.run";
read -p "### Do you want to install $_file__nv_cuda_run ? [Y|n] " _answer;
if [ "X$_answer" != "Xn" ]; then
	mkdir -p $_dir__files; 
	( cd $_dir__files;
	if [ ! -f $_file__nv_cuda_run ]; then
		wget https://developer.download.nvidia.com/compute/cuda/12.2.2/local_installers/${_file__nv_cuda_run};
		# wget https://developer.download.nvidia.com/compute/cuda/12.2.2/local_installers/cuda_12.2.2_535.104.05_linux.run ;
	fi
	sudo sh $_file__nv_cuda_run;
	)
fi


set +x;
