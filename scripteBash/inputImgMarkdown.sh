#!/bin/bash -e
# Letztes Update: 27-Jul-20

# Bilder in Markdown einfügen

# Bildname vgl. abb.
# ![Bildname](images/Bildname.pdf){width=60%}

# Variable
file="input-img.txt"
img="images"
archiv="archiv"
info="Alle Abbildungen 'images/' in Markdown speichern.
	* '$archiv/$file'"
timestamp=$(date +"%d-%h-%Y")
copyright="ju $timestamp $file"

echo "+ $info"

# File neu anlegen
echo "<!-----------------------------------------------"  >  $archiv/$file
echo "$info"                                              >> $archiv/$file
echo "$copyright"                                         >> $archiv/$file
echo "------------------------------------------------->" >> $archiv/$file
printf "\n\n"                                             >> $archiv/$file

cd $img
for i in *.pdf; do
	# dateiname ohne Endung
	picname=`basename "$i" .pdf`
    printf "$picname vgl. abb.\n\n"                  >> ../$archiv/$file
	echo "![$picname]($img/$i){width=60%}"           >> ../$archiv/$file
    printf "\n\n"                                    >> ../$archiv/$file
done
cd ..

#echo "fertig"
