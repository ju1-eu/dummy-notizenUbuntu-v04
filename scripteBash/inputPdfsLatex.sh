#!/bin/bash -e
# Letztes Update: 27-Jul-20

# Tabellen als PDFs in Latex einfügen

# \usepackage{pdfpages}
# alle PDF Seiten im Querformat
#   \includepdf[landscape=true,pages=-]{tabelle.pdf}
# eine Seite pro Seite
#   \includepdf[landscape=true,pages={1}]{tabelle.pdf}
# zwei Seiten pro Seite: nup=<Anzahl der Spalten>x<Anzahl der Zeilen>
#   \includepdf[pages=-,nup= 1x2]{tabelle.pdf}

# Variablen
tex="tex"
tabelle="Tabellen"
file="input-PDFs.txt"
archiv="archiv"
info="Tabellen als PDFs in Latex einfügen. 'Tabellen/*.pdf ?'"
timestamp=$(date +"%d-%h-%Y")
copyright="ju $timestamp $file"

echo "+ $info"

# File neu anlegen
printf "%% -------------------------------------------------------\n"      >  $archiv/$file
printf "%% $info \n"                                 >> $archiv/$file
printf "%% $copyright\n"                             >> $archiv/$file
printf "%% -------------------------------------------------------\n"      >> $archiv/$file
printf "%% \n"                                       >> $archiv/$file

cd $tabelle
EXTENSION="pdf" 
exist=$(find -iname "*.$EXTENSION" | wc -l)
if [ $exist -ge 1 ]; then
    # vorhanden
	for i in *.pdf; do
		# Dateiname ohne Endung
		pdfname=`basename "$i" .pdf`
		printf "\section{$pdfname}\n"                                      >> ../$archiv/$file
		printf "%% -------\n"                                              >> ../$archiv/$file
		printf "\includepdf[scale=0.95, landscape=false,pages={1-1},nup=1x1,frame=false]{$tabelle/$i}\n\n"   >> ../$archiv/$file
	done
fi
cd ..

#echo "fertig"
