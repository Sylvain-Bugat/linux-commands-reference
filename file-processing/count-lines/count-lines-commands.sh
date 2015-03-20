wc -l < "${sourceFile}"
wc -l "${sourceFile}" | cut -d ' ' -f 1
wc -l "${sourceFile}" | cut -d' ' -f1
wc -l "${sourceFile}" | awk '{print $1}'
wc -l "${sourceFile}" | sed 's/ .*//'
wc -l "${sourceFile}" | sed 's/ .*$//'
wc -l "${sourceFile}" | sed -e 's/ .*//'
wc -l "${sourceFile}" | sed -e 's/ .*$//'
wc "${sourceFile}"  | tr -s ' ' | cut -d ' ' -f 2
wc "${sourceFile}"  | tr -s ' ' | cut -d' ' -f2
wc < "${sourceFile}"  | tr -s ' ' | cut -d ' ' -f 2
wc < "${sourceFile}"  | tr -s ' ' | cut -d' ' -f2
wc "${sourceFile}"  | tr -s ' ' | awk '{print $1}'
wc < "${sourceFile}"  | tr -s ' ' | awk '{print $1}'
wc "${sourceFile}"  | tr --squeeze-repeats ' ' | cut --delimiter=' ' --fields=2
wc < "${sourceFile}"  | tr --squeeze-repeats ' ' | cut --delimiter=' ' --fields=2
wc "${sourceFile}"  | awk '{print $1}'
wc < "${sourceFile}"  | awk '{print $1}'
cat "${sourceFile}" | wc -l
sed -n '$=' "${sourceFile}"
sed -n '$=' < "${sourceFile}"
cat "${sourceFile}" | sed -n '$='
awk 'END {print NR}' "${sourceFile}"
awk 'END {print NR}' < "${sourceFile}"
cat "${sourceFile}" | awk 'END {print NR}'
grep -c "" "${sourceFile}"
grep -c "" < "${sourceFile}"
cat "${sourceFile}" | grep -c ""
grep --count "" "${sourceFile}"
grep --count "" < "${sourceFile}"
cat "${sourceFile}" | grep --count ""
egrep -c "" "${sourceFile}"
egrep -c "" < "${sourceFile}"
cat "${sourceFile}" | egrep -c ""
egrep --count "" "${sourceFile}"
egrep --count "" < "${sourceFile}"
cat "${sourceFile}" | egrep --count ""
perl -lne 'END { print $. }' "${sourceFile}"
perl -lne 'END { print $. }' < "${sourceFile}"
cat "${sourceFile}" | perl -lne 'END { print $. }'
perl -lne'END { print $. }' "${sourceFile}"
perl -lne'END { print $. }' < "${sourceFile}"
cat "${sourceFile}" | perl -lne'END { print $. }'
