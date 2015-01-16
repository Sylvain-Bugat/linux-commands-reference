#!/usr/bin/env bash

if [[ "${#}" -ge 1 && "${#1}" -ne 1 ]]
then
	echo "Usage: $0 <character to squeeze>"
	exit 2
fi

#Character to squeeze
typeset -ir squeezeCharacter="${1:- }"
typeset -r sourceFile="input-file.txt"
typeset -r targetFile="output-file.txt"
typeset -r referenceFilePrefix="ref-"

#make a reference file based on the most common command
tr -s"'${squeezeCharacter}'" "${sourceFile}" > "${referenceFilePrefix}${targetFile}"

function checkOutputFile {

	cmp "${referenceFilePrefix}${targetFile}" "${targetFile}"
	if [[ ${?} -ne 0 ]]
	then
		echo "Error checking file after $1" 1>&2
		exit 1
	fi
}

#List one-line commands to execute and test
while read line
do
	executedCommand=$( echo "${line}" | sed -e 's/"${squeezeCharacter}"/'"${squeezeCharacter}"'/g' -e 's/"${sourceFile}"/'"${sourceFile}"'/g' )
	echo "Executing: ${executedCommand}"
	eval "${line}" > "${targetFile}"
	checkSelectedLines "${executedCommand}"
done < "$0"-commands.sh

