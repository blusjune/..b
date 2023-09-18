#!/bin/bash
# .bdx.0100.y.llama.main.run_and_profile.sh
# 20230910_225422
# 20230914_234326




set -x; ### {
_ts="date +%Y%m%d_%H%M%S";
_tstamp="$($_ts)";
_tmp_bdx_d=".tmp.bdx.d";
mkdir -p $_tmp_bdx_d;




###
### Check prerequisites: execution environment (venv, torch-for-cpu)
###
echo "### CHK: Let me check where 'torchrun' is:  '$(which torchrun)'";   ### Litmus test to check the virtual environment
read -p "### ASK: Do we need to (re-)install all things required? [y|N] " _answer;
if [ "X$_answer" = "Xy" ]; then
	#
	python -m venv .env;
	source .env/bin/activate; ### must do
	echo $_tstamp > ${_tmp_bdx_d}/.flag.venv.created;
	#
	python -m pip install --upgrade pip;
	python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu;
	python -m pip install gprof2dot; ### python profiling and visualization
	python -m pip install snakeviz; ### python profiling and visualization
	python -m pip install viztracer; ### python profiling and visualization
	#python -m pip install pycscope;
	#python -m pip install pycallgraph; ### python profiling and visualization ### ERROR?
	python -m pip install -e .;
	if [ "X$(basename $(which eog))" != "Xeog" ]; then
		sudo apt install eog;
	fi
	echo $_tstamp > ${_tmp_bdx_d}/.flag.pkg.installed;
	#
else
	source .env/bin/activate; ### must do
fi

###
### Check prerequisites: good download of tokenizer.model
###
if [ -f ${_tmp_bdx_d}/.flag.venv.created -a -f ${_tmp_bdx_d}/.flag.pkg.installed ]; then
	echo "### CHK: GOOD: execution environment (as a prerequisite) is ready";
	_chksum_tokenizer_ref="eeec4125e9c7560836b4873b6f8e3025";
	_chksum_tokenizer_test="$( cat tokenizer.model | md5sum | awk '{ print $1 }' )";
	if [ "X$_chksum_tokenizer_ref" = "X$_chksum_tokenizer_test" ]; then
		echo "### CHK: GOOD: tokenizer.model checksum matches the reference value";
	else
		echo "### CHK: ERROR: tokenizer.model checksum does not match -- EXIT 18";
		exit 18;
	fi
else
	echo "### CHK: ERROR: execution environment is not ready -- EXIT 18";
	exit 18;
fi




_tmp_star_d=".tmp.star.d";
mkdir -p $_tmp_star_d;




declare -A _ai_models;
_ai_models["llama-2-13b"]="LLAMA2-13B";
_ai_models["llama-2-13b-chat"]="LLAMA2-13B-CHAT";
_ai_models["llama-2-70b"]="LLAMA2-70B";
_ai_models["llama-2-70b-chat"]="LLAMA2-70B-CHAT";
_ai_models["llama-2-7b"]="LLAMA2-7B";
_ai_models["llama-2-7b-chat"]="LLAMA2-7B-CHAT";

function _star_doe_testcase_prepare()
{
	### STAR profiling configuration
	_star_prof_cprofile_out_bin=".star.prof.${_xprmnt_uuid}.cprofile_out.bin"; # generated by (prof).dump_stats(f.pstats) or python -m cProfile -o f.pstats test.py
	_star_prof_cprofile_out_txt=".star.prof.${_xprmnt_uuid}.cprofile_out.txt"; # generated by (pstats).print_stats()
	_star_prof_cprofile_out_svg=".star.prof.${_xprmnt_uuid}.cprofile_out.svg"; # generated by gprof2dot
	_star_prof_viztracer_out_json=".star.prof.${_xprmnt_uuid}.viztracer_out.json"; # generated by viztracer
	_star_prof_viztracer_tracer_entries="100000000";
	_star_doe_conf__prof_out_save_path_cprofile="${_tmp_star_d}/${_star_prof_cprofile_out_bin}";
	_star_doe_conf__prof_out_save_path_viztracer="${_tmp_star_d}/${_star_prof_viztracer_out_json}";
	_star_prof_asys_script_cprofile=".star.prof.${_xprmnt_uuid}.asys_script.cprofile.sh"; # 
	_star_prof_asys_script_viztracer=".star.prof.${_xprmnt_uuid}.asys_script.viztracer.sh"; # 
	#
	### STAR DOE (Design of Experiment) configuration parameters
	### to be passed to the python test script
	export STAR_DOE_CONF__LLAMA2__CKPT_DIR=${_ckpt_dir};
	export STAR_DOE_CONF__LLAMA2__NPROC_PER_NODE=${_nproc_per_node};
	export STAR_DOE_CONF__LLAMA2__MAX_SEQ_LEN=${_max_seq_len};
	export STAR_DOE_CONF__LLAMA2__MAX_GEN_LEN=${_max_gen_len};
	export STAR_DOE_CONF__LLAMA2__MAX_BATCH_SIZE=${_max_batch_size};
	export STAR_DOE_CONF__XPRMNT_TIMESTAMP="${_tstamp}";
	export STAR_DOE_CONF__XPRMNT_NAME="${_xprmnt_name}";
	export STAR_DOE_CONF__XPRMNT_UUID="${_xprmnt_uuid}";
	export STAR_DOE_CONF__PROF_OUT_SAVE_PATH_CPROFILE="${_star_doe_conf__prof_out_save_path_cprofile}"
	export STAR_DOE_CONF__PROF_OUT_SAVE_PATH_VIZTRACER="${_star_doe_conf__prof_out_save_path_viztracer}"
}

function main_exec_profiling_with_cprofile()
{
	echo "### { =============================================";
	echo "###	function main_exec_profiling_with_cprofile(): start";
	_main_python_file_with_cprofile="example_text_completion.star.cprofile.py";   ### _main_python_file="example_text_completion.py";
	torchrun --nproc_per_node $_nproc_per_node $_main_python_file_with_cprofile --ckpt_dir $_ckpt_dir  --tokenizer_path tokenizer.model --max_seq_len $_max_seq_len --max_batch_size $_max_batch_size ;
	echo "###	${_main_python_file_with_cprofile}: completed";
	( cd $_tmp_star_d; 
	cat > $_star_prof_asys_script_cprofile << EOF_ASYS_SCRIPT
#!/bin/bash
gprof2dot -f pstats $_star_prof_cprofile_out_bin | dot -Tsvg -o $_star_prof_cprofile_out_svg;
eog $_star_prof_cprofile_out_svg &
snakeviz $_star_prof_cprofile_out_bin &
EOF_ASYS_SCRIPT
	chmod 755 $_star_prof_asys_script_cprofile;
	);
	echo "###	Please run ${_star_prof_asys_script_cprofile} to see the profiling result";
	echo "###	function main_exec_profiling_with_cprofile(): end";
	echo "### } =============================================";
}

function main_exec_profiling_with_viztracer()
{
	echo "### { =============================================";
	echo "###	function main_exec_profiling_with_viztracer(): start";
	_main_python_file_with_viztracer="example_text_completion.star.viztracer.py";   ### _main_python_file="example_text_completion.py";
	# python -m viztracer --tracer_entries $_star_prof_viztracer_tracer_entries -o ${_tmp_star_d}/${_star_prof_viztracer_out_json} \
	torchrun --nproc_per_node $_nproc_per_node $_main_python_file_with_viztracer --ckpt_dir $_ckpt_dir  --tokenizer_path tokenizer.model --max_seq_len $_max_seq_len --max_batch_size $_max_batch_size ;
	echo "###	${_main_python_file_with_viztracer}: completed";
	( cd $_tmp_star_d;
	cat > $_star_prof_asys_script_viztracer << EOF_ASYS_SCRIPT
#!/bin/bash
vizviewer $_star_prof_viztracer_out_json &
EOF_ASYS_SCRIPT
	chmod 755 $_star_prof_asys_script_viztracer;
	);
	echo "###	Please run ${_star_prof_asys_script_viztracer} to see the profiling result";
	echo "###	function main_exec_profiling_with_viztracer(): end";
	echo "### } =============================================";
}

function _star_doe_testcase_exec()
{
	echo "### CHK: _star_doe_conf_dummy_run: $_star_doe_conf_dummy_run";
	if [ "X$_star_doe_conf_dummy_run" = "Xy" ]; then ### come from .star.doe.conf.testpool.sh;
		2>&1 python .star.doe.main.testcase.dummy.py | tee -a $_star_doe_testcase_log;
	else
		2>&1 main_exec_profiling_with_cprofile | tee -a $_star_doe_testcase_log;
		2>&1 main_exec_profiling_with_viztracer | tee -a $_star_doe_testcase_log;
	fi
}




###
### Main loop
###
### source .star.doe.conf.testpool.sh;
	#_list__ckpt_dir="llama-2-13b llama-2-13b-chat llama-2-70b llama-2-70b-chat llama-2-7b llama-2-7b-chat";
	#_list__nproc_per_node="1 2 4 8 16 32";
	#_list__max_seq_len="64 128 256 512 1024";
	#_list__max_gen_len="64 128 256 512 1024";
	#_list__max_batch_size="1 2 4 8 16 32";
	#_list__xprmnt_cpu_model="CORE-I7-1270P";
source .star.doe.conf.testpool.sh;
_exec_count="0";
for _ckpt_dir in $_list__ckpt_dir; do
	_xprmnt_ai_model="${_ai_models[$_ckpt_dir]}";
	for _nproc_per_node in $_list__nproc_per_node; do
		export WORLD_SIZE=${_nproc_per_node};
		export OMP_NUM_THREADS=${_nproc_per_node};
		for _max_seq_len in $_list__max_seq_len; do
			for _max_gen_len in $_list__max_gen_len; do
				for _max_batch_size in $_list__max_batch_size; do
					for _xprmnt_cpu_model in $_list__xprmnt_cpu_model; do
						_exec_count=$(expr $_exec_count + 1)
						_xprmnt_sn="$(printf '%08d' $_exec_count)";
						_xprmnt_name="${_xprmnt_sn}_${_xprmnt_ai_model}_${_xprmnt_cpu_model}_P${_nproc_per_node}_S${_max_seq_len}_G${_max_gen_len}_B${_max_batch_size}";
						_xprmnt_uuid="${_tstamp}.${_xprmnt_name}";
						_star_doe_testcase_log="${_tmp_bdx_d}/.star.doe.log.${_xprmnt_uuid}.txt";
						echo "### DoE main-loop ________________________________________________________________________________________________" | tee $_star_doe_testcase_log;
						echo "### ${_xprmnt_uuid} : $($_ts) " | tee -a $_star_doe_testcase_log;
						_star_doe_testcase_prepare;
						_star_doe_testcase_exec;
					done
				done
			done
		done
	done
done
set +x; ### }




###
### Main Old History
###
# torchrun --nproc_per_node 1 example_text_completion.py --ckpt_dir llama-2-7b/  --tokenizer_path tokenizer.model --max_seq_len 128 --max_batch_size 1
# torchrun --nproc_per_node $_nproc_per_node --ckpt_dir $_ckpt_dir  --tokenizer_path tokenizer.model --max_seq_len $_max_seq_len --max_batch_size $_max_batch_size $_main_python_file   ### ERROR: this order of arguments does not work
# python -m viztracer --tracer_entries 100000000 -o .tmp.star.d/.star.prof_out.viztr.json torchrun --nproc_per_node 1 example_text_completion.star.py --ckpt_dir llama-2-7b/ --tokenizer_path tokenizer.model --max_seq_len 128 --max_batch_size 1




###
### Help
###
print_help()
{
	echo "
; LLAMA 2:
* [https://github.com/facebookresearch/llama Llama 2]
* [https://github.com/krychu/llama Llama 2 on CPU, and Mac M1/M2 GPU]
* [https://github.com/facebookresearch/llama/issues/436#issuecomment-1650001563 RuntimeError: ProcessGroupNCCL is only supported with GPUs, no GPUs found? #436]

; Python profiling feferences:
* https://docs.python.org/3/library/profile.html
* https://medium.com/@narenandu/profiling-and-visualization-tools-in-python-89a46f578989
* https://pytorch.org/tutorials/recipes/recipes/profiler_recipe.html
	";
}




