#!/bin/bash -e
# Letztes Update: 15-Feb-2019
# Dateiende umbenennen

# Variable
#work=~/tex/projekt
code="code"
info="Dateiende umbenennen"

# ---------------------
echo "+++ $info"
# Dateiende umbenennen
cd $code
find . -name "*.ps1"  -exec rename 's/.ps1/.sh/g' {} +
cd ..

echo "fertig"
