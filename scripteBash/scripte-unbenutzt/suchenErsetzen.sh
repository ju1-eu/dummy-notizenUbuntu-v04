#!/bin/bash -e
# letztes Update: 24-Dez-19
# Suchen und Ersetzen in images/

# - Umlaute
# - Unterstrich
# - Leerzeichen
# - images

# Variable
#work=~/tex/projekt
img="img-out"
info="Suchen und Ersetzen - Umlaute, Unterstrich, Leerzeichen, images"
timestamp=$(date +"%Y-%h-%d_%H:%M")
timestamp_2=$(date +"%d-%h-%Y")
copyright="ju - Letztes Update: $timestamp_2"

# -----------------------------
echo "+++ $info"

# 's/suchen/ersetzen/g'

cd $img
# Umlaute
find . -name "*"  -exec rename 's/ü/ue/g' {} +
find . -name "*"  -exec rename 's/ä/ae/g' {} +
find . -name "*"  -exec rename 's/ö/oe/g' {} +
find . -name "*"  -exec rename 's/Ü/ue/g' {} +
find . -name "*"  -exec rename 's/Ä/ae/g' {} +
find . -name "*"  -exec rename 's/Ö/oe/g' {} +
find . -name "*"  -exec rename 's/ß/ss/g' {} +
# Unterstrich
find . -name "*"  -exec rename 's/_/-/g'  {} +
# Leerzeichen
find . -name "*"  -exec rename 's/ //g'   {} +
# images
find . -name "*.JPG"  -exec rename 's/.JPG/.jpg/g'  {} +
find . -name "*.jpeg" -exec rename 's/.jpeg/.jpg/g' {} +

cd ..

echo "fertig"
