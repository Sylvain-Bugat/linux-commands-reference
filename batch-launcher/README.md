# Batch launcher
***
Th batch launcher or [shebang](https://en.wikipedia.org/wiki/Shebang_%28Unix%29) is the first line of a script file that describe the interpreter to use (bash, ksh, awk, etc.).

Example:
```bash
#!/bin/bash
```
:warning: The path to the used command must be absolute!  
:warning: The file must be in UNIX/Linux format with \r to mark end-of-line. Otherwise the command
```/bin/bash\r``` will not be found on the system and the script will not be executed.  
:warning: UTF BOM are forbidden in shell script because they insert caracters before the shebang!  
```0xEF 0xBB 0xBF!/bin/bash``` will not be executed because of 3 BOM caracters (UTF-8 example).

## Using absolute path
**The classic method**:
```bash
#!/bin/bash
```
Options can be passed to the used command:
```bash
#!/bin/bash -i
```

Shebang examples:
```bash
#!/bin/bash
#!/usr/bin/bash
#!/usr/bin/ksh
#!/bin/sh
#!/bin/awk -f
```

## Using env command
The intrepreter to use is passed as argument of the ```env``` command and will be search in directores defined on the PATH environement variable.
```bash
#!/usr/bin/env bash
```
:warning: Options cannot be passed to the used interpreter on Linux.

Shebang examples:
```bash
#!/bin/env bash
#!/usr/bin/env ksh93
#!/usr/bin/env sh
```
