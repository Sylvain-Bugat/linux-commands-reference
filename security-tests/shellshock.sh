#!/bin/env bash

function check_bash_version {

	typeset bash_location=$( which bash )
	echo "BASH found: ${bash_location}"
	typeset version=$( ${bash_location} --version | head -1 | sed 's/^.* version //' )
	echo "version of ${bash_location}: ${version}"
	#test if the version is vulnerable
	if [[ "${version}" < "4.3" && "${version}" > "1.14" ]]
	then
		echo -e "\033[33mThis version may be vulnerable to bash bug/Shell Shock\033[0m"
	else
		echo -e "\033[32mThis version is not vulnerable to bash bug/Shell Shock\033[0m"
	fi
}

function test_shell_shock {

	#Source of this command: http://thehackernews.com/2014/09/bash-shell-vulnerability-shellshock.html
	env X="() { :;} ; echo VULNERABILITY" $( which bash ) -c "echo BASH"
}

function check_shell_shock {

	echo ""
	echo "Testing bash bug/Shell Shock vulnerability"
	typeset shell_shock=$( test_shell_shock 2>/dev/null )
	if [[ "${shell_shock}" = "BASH" ]]
	then
		echo -e "\033[32mThis system is not vulnerable to bash bug/Shell shock\033[0m"
		return 0
	else
		echo -e "\033[31mThis system is vulnerable to bash bug/Shell shock, BASH must be updated with a fixed version\033[0m"
		return 1
	fi
}

#Print the used BASH and the version
check_bash_version
#Test bash bug/shell shock command injection
check_shell_shock
return $?
