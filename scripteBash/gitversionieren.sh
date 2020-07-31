#!/bin/bash -e
# letztes Update: 24-Dez-19

# Git versionieren

# Variablen
#------------------------------------------------------
  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
  repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
#------------------------------------------------------

info="Git versionieren"
file="git.log"
timestamp=$(date +"%d-%h-%Y")
copyright="ju $timestamp $file"

echo "+ $info"

# Voraussetzung:
#
# lokales Repository: HEAD -> master
#  git init # rm -rf .git
#  git add .
#  git commit -m"Projekt init"

   # Github Repository: origin/master
      # anpassen    
  #git remote add origin https://github.com/ju1-eu/dummy-notizenUbuntu-v04.git
  #git push -u origin master

  # backup Repository: backupUSB/master
      # anpassen
#  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
#  REPOSITORY="dummy-notizenUbuntu-v04"
#  LESEZEICHEN="backupUSB"
#  git clone --no-hardlinks --bare . $repos_USB/$REPOSITORY.git 
#  git remote add $LESEZEICHEN $repos_USB/$REPOSITORY.git 
#  git push --all $LESEZEICHEN

  # Backup Repository: backupHD/master
# repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
# REPOSITORY="dummy-notizenUbuntu-v04"
# LESEZEICHEN="backupHD"
# git clone --no-hardlinks --bare . $repos_HD/$REPOSITORY.git 
# git remote add $LESEZEICHEN $repos_HD/$REPOSITORY.git 
# git push --all $LESEZEICHEN

# Git-Version
# lokales Repository: HEAD -> master
#
# usereingabe
read -p "lokales Repository vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
  # String ist leer
  echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
  # lokales Repository: HEAD -> master
  git add .
  git commit -a # editor
  echo "# ------------------------"
else
  # beenden
  echo "Ende: $antwort"
fi

# Github Repository: origin/master
#
# usereingabe
read -p "Github Repository vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
  # String ist leer
  echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
  # Github Repository: origin/master
  git push
  echo "# ------------------------"
else
  # beenden
  echo "Ende: $antwort"
fi

# Backup Repository: backupHD/master
#
# usereingabe
read -p "Backup Repository $repos_HD vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
  # Fehler: String ist leer
  echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
  # Speicher - Laufwerk vorhanden?
  if [ ! -d $repos_HD ]; then
    echo "$repos_HD mounten."
  else
    # Backup Repository
    LESEZEICHEN="backupHD"
    git push --all $LESEZEICHEN 
    echo "# ------------------------"
  fi
else
  # beenden
  echo "Ende: $antwort"
fi

# Backup Repository: backupUSB/master
#
# usereingabe
read -p "Backup Repository $repos_USB vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
  # Fehler: String ist leer
  echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
  # Speicher - Laufwerk vorhanden?
  if [ ! -d $repos_USB ]; then
    echo "$repos_USB mounten."
  else
    # Backup Repository
    LESEZEICHEN="backupUSB"
    git push --all $LESEZEICHEN 
    echo "# ------------------------"
  fi
else
  # beenden
  echo "Ende: $antwort"
fi

echo "# ------------------------"
git status
git lg

echo $copyright > $file
git lg >> $file
echo "# ------------------------"

echo "fertig"
