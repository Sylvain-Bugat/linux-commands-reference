#!/usr/bin/env bash

function checkSelectedLines {

	cmp ref-selected-lines.txt selected-lines.txt
	if [[ ${?} -ne 0 ]]
	then
		echo "Error checking file after $1" 1>&2
		exit 1
	fi
}

#Select only lines 1 to 15
head -15 input-file.txt > selected-lines.txt
checkSelectedLines "head -15"
#Equivalent with redirecting input
head -15 < input-file.txt > selected-lines.txt
checkSelectedLines "head -15"

#Select only lines 1 to 15
sed -n '1,15p' input-file.txt > selected-lines.txt
checkSelectedLines "sed -n '1,15p'"
#Equivalent with redirecting input
sed -n '1,15p' < input-file.txt > selected-lines.txt
checkSelectedLines "sed -n '1,15p'"
