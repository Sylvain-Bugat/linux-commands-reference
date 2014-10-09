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
