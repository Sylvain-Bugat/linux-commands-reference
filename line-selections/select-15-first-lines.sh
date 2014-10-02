#!/usr/bin/env bash

function checkSelectedLines {

	cmp ref-selected-lines.txt selected-lines.txt
	if [[ ${?} -ne 0 ]]
	then
		echo "Error checking file after $1" 1>&2
		exit 1
	fi
}

#Substitute all line ending \r characters with nothing
head -15 input-file.txt > selected-lines.txt
checkSelectedLines "head -15"
#Equivalent with redirecting input
head -15 < input-file.txt > selected-lines.txt
checkSelectedLines "head -15"
