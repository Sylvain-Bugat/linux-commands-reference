#!/usr/bin/env bash

if [[ "${#}" -gt 0 ]]
then
	echo "Usage: $0"
	exit 2
fi


typeset -r sourceFile="input-file.txt"
typeset -r targetFile="output-file.txt"

#make a reference file based the input file (copy
cp input-file.txt ref-output-file.txt

function checkOutputFile {

	cmp ref-output-file.txt output-file.txt
	if [[ ${?} -ne 0 ]]
	then
		echo "Error checking file after $1" 1>&2
		exit 1
	fi
}

#List one-line commands to execute and test
while read line
do
	executedCommand=$( echo "${line}" | sed -e 's/"${sourceFile}"/'"${sourceFile}"'/g' )
	echo "Executing: ${executedCommand}"
	eval "${line}" > "${targetFile}"
	checkSelectedLines "${executedCommand}"
done < processing-file-commands.sh
