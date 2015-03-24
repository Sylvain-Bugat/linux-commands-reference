#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 ]]
then
	echo "Usage: $0"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#Number of last lines to select, default: 15
typeset -ir selectedLines="${1:-15}"

#make a reference file based on the most common command
test -f "${sourceFile}" ; echo $? > "${refTargetFile}"

#Test all commands
testCommands "${selectedLines}"
