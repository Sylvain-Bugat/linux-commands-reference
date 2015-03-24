#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 ]]
then
	echo "Usage: $0"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#make a reference file based on the most common command
test -d "${sourceFile}" ; echo $? > "${refTargetFile}"

#Test all commands
testCommands "${selectedLines}"
