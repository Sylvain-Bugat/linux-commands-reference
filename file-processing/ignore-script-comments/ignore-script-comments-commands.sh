sed '/^[ 	]*#/d' "${sourceFile}"
sed '/^[ 	]*#/d' < "${sourceFile}"
grep -v '^[ 	]*#' "${sourceFile}"
grep -v '^[ 	]*#' < "${sourceFile}"
egrep -v '^[ 	]*#' "${sourceFile}"
egrep -v '^[ 	]*#' < "${sourceFile}"
awk '$0 !~ /^[ 	]*#/ { print $0 }' "${sourceFile}"
awk '$0 !~ /^[ 	]*#/ { print $0 }' < "${sourceFile}"
awk '{ if ( $0 !~ "^[ 	]*#" ) { print $0 } }' "${sourceFile}"
awk '{ if ( $0 !~ "^[ 	]*#" ) { print $0 } }' < "${sourceFile}"
