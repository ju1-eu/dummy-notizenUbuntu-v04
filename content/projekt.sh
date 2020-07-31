#!/bin/bash -e
# Letztes Update: 27-Jul-20
#
# Erstellt Websiten & \LaTeX PDFs mit Markdown und Pandoc.
# sed passt die \LaTeX-Syntax an.
# Versionsverwaltung: Git
#
# Projekt getestet unter Ubuntu 18.04.3 LTS

# Erste Schritte
# 
# anpassen
# scripte/sed.sh
#  - codelanguage:    HTML5, Python, Bash, C, C++, TeX
#  - CMS Server Pfad: https://bw-ju.de/#
#  - Bildformat:      pdf, svg, png, jpg, webp

# projekt.sh
#  - Backupverzeichnis

# content/metadata.tex
#  - Datum, Titel, Autor

# $ ./projekt.sh


# ANPASSEN
#------------------------------------------------------
	# anpassen
	THEMA="dummy-notizenUbuntu-v04"

	backup_USB="/media/jan/usb/backup/notizenUbuntu"    
	backup_HD="/media/jan/virtuell/backup/notizenUbuntu"

	archiv_USB="/media/jan/usb/archiv/notizenUbuntu"    
	archiv_HD="/media/jan/virtuell/archiv/notizenUbuntu"

	repos_USB="/media/jan/usb/repos/notizenUbuntu"    
	repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
#------------------------------------------------------

# Variable
info="+ Erstellt Websiten & \LaTeX PDFs mit Markdown und Pandoc."
scripte="scripteBash"
code="code"
img="images"
img_in="img-in"
img_out="img-out"
md="md"
tex="tex"
tex_pandoc="tex-pandoc"
css="css"
html="html"
cms_lokal="cms-lokal"
cms_server="cms-server"
archiv="archiv"
content="content"
timestamp=$(date +"%Y-%h-%d")
timestamp_2=$(date +"%d-%h-%Y")
timestamp_3=$(date +"%d%m%y")
copyright="Letztes Update: $timestamp_2"

# ---------------------------
janein=1
while [ "$janein" -eq 1 ]; do
	###clear
	printf "\n $info \n"
	printf "\n  0) Projekt aufräumen"
	printf "\n  1) Projekt erstellen"
	printf "\n  2) Markdown in (tex, html5) + sed (Suchen/Ersetzen)"
	printf "\n  3) Kapitel erstellen + Scripte ausführen"
	printf "\n  4) Fotos optimieren (Web, Latex)"
	printf "\n  5) www + index.html"
	printf "\n  6) git init"
	printf "\n  7) git status + git log"
	printf "\n  8) Git-Version erstellen"
	printf "\n  9) Backup + Archiv erstellen"
	printf "\n 10) Beenden?"
	a=
	while [ -z "$a" ]; do
		printf "\n\n Eingabe Zahl >_ "
		read a
		# Zeichenketten eliminieren ,die Zeichen ausser 0-9  enthalten
		a=${a##*[^0-9]*}
		if [ -z "$a" ]; then
			echo "+ Ungueltige Eingabe"
		fi
	done

	echo "--------------------------"
	printf "\n"

    # --------------------
	if [ $a -eq 0 ]; then
		# Projekt aufräumen

		# löschen  
		if [ -d $tex-pandoc ]; then rm -rf $tex_pandoc; fi
		if [ -d $html ]; then rm -rf $html; fi
		if [ -d $cms_lokal ]; then rm -rf $cms_lokal; fi
		if [ -d $cms_server ]; then rm -rf $cms_server; fi
		if [ -d $img_out ]; then rm -rf $img_out; fi
		if [ -f index.html ]; then rm -rf index.html; fi
		if [ -f inhalt.txt ]; then rm -rf inhalt.txt; fi

		make clean
		make distclean

		echo "fertig"

	# --------------------
	elif [ $a -eq 1 ]; then
		# Projekt erstellen
		# Scriptaufruf
		./$scripte/projekterstellen.sh

	# --------------------
	elif [ $a -eq 2 ]; then
		# Markdown in (tex, html5) - sed (Suchen/Ersetzen)
		# Scriptaufruf
		./$scripte/markdownLatexHtml.sh
	    ./$scripte/sed.sh

    # --------------------
	elif [ $a -eq 3 ]; then
		# Kapitel erstellen, Scripte ausführen
		# Scriptaufruf
		./$scripte/inputImgMarkdown.sh
		./$scripte/inputKapitelLatex.sh
		./$scripte/inputPdfsLatex.sh
		./$scripte/projektInhalt.sh
		./$scripte/codeFiles.sh
		./$scripte/artikel-anlegen.sh
		./$scripte/picFiles.sh

	# --------------------
    elif [ $a -eq 4 ]; then
		# Fotos optimieren (Web, Latex)
		# Scriptaufruf
		./$scripte/jpg-pdf.sh

	# --------------------
	elif [ $a -eq 5 ]; then
		# www & index.html
		# Scriptaufruf
		./$scripte/www.sh

    # --------------------
    elif [ $a -eq 6 ]; then
		# git init
		rm -rf .git
		git init
		git add .
		git commit -m"Projekt init"
		git status
		echo "# ----------------------------------------------"
		git log --graph --oneline
		echo "# ----------------------------------------------"

	# --------------------
	elif [ $a -eq 7 ]; then
		# git status und git log 
		git status
		echo "# ----------------------------------------------"
		git log --graph --oneline
		echo "# ----------------------------------------------"

    # --------------------
    elif [ $a -eq 8 ]; then
		# Git-Version erstellen
		# Scriptaufruf
		./$scripte/gitversionieren.sh
	
	# --------------------
    elif [ $a -eq 9 ]; then
		echo "+ Backup + Archiv erstellen"

		# Laufwerk vorhanden?
		if [ ! -d $backup_HD ]; then
		    echo "$backup_HD Laufwerk mounten."
		else
            # backup 
            rsync -av --delete ./ $backup_HD/$THEMA/
		fi

		# Laufwerk vorhanden?
		if [ ! -d $backup_USB ]; then
		    echo "$backup_USB Laufwerk mounten."
		else
		    # backup 
		    rsync -av --delete ./ $backup_USB/$THEMA/
		fi

	    # archiv
		ID=$(git rev-parse --short HEAD) # git commit (hashwert) = id
		
		#tar cvzf $archiv_HD/$timestamp_3'_'$THEMA'_v_'$ID.tgz .
		#tar cvzf $archiv_USB/$timestamp_3'_'$THEMA'_v_'$ID.tgz .

		#tar cvzf ../$timestamp_3'_'$THEMA'_v'$ID.tgz .
		#tar cvzf ../$THEMA.tgz .
	    #rm -rf ../$THEMA.zip
	    #zip -r ../$THEMA.zip .
		rm -rf $archiv_HD/$THEMA.zip
	    zip -r $archiv_HD/$THEMA.zip .
		rm -rf $archiv_USB/$THEMA.zip
	    zip -r $archiv_USB/$THEMA.zip .
		rm -rf $archiv/$tex.zip
	    zip -r $archiv/$tex.zip tex/
		rm -rf $archiv/$md.zip
	    zip -r $archiv/$md.zip md/

		echo "# ----------------------------------------------"
	    echo "+ Archiv ($archiv_HD/)"
		echo "+ Backup ($backup_HD/)"
	    echo "+ Archiv ($archiv_USB/)"
		echo "+ Backup ($backup_USB/)"
		echo "+ Archiv ($archiv/$tex/)"
		echo "+ Archiv ($archiv/$md/)"		
		echo "# ----------------------------------------------"

		echo "fertig"
	
	# --------------------
	else
		echo "Beenden"; break
	fi
done
