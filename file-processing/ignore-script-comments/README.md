# Ignore comments
***
Classic use-cases:  
**Ignore # comments in a configuration file**  
**Ignore comments marked with any character/string in a file read by a script**

## with grep command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |
**The classic method**:
```bash
grep -v '^[ 	]*#' <file>
```
:warning: Space and tabulation characters are both present and between [ and ].

Argument syntax variants:
```bash
grep -v -P '^[ \t]*#' <file>
grep -v '^\\s*#' <file>
grep -v '^[[:space:]]*#' <file>
grep -v '^[[:blank:]]*#' <file>
```

Input variant:
```bash
grep -v '^[ 	]*#' < <file>
```

## with egrep command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
egrep -v '^[ 	]*#' <file>
```
:warning: Space and tabulation caracters are between [ and ].

Argument syntax variants:
```bash
egrep -v '^\\s*#' <file>
egrep -v '^[[:space:]]*#' <file>
egrep -v '^[[:blank:]]*#' <file>
```

Input variant:
```bash
egrep -v '^[ 	]*#' < <file>
```

## with sed command
| Complexity::white_check_mark: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
sed '/^[ 	]*#/d' <file>
```
:warning: Space and tabulation caracters are between [ and ].

Argument syntax variants:
```bash
sed '/^[ \\t]*#/d'  <file>
sed '/^\\s*#/d' <file>
sed '/^[[:space:]]*#/d' <file>
sed '/^[[:blank:]]*#/d' <file>
```

Input variant:
```bash
sed '/^[ 	]*#/d' < <file>
```

## with awk command
| Complexity::warning: | Efficiency::white_check_mark: |
| ---------- | ---------- |

```bash
awk '$0 !~ /^[ 	]*#/ { print $0 }' <file>
```

Argument syntax variant:
```bash
awk '{ if ( $0 !~ "^[ 	]*#" ) { print $0 } }' <file>
```

Input variant:
```bash
awk '$0 !~ /^[ 	]*#/ { print $0 }' < <file>
```
