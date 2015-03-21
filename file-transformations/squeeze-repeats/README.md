# Squeeze repeated characters
***
Classic use-cases:  
**Preprocess formatted output before cut command (ls -l | tr -s ' ' | cut -f 2, etc.)**  

## with tr command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |
**The classic method**:  

:warning: The ```tr``` command don't accept file arguments as input, it only read standard input from ```<``` or ```|```.
```bash
tr -s 'a' < <file>
```
Argument syntax variants:
```bash
tr -s'a' < <file>
tr --squeeze-repeats 'a' < <file>
```
Unefficient input variant:
```bash
cat <file> | tr -s 'a'
```

## with sed command
| Complexity::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
sed 's/aa*/a/g' <file>
```
Argument syntax variants:
```bash
sed -e 's/aa*/a/g' <file>
sed -e's/aa*/a/g' <file>
sed -r 's/a+/a/g' <file>
sed -r's/a+/a/g' <file>
sed -r -e 's/a+/a/g' <file>
sed -r -e's/a+/a/g' <file>
```
Input variant:
```bash
sed 's/aa*/a/g' < <file>
```
