#!/bin/bash -e
# Letztes Update: 27-Jul-20

# Markdown in Latex + HTML5 + Wordpress"

# variablen
md="md"
tex_pandoc="tex-pandoc"
html="html"
cms_lokal="cms-lokal"
cms_server="cms-server"
CSS="../css/design.css"
BIB_1="../content/literatur.bib"
BIB_2="../content/literatur-kfz.bib"
BIB_3="../content/literatur-sport.bib"
CSL="zitierstil-number.csl"
HTML_OPTIONS="-s --toc  -t html5 --from markdown+smart --bibliography $BIB_1 --bibliography $BIB_2 --bibliography $BIB_3 --filter pandoc-citeproc --csl $CSL --mathjax --strip-comments -c $CSS"
HTML_WP_OPTIONS="-t html5 --from markdown+smart --bibliography $BIB_1 --bibliography $BIB_2 --bibliography $BIB_3 --filter pandoc-citeproc --csl $CSL --mathjax --strip-comments" 

echo "+ Markdown in Latex + HTML5 + Wordpress"

cd $md
for i in *.md; do
	filename=`basename "$i" .md`
	# Latex
	pandoc "$i" --from markdown --listings -o ../$tex_pandoc/$filename.tex
	# Wordpress
	pandoc "$i" $HTML_WP_OPTIONS -o ../$cms_lokal/$filename.html
	pandoc "$i" $HTML_WP_OPTIONS -o ../$cms_server/$filename.html
	# HTML5
	pandoc "$i" $HTML_OPTIONS -o ../$html/$filename.html
done

cd ..

#echo "fertig"
