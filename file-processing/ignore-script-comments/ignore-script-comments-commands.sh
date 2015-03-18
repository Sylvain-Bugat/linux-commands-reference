sed '/^[ 	]*#/d' "${sourceFile}"
sed '/^[ 	]*#/d' < "${sourceFile}"
grep -v '^[ 	]*#' "${sourceFile}"
grep -v '^[ 	]*#' < "${sourceFile}"
