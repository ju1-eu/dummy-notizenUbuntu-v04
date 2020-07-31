#!/bin/bash -e
# letztes Update: 24-Dez-19

# suchen und ersetzen
  # content/metadata.tex
    # suche:    DATUM-ID
    # ersetzte: 2019/06/27 - v_42c3f88

# Variable
content="content"
ID="Version\: $(git rev-parse --short HEAD)"  # Version: v_42c3f88
DATUM=$(date +"%Y\/%m\/%d")          # Datum: 2019/06/27

suchen="DATUM-ID"
ersetzen="$DATUM - $ID"

# -------------------------------
cp $content/metadata-dummy.tex $content/metadata.tex


# suche vorher
#grep -r $suchen $content/ |wc -l

cd $content/
	# suchen und ersetzen
  sed -i -e "s/$suchen/$DATUM - $ID/g" 'metadata.tex'
cd ..

# suche nachher
#grep -r $suchen $content/ |wc -l

echo "fertig"
