test -d "${sourceFile}" ; echo $?
test -d "${sourceFile}" && echo 0
[ -d "${sourceFile}" ] ; echo $?
[ -d "${sourceFile}" ] && echo 0
[[ -d "${sourceFile}" ]] ; echo $?
[[ -d "${sourceFile}" ]] && echo 0
ls -ld "${sourceFile}" | grep "^d" >/dev/null ; echo $?
ls -ld "${sourceFile}" | grep "^d" >/dev/null && echo 0
ls -ld "${sourceFile}" | grep -q "^d" ; echo $?
ls -ld "${sourceFile}" | grep -q "^d" && echo 0
ls -od "${sourceFile}" | grep "^d" >/dev/null ; echo $?
ls -od "${sourceFile}" | grep "^d" >/dev/null && echo 0
ls -od "${sourceFile}" | grep -q "^d" ; echo $?
ls -od "${sourceFile}" | grep -q "^d" && echo 0
