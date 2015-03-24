#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 ]]
then
	echo "Usage: $0"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

ln -s "target-file.txt" "${sourceFile}"

#make a reference file based on the most common command
test -h "${sourceFile}" ; echo $? > "${refTargetFile}"

#Test all commands
testCommands "${selectedLines}"
