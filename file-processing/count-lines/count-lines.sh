#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 && "${#1}" -ne 1 ]]
then
	echo "Usage: $0 <number of lines>"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#count lines into a reference file based on the most common command
wc -l < "${sourceFile}" > "${refTargetFile}"

#Test all commands
testCommands "${selectedLines}"

#Shell scripted variant to count lines
script="while read line ... lineNumber++ ... done < input-file.txt"
echo -n "${EXECUTING} ${script}"
typeset -i lineNumber=0
while read line
do
	(( lineNumber ++ ))
done < "${sourceFile}"
echo "${lineNumber}" > "${targetFile}"
checkGeneratedFile "${script}" "${refTargetFile}" "${targetFile}"

#Shell scripted variant to count lines
script="while read line < &3 ... lineNumber++ ... done"
echo -n "${EXECUTING} ${script}"
typeset -i lineNumber=0
exec 3< "${sourceFile}"
while read line <&3
do
	(( lineNumber ++ ))
done
exec 3<&- 
echo "${lineNumber}" > "${targetFile}"
checkGeneratedFile "${script}" "${refTargetFile}" "${targetFile}"

#Shell scripted variant to count lines
script="while true ... read line <&3 ... done"
echo -n "${EXECUTING} ${script}"
typeset -i lineNumber=0
exec 3< "${sourceFile}"
> "${targetFile}"
while true
do
	read line <&3
	if [[ "${?}" -ne 0 ]]
	then
		break
	fi
	(( lineNumber ++ ))
done
exec 3<&-
echo "${lineNumber}" > "${targetFile}"
checkGeneratedFile "${script}" "${refTargetFile}" "${targetFile}"
