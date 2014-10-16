#!/usr/bin/env bash

function test_connection {

	echo "Testing connection to ${1:-localhost}:${2:-443}"
	typeset result=$( echo quit | timeout 5 telnet ${1:-localhost} ${2:-443} 2>&1 )
	typeset connected=$( echo "${result}" | grep -i "connected" )
	
	if [[ -z "${connected}" ]]
	then
		echo -e "\033[31mCannot connect to the server ${1:-localhost} on port ${2:-443}, check the network\033[0m"
		return 1
	else
		echo -e "\033[32mConnection with server ${1:-localhost} on port ${2:-443} established\033[0m"
		return 0
	fi
}

#CVE-2014-3566
function test_poodle_cve_2014_3566 {
	
	echo "Testing SSLv3 connection on ${1:-localhost}:${2:-443}"
	typeset result=$( timeout 5 openssl s_client -connect ${1:-localhost}:${2:-443} -ssl3 2>&1 )
	typeset certificateFound=$( echo "${result}" | grep -- "-----BEGIN CERTIFICATE-----" )
	
	if [[ -z "${certificateFound}" ]]
	then
		echo -e "\033[32mThe server ${1:-localhost}:${2:-443} system is not vulnerable to poodle CVE-2014-3566\033[0m"
		return 0
	else 
		echo -e "\033[31mThe server ${1:-localhost}:${2:-443} system is vulnerable to poodle CVE-2014-3566, SSLv3 must be disabled on this server\033[0m"
		return 1
	fi
}

#test server connection
test_connection $1 $2
if [[ $? -ne 0 ]]
then
	exit 1
fi

#Test poodle
test_poodle_cve_2014_3566 $1 $2
exit $?
