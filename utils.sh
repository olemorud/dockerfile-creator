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
	printenv > $HOME/output/$ENVLOG

	echo "FROM ubuntu:20.04"
	echo ""
	echo "COPY $(basename $PACKAGELOG) ."
	echo "COPY $(basename $ENVLOG) ."
	echo ""
	echo "RUN apt upgrade \\"
	echo " && apt install \$(cat $(basename $PACKAGELOG)) \\"
	echo " && source $(basename $ENVLOG)"
	echo ""
}

alias apt=aptWithLog
