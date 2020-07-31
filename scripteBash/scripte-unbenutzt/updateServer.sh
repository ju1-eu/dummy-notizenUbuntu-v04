#!/bin/bash
# Letztes Update: 14-Mrz-2019
# Server Update und Aufräumen

echo "Server update"
apt-get update &&  apt-get -y upgrade
apt-get -y dist-upgrade
echo "Aufräumen"
apt-get -y autoremove &&  apt-get -y autoclean

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
