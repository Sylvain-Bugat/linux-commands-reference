# Select the lines N to EOF in a file
***
## with tail command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |
**The classic method**:
```bash
tail -n +5 <file> 
```
Argument syntax variants:
```bash
tail -n+5 <file>
```
Input variant:
```bash
tail -n+5 < <file>
```

## with sed command
| Complexity::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
sed -n '5,$p' <file>
```
Argument syntax variants:
```bash
sed -n -e '5,$p' <file>
sed '5,$!d'" <file>
sed -e '5,$!d'" <file>
```
Input variant:
```bash
sed -n '5,$p' < <file>
```

## with awk command
| Complexity::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
awk 'NR >= 5 { print $0 }' <file>
```
Argument syntax variants:
```bash
awk '{  if ( NR >= 5 ) print $0 }' <file>
```
Input variant:
```bash
awk 'NR >= 5 { print $0 }' < <file>
```

## with shell scripting
| Complexity::warning: | Efficiency::warning: |
| ---------- | ---------- |

Loop and read one line of the file and print it within the `while`, ignore the 4 first lines.
```bash
typeset -i lineNumber=0
while read line
do
	(( lineNumber ++ ))
	if [[ "${lineNumber}" -lt 5 ]]
	then
		continue
	fi

	echo -E "${line}"
done < <file>
```
Interpreted shell script is less efficient than a single command.

Script variant using a file descriptor opened on the input file:
```bash
typeset -ir fileLength=$( wc -l <file> | awk '{ print $1 }' )
exec 3< <file>
typeset -i lineNumber=0
for lineNumber in $( seq $"{fileLength}" )
do
	read line <&3

  if [[ "${lineNumber}" -lt 5 ]]
	then
		continue
	fi

	echo -E "${line}"
done
exec 3<&-
```
Number of lines of the input file must be calculated before iterate over the file.
