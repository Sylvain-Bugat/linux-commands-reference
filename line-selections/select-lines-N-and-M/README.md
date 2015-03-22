# Select the lines N and M in a file
***
Classic use-cases:  
**Get some fixed lines part of a file**  
**Get only some lines a formated header ( vmstat, iostat, etc.)**

## with sed
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |
**The classic method**:
```bash
sed -n -e "5p" -e "15p" <file>
```
Argument syntax variants:
```bash
sed -n -e "5p;15p" <file>
sed -n "5p;15p" <file>
sed -n -e "5p" -e "15p" -e "15q" <file>
sed -n -e "5p;15p;15q" <file>
sed -n "5p;15p;15q" <file>
```
Input variant:
```bash
sed -n -e "5p" -e "15p" < <file>
```

## with awk command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
awk 'NR == 5 ; NR == 15 ' <file>
```
Argument syntax variants:
```bash
awk 'NR == 5 ; NR == 15 { print $0 }' <file>
awk 'NR == 5 { print $0 } ; NR == 15 { print $0 }' <file>
awk 'NR == 5 ; NR == 15 { print $0 ; exit }' <file>
awk 'NR == 5 { print $0 } NR == 15 { print $0 }' <file>
awk 'NR == 5 { print $0 } NR == 15 { print $0 ; exit }' <file>
awk '{ if ( NR == 5 ) print $0 ; if ( NR == 15 ) print $0 }' <file>
awk '{ if ( NR == 5 ) { print $0 } ; if ( NR == 15 ) { print $0 } }' <file>
awk '{ if ( NR == 5 ) { print $0 } ; if ( NR == 15 ) { print $0 ; exit } }' <file>
awk '{ if ( NR == 5 || NR == 15 ) print $0' <file>
awk '{ if ( NR == 5 || NR == 15 ) { print $0 }' <file>
awk '{ if ( NR == 5 || NR == 15 ) print $0 ; if ( NR == 15 ) exit' <file>
awk '{ if ( NR == 5 || NR == 15 ) { print $0 } ; if ( NR == 15 ) { exit }' <file>
```
Input variant:
```bash
awk 'NR == 5 ; NR == 15' < <file>
```
