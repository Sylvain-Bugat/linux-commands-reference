test -f "${sourceFile}" 
[ -f "${sourceFile}" ]
[[ -f "${sourceFile}" ]]
ls -l "${sourceFile}" | grep "^-" >/dev/null 
ls -l "${sourceFile}" | grep -q "^-" 
ls -o "${sourceFile}" | grep "^-" >/dev/null 
ls -o "${sourceFile}" | grep -q "^-"
