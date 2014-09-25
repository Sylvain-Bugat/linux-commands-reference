#!/bin/env bash

function check_bash_version {

	typeset bash_location=$( which bash )
	echo "BASH found: ${bash_location}"
	typeset version=$( ${bash_location} --version | head -1 | sed 's/^.* version //' )
	echo "version of ${bash_location}: ${version}"
	#test if the version is vulnerable
	if [[ "${version}" < "4.3" && "${version}" > "1.14" ]]
	then
		echo "This version may be vulnerable to bash bug/Shell Shock"
	else
		echo "This version is not vulnerable to bash bug/Shell Shock"
	fi
}

function test_shell_chock {

	#Source of this command: http://thehackernews.com/2014/09/bash-shell-vulnerability-shellshock.html
	env X="() { :;} ; echo VULNERABILITY" $( which bash ) -c "echo BASH"
}

function check_shell_chock {

	echo "testing bash bug/Shell Shock vulnerability"
	typeset shell_chock=$( test_shell_chock 2>/dev/null )
	if [[ "${shell_chock}" = "BASH" ]]
	then
		echo "This system is not vulnerable to bash bug/Shell shock"
	else
		echo "This system is vulnerable to bash bug/Shell shock, BASH must be updated with a fixed version"
	fi
}

#Print the used BASH and the version
check_bash_version
#Test bash bug/shell shock command injection
check_shell_chock
