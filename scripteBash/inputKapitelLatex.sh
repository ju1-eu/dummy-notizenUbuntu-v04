#!/bin/bash -e
# Letztes Update: 27-Jul-20

# Latex
#   \chapter{Kapitel}
#   \input{tex/Kapitel}

# Variablen
tex_pandoc="tex-pandoc"
tex="tex"
content="content"
archiv="archiv"
tabellen="Tabellen"
beispiele="beispiele"
file="inhalt.tex"
info="Latex Kapitel erstellen."
info2="* Kopiere '$tex_pandoc/*.tex' nach '$tex/'" 
info3="* '$tex/' **Handarbeit... für opt. Ergebnisse!**" 
info4="* Kopiere 'archiv/inhalt.tex' nach 'content/'"
info5="* make -- Latex-PDF erstellen"
timestamp=$(date +"%d-%h-%Y")
copyright="ju $timestamp $file"

echo "+ $info"
echo "	$info2"
echo "	$info3"
echo "	$info4"
echo "	$info5"

# File neu anlegen
printf "%% -----------------------------------------------\n"      >  $archiv/$file
printf "%% $info \n"                                 >> $archiv/$file
printf "%% $info2 \n"                                 >> $archiv/$file
printf "%% $info3 \n"                                 >> $archiv/$file
printf "%% $info4 \n"                                 >> $archiv/$file
printf "%% $info5 \n"                                 >> $archiv/$file
printf "%% $copyright\n"                             >> $archiv/$file
printf "%% -----------------------------------------------\n"      >> $archiv/$file
printf "%%\n"                                        >> $archiv/$file

# book - print
cd $tex_pandoc
printf "%% $tex/\n"                                  >> ../$archiv/$file
for i in *.tex; do
	if [ ! "Neu.tex" = "$i" ]; then
		# dateiname ohne Endung
		texname=`basename "$i" .tex`
		printf "%%\n"                                         >> ../$archiv/$file
		printf "%%\chapter{$texname}%% book, print anpassen\n"  >> ../$archiv/$file
		printf "%%\input{$tex/$texname}\n"                      >> ../$archiv/$file
	fi
done

printf "%% ---------------------------------\n"           >> ../$archiv/$file
cd ..

cd $archiv
printf "%% $archiv/\n"                                    >> ../$archiv/$file
for i in *.tex; do
	if [ ! "inhalt.tex" = "$i" ]; then
		# dateiname ohne Endung
		texname=`basename "$i" .tex`
		printf "%%\n"                                         >> ../$archiv/$file	
		printf "%%\chapter{$texname}%% book, print anpassen\n"  >> ../$archiv/$file
		printf "%%\input{$archiv/$texname}\n"                   >> ../$archiv/$file
	fi
done

printf "%% ---------------------------------\n"           >> ../$archiv/$file
cd ..

cd $tabellen
printf "%% $tabellen/\n"                                  >> ../$archiv/$file
for i in *.tex; do
	# dateiname ohne Endung
	texname=`basename "$i" .tex`
	printf "%%\n"                                         >> ../$archiv/$file		
	printf "\chapter{$texname}%% book, print anpassen\n"  >> ../$archiv/$file
	printf "%%\input{$tabellen/$texname}\n"                 >> ../$archiv/$file
done

printf "%% ---------------------------------\n"           >> ../$archiv/$file
cd ..

cd $content/$beispiele/$tex
printf "%% $content/$beispiele/$tex/\n"                   >> ../../../$archiv/$file
for i in *.tex; do
	# dateiname ohne Endung
	texname=`basename "$i" .tex`
	printf "%%\n"                                         >> ../../../$archiv/$file	
	printf "%%\chapter{$texname}%% book, print anpassen\n"  >> ../../../$archiv/$file
	printf "%%\input{$content/$beispiele/$tex/$texname}\n"  >> ../../../$archiv/$file
done

printf "%% ---------------------------------\n"           >> ../../../$archiv/$file

cd ../../..
     
#echo "fertig"
