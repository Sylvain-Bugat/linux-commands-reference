#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 && "${#1}" -ne 1 ]]
then
	echo "Usage: $0 <number of lines>"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#Character to squeeze, default: space
typeset -ir selectedLines="${1:-15}"

#make a reference file based on the most common command
head -${selectedLines} "${sourceFile}" > "${refTargetFile}"

#Test all commands
testCommands "${selectedLines}"

#Shell scripted variant to select only lines 1 to N
typeset -i lineNumber=0
> "${targetFile}"
while read line
do
	echo -E "${line}" >> "${targetFile}"
	(( lineNumber ++ ))
	if [[ "${lineNumber}" -ge "${selectedLines}" ]]
	then
		break
	fi
done < "${sourceFile}"
checkGeneratedFile "while read line ... break ... done < input-file.txt" "${refTargetFile}" "${targetFile}"

#Shell scripted variant to select only lines 1 to N
typeset -i lineNumber=0
> "${targetFile}"
exec 3< "${sourceFile}"
while read line <&3
do
	echo -E "${line}" >> "${targetFile}"
	(( lineNumber ++ ))
	if [[ "${lineNumber}" -ge "${selectedLines}" ]]
	then
		break
	fi
done
exec 3<&- 
checkGeneratedFile "while read line < &3... break ... done" "${refTargetFile}" "${targetFile}"

#Shell scripted variant to select only lines 1 to N
exec 3< "${sourceFile}"
> "${targetFile}"
for lineNumber in $( seq "${selectedLines}" )
do
	read line <&3
	echo -E "${line}" >> "${targetFile}"
done
exec 3<&-
checkGeneratedFile "for read line" "${refTargetFile}" "${targetFile}"
