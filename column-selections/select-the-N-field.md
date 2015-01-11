# Select the Nth field of each line
***
## with cut command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |
**The classic method**:
```bash
cut -d ';' -f 2 <file>
```
Argument syntax variants:
```bash
cut -d';' -f2 <file>
```
Input variant:
```bash
cut -d';' -f2 < <file>
```