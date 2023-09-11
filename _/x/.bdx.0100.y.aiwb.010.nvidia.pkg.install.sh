#!/bin/bash
# AIWB: Artificial Intelligence Work Bench
# .bdx.0100.y.aiwb.010.nvidia.pkg.install.sh
# 20230906_222738
_corename="aiwb.010.nvidia.pkg.install";
_thisprog=".bdx.0100.y.${_corename}.sh";




###
###
### _work_step_file: declaration
_ts="date +%Y%m%d_%H%M%S";
declare -A _work_step_file;
_step=0;
_exe_log=".exelog.${_corename}.$($_ts).log";




echo "$_thisprog: install NVIDIA CUDA, TensorRT";
read -p "### Please do the following before going any further:
#
source .env/bin/activate;
#
### Are you ready to go? [Y|n] " _answer;
if [ "X$_answer" = "Xn" ]; then
	echo "### Come back again when you are ready";
	exit 0;
fi
_files_dir=".files.d";
if [ ! -d $_files_dir ]; then
	if [ ! -d /_b/s/bxd/obj/huggingface/$_files_dir ]; then
		echo "### ERROR: no such directory: /_b/s/bxd/obj/huggingface/$_files_dir -- EXIT 18";
		exit 18;
	fi
	ln -s /_b/s/bxd/obj/huggingface/$_files_dir;
fi




###
###
### _work_step_file: _step++
_step=$((_step + 1));
_work_step_file[$_step]=".workstep.${_corename}.$(printf '%08d' $_step).sh";
cat > ${_work_step_file[$_step]} << EOF_WORK_STEP_COMMANDS
#!/bin/bash
### workstep[$_step];
###_step{###----------------------------------
### Prerequisites
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
###}_step###----------------------------------
EOF_WORK_STEP_COMMANDS
chmod 755 ${_work_step_file[$_step]};




###
###
### _work_step_file: _step++
_step=$((_step + 1));
_work_step_file[$_step]=".workstep.${_corename}.$(printf '%08d' $_step).sh";
cat > ${_work_step_file[$_step]} << EOF_WORK_STEP_COMMANDS
#!/bin/bash
### workstep[$_step];
###_step{###----------------------------------
### NVIDIA TensorRT
set -x;
_files_dir=".files.d";
_file__nv_cuda_tensorrt="nv-tensorrt-local-repo-ubuntu2204-8.6.1-cuda-11.8_1.0-1_amd64.deb";
if [ -f ${_files_dir}/\${_file__nv_cuda_tensorrt} ]; then
	sudo dpkg -i ${_files_dir}/\${_file__nv_cuda_tensorrt} ;
else
	echo "ERROR: no such file: \$_file__nv_cuda_tensorrt  -- EXIT 18";
	exit 18;
fi
###}_step###----------------------------------
EOF_WORK_STEP_COMMANDS
chmod 755 ${_work_step_file[$_step]};




###
###
### _work_step_file: _step++
_step=$((_step + 1));
_work_step_file[$_step]=".workstep.${_corename}.$(printf '%08d' $_step).sh";
cat > ${_work_step_file[$_step]} << EOF_WORK_STEP_COMMANDS
#!/bin/bash
### workstep[$_step];
###_step{###----------------------------------
### NVIDIA CUDA Toolkit 12.2 Update 2 Downloads
set -x;
_files_dir=".files.d";
_file__nv_cuda_run="cuda_12.2.2_535.104.05_linux.run";
mkdir -p $_files_dir; 
( cd $_files_dir;
if [ ! -f \$_file__nv_cuda_run ]; then
	wget https://developer.download.nvidia.com/compute/cuda/12.2.2/local_installers/\${_file__nv_cuda_run};
fi
sudo sh \$_file__nv_cuda_run;
)
###}_step###----------------------------------
EOF_WORK_STEP_COMMANDS
chmod 755 ${_work_step_file[$_step]};




###
###
### _work_step_file: execution main loop{
echo "";
echo "### Execution log will be saved in $_exe_log";
_i=0;
while [ $_i -lt $_step ]; do
	_i=$((_i + 1));
	echo "";
	echo "";
	echo "====================================================";
	echo "step[ $_i ]: " ${_work_step_file[$_i]};
	echo "----------------------------------------------------";
	cat ${_work_step_file[$_i]};
	echo "----------------------------------------------------";
	read -p ">>> Execute? [y(yes)|S(skip)|t(terminate)] " _answer;
	case $_answer in 
		"y"|"Y")
			echo "### $($_ts) :EXEC: phase[ $_i ]: " ${_work_step_file[$_i]} | tee -a $_exe_log;
			echo "____________________________________________________";
			${_work_step_file[$_i]};
			;;
		"s"|"S"|"n"|"N")
			echo "### $($_ts) :SKIP: phase[ $_i ]: " ${_work_step_file[$_i]} | tee -a $_exe_log;
			;;
		"t"|"T")
			echo "### $($_ts) :TERM: terminate this installation loop" | tee -a $_exe_log;
			break;
			;;
		*)
			echo "### $($_ts) :SKIP: phase[ $_i ]: " ${_work_step_file[$_i]} | tee -a $_exe_log;
			;;
	esac
	echo "____________________________________________________";
	echo "";
	echo "";
done
### _work_step_file: }execution main loop
###
###




