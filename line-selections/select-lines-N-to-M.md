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

Sed stop reading the input and exit when the 15th line is reached.
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
Unefficient variants:
```bash
cat <file> | head -n 15 | tail -n +5
```
All the content of the file is read and passed into the pipe **|** and another process is created for the `cat` command.
