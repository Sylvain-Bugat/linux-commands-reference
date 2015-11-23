#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 ]]
then
	echo "Usage: $0"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#Test all commands
testCommandsReturn "${selectedLines}"
