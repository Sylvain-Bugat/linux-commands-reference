#!/bin/env bash

function checkUnixFile {

	cmp ref-unix-file.txt unix-file.txt
	if [[ ${?} -ne 0 ]]
	then
		echo "Error checking file after $1" 1>&2
		exit 1
	fi
}

#Substitute all line ending \r characters with nothing
sed 's/\r$//' windows-file.txt > unix-file.txt
checkUnixFile "sed 's/\r$//'"
#Equivalent with redirecting input
sed 's/\r$//' < windows-file.txt > unix-file.txt
checkUnixFile "sed 's/\r$//'"

#Substitute all \r characters with nothing
sed 's/\r//' windows-file.txt > unix-file.txt
checkUnixFile "sed 's/\r//'"
#Equivalent with redirecting input
sed 's/\r//'< windows-file.txt > unix-file.txt
checkUnixFile "sed 's/\r//'"

#Delete all \r characters with nothing
tr -d '\r' < windows-file.txt > unix-file.txt2
checkUnixFile "tr -d '\r'"

#Substitute all line ending \r characters with nothing
awk ' /\r$/ { sub("\r$", "" ); print }' windows-file.txt > unix-file.txt
checkUnixFile "awk ' /\r$/ { sub("\r$", "" ); print }'"
#Equivalent with redirecting input
awk ' /\r$/ { sub("\r$", "" ); print }' < windows-file.txt unix-file.txt
checkUnixFile "awk ' /\r$/ { sub("\r$", "" ); print }'"

#Substitute all line ending \r characters with nothing
awk 'sub("\r$", "" )' windows-file.txt > unix-file.txt
checkUnixFile "awk 'sub("\r$", "" )'"
#Equivalent with redirecting input
awk 'sub("\r$", "" )' < windows-file.txt > unix-file.txt
checkUnixFile "awk 'sub("\r$", "" )'"
