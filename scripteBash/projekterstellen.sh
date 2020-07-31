#!/bin/bash -e
# letztes Update: 27-Jul-20
# Projekt erstellen

# Variable
info="Projekt erstellen"
img_out="img-out"
tex_pandoc="tex-pandoc"
html="html"
cms_lokal="cms-lokal"
cms_server="cms-server"

# ----------------------------
echo "+ $info"

echo "+ Verz. erstellen, wenn nicht vorhanden"
if [ ! -d ./$html ];            then mkdir -p ./$html; fi
if [ ! -d ./$cms_lokal ];       then mkdir -p ./$cms_lokal; fi
if [ ! -d ./$cms_server ];      then mkdir -p ./$cms_server; fi
if [ ! -d ./$tex_pandoc ];      then mkdir -p ./$tex_pandoc; fi
if [ ! -d ./$img_out ];         then mkdir -p ./$img_out; fi

echo "fertig"
