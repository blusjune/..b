#!/bin/bash
# 20231029_184642
# Math extension for mediawiki 1.35.6


###
### 1. download and install Math extention (we need compatible version of Math extention for mediawiki 1.35.6)
###
mkdir -p .tmp.d;
(cd .tmp.d;
	_tarball="Math-REL1_35-c3fa82e.tar.gz"; #_tarball="Math-REL1_40-3f00f61.tar.gz";
	wget https://extdist.wmflabs.org/dist/extensions/${_tarball}; # wget https://extdist.wmflabs.org/dist/extensions/Math-REL1_40-3f00f61.tar.gz
	sudo tar -xzf ${_tarball} -C /var/lib/mediawiki/extensions; # tar -xzf Math-REL1_40-3f00f61.tar.gz -C /var/www/mediawiki/extensions
	(cd /var/lib/mediawiki/extensions; 
		sudo chown -R root:root .
	)
)
rm -fr .tmp.d;


###
### 2. modify LocalSettings.php
###
read -p "### ASK:  Will you edit LocalSettings.php file to add the following line? [Y|n] 
	wfLoadExtension( 'Math' );
" _answer;
if [ "X$_answer" != "Xn" ]; then
	sudo vi /var/lib/mediawiki/LocalSettings.php
fi


###
### 3. run update.php (in the 'mediawiki/maintenance' directory)
###
(cd /var/lib/mediawiki/maintenance;
php update.php;
)


