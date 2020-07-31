#!/usr/bin/env python3
# letztes Update: 16-Jan-20
# Quelle: https://www.uweziegenhagen.de/?p=4036
# Aufgaben zum Bruchrechnen erstellen mit LaTeX und Python
# Latex: https://www.grund-wissen.de/informatik/latex/mathematischer-formelsatz.html
import os
import random
from datetime import date  # sudo locale-gen de_DE.UTF-8

# variablen
# Datum
d1 = date.today()
timestamp = d1.strftime('%d-%b-%y') # 16-Jan-20
#print(timestamp) 

anzahl_Aufgaben = 30
# Zufallszahlen von 1 bis 20
von_Zahl = 1
bis_Zahl = 21 

op = "\cdot" # + - * = \cdot :

thema = "Brüche multiplizieren"
# addieren, subtrahieren, multiplizieren, dividieren
file = "Mathe-Brueche-multiplizieren" # dateinamen

head = """% letztes Update: """ + timestamp + """
\\documentclass[14pt, twocolumn]{scrartcl}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\pagestyle{empty}
\\usepackage[osf,sc]{mathpazo} 
\\usepackage[scale=.9,semibold]{sourcecodepro}   
\\usepackage[osf]{sourcesanspro} 
\\usepackage{amsmath}
 
\\begin{document}

\\section*{""" + thema + """}
Datum: """ + timestamp + """
% Aufgaben
\\begin{enumerate} 
"""
 
foot = """
\\end{enumerate} 

\\end{document}
"""
 
def create_bruch_1():
    zahlen = list(range(von_Zahl,bis_Zahl)) # Zufallszahlen
    zaehler = random.choice(zahlen)
    zahlen.remove(zaehler)
    nenner = random.choice(zahlen)
    return '  \\item $ \\frac{'+ str(zaehler) + '}{' + str(nenner) + '} '

def create_bruch_2():
    zahlen = list(range(von_Zahl,bis_Zahl)) # Zufallszahlen
    zaehler = random.choice(zahlen)
    zahlen.remove(zaehler)
    nenner = random.choice(zahlen)
    return str(op) + ' \\frac{'+ str(zaehler) + '}{' + str(nenner) + '} $ \\vspace{1em}'
 
# file.tex
with open(file + ".tex", "w") as document:
    document.write(head);
    for i in range(anzahl_Aufgaben):
        document.write(create_bruch_1());
        document.write(create_bruch_2());
    document.write(foot);
    document.close();
 
os.system("pdflatex " + file + ".tex") # file.tex
os.unlink(file + ".log")               # file.log
os.unlink(file + ".aux")               # file.aux
#os.unlink(file + ".tex")              # file.tex