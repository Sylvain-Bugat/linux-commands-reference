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

#Select only lines 1 to 15
awk 'NR == 15 { print $0 ; exit } { print $0 }' input-file.txt > selected-lines.txt
checkSelectedLines "awk 'NR == 15 { print $0 ; exit } { print $0 }'"
 #Equivalent with redirecting input
awk 'NR == 15 { print $0 ; exit } { print $0 }' < input-file.txt > selected-lines.txt
checkSelectedLines "awk 'NR == 15 { print $0 ; exit } { print $0 }'"

#Shell scripted select only lines 1 to 15
typeset -i lineNumber=0
> selected-lines.txt
while read line
do
	echo -E "${line}" >> selected-lines.txt
	(( lineNumber ++ ))
	if [[ ${lineNumber} -ge 15 ]]
	then
		break
	fi
done < input-file.txt
checkSelectedLines "while read line ... break"

#Shell scripted select only lines 1 to 15
exec 3< input-file.txt
> selected-lines.txt
for lineNumber in $( seq 15 )
do
    read line <&3
    echo -E "${line}" >> selected-lines.txt
done
checkSelectedLines "for read line"
