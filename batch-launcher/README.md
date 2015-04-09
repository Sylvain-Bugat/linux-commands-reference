# Batch launcher
***
Th batch launcher or [shebang](https://en.wikipedia.org/wiki/Shebang_%28Unix%29) is the first line of a script file that describe the interpreter to use (bash, ksh, awk, etc.).

Example:
```bash
#!/bin/bash
```
:warning: The path to the used command must be absolute!  
:warning: The file must be in UNIX/Linux format with \n to mark end-of-line. Otherwise the used command
```/bin/bash\r``` with unexpected ending characters will not be found on the system and the script will not be executed.  
:warning: UTF BOM are forbidden in shell script because they insert caracters before the shebang!  
```0xEF 0xBB 0xBF!/bin/bash``` will not be executed because of 3 BOM characters (UTF-8 hexadecimal example).

Example of error obtained in the case of a Windows format script file:
```bash
-bash: ./windows-format-launcher.sh : /bin/bash^M : bad interpreter: No such file or directory
```

## Using absolute path
**The classic method**:
```bash
#!/bin/bash
```
:warning: only one option or group of options in a single block can be passed to the used command:
```bash
#!/bin/bash -i
#!/bin/bash -ix
```
**Shebang examples:**
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
:warning: ```env``` command path must be absolute!

**Shebang examples:**
```bash
#!/bin/env bash
#!/usr/bin/env ksh93
#!/usr/bin/env sh
```

## Known shebang
Some very usefull shebang:

### Bourne shell (sh)
```bash
#!/bin/sh
```

### Bourne again shell (bash)
```bash
#!/bin/bash
```

### Korn shell (ksh)
```bash
#!/bin/ksh
```

### AWK acript
```bash
#!/bin/awk -f
```

### SED script
```bash
#!/bin/sed -f
```

### nodejs script
```bash
#!/usr/bin/nodejs
```
:warning: ```nodejs``` can be installed as ```node``` on some Linux distribution.
