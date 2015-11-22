#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 && "${#1}" -ne 1 ]]
then
	echo "Usage: $0 <character to squeeze>"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#Character to squeeze, default: a
typeset -r squeezeCharacter="${1:-a}"

#make a reference file based on the most common command
tr -s "'${squeezeCharacter}'" < "${sourceFile}" > "${refTargetFile}"

#Test all commands
testCommands "${squeezeCharacter}"
