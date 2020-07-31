#!/bin/bash -e
# letztes Update: 24-Dez-19
# PDF erstellen - pdflatex: tex -> pdf

# ANPASSEN
THEMA="dummy-notizenUbuntu-v03"

# Variable
info="PDF erstellen - pdflatex: tex -> pdf"
scripte="scripteBash"
code="code"
css="css"
img="images"
img_in="img-in"
img_out="img-out"
pdf="pdf"
md="md"
tex="tex"
tex_pandoc="tex-pandoc"
html="html"
cms_wp_lokal="cms-wp-lokal"
cms_wp_server="cms-wp-server"
archiv="archiv"
excel="excel"
content="content"
timestamp=$(date +"%Y-%h-%d")
timestamp_2=$(date +"%d-%h-%y")
copyright="letztes Update: $timestamp_2"

# -------------------------------
echo "+++ $info"

# pdflatex: Latex --> PDF

# -------------------------------
ID="$(git rev-parse --short HEAD)"  # Version: v42c3f88
DATUM=$(date +"%Y/%m/%d")            # Datum: 2019/06/27


# artikel
dummyArtikel="main-artikel-dummy.tex"
#ls $content/$dummyBook
# schreibe in datei
artikel="main-artikel"
echo "% $copyright" > $artikel.tex
cat $content/$dummyArtikel >> $artikel.tex

pdflatex $artikel.tex
# Literatur
biber $artikel
#bibtex $artikel
# Index
#texindy -g --module ff-ranges-only $artikel.idx
# IndexKonfig.xdy
#xindy -L german-din -I latex --module IndexKonfig main-artikel.idx
pdflatex $artikel.tex
pdflatex $artikel.tex

# -------------------------------
# book
dummyBook="main-book-dummy.tex"
#ls $content/$dummyBook
# schreibe in datei
book="main-book"
echo "% $copyright" > $book.tex
cat $content/$dummyBook >> $book.tex

pdflatex $book.tex
# Literatur
biber $book
#bibtex $book
# Index
#texindy -g --module ff-ranges-only $book.idx
# IndexKonfig.xdy
#xindy -L german-din -I latex --module IndexKonfig main-book.idx
pdflatex $book.tex
pdflatex $book.tex

# -------------------------------
# print
dummyPrint="main-print-dummy.tex"
#ls $content/$dummyPrint
# schreibe in datei
print="main-print"
echo "% $copyright" > $print.tex
cat $content/$dummyPrint >> $print.tex

pdflatex $print.tex
# Literatur
biber $print
#bibtex $print
# Index
#texindy -g  --module ff-ranges-only $print.idx
# IndexKonfig.xdy
#xindy -L german-din -I latex --module IndexKonfig $print.idx
pdflatex $print.tex
pdflatex $print.tex

# -------------------------------
# latexmk
#latexmk -f -pdf $book
#latexmk -f -pdf $print


# -------------------------------
# Latex aufraeumen
rm -f *~ *.aux *.bbl *.blg *.fls *.log *.nav *.out *.snm *.synctex *.toc \
  *.idx *.ilg *.ind *.thm *.lof *.lol *.lot *.nlo *.run.xml *blx.bib *.bcf

# -------------------------------
# kopie
# Datei umbenennen
cp -Rp "$book".pdf     $pdf/$THEMA-book.pdf
cp -Rp "$print".pdf   $pdf/$THEMA-print.pdf
mv main*.pdf   $pdf/

# Scriptaufruf
./$scripte/projektInhalt.sh


# archiv Handarbeit tex
timestamp_3=$(date +"%d%m%y")
# git commit (hashwert) = id
ID=$(git rev-parse --short HEAD)

cd $tex
tar cvfz ../$archiv/$timestamp_3'_Handarbeit-'$tex'_v_'$ID.tgz .
cd ..
cd $md
tar cvfz ../$archiv/$timestamp_3'_Handarbeit-'$md'_v_'$ID.tgz .
cd ..

echo "fertig"
