#!/bin/sh
# ^^ script is supposed to be sourced but this helps debug

PACKAGELOG="$HOME/output/packages"
ENVLOG="$HOME/output/envdump"

alias source='.'

# logs successfully installed packages to logfile pointed to by $log
aptWithLog() {
	if [ "$1" != "install" ]; then
		apt $@
	fi

	# command is 'install
	packages="${@:2}"

	# append installed packages to $PACKAGELOG
	# if successfully installed
	if apt install $packages -y; then
		echo $packages >> $PACKAGELOG
	fi
}

exportimage() {
	printenv > $ENVLOG

	echo "FROM ubuntu:20.04"
	echo ""
	echo "COPY $(basename $PACKAGELOG) ."
	echo ""
	echo "RUN apt update \\"
	echo " && apt install \$(cat $(basename $PACKAGELOG)) \\"
	echo ""
	echo "COPY $(basename $ENVLOG) /$(basename $ENVLOG)"
	echo "echo 'source /$(basename $ENVLOG)' >> ~/.bashrc"
	echo ""
}

alias apt=aptWithLog
