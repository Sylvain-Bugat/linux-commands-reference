# Squeeze repeated characters
***
## with tr command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |
**The classic method**:  

:warning: The ```tr``` command don't accept file arguments as input.
```bash
tr -s 'a' < <file>
```
Argument syntax variants:
```bash
tr -s'a' < <file>
```
Input variant:
```bash
cat <file> | tr -s 'a'
```

## with sed command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
sed 's/aa*/a' <file>
```
Argument syntax variants:
```bash
sed 's/aa*/a/g' <file>
sed -e 's/aa*/a/g' <file>
sed -e's/aa*/a/g' <file>
sed -r 's/a+/a/g' <file>
sed -r's/a+/a/g' <file>
sed -r -e 's/a+/a/g' <file>
sed -r -e's/a+/a/g' <file>
```
Input variant:
```bash
sed 's/aa*/a' < <file>
```