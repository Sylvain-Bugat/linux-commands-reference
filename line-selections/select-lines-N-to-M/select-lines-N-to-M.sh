#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 && ( "${1}" != [0-9]* || "${2}" != [0-9]* ) ]]
then
	echo "Usage: $0 <first line> <last line>"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#Number of first lines to select (limits included)
#Select only lines between first and last lines number both first line and last are included
typeset -ir firstSelectedLine=${1:-5} #included
typeset -ir lastSelectedLine=${2:-15} #included

#make a reference file based on the most common command
head -n "${lastSelectedLine}" "${sourceFile}" | tail -n $(( lastSelectedLine - firstSelectedLine + 1 )) > "${refTargetFile}"

#Test all commands
testCommands "${firstSelectedLine}" "${lastSelectedLine}"
