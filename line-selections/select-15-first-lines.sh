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
head -n 15 input-file.txt > selected-lines.txt
checkSelectedLines "head -n 15"
#Equivalent with redirecting input
head -n 15 < input-file.txt > selected-lines.txt
checkSelectedLines "head -n 15"

#Select only lines 1 to 15
head -n +15 input-file.txt > selected-lines.txt
checkSelectedLines "head -n +15"
#Equivalent with redirecting input
head -n +15 < input-file.txt > selected-lines.txt
checkSelectedLines "head -n +15"

#Select only lines 1 to 15
sed -n '1,15p' input-file.txt > selected-lines.txt
checkSelectedLines "sed -n '1,15p'"
#Equivalent with redirecting input
sed -n '1,15p' < input-file.txt > selected-lines.txt
checkSelectedLines "sed -n '1,15p'"

#Select only lines 1 to 15
sed '15q' input-file.txt > selected-lines.txt
checkSelectedLines "sed '15q'"
#Equivalent with redirecting input
sed '15q' < input-file.txt > selected-lines.txt
checkSelectedLines "sed '15q'"

#Select only lines 1 to 15
awk 'NR <= 15 { print $0 }' input-file.txt > selected-lines.txt
checkSelectedLines "awk 'NR <= 15 { print $0 }'"
 #Equivalent with redirecting input
awk 'NR <= 15 { print $0 }' < input-file.txt > selected-lines.txt
checkSelectedLines "awk 'NR <= 15 { print $0 }'"

#Select only lines 1 to 15
awk '{ if( NR <= 15 ) print $0 }' input-file.txt > selected-lines.txt
checkSelectedLines "awk '{ if( NR <= 15 ) print $0 }'"
 #Equivalent with redirecting input
awk '{ if( NR <= 15 ) print $0 }' < input-file.txt > selected-lines.txt
checkSelectedLines "awk '{ if( NR <= 15 ) print $0 }'"
