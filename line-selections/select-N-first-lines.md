# Select the first N lines of a file
***
## with head command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |
**The classic method**:
```bash
head -n 15 <file>
```
Argument syntax variants:
```bash
head -15 <file>
head -n +15 <file>
head -n+15 <file>
```
Input variant:
```bash
head -n 15 < <file>
```

Unefficient variant:
```bash
cat <file> | head -n 15
```
All the content of the file is read and passed into the pipe **|** and another process is created for the `cat` command.

## with sed command
| Complexity::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |
Sed stop reading the input and exit when the 15th line is reached.
```bash
sed '15q' <file>
```
Input variant:
```bash
sed '15q' < <file>
```
Unefficient variants:
```bash
sed -n '1,15p' <file>
sed '1,15!d' <file>
```
All the content of the file is read by the `sed` command.

## with awk command
| Complexity::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |
Awk stop reading the input and exit when the 15th line is reached.
```bash
awk 'NR > 15 { exit } { print $0 }' <file>
```
Syntax variants:
```bash
awk '{ print $0 ; if( NR >= 15 ) exit }' <file>
awk '{ if( NR > 15 ) exit ; print $0 }' <file>
awk '{ if( NR > 15 ) { exit } print $0 }' <file>
awk 'NR >= 15 { print $0 ; exit } { print $0 }' <file>
```
Input variant:
```bash
awk 'NR >= 15 { print $0 ; exit } { print $0 }' < <file>
```
Unefficient variants:
```bash
awk 'NR <= 15 { print $0 }' <file>
awk '{ if( NR <= 15 ) print $0 }' <file>
```
All the content of the file is read by the `awk` command.

## with shell scripting
| Complexity::warning: | Efficiency::warning: |
| ---------- | ---------- |

Loop and read one line of the file and print it within the `while`, exit the when the 15th line is reached.
```bash
typeset -i lineNumber=0
while read line
do
	echo -E "${line}"
	(( lineNumber ++ ))
	if [[ "${lineNumber}" -ge 15 ]]
	then
		break
	fi
done < <file>
```
Interpreted shell script is less efficient than a single command
