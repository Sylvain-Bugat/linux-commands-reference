#!/usr/bin/env bash

if [[ "${#}" -ge 1 && "${1}" != [0-9]* ]]
then
	echo "Usage: $0 <field to get>"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#Field number to select (starting from 1)
typeset -ir selectedField="${1:-2}"

#make a reference file based on the most common command
cut -d';' -f "${selectedField}" "${sourceFile}" > "${refTargetFile}"

#Test all commands
testCommands "${selectedField}"
