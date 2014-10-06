#!/usr/bin/env bash
alias lastcommand="fc -rnl | sed '2!d'"

#Number of first lines to select (limit included)
typeset -ir selectedLines="${1:-15}"
typeset -r sourceFile="input-file.txt"
typeset -r targetFile="selected-lines.txt"

#make a reference file based on the most common command
head -${selectedLines} input-file.txt > ref-selected-lines.txt

function checkSelectedLines {

	cmp ref-selected-lines.txt selected-lines.txt
	if [[ ${?} -ne 0 ]]
	then
		echo "Error checking file after $1" 1>&2
		exit 1
	fi
}

#List one-line commands to execute and test
while read line
do
	executedCommand=$( echo "${line}" | sed -e 's/"${selectedLines}"/'"${selectedLines}"'/g' -e 's/"${sourceFile}"/'"${sourceFile}"'/g' )
	echo "Executing: ${executedCommand}"
	eval "${line}" > "${targetFile}"
	checkSelectedLines "${executedCommand}"
done < select-N-first-lines-commands.sh

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
checkSelectedLines "while read line ... break ... done < input-file.txt"

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
checkSelectedLines "while read line < &3... break ... done"

#Shell scripted variant to select only lines 1 to N
exec 3< "${sourceFile}"
> "${targetFile}"
for lineNumber in $( seq "${selectedLines}" )
do
    read line <&3
    echo -E "${line}" >> "${targetFile}"
done
exec 3<&-
checkSelectedLines "for read line"
