#!/bin/bash -e
# Letztes Update: 27-Jul-20

# Inhalt vom Projektverzeichnis

# Variablen
file=Projekt-Inhalt.txt
archiv="archiv"
info="Inhalt vom Projektverzeichnis."
info2="'$archiv/$file'"
timestamp=$(date +"%d-%h-%Y")
copyright="ju $timestamp $file"

echo "+ $info"
echo "  $info2"

# File neu anlegen
printf "%% ---------------------------------\n"      >  $archiv/$file
printf "%% $info\n"                                  >> $archiv/$file
printf "%% $info2\n"                                  >> $archiv/$file
printf "%% $copyright\n"                             >> $archiv/$file
printf "%% ---------------------------------\n"      >> $archiv/$file
printf "%% \n"                                       >> $archiv/$file

pwd         >> $archiv/$file
ls -lath *  >> $archiv/$file

#echo "fertig"
