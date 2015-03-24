test -f "${sourceFile}" ; echo $?
test -f "${sourceFile}" && echo 0
[ -f "${sourceFile}" ] ; echo $?
[ -f "${sourceFile}" ] && echo 0
[[ -f "${sourceFile}" ]] ; echo $?
[[ -f "${sourceFile}" ]] && echo 0
ls -l "${sourceFile}" | grep "^-" >/dev/null ; echo $?
ls -l "${sourceFile}" | grep "^-" >/dev/null && echo 0
ls -l "${sourceFile}" | grep -q "^-" ; echo $?
ls -l "${sourceFile}" | grep -q "^-" && echo 0
ls -o "${sourceFile}" | grep "^-" >/dev/null ; echo $?
ls -o "${sourceFile}" | grep "^-" >/dev/null && echo 0
ls -o "${sourceFile}" | grep -q "^-" ; echo $?
ls -o "${sourceFile}" | grep -q "^-" && echo 0
