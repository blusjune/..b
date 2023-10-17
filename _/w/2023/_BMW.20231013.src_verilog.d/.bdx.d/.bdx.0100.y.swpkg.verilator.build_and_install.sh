#!/bin/bash
# .bdx.0100.y.swpkg.verilator.build_and_install.sh
# 20231013_232138



function install_prerequisites()
{
	sudo apt-get install git help2man perl python3 make autoconf g++ flex bison ccache
	sudo apt-get install libgoogle-perftools-dev numactl perl-doc
	sudo apt-get install libfl2  # Ubuntu only (ignore if gives error)
	sudo apt-get install libfl-dev  # Ubuntu only (ignore if gives error)
	sudo apt-get install zlibc zlib1g zlib1g-dev  # Ubuntu only (ignore if gives error)
	
	sudo apt-get install ccache  # If present at build, needed for run
	sudo apt-get install mold  # If present at build, needed for run
	sudo apt-get install libgoogle-perftools-dev numactl
	
	sudo apt-get install clang clang-format-14 cmake gdb gprof graphviz lcov
	sudo apt-get install libclang-dev yapf3 bear
	sudo pip3 install clang sphinx sphinx_rtd_theme sphinxcontrib-spelling breathe ruff
	
	cpan install Pod::Perldoc
	cpan install Parallel::Forker
}

function install_verilator_by_apt()
{
	apt-get install verilator
}

function install_verilator_from_source()
{
	git clone https://github.com/verilator/verilator   # Only first time
	unsetenv VERILATOR_ROOT  # For csh; ignore error if on bash
	unset VERILATOR_ROOT  # For bash
	cd verilator
	git pull         # Make sure git repository is up-to-date
	git tag          # See what versions exist
	#git checkout master      # Use development branch (e.g. recent bug fixes)
	git checkout stable      # Use most recent stable release
	#git checkout v{version}  # Switch to specified release version
	#
	autoconf         # Create ./configure script
	./configure      # Configure and create Makefile
	make -j $(nproc)  # Build Verilator itself (if error, try just 'make')
	sudo make install
}

function install_docker()
{
	sudo docker pull verilator/verilator-buildenv
	sudo docker run -ti verilator/verilator-buildenv
	sudo docker run -ti verilator/verilator-buildenv test
}



#install_docker
install_prerequisites
#install_verilator_by_apt
install_verilator_from_source
