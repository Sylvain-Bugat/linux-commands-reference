#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -gt 0 ]]
then
        echo "Usage: $0"
        exit 2
fi

#Source commands library
. ../common-libs/commands-lib.sh

#Add execution rights to all batch launcher files
chmod u+x *.sh

#Add current path to PATH to execute customInterpreter
export PATH="${PATH}:."

#Test all commands
testCommandsReturn 

