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

#Shell scripted variant to select only lines N to M
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

	if [[ "${lineNumber}" -ge "${lastSelectedLine}" ]]
	then
		break
	fi
done < "${sourceFile}"
checkGeneratedFile "while read line ... continue/break ... done < <file>" "${refTargetFile}" "${targetFile}"

#Shell scripted variant to select only lines N to M
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

	if [[ "${lineNumber}" -ge "${lastSelectedLine}" ]]
	then
		break
	fi
done
exec 3<&- 
checkGeneratedFile "while read line < &3... continue/break ... done" "${refTargetFile}" "${targetFile}"

#Shell scripted variant to select only lines N to M
exec 3< "${sourceFile}"
> "${targetFile}"
for lineNumber in $( seq "${lastSelectedLine}" )
do
	read line <&3

	if [[ "${lineNumber}" -lt "${firstSelectedLine}" ]]
	then
		continue
	fi

	echo -E "${line}" >> "${targetFile}"
done
exec 3<&-
checkGeneratedFile "for read line ... continue ... echo" "${refTargetFile}" "${targetFile}"
