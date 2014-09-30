#!/usr/bin/env bash

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

#CVE-2014-6271
function test_shell_shock_cve_2014_6271 {

	#Source of this command: http://thehackernews.com/2014/09/bash-shell-vulnerability-shellshock.html
	env X="() { :;} ; echo VULNERABILITY" $( which bash ) -c "echo BASH"
}

#CVE-2014-7169
function test_shell_shock_cve_2014_7169 {

	cd /tmp; rm -f echo; env 'x=() { (a)=>\' bash -c "echo date"

	if [[ -f /tmp/echo ]]
	then
		rm -f /tmp/echo
		return 1
	fi

	return 0
}

function check_shell_shock {

	typeset check_return=0

	echo ""
	echo "Testing bash bug/Shell Shock vulnerability"
	typeset shell_shock=$( test_shell_shock_cve_2014_6271 2>/dev/null )
	if [[ "${shell_shock}" = "BASH" ]]
	then
		echo -e "\033[32mThis system is not vulnerable to shell shock CVE-2014-6271\033[0m"
	else
		echo -e "\033[31mThis system is vulnerable to shell shock CVE-2014-6271, BASH must be updated with a fixed version\033[0m"
		check_return=1
	fi

	test_shell_shock_cve_2014_7169 >/dev/null 2>&1
	if [[ "${?}" -ne 1 ]]
	then
		echo -e "\033[32mThis system is not vulnerable to shell shock CVE-2014-7169\033[0m"
	else
		echo -e "\033[31mThis system is vulnerable to shell shock CVE-2014-7169, BASH must be updated with a fixed version\033[0m"
		check_return=1
	fi

	return "${check_return}"
}

#Print the used BASH and the version
check_bash_version
#Test bash bug/shell shock command injection
check_shell_shock
exit $?
