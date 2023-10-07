#!/bin/bash
# 20231007_002213

_thisprog="$(echo $0)";
_action=$(echo $_thisprog | awk -F'.' '{print $(NF-1)}');




function _star_doe_pkg_install()
{
# .star.doe.pkg.install.sh
# 20230927_110431
#
echo "### --------------------------------"
echo "### .star.doe.pkg.install.sh { start"
python -m pip install --upgrade pip;
python -m pip install torch --index-url https://download.pytorch.org/whl/cpu;
python -m pip install torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu;
python -m pip install gprof2dot; ### python profiling and visualization
python -m pip install snakeviz; ### python profiling and visualization
python -m pip install viztracer; ### python profiling and visualization
python -m pip install py-spy;
python -m pip install ps-utils;
python -m pip install memory-profiler;
python -m pip install Pympler;
python -m pip install filprofiler;
###python -m pip install pycscope;
###python -m pip install pycallgraph; ### python profiling and visualization ### ERROR?
#python -m pip install -e .;
if [ "X$(basename $(which eog))" != "Xeog" ]; then
	echo "### sudo apt install eog";
	sudo apt install eog;
fi
if [ "X$(basename $(which speedscope))" != "Xspeedscope" ]; then
	if [ "X$(basename $(which npm))" != "Xnpm" ]; then
		sudo apt install npm;
	fi
	sudo npm install -g speedscope;
fi
echo "### .star.doe.pkg.install.sh } end"
echo "### --------------------------------"
}




function _star_doe_pkg_uninstall()
{
# .star.doe.pkg.uninstall.sh
# 20230927_110431
#
echo "### --------------------------------"
echo "### .star.doe.pkg.uninstall.sh { start"
python -m pip uninstall pip;
python -m pip uninstall torch
python -m pip uninstall torchvision torchaudio
python -m pip uninstall gprof2dot; ### python profiling and visualization
python -m pip uninstall snakeviz; ### python profiling and visualization
python -m pip uninstall viztracer; ### python profiling and visualization
python -m pip uninstall py-spy;
python -m pip uninstall ps-utils;
python -m pip uninstall memory-profiler;
###python -m pip uninstall pycscope;
###python -m pip uninstall pycallgraph; ### python profiling and visualization ### ERROR?
#python -m pip uninstall -e .;
echo "### .star.doe.pkg.uninstall.sh } end"
echo "### --------------------------------"
}




case $_action in
	"install")
		python -m venv .env;
		source .env/bin/activate;
		echo _star_doe_pkg_install;
		_star_doe_pkg_install;
		;;
	"uninstall")
		python -m venv .env;
		source .env/bin/activate;
		echo _star_doe_pkg_uninstall;
		_star_doe_pkg_uninstall;
		;;
	*)
		echo "### ERR: wrong action specified ($_action) -- EXIT 18";
		exit 18;
		;;
esac




