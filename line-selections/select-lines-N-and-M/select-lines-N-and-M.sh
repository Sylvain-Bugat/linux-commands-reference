#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 && ( "${1}" != [0-9]* || "${2}" != [0-9]* || "${1}" -ge "${2}" ) ]]
then
	echo "Usage: $0 <one line> <second line>"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#Select only these two lines
typeset -ir oneSelectedLine=${1:-5} #included
typeset -ir secondSelectedLine=${2:-15} #included

#make a reference file based on the most common command
sed -n -e "${oneSelectedLine}p" -e "${secondSelectedLine}p" "${sourceFile}" > "${refTargetFile}"

#Test all commands
testCommands "${oneSelectedLine}" "${secondSelectedLine}"
