#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 && "${1}" != [0-9]* ]]
then
	echo "Usage: $0 <number of lines>"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#Number of last lines to select, default: 15
typeset -ir selectedLines="${1:-15}"

#make a reference file based on the most common command
tail -${selectedLines} "${sourceFile}" > "${refTargetFile}"

#Test all commands
testCommands "${selectedLines}"

#Shell scripted variant to select only the N last lines
script='while read line ... if [[ "${fileLength}" -lt "${selectedLines}" ]] ... echo ... done'
echo -n "${EXECUTING} ${script}"
typeset -i fileLength=$( wc -l < ${sourceFile} )
> "${targetFile}"
while read line
do
	(( fileLength -- ))
	if [[ "${fileLength}" -lt "${selectedLines}" ]]
	then
		echo -E "${line}" >> "${targetFile}"
	fi
done < "${sourceFile}"
checkGeneratedFile "${script}" "${refTargetFile}" "${targetFile}"
