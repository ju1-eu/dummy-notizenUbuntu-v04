#!/bin/bash -e
# letztes Update: 24-Dez-19
# optimiere Bilder für das Web & Latex

#- quer: 1600x1200 
#- hoch: 800x1200
#- kontakt: 1920x1080 
#- footer: 1920x180
#- logo: 340x180
#- Icon: 512x512
#- Beitragsbild: 2560x1440
#- Verkaufsfoto: 5760x3840 bzw. Original

#aufloesungTex = '728x516'  # B5 = 728x516
#aufloesungWeb = '1600x1200' # 1920x1080 1600x1100 
#qualitaetWeb  = '75%' # ImageMagik: 82% = Photoshop: 60%

# Variable
#work=~/tex/projekt #
scripte="scripteBash"
quelle="img-in"
ziel="img-out"
tmp="tmp"
liste="liste.txt"
info="optimiere Bilder für das Web & Latex"
timestamp_2=$(date +"%d-%h-%Y")
copyright="ju - Letztes Update: $timestamp_2"

# -----------------------------
echo "+++ $info"

# Ordner prüfen
if [ ! -d $quelle ];   then mkdir -p $quelle; fi
if [ ! `ls -a $quelle | wc -l` -gt 2  ]; then echo "+++ Fehler: $quelle ist leer."; exit; fi
if [ ! -d $ziel ];   then mkdir -p $ziel; fi



echo "+++ Kopie: Quelle - Ziel"
rsync -avpEh --delete $quelle/ $ziel/
echo "-----------------------------"

# Suchen und Ersetzen
./$scripte/suchenErsetzen.sh # Scriptaufruf

echo "-----------------------------"

cd $ziel
echo "+++ Web optimierte Fotos"
# Rahmen - Progressiv - Schärfen -auto-orient - Meta entfernen - Qualität
for i in *.jpg; do
	# convert quelle.jpg ziel.png
	convert $i -quality 75 $i # Qualitaet 75%
	# Progressiv - Schärfen - Meta entfernen
	convert $i -auto-orient -sharpen 1 -strip -interlace JPEG $i
done

# 1600x1200 Auflösung web
mogrify -resize "1600" *.jpg


echo "-----------------------------"

echo "+++ Latex optimierte Fotos"
# jpg in png"
for i in *.jpg; do
	pngname=${i%.jpg}.png
	# convert quelle.jpg ziel.png
	convert $i $pngname
done

# 728x516 Auflösung png
mogrify -resize "728" *.png

# png in eps
for i in *.png; do
	epsname=${i%.png}.eps
	# convert quelle.jpg ziel.png
	convert $i eps3:$epsname
done

# eps in pdf (728x516) latex
for i in *.eps; do
	pdfname=${i%.eps}.pdf
	gs -dEPSCrop -dBATCH -dNOPAUSE -sOutputFile=$pdfname -sDEVICE=pdfwrite \
		-c "<< /PageSize [728 516]  >> setpagedevice" 90 rotate 0 -f $i
done

echo "-----------------------------"

echo "+++ Aufräumen"
rm *.eps
rm *.png
#rm *.webp
cd ..

echo "fertig"
