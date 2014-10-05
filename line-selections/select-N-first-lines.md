# Select the first N lines of a file
***
## with head command
| Comlexity::white_check_mark: | Efficiency::white_check_mark: |
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
| Comlexity::warning::warning: | Efficiency::white_check_mark: |
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
