#!/usr/bin/env bash

echo "$( basename ${0} ) can be executed, /usr/bin/env has been found on this system and a bash executable has been found on PATH environnement variable"
echo "PATH: ${PATH}"
echo "bash version:"
/bin/env bash --version
