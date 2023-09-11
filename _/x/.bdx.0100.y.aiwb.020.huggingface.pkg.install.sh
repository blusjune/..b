#!/bin/bash
# AIWB: Artificial Intelligence Work Bench
# .bdx.0100.y.aiwb.020.huggingface.pkg.install.sh
# 20230907_002829
_corename="aiwb.020.huggingface.pkg.install";
_thisprog=".bdx.0110.y.${_corename}.sh"




###
###
### _work_step_file: declaration
_ts="date +%Y%m%d_%H%M%S";
declare -A _work_step_file;
_step=0;
_exe_log=".exelog.${_corename}.$($_ts).log";




#######################
### prerequisites { ###
_hf_token=".tmp.hf_token.txt";
_hf_token_gpg=".tmp.hf_token.txt.gpg";
cat > $_hf_token_gpg << EOF_HF_TOKEN
-----BEGIN PGP MESSAGE-----
Comment: BGPGFile:20230904_175119 by B.

jA0ECQMCUPsM6YCDr6f/0mcBAOGFKOGtcQlMttnT2Chx8VNlIrnFk2PJtKDFxvWN
0bwD5/ooiwRyV4ikZWLzCzoF20ENpO4pAW1IyGDsV88Uqa/lLFhHwCx+5I/7RhFS
/m3oNFnUW9Z2avG4zXrbDF8q9Hv5Pthp
=dPZP
-----END PGP MESSAGE-----
EOF_HF_TOKEN
gpg $_hf_token_gpg;
echo "HF_TOKEN='$( cat $_hf_token )'";
# huggingface-cli login;
### } prerequisites ###
#######################




###
###
### _work_step_file: _step++
_step=$((_step + 1));
_work_step_file[$_step]=".workstep.${_corename}.$(printf '%08d' $_step).sh";
cat > ${_work_step_file[$_step]} << EOF_WORK_STEP_COMMANDS
#!/bin/bash
### workstep[$_step];
###_step{###----------------------------------
echo "hello, world";
echo "put your _step commands here";
python --version;
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
python -m venv .env;
source .env/bin/activate;
pip install --upgrade huggingface_hub;
#pip install 'huggingface_hub[tensorflow]';
pip install 'huggingface_hub[cli,torch]';
pip install transformers;
pip install 'transformers[torch]';
#pip install 'transformers[tf-cpu]';
#pip install 'transformers[flax]';
python -c "from transformers import pipeline; print(pipeline('sentiment-analysis')('we love you'))"
echo "
### JFYI, expected output:
[{'label': 'POSITIVE', 'score': 0.9998704791069031}]
";
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




