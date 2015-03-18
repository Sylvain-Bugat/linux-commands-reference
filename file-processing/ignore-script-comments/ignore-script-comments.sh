#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 && "${#1}" -ne 1 ]]
then
	echo "Usage: $0 <number of lines>"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#Ignore comments with a 
sed '/^[ 	]*#/d' < "${sourceFile}" > "${refTargetFile}"

#Test all commands
testCommands "${selectedLines}"
