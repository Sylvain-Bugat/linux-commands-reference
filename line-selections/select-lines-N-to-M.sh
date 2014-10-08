#!/usr/bin/env bash

if [[ "${#}" -ge 1 && "${1}" != [0-9]* ]]
then
	echo "Usage: $0 <number of lines>"
	exit 2
fi

#Number of first lines to select (limit included)
#Select only lines between first and last lines number both first line and last are included
typeset -ir firstSelectedLine=${1:-5} #included
typeset -ir lastSelectedLine=${2:-15}
typeset -r sourceFile="input-file.txt"
typeset -r targetFile="selected-lines.txt"

#make a reference file based on the most common command
head -n 15 input-file.txt | tail -n $(( lastSelectedLine - firstSelectedLine + 1 )) > ref-selected-lines.txt

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
	executedCommand=$( echo "${line}" | sed -e 's/"?${firstSelectedLine}"?/'"${firstSelectedLine}"'/g' -e 's/"?${lastSelectedLine}"?/'"${lastSelectedLine}"'/g' -e 's/"${sourceFile}"/'"${sourceFile}"'/g' )
	echo "Executing: ${executedCommand}"
	eval "${line}" > "${targetFile}"
	checkSelectedLines "${executedCommand}"
done < select-lines-N-to-M-commands.sh
