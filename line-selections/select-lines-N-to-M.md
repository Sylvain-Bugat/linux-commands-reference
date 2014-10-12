# Select the first N lines of a file
***
## with head and tail - commands
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |
**The classic method**:
```bash
head -n 15 <file> | tail -n $(( 15 - 5 + 1 ))
```
Argument syntax variants:
```bash
head -15 <file> | tail -$(( 15 - 5 + 1 ))
head -n15 <file> | tail -n$(( 15 - 5 + 1 ))
head -n+15 <file> | tail -n $(( 15 - 5 + 1 ))
```
Input variant:
```bash
head -n 15 < <file> | tail -n $(( 15 - 5 + 1 ))
```

Unefficient variant:
```bash
cat <file> | head -n 15 | tail -n $(( 15 - 5 + 1 ))
```
All the content of the file is read and passed into the pipe **|** and another process is created for the `cat` command.

## with head and tail + commands
| Complexity::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
head -n 15 <file> | tail -n +5
```
Argument syntax variants:
```bash
head -n +15 <file> | tail -n +5
head -n+15 <file> | tail -n+5
head -15 <file> | tail -n +5
```
Input variant:
```bash
head -n 15 < <file> | tail -n +5
```
Unefficient variant:
```bash
cat <file> | head -n 15 | tail -n +5
```
All the content of the file is read and passed into the pipe **|** and another process is created for the `cat` command.

## with sed command
| Complexity::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
sed -n -e "5,15p" -e "15q" <file>
```
Argument syntax variants:
```bash
sed -e "5,15!d" -e "15q" <file>
```
Input variant:
```bash
sed -n -e "5,15p" -e "15q" < <file>
```
Unefficient variants:
```bash
sed -n "5,15p" <file>
sed "5,15!d" <file>
```
All the content of the file is read by the `sed` command.

## with awk command
| Complexity::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
awk 'NR >= 5 { print $0 } NR >= 15 { print $0 ; exit }' <file>
```
Argument syntax variants:
```bash
awk 'NR >= 5 { print $0 } NR == 15 { print $0 ; exit }' <file>
awk 'NR >= 5 && NR <=15 { print $0 } NR > 15 { exit }' <file>
awk 'NR == 15 { print $0 ; exit } NR >= 5 { print $0 } ' <file>
awk 'NR >= 15 { print $0 ; exit } NR >= 5 { print $0 } ' <file>
awk 'NR >= 5 && NR <15 { print $0 } NR ==15 { print $0 ; exit }' <file>
awk 'NR >= 5 && NR <15 { print $0 } NR >=15 { print $0 ; exit }' <file>
```
Input variant:
```bash
awk 'NR >= 5 { print $0 } NR >= 15 { print $0 ; exit }' < <file>
```
Unefficient variants:
```bash
awk 'NR >= 5 && NR <=15 { print $0 }' <file>
```
All the content of the file is read by the `awk` command.
