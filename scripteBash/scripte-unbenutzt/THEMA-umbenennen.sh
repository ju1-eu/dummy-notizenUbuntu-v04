#!/bin/bash -e
# Letztes Update: 25-Dez-19
# THEMA - Suchen und Ersetzen anpassen
# Erstellt Ordner für Notizen: Thema-Notiz
# Erstellt Backup Repository

# Github Repository downloaden
#REPOSITORY="dummy-notizenUbuntu-v03"
#ADRESSE="git@github.com:ju1-eu"
#git clone $ADRESSE/$REPOSITORY.git 
  # oder
# Backup Repository clonen
#git clone /media/jan/virtuell/repos/notizenUbuntu/dummy-notizenUbuntu-v03.git .
#HD="/media/jan/virtuell/repos/notizenUbuntu"
#REPOSITORY="dummy-notizenUbuntu-v03"
#git clone $HD/$REPOSITORY.git 

#------------------------------------------------------------
clear

# Repository
#------------------------------------------------------
  # anpassen
  THEMA="TCP_IP-Praxis-Notiz"

  #backup_USB="/media/jan/usb/backup/notizenUbuntu"    
  #backup_RPI4="smb://rpi4.local/nas/backup/notizenUbuntu" 
  #backup_HD="/media/jan/virtuell/backup/notizenUbuntu"

  #archiv_USB="/media/jan/usb/archiv/notizenUbuntu"    
  #archiv_RPI4="smb://rpi4.local/nas/archiv/notizenUbuntu" 
  #archiv_HD="/media/jan/virtuell/archiv/notizenUbuntu"

  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
  #repos_RPI4="smb://rpi4.local/nas/repos/notizenUbuntu" 
  repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
#------------------------------------------------------

code="code"
img="images"
md="md"
tex="tex"
tabellen="Tabellen"
work_files="work_files"
grafiken="Grafiken"


alt="alt"
neu="neu"
#work="/home/jan/tex"
#cd $work

# datum
TIMESTAMP=$(date +"%d-%h-%Y")
echo "Script: Suchen und Ersetzen"
echo ""

# usereingabe
REPOSITORY="dummy-notizenUbuntu-v03"
read -p "Repository $REPOSITORY auf Github vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
  # String ist leer
  echo "Keine Eingabe"
fi
if [ "$antwort" == "j" ]; then
  echo "#---------------------"
  if [ ! -d $neu ]; then mkdir -p $neu; fi
  cd $neu
  if [ -d $THEMA ]; then rm -rf $THEMA; fi

  # Backup Repository
  git clone $repos_HD/$REPOSITORY.git $THEMA
  # Github Repository downloaden
  #REPOSITORY="dummy-notizenUbuntu-v03"
  #ADRESSE="git@github.com:ju1-eu"
  #git clone $ADRESSE/$REPOSITORY.git $THEMA


  echo "#---------------------"
  read -p "Backup Repository $THEMA erstellen? [j/n] " antwort
  if [ -z "$antwort" ]; then
    # String ist leertex
    echo "Keine Eingabe"
  fi
  if [ "$antwort" == "j" ]; then
    echo "#---------------------"
    # suchen und ersetzen
    # anpassen
    folder="$THEMA"
    suchen="$REPOSITORY"
    suchen_sed_reg="$REPOSITORY" # sed  https:\/\/ju1.eu
    ersetzen="$THEMA"
    echo "Suche: $suchen -> Ersetze: $ersetzen"

    # Suche vorher
    printf "Suchtreffer vorher: "
    grep -r $suchen $folder/ |wc -l

    # usereingabe
    #read -p "Ordner der Duchsucht werden soll: " folder
    #read -p "Suchen: " suchen
    #read -p "Ersetzen: " ersetzen

    echo "Verarbeitung beginnt..."
    find $folder/ -type f -print0 | xargs -0 sed -i -e "s/$suchen_sed_reg/$ersetzen/g"

    # Suche nachher
    printf "Suchtreffer nachher: "
    grep -r $suchen $folder/|wc -l
    echo "#---------------------"

    # git init
    cd $THEMA
		rm -rf .git
		git init
		git add .
		git commit -m"Projekt init"

    echo "#---------------------"
    REPOSITORY_NEU="$THEMA"
    LESEZEICHEN="backupHD"
    if [ -d $repos_HD/$REPOSITORY_NEU.git ]; then rm -rf $repos_HD/$REPOSITORY_NEU.git; fi
    git clone --no-hardlinks --bare . $repos_HD/$REPOSITORY_NEU.git
    git remote add $LESEZEICHEN $repos_HD/$REPOSITORY_NEU.git
    git push --all $LESEZEICHEN


  else
    echo "Ende"
  fi

else
  echo "Ende"
fi

echo "#---------------------"
echo "+ Sind alte Notizen vorhanden?"
echo "+ Verzeichnisse von alt/ nach neu/ kopieren?"
read -p "Eingabe [j/n] >_ " antwort
if [ -z "$antwort" ]; then
  # String ist leer
  echo "Keine Eingabe"
fi
if [ "$antwort" == "j" ]; then
  # Kopie
  cd ../..
  # Option: -u	überspringt Dateien, die im Ziel neuer sind als in der Quelle
  rsync -a ./$alt/$THEMA/$code/ ./$neu/$THEMA/$code/
  rsync -a ./$alt/$THEMA/$img/ ./$neu/$THEMA/$img/
  rsync -a ./$alt/$THEMA/$md/ ./$neu/$THEMA/$md/
  rsync -a ./$alt/$THEMA/$tex/ ./$neu/$THEMA/$tex/
  rsync -a ./$alt/$THEMA/$work_files/ ./$neu/$THEMA/$work_files/
  rsync -a ./$alt/$THEMA/$grafiken/ ./$neu/$THEMA/$grafiken/
  rsync -a ./$alt/$THEMA/$tabellen/ ./$neu/$THEMA/$tabellen/
else
  echo "Ende"
fi

echo "#--------------------------------------------------------"
echo "+ Erste Schritte"
echo "
$ cd $neu/$THEMA

# anpassen
scripte/sed.sh
  - codelanguage:    HTML5, Python, Bash, C, C++, TeX
  - CMS Server Pfad: https://www.ju1.eu/#
  - Bildformat:      pdf, svg, png, jpg, webp

projekt.sh
  - Backupverzeichnis prüfen

content/metadata.tex
  - Datum, Titel, Autor

$ ./projekt.sh # Projekt erstellen"
echo "#---------------------------------------------------------"

echo "Script beendet."
