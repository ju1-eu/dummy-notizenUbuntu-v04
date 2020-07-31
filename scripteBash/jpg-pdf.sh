#!/bin/bash -e
# ju 26-Jun-20

# sudo apt install -y webp

# ANPASSEN
quelle="img-in"
ziel="img-out"
tmp="tmp"
timestamp=$(date +"%Y-%h-%d")
file="pics-liste.txt"
AUFLOESUNG="1200"      # 1600x1200
QUALITAET="75"         # 75% 

clear

printf "+ Fotos bearbeiten - $timestamp\n"

printf "\n+ Directory anlegen\n"
# Ordner prüfen
if [ ! -d $ziel ];   then mkdir -p $ziel; fi
if [ ! `ls -a $quelle | wc -l` -gt 2  ]; then echo "Fehler: $quelle leer"; exit; fi

# Ordnername in $file speichern 
find $quelle/* -type d -exec basename {} \; | sort > $ziel/$file

# $file zeilenweise lesen
cd $ziel
while read ORDNER ; do 
	printf "\n--------------------------------------\n";
	printf "$ORDNER";
	printf "\n--------------------------------------\n";

	# ordner anlegen
	if [ ! -d "$ORDNER"/$tmp ]; then 
    	mkdir -p "$ORDNER"/$tmp; 
	else
		rm -rf "$ORDNER"/$tmp;
		mkdir -p "$ORDNER"/$tmp; 
	fi
		cp -p ../$quelle/"$ORDNER"/* "$ORDNER"/$tmp

	# Bildbearbeitung
	printf "\n+ Umlaute, Leerzeichen, _, *.JPG, *.jpeg eliminieren\n"
	cd $ORDNER/$tmp
  	ls *.jpg | cat -n | while read zaehler file; do mv "$file" "$ORDNER-$zaehler.jpg"; done

	### 's/suchen/ersetzen/g'
	find ./ -name "*.JPG"  -exec rename 's/.JPG/.jpg/g'  {} +
	find ./ -name "*.jpeg" -exec rename 's/.jpeg/.jpg/g' {} +
	find ./ -name "*"      -exec rename 's/ü/ue/g' {} +
	find ./ -name "*"  		 -exec rename 's/ä/ae/g' {} +
	find ./ -name "*"  		 -exec rename 's/ö/oe/g' {} +
	find ./ -name "*"      -exec rename 's/Ü/ue/g' {} +
	find ./ -name "*"      -exec rename 's/Ä/ae/g' {} +
	find ./ -name "*"      -exec rename 's/Ö/oe/g' {} +
	find ./ -name "*"      -exec rename 's/ß/ss/g' {} +
	find ./ -name "*"      -exec rename 's/_/-/g'  {} +
	find ./ -name "*"      -exec rename 's/ //g'   {} +


	# web 
	printf "\n+ Web - optimierte Fotos\n"

	printf "\n+ Progressiv - Schärfen -auto-orient - Meta entfernen\n\n"
	#cd $ORDNER/$tmp
	for filename in *.jpg; do 
		filename_neu=../$filename
		echo "processing $filename"
		# Rahmen - Progressiv - Schärfen - Meta entfernen 
		convert $filename -auto-orient -sharpen 1 -strip \
			-interlace JPEG $filename_neu
	done 

	printf "\n+ Qualität $QUALITAET%%\n\n"
	#cd $ORDNER/$tmp
	for filename in *.jpg; do 
		filename_neu=./$filename 
		echo "processing $filename $filename_neu"
		convert $filename -quality $QUALITAET $filename_neu
	done 

	printf "\n+ Auflösung $AUFLOESUNG\n"
	#cd $ORDNER/$tmp
	mogrify -resize "$AUFLOESUNG" ./*

  	#------------------------------------------------------------------------

	# Latex - pdf
	printf "\n\n+ TeX - optimierte Fotos\n"

	#cd $ORDNER/$tmp
	printf "\n+ Auflösung $AUFLOESUNG\n"
	mogrify -resize "$AUFLOESUNG" ./*

  	printf "\n+ *.jpg in *.png\n\n"
	for filename in *.jpg; do 
		pngname=${filename%.jpg}.png
		echo "processing $filename $pngname"
		convert $filename -auto-orient $pngname
	done 

	printf "\n+ *.jpg in *.webp\n\n"
	for filename in *.jpg; do 
		webpname=${filename%.jpg}.webp
		echo "processing $filename $webpname"
		convert $filename -auto-orient $webpname
	done 

	printf "\n+ *.png in *.eps\n\n"
	for filename in *.png; do
		epsname=${filename%.png}.eps
		echo "processing $filename $epsname"
		convert $filename eps3:$epsname
	done

	printf "\n+ *.eps in *.pdf\n\n"
	for filename in *.eps; do
		pdfname=../${filename%.eps}.pdf
		echo "processing $filename $pdfname"
		gs -dEPSCrop -dBATCH -dNOPAUSE -sOutputFile=$pdfname -sDEVICE=pdfwrite \
			-c "<< /PageSize [$AUFLOESUNG]  >> setpagedevice" 90 rotate 0 -f $filename
	done

	# aufraeumen
	printf "\n+ Aufräumen\n\n"
	#cd $ORDNER/$tmp
	mv *.webp ../

  	cd ..
	rm -rf $tmp 
	#cd $ziel
	cd ..

done < $file

