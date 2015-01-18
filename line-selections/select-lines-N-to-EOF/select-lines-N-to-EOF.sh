#!/usr/bin/env bash

#Check arguments
if [[ "${#}" -ge 1 && "${1}" != [0-9]* ]]
then
	echo "Usage: $0 <first line>"
	exit 2
fi

#Source commands library
. ../../common-libs/commands-lib.sh

#Number of lines to select (limit included)
#Select only lines between first and end-of-file, first line and last is included
typeset -ir firstSelectedLine=${1:-5} #included

#make a reference file based on the most common command
tail -n +"${firstSelectedLine}" "${sourceFile}" > "${refTargetFile}"

#Test all commands
testCommands "${firstSelectedLine}"

#Shell scripted variant to select only lines N to EOF
typeset -i lineNumber=0
> "${targetFile}"
while read line
do
	(( lineNumber ++ ))
	if [[ "${lineNumber}" -lt "${firstSelectedLine}" ]]
	then
		continue
	fi

	echo -E "${line}" >> "${targetFile}"
done < "${sourceFile}"
checkGeneratedFile "while read line ... continue ... done < <file>" "${refTargetFile}" "${targetFile}"

#Shell scripted variant to select only lines N to EOF
typeset -i lineNumber=0
> "${targetFile}"
exec 3< "${sourceFile}"
while read line <&3
do
	(( lineNumber ++ ))
	if [[ "${lineNumber}" -lt "${firstSelectedLine}" ]]
	then
		continue
	fi

	echo -E "${line}" >> "${targetFile}"
done
exec 3<&- 
checkGeneratedFile "while read line < &3... continue ... done" "${refTargetFile}" "${targetFile}"

#Shell scripted variant to select only lines N to EOF
typeset -ir fileLength=$( wc -l ${sourceFile} | awk '{ print $1 }' )
exec 3< "${sourceFile}"
> "${targetFile}"
for lineNumber in $( seq "${fileLength}" )
do
	read line <&3

	if [[ "${lineNumber}" -lt "${firstSelectedLine}" ]]
	then
		continue
	fi

	echo -E "${line}" >> "${targetFile}"
done
exec 3<&-
checkGeneratedFile "for read seq line ... continue ... echo" "${refTargetFile}" "${targetFile}"
