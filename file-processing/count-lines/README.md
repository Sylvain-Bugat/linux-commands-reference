# Count lines of a file or any input
***
Classic use-cases:  
**Count lines of a single file**  
**Count result of an input behind a pipe (|)**

## with wc command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |
**The classic method**:
```bash
wc -l <file> 
```
:warning: The file is printed on the output by the `wc` command, if only the lines count is needed you can just redirect the input:
```bash
wc -l < <file> 
```

To suppress the file name, many unefficient variant exist:
```bash
wc -l <file>  | cut -d ' ' -f 1
wc -l <file>  | cut -d' ' -f1
wc -l <file>  | awk '{print $1}'
wc -l <file>   | sed 's/ .*//'
wc -l <file>   | sed 's/ .*$//'
wc <file>   | tr -s ' ' | cut -d ' ' -f 2
wc <file>   | tr -s ' ' | cut -d' ' -f2
wc <file>   | awk '{print $1}'
wc <file>   | tr --squeeze-repeats ' ' | cut --delimiter=' ' --fields=2
wc <file>   | awk '{print $1}'
```
In these command one or more process are created to execute these commands.

## with sed command
| Complexity::warning::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |

:warning: This commande ony work with GNU sed, use `sed --version` or `man sed` to see which version of sed is installed.
```bash
sed -n '$=' <file>
```
Input variant:
```bash
sed -n '$=' < <file>
```

## with awk command
| Complexity::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
awk 'END {print NR}' <file>
```

Syntax variant:
```bash
awk '{ lineNumber++ } END {print lineNumber}'
```

Input variant:
```bash
awk 'END {print NR}' < <file>
```

## with grep command
| Complexity::warning: | Efficiency::warning: |
| ---------- | ---------- |

```bash
grep -c "" <file>
```
Argument syntax variants:
```bash
grep --count "" "${sourceFile}"
```
Input variant:
```bash
grep -c "" < <file>
```

## with egrep command
| Complexity::warning: | Efficiency::warning: |
| ---------- | ---------- |

```bash
egrep -c "" <file>
```
Argument syntax variants:
```bash
egrep --count "" "${sourceFile}"
```
Input variant:
```bash
egrep -c "" < <file>
```

## with perl command
| Complexity::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
perl -lne 'END { print $. }' <file>
```
Argument syntax variants:
```bash
perl -lne'END { print $. }' <file>
```
Input variant:
```bash
perl -lne 'END { print $. }' < <file>
```

## with shell scripting
| Complexity::warning: | Efficiency::warning::warning: |
| ---------- | ---------- |

Loop and read one line of the file to count it.
```bash
typeset -i lineNumber=0
while read line
do
	(( lineNumber ++ ))
done < <file>
echo "${lineNumber}"
```
Interpreted shell script is less efficient than a single command.

Script variant using a file descriptor opened on the input file:
```bash
typeset -i lineNumber=0
exec 3< <file>
while read line <&3
do
	(( lineNumber ++ ))
done
exec 3<&- 
echo "${lineNumber}"
```
Interpreted shell script is less efficient than a single command.

Script variant using a file descriptor opened on the input file:
```bash
typeset -i lineNumber=0
exec 3< <file>
while true
do
	read line <&3
	if [[ "${?}" -ne 0 ]]
	then
		break
	fi
	(( lineNumber ++ ))
done
exec 3<&-
echo "${lineNumber}" > "${targetFile}"
```
A test is needed after each line read which is inefficient.
