#!/bin/bash -e
# Letztes Update: 15-Feb-2019
# lap ubuntu jan Rechte

# variable
TIMESTAMP=$(date +%F)
HOST=$(hostname)
#USER=$(whoami) # Achtung: root user
USER="jan"  
M=$(date "+%m")
Y=$(date "+%Y")

VERZ_HOME="/home/jan/"
VERZ_ROOT="/root/"
VERZ_BIN="/usr/local/bin/"
VERZ_BACKUP="/media/jan/virtuell/backup/"
VERZ_ARCHIV="/media/jan/virtuell/archiv/"
VERZ_LW="/media/jan/virtuell/VMs/"

echo "+++ Rechte - $HOST - $USER - $TIMESTAMP - script +++"

SSD="/media/jan/virtuell"
# /media/jan/virtuell
if [ ! -d $SSD ]; then 
  echo "SSD Laufwerk 'virtuell' mounten."
else
  # code
  echo "+++ Rechte werden geändert. ..."
  # lap
  cd $VERZ_HOME
  find . -type d -exec chmod -R 755 {} +      # ordner
  find . -type f -exec chmod -R 644 {} +      # files
  find . -name '*.sh' -exec chmod -R 744 {} + # bash scripte
  find . -name '*.x' -exec chmod -R 744 {} +  # c++
  # ausnahme sonderrechte
  find .ssh -type d -exec chmod -R 700 {} +   # .ssh
  find .ssh -type f -exec chmod -R 600 {} +   # .ssh
  cd $VERZ_BACKUP
  find . -type d -exec chmod -R 700 {} +      # ordner
  find . -type f -exec chmod -R 600 {} +      # files
  cd $VERZ_ARCHIV
  find . -type d -exec chmod -R 700 {} +      # ordner
  find . -type f -exec chmod -R 600 {} +      # files
  cd $VERZ_LW
  find . -type d -exec chmod -R 755 {} +      # ordner
  find . -type f -exec chmod -R 644 {} +      # files

  echo "+++ zugriffsrechte"
  chown -R jan.jan $VERZ_HOME
  chown -R root.root $VERZ_ROOT
  chown -R jan.root $VERZ_BACKUP
  chown -R jan.root $VERZ_ARCHIV
  chown -R jan.root $VERZ_BIN # bash scripte

  echo "+++ aufräumen"
  rm -rf /tmp/*
  find / -name '*~' 2>/dev/null -exec rm -rf {}  +

  echo "------------------------"
  echo "+++ fertig +++"
  echo "------------------------"
fi

# HINWEIS
# ---------------------------------------------
# vi Zeilennummer
# set nu    # an
# set nonu  # aus

# Vollzugriff auf Eigentümer (4+2+1 = 7). kein Zugriff (0) für Gruppe u. Gast:
# chmod 700 *.sh

# Script überall ausführbar machen
# cp -Rp *.sh /usr/local/bin/
# chown -R $USER.root /usr/local/bin/
# script.sh oder bash sript.sh

# file: /etc/cron.d/backup
   # jeden Sonntag um 3:15 Uhr
   #15 3 * * 0 root /usr/local/bin/backup.sh
# --------------------------------------------
