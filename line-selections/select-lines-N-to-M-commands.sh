head -"${lastSelectedLine}" "${sourceFile}" | tail -$(( ${lastSelectedLine} - ${firstSelectedLine} + 1 ))
head -"${lastSelectedLine}" < "${sourceFile}" | tail -$(( ${lastSelectedLine} - ${firstSelectedLine} + 1 ))
head -n "${lastSelectedLine}" "${sourceFile}" | tail -n $(( ${lastSelectedLine} - ${firstSelectedLine} + 1 ))
head -n "${lastSelectedLine}" < "${sourceFile}" | tail -n $(( ${lastSelectedLine} - ${firstSelectedLine} + 1 ))
head -n"${lastSelectedLine}" "${sourceFile}" | tail -n$(( ${lastSelectedLine} - ${firstSelectedLine} + 1 ))
head -n"${lastSelectedLine}" < "${sourceFile}" | tail -n$(( ${lastSelectedLine} - ${firstSelectedLine} + 1 ))
head -n +"${lastSelectedLine}" "${sourceFile}" | tail -n +"${firstSelectedLine}"
head -n +"${lastSelectedLine}" < "${sourceFile}" | tail -n +"${firstSelectedLine}"
head -n+"${lastSelectedLine}" "${sourceFile}" | tail -n+"${firstSelectedLine}"
head -n+"${lastSelectedLine}" < "${sourceFile}" | tail -n+"${firstSelectedLine}"
sed -n "${firstSelectedLine},${lastSelectedLine}p" "${sourceFile}"
sed -n "${firstSelectedLine},${lastSelectedLine}p" < "${sourceFile}"
sed "${firstSelectedLine},${lastSelectedLine}!d" "${sourceFile}"
sed "${firstSelectedLine},${lastSelectedLine}!d" < "${sourceFile}"
sed -n -e "${firstSelectedLine},${lastSelectedLine}p" -e "${lastSelectedLine}q" "${sourceFile}"
sed -n -e "${firstSelectedLine},${lastSelectedLine}p" -e "${lastSelectedLine}q" < "${sourceFile}"
sed -e "${firstSelectedLine},${lastSelectedLine}!d" -e "${lastSelectedLine}q" "${sourceFile}"
sed -e "${firstSelectedLine},${lastSelectedLine}!d" -e "${lastSelectedLine}q" < "${sourceFile}"
sed -e "${firstSelectedLine},${lastSelectedLine}!d" -e "${lastSelectedLine}q" < "${sourceFile}"
awk 'NR >= '"${firstSelectedLine}"' && NR <='"${lastSelectedLine}"' { print $0 }' "${sourceFile}"
awk 'NR >= '"${firstSelectedLine}"' && NR <='"${lastSelectedLine}"' { print $0 }' < "${sourceFile}"
awk 'NR >= '"${firstSelectedLine}"' && NR <'"${lastSelectedLine}"' { print $0 } NR =='"${lastSelectedLine}"' { print $0 ; exit }' "${sourceFile}"
awk 'NR >= '"${firstSelectedLine}"' && NR <'"${lastSelectedLine}"' { print $0 } NR =='"${lastSelectedLine}"' { print $0 ; exit }' < "${sourceFile}"
