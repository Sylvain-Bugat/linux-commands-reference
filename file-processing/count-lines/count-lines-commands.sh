wc -l < "${sourceFile}"
wc -l "${sourceFile}" | cut -d ' ' -f 1
wc -l "${sourceFile}" | cut -d' ' -f1
wc -l "${sourceFile}" | awk '{print $1}'
wc "${sourceFile}"  | tr -s ' ' | cut -d ' ' -f 2
wc "${sourceFile}"  | tr -s ' ' | cut -d' ' -f2
wc < "${sourceFile}"  | tr -s ' ' | cut -d ' ' -f 2
wc < "${sourceFile}"  | tr -s ' ' | cut -d' ' -f2
wc "${sourceFile}"  | tr -s ' ' | awk '{print $1}'
wc < "${sourceFile}"  | tr -s ' ' | awk '{print $1}'
wc "${sourceFile}"  | tr --squeeze-repeats ' ' | cut --delimiter=' ' --fields=2
wc < "${sourceFile}"  | tr --squeeze-repeats ' ' | cut --delimiter=' ' --fields=2
wc "${sourceFile}"  | tr --squeeze-repeats ' ' | awk '{print $1}'
wc < "${sourceFile}"  | tr --squeeze-repeats ' ' | awk '{print $1}'
sed -n '$=' "${sourceFile}"
sed -n '$=' < "${sourceFile}"
awk 'END {print NR}' "${sourceFile}"
awk 'END {print NR}' < "${sourceFile}"
grep -c "" "${sourceFile}"
grep -c "" < "${sourceFile}"
perl -lne 'END { print $. }' "${sourceFile}"
perl -lne 'END { print $. }' < "${sourceFile}"
perl -lne'END { print $. }' "${sourceFile}"
perl -lne'END { print $. }' < "${sourceFile}"
