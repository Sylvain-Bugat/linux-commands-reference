#!/usr/bin/env bash

if [[ "${#}" -ge 1 && "${1}" != [0-9]* ]]
then
	echo "Usage: $0 <field to get>"
	exit 2
fi

#Field number to select (starting from 1)
typeset -ir selectedField="${1:-2}"
typeset -r sourceFile="input-file.txt"
typeset -r targetFile="selected-lines.txt"

#make a reference file based on the most common command
cut -d';' -f "${selectedField}" input-file.txt > ref-selected-lines.txt

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
	executedCommand=$( echo "${line}" | sed -e 's/"${selectedField}"/'"${selectedField}"'/g' -e 's/"${sourceFile}"/'"${sourceFile}"'/g' )
	echo "Executing: ${executedCommand}"
	eval "${line}" > "${targetFile}"
	checkSelectedLines "${executedCommand}"
done < select-the-N-field-commands.sh
