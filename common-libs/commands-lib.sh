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

	cmp "${expectedFile}" "${generatedFile}" >/dev/null 2>&1
	if [[ ${?} -ne 0 ]]
	then
		echo -e " [\033[31mKO\033[0m]"
		exit 1
	else
		echo -e " [\033[32mOK\033[0m]"
	fi
}

#------------------------------------------------------
#
# Check the command return, must be 0 (OK)
#
# $1 -> executed command
# $2 -> command return
#
#------------------------------------------------------
function checkCommandReturn {

        typeset -r executedCommand="${1}"
        typeset -r commandReturn="${2}"

        if [[ ${commandReturn} -ne 0 ]]
        then
                echo -e " [\033[31mKO\033[0m]"
                exit 1
        else
                echo -e " [\033[32mOK\033[0m]"
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
		executedCommand=$( echo "${executedCommand}" | sed -e 's/'\''"${arg'"${argNumber}"'}"'\''/'"${1}"'/g' -e 's/"${arg'"${argNumber}"'}"/'"${1}"'/g' -e 's/'\''${arg'"${argNumber}"'}'\''/'"${1}"'/g' -e 's/${arg'"${argNumber}"'}/'"${1}"'/g' )
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

		#Test input after | with cat instead of '< "${sourceFile}"'
		if [[ "${line}" = *'< "${sourceFile}"' ]]
		then
			typeset lineCat=$( echo "${line}" | sed 's/\(.*\)< "${sourceFile}"$/cat "${sourceFile}" | \1/' )
			executedCommand=$( printExecutedCommand "${lineCat}" "${sourceFile}" ${*})
			echo -n "${EXECUTING} ${executedCommand}"
			eval "${lineCat}" > "${targetFile}"
			checkGeneratedFile "${executedCommand}" "${refTargetFile}" "${targetFile}"

			typeset lineCat=$( echo "${line}" | sed 's/\(.*\)< "${sourceFile}"$/cat < "${sourceFile}" | \1/' )
			executedCommand=$( printExecutedCommand "${lineCat}" "${sourceFile}" ${*})
			echo -n "${EXECUTING} ${executedCommand}"
			eval "${lineCat}" > "${targetFile}"
			checkGeneratedFile "${executedCommand}" "${refTargetFile}" "${targetFile}"
		fi
	done < "${commandsShell}"
}

#------------------------------------------------------
#
# Test all commands return un the associated -commands.sh file
#
# $1... -> commands arguments
#
#------------------------------------------------------
function testCommandsReturn {

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
                commandReturn=${?}
		checkCommandReturn "${executedCommand}" "${commandReturn}" 

                #Test input after | with cat instead of '< "${sourceFile}"'
                if [[ "${line}" = *'< "${sourceFile}"' ]]
                then
                        typeset lineCat=$( echo "${line}" | sed 's/\(.*\)< "${sourceFile}"$/cat "${sourceFile}" | \1/' )
                        executedCommand=$( printExecutedCommand "${lineCat}" "${sourceFile}" ${*})
                        echo -n "${EXECUTING} ${executedCommand}"
                        eval "${lineCat}" > "${targetFile}"
	                commandReturn=${?}
        	        checkCommandReturn "${executedCommand}" "${commandReturn}"

                        typeset lineCat=$( echo "${line}" | sed 's/\(.*\)< "${sourceFile}"$/cat < "${sourceFile}" | \1/' )
                        executedCommand=$( printExecutedCommand "${lineCat}" "${sourceFile}" ${*})
                        echo -n "${EXECUTING} ${executedCommand}"
                        eval "${lineCat}" > "${targetFile}"
                        commandReturn=${?}
                	checkCommandReturn "${executedCommand}" "${commandReturn}"
                fi
        done < "${commandsShell}"
}

