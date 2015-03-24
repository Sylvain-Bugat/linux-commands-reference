test -h "${sourceFile}" ; echo $?
test -h "${sourceFile}" && echo 0
[ -h "${sourceFile}" ] ; echo $?
[ -h "${sourceFile}" ] && echo 0
[[ -h "${sourceFile}" ]] ; echo $?
[[ -h "${sourceFile}" ]] && echo 0
ls -ld "${sourceFile}" | grep "^l" >/dev/null ; echo $?
ls -ld "${sourceFile}" | grep "^l" >/dev/null && echo 0
ls -ld "${sourceFile}" | grep -q "^l" ; echo $?
ls -ld "${sourceFile}" | grep -q "^l" && echo 0
ls -od "${sourceFile}" | grep "^l" >/dev/null ; echo $?
ls -od "${sourceFile}" | grep "^l" >/dev/null && echo 0
ls -od "${sourceFile}" | grep -q "^l" ; echo $?
ls -od "${sourceFile}" | grep -q "^l" && echo 0
