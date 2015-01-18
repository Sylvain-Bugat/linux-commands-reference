head -"${arg2}" "${sourceFile}" | tail -$(( ${arg2} - ${arg1} + 1 ))
head -"${arg2}" < "${sourceFile}" | tail -$(( ${arg2} - ${arg1} + 1 ))
head -n "${arg2}" "${sourceFile}" | tail -n $(( ${arg2} - ${arg1} + 1 ))
head -n "${arg2}" < "${sourceFile}" | tail -n $(( ${arg2} - ${arg1} + 1 ))
head -n"${arg2}" "${sourceFile}" | tail -n$(( ${arg2} - ${arg1} + 1 ))
head -n"${arg2}" < "${sourceFile}" | tail -n$(( ${arg2} - ${arg1} + 1 ))
head -n +"${arg2}" "${sourceFile}" | tail -n +"${arg1}"
head -n +"${arg2}" < "${sourceFile}" | tail -n +"${arg1}"
head -n+"${arg2}" "${sourceFile}" | tail -n+"${arg1}"
head -n+"${arg2}" < "${sourceFile}" | tail -n+"${arg1}"
sed -n "${arg1},${arg2}p" "${sourceFile}"
sed -n "${arg1},${arg2}p" < "${sourceFile}"
sed "${arg1},${arg2}!d" "${sourceFile}"
sed "${arg1},${arg2}!d" < "${sourceFile}"
sed -n -e "${arg1},${arg2}p" -e "${arg2}q" "${sourceFile}"
sed -n -e "${arg1},${arg2}p" -e "${arg2}q" < "${sourceFile}"
sed -e "${arg1},${arg2}!d" -e "${arg2}q" "${sourceFile}"
sed -e "${arg1},${arg2}!d" -e "${arg2}q" < "${sourceFile}"
sed "${arg1},${arg2}!d;${arg2}q" "${sourceFile}"
sed "${arg1},${arg2}!d;${arg2}q" < "${sourceFile}"
awk 'NR >= '"${arg1}"' && NR <='"${arg2}"' { print $0 }' "${sourceFile}"
awk 'NR >= '"${arg1}"' && NR <='"${arg2}"' { print $0 }' < "${sourceFile}"
awk 'NR >= '"${arg1}"' && NR <'"${arg2}"' { print $0 } NR =='"${arg2}"' { print $0 ; exit }' "${sourceFile}"
awk 'NR >= '"${arg1}"' && NR <'"${arg2}"' { print $0 } NR =='"${arg2}"' { print $0 ; exit }' < "${sourceFile}"
awk 'NR >= '"${arg1}"' && NR <'"${arg2}"' { print $0 } NR >='"${arg2}"' { print $0 ; exit }' "${sourceFile}"
awk 'NR >= '"${arg1}"' && NR <'"${arg2}"' { print $0 } NR >='"${arg2}"' { print $0 ; exit }' < "${sourceFile}"
awk 'NR >= '"${arg1}"' && NR <='"${arg2}"' { print $0 } NR >'"${arg2}"' { exit }' "${sourceFile}"
awk 'NR >= '"${arg1}"' && NR <='"${arg2}"' { print $0 } NR >'"${arg2}"' { exit }' < "${sourceFile}"
awk 'NR =='"${arg2}"' { print $0 ; exit } NR >= '"${arg1}"' { print $0 } ' "${sourceFile}"
awk 'NR =='"${arg2}"' { print $0 ; exit } NR >= '"${arg1}"' { print $0 } ' < "${sourceFile}"
awk 'NR >= '"${arg1}"' {  print $0 ; if ( NR >= '"${arg2}"' ) exit }' "${sourceFile}"
awk 'NR >= '"${arg1}"' {  print $0 ; if ( NR >= '"${arg2}"' ) exit }' < "${sourceFile}"
awk '{  if ( NR >= '"${arg1}"' ) print $0 ; if ( NR >= '"${arg2}"' ) exit }' "${sourceFile}"
awk '{  if ( NR >= '"${arg1}"' ) print $0 ; if ( NR >= '"${arg2}"' ) exit }' < "${sourceFile}"
