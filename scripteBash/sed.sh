#!/bin/bash -e
# Letztes Update: 27-Jul-20

# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
# loeschen:            sed -i '/suchen/d' "$i"
	# Ersetze "foo" mit "bar" NUR in Zeilen die "baz" enthalten
 	#sed '/baz/s/foo/bar/g'
 	# Ersetze "foo" mit "bar" AUSSER in Zeilen die "baz" enthalten
 	#sed '/baz/!s/foo/bar/g'


# ANPASSEN
codelanguage="C"      # HTML5, Python, Bash, C, C++, TeX

# CMS
# Server Pfad anpassen Zeile 80
# https://bw-ju.de/#
PFAD_SERVER="https:\/\/bw-ju.de\/#"
PFAD_LOKAL="..\/images"

# Bildformat:  pdf, svg, png, jpg, webp
bildformat="svg"     # eps -> svg
bildformat_2="webp"  # pdf -> webp
bildformat_3="jpg"   # wenn kein svg oder webp

# Variablen
tex_pandoc="tex-pandoc"
cms_lokal="cms-lokal"
cms_server="cms-server"
html="html"
strich="%+---------------------------------------------------------------------"
timestamp=$(date +"%d-%h-%y")


echo "+ sed - Wordpress"

cd $cms_lokal
for i in *.html; do
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	#sed -i '/---/ s//-/g' "$i"
	#sed -i 's/<embed/<img/g' "$i"
	#sed -i '/"images/ s//"..\/images/g' "$i"
	sed -i '/<figure>/ s//<!-- Muster: Link auf Bild \n<p><a href="'$PFAD_LOKAL'\/bildname.'$bildformat'"> \n	<figure> \n		<img class=scaled src="'$PFAD_LOKAL'\/bildname.'$bildformat'" alt="bildname" width="100%"> \n		<figcaption>Abb. : bildname.'$bildformat'<\/figcaption> \n<\/figure><\/a><\/p> \n--> \n<figure>/g' "$i"
	sed -i '/.pdf/ s//.'$bildformat'/g' "$i"
	sed -i '/\/><figcaption>/ s//alt="bildname" width="100%"> \n	<figcaption>Abb. : /g' "$i"
	sed -i 's/<embed/	<!--Link auf Bild anpassen-->/g' "$i"
	sed -i 's/src="images/\n	<img class=scaled src="'$PFAD_LOKAL'/g' "$i"

	#sed -i '/ / s// /g' "$i"
	sed -i '/”/ s//\&laquo;/g' "$i"
	sed -i '/“/ s//\&raquo;/g' "$i"
done

cd ../$cms_server
for i in *.html; do
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	#sed -i '/---/ s//-/g' "$i"
	#sed -i 's/<embed/<img/g' "$i"
	#sed -i '/"images/ s//"..\/images/g' "$i"
	sed -i '/<figure>/ s//<!-- Muster: Link auf Bild \n<p><a href="'$PFAD_SERVER'\/bildname.'$bildformat'"> \n	<figure> \n		<img class=scaled src="'$PFAD_SERVER'\/bildname.'$bildformat'" alt="bildname" width="100%"> \n		<figcaption>Abb. : bildname.'$bildformat'<\/figcaption> \n<\/figure><\/a><\/p> \n--> \n<figure>/g' "$i"
	sed -i '/.eps/ s//.'$bildformat'/g' "$i"
	sed -i '/.pdf/ s//.'$bildformat_2'/g' "$i"
	sed -i '/\/><figcaption>/ s//alt="bildname" width="60%"> \n	<figcaption>Abb. : /g' "$i"
	sed -i 's/<embed/	<!--Link auf Bild anpassen-->/g' "$i"
	sed -i 's/src="images/\n	<img class=scaled src="'$PFAD_SERVER'/g' "$i"

	#sed -i '/ / s// /g' "$i"
	sed -i '/”/ s//\&laquo;/g' "$i"
	sed -i '/“/ s//\&raquo;/g' "$i"
done

cd ../$html
for i in *.html; do
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	#sed -i '/ / s// /g' "$i"
	sed -i 's/<embed/<img/g' "$i"
	sed -i '/"images/ s//"..\/images/g' "$i"
	sed -i '/.eps/ s//.'$bildformat'/g' "$i"
	#sed -i '/.pdf/ s//.'$bildformat_2'/g' "$i"
	sed -i '/.pdf/ s//.'$bildformat_3'/g' "$i"
	sed -i '/”/ s//\&laquo;/g' "$i"
	sed -i '/“/ s//\&raquo;/g' "$i"
done

echo "+ sed - Latex"

cd ../$tex_pandoc
for i in *.tex; do
    # section
	# Ersetze "foo" mit "bar" NUR in Zeilen die "baz" enthalten
 	#sed '/baz/s/foo/bar/g'
 	# Ersetze "foo" mit "bar" AUSSER in Zeilen die "baz" enthalten
 	#sed '/baz/!s/foo/bar/g'
	sed -i '/hypertarget/d' "$i"
	sed -i '/\\label/ s/}}/}/g' "$i"
	#sed -i '/url/ !s/}}/}/g' "$i"
	#sed -i '/\section{*}}/ s//}/g' "$i"
    sed -i '/vgl. kap./ s//%vgl.~(\\autoref{})./g' "$i"

	# Abbildung
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
    sed -i '/vgl. abb./ s//%vgl.~(\\autoref{fig:})./g' "$i"
	sed -i '/\\begin{figure}/ s//\\begin{figure}[!hb]% hier: !hb/g' "$i"
	sed -i '/\\end{figure}/ s//%\\label{fig:}%% anpassen\n\\end{figure}/g' "$i"
	sed -i '/,height=\\textheight/ s///g' "$i"

    # ~ geschütztes Leerzeichen (engl. no-break space)
    sed -i '/\\textasciitilde / s//~/g' "$i"
    sed -i '/\\textasciitilde{}/ s//~/g' "$i"
    sed -i '/\\textasciitilde/ s//~/g' "$i"

    # \%
    sed -i '/\\textbackslash/ s//\\/g' "$i"

 
	# Tabellen
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/vgl. tab./ s//%vgl.~(\\autoref{tab:})./g' "$i"
	sed -i '/\\begin{longtable}[[]]/ s//\\begin{table}[!ht]% hier: !ht \n\\centering \n	\\caption{}% \\label{tab:}%% anpassen \n\\begin{tabular}/g' "$i"
	sed -i '/tabularnewline/ s//\\/g' "$i"
	sed -i '/\\end{longtable}/ s//\\end{tabular} \n\\end{table}/g' "$i"
    sed -i '/@{}/ s//@{}}/g' "$i"
    sed -i '/\\begin{tabular}{@{}}/ s//\\begin{tabular}{@{}/g' "$i"
    sed -i '/\\%/ s//%/g' "$i"
    sed -i '/\\endhead/d' "$i"
	sed -i '/\\begin{tabular/ s/}}/}/g' "$i"


	# Quellcode
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/vgl. code./ s//%vgl.~(\\autoref{code:})./g' "$i"
	sed -i '/\\begin{lstlisting}/ s//\\lstset{language='$codelanguage'}% C, TeX, Bash, Python \n\\begin{lstlisting}[\n	%caption={}, label={code:}%% anpassen\n]/g' "$i"

	#\passthrough{\lstinline!code!}
	sed -i '/\\passthrough{\\lstinline!/ s//\\verb|/g' "$i"
	sed -i '/!}/ s//|/g' "$i"

	# Literaturangaben
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	#sed -i '/vgl. lit./ s//%Quelle:~\\textcite{}/g' "$i"
	sed -i '/{\[}@/ s//~\\textcite{/g' "$i"
	sed -i '/{\]}/ s//}/g' "$i"	

	# listen
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/\\tightlist/d' "$i"
	sed -i '/\\def\\labelenumi{\\arabic{enumi}.}/d' "$i"


	# Fileanfang
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '1i% letztes Update: '$timestamp'' "$i"


	# Umlaute im Label
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/uxfc/ s//ue/g' "$i"
	sed -i '/uxf6/ s//oe/g' "$i"
	sed -i '/uxe4/ s//ae/g' "$i"
	sed -i '/uxdf/ s//ss/g' "$i"
	sed -i '/---/ s//-/g'   "$i"

	# Mathe
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/\\(/ s//$/g' "$i"
	sed -i '/\\)/ s//$/g' "$i"
	# \textbackslash{} - \
	sed -i '/\\textbackslash{}/ s//\\/g' "$i"
	# \textgreater{} - >
	sed -i '/\\textgreater{}/ s//>/g' "$i"

	# Anführungszeichen
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/``/ s//>>/g' "$i"
	sed -i "/''/ s//<</g" "$i"
    #\flqq Text\frqq
    #\textgreater\textgreater Vorratsdrücke\textless\textless{}
    sed -i '/\\textgreater\\textgreater/ s//\\flqq/g' "$i"
	sed -i '/\\textless\\textless{}/ s//\\frqq/g' "$i"

done

cd ..

echo "fertig"
