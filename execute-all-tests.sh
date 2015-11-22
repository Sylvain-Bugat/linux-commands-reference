#!/usr/bin/env bash

. ./common-libs/commands-lib.sh

export PATH="${PATH}:."

listCommands=$( find . -type f -name "*-commands.sh" )

typeset -r baseDirectory="${PWD}"

typeset -i scriptReturn=0
for command in ${listCommands}
do
	typeset scriptFile=$( basename "${command}" | sed 's/-commands//' )
	typeset scriptDirectory=$( dirname "${command}" )
	typeset logFile=$( echo "${scriptFile}" | sed 's/.sh$/.log/' )
	
	cd "${scriptDirectory}"
	if [[ ! -x "${scriptFile}" ]]
	then
		chmod u+x "${scriptFile}"
	fi

	echo -n "${EXECUTING} ${scriptDirectory}/${scriptFile}"
	"${scriptFile}" >"${logFile}" 2>&1
	if [[ ${?} -ne 0 ]]
	then
		echo -e " [\033[31mKO\033[0m] more details in log file: ${scriptDirectory}/${logFile}"
		scriptReturn=1
	else
		echo -e " [\033[32mOK\033[0m]"
	fi
	cd "${baseDirectory}"
done 
