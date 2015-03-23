# Select the N last lines of a file
***
Classic use-cases:  
**Get the last line (tailer) of a file (csv, etc.)**  
**Get 10 last lines of a command output ( ls -lt, etc.)**

## with head command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |
**The classic method**:
```bash
tail -n 15 <file>
```
Argument syntax variants:
```bash
tail -15 <file>
head -n15 <file>
```
Input variant:
```bash
tail -n 15 < <file>
```

Unefficient variants:
```bash
cat <file> | tail -n 15
cat < <file> | tail -n 15
```
All the content of the file is read and passed into the pipe **|** and another process is created for the `cat` command.
