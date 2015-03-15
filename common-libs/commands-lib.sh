#!/usr/bin/env bash

#Default source file
typeset sourceFile="input-file.txt"
#Default target file
typeset targetFile="output-file.txt"

#Default reference file
typeset -r referenceFilePrefix="ref-"
typeset refTargetFile="${referenceFilePrefix}${targetFile}"

#Constant
typeset -r EXECUTING="Executing:"

#------------------------------------------------------
#
# Check the generated file by comparing it with an expected file
#
# $1 -> executed command
# $2 -> expected file name
# $3 -> generated file name
#
#------------------------------------------------------
function checkGeneratedFile {

	typeset -r executedCommand="${1}"
	typeset -r expectedFile="${2}"
	typeset -r generatedFile="${3}"

	cmp "${expectedFile}" "${generatedFile}"
	if [[ ${?} -ne 0 ]]
	then
		echo -e " [\033[31mKO\033[0m]" 1>&2
		exit 1
	else
		echo -e " [\033[32mOK\033[0m]" 1>&2
	fi
}

#------------------------------------------------------
#
# Print the executed command after arguments replacements
#
# $1 -> raw executed command
# $2 -> input file name
# $3... -> command arguments
#
#------------------------------------------------------
function printExecutedCommand {

	typeset -r inputFile="${2}"
	typeset executedCommand=$( echo "${1}" | sed -e 's/"${sourceFile}"/'"${inputFile}"'/g' )

	shift 2

	typeset -i argNumber=1
	while [[ ! -z "${1}" ]]
	do
		executedCommand=$( echo "${executedCommand}" | sed -e 's/'\''"${arg'"${argNumber}"'}"'\''/'"${1}"'/g' -e 's/"${arg'"${argNumber}"'}"/'"${1}"'/g' -e 's/'\''${arg'"${argNumber}"'}'\''/'"${1}"'/g' )
		shift
		(( argNumber ++ ))
	done

	echo -n "${executedCommand}"
}

#------------------------------------------------------
#
# Test all commands in the associated -commands.sh file
#
# $1... -> commands arguments
#
#------------------------------------------------------
function testCommands {

	typeset -r commandsShell=$( dirname "${0}" )/$( basename "${0}" | sed 's/.sh$/-commands.sh/' )

	#Map arguements as argX
	typeset -i argNumber=1
	for arg in ${*}
	do
		eval arg${argNumber}="'${arg}'"
		(( argNumber ++ ))
	done

	#List one-line commands to execute and test
	while read line
	do
		executedCommand=$( printExecutedCommand "${line}" "${sourceFile}" ${*})
		echo -n "${EXECUTING} ${executedCommand}"
		eval "${line}" > "${targetFile}"
		checkGeneratedFile "${executedCommand}" "${refTargetFile}" "${targetFile}"
	done < "${commandsShell}"
}
