---
title: 'Markdown - Spickzettel'
author: ''
date: \today
bibliography: literatur.bib
csl: zitierstil-number.csl
---  
<!---------------------------
Referenzen: [at... einfügen!!!!]
Quelle: [ monk:2014:raspberry]

Einheiten: $5~cm$, $\cdot$, $\cdots$, $\Omega$
$100^\circ\text{C}$  > 100◦C
$80~\\% $            > 80 %
Fussnote [^1]        > \footnote{\url{https://bw-ju.de/}} 
[^1]: <https://bw-ju.de/>

![Logo](images/logo.pdf){width=60%}

Bild vgl. abb.    > (\autoref{fig:bild}). 
Tabelle vgl. tab. > (\autoref{tab:tabellen}). 
Kapitel vgl. kap. > (\autoref{sec:zusammenfassung}). 
Code vgl. code.   > (\autoref{code:halloweltex}). 

<https://bw-ju.de/> > \url{https://bw-ju.de/} 

# Schreiben
1. Markdown
2. Textauszeichnung - Was ist wichtig?, Tabellen, Bilder, Quellcode, Literatur, Links
3. Rechtschreibprüfung: https://languagetoolplus.com/?pk_campaign=addon2-popup-logo
4. Literatur: https://www.zotero.org/user/login 
# Markdown -> Latex -> PDF
1. Markdown -> Latex: projekt.sh (pandoc) 
2. Hand-Kopie: tex_pandoc/ tex/
3. Referenzen: Links
4. Latex -> PDF: Makefile (latexmk)

update: 27-Jul-20
# Markdown - Spickzettel
+------------------------------>
   
#  Quellen
  
Quelle: [@monk:2016:action]

Quelle: [@homofaciens:2018:projekt]

Quelle: [@kofler:2018:hacking]
  
#  Listen
  
**ungeordnete Liste**
  
- a
- b
	- bb
- c
  
**Sortierte Liste**
  
1. eins
2. zwei
3. drei
  
**Sortierte Liste**
  
a) a
b) b
c) c
  
#  Anführungszeichen
  
"Anführungszeichen" 
  
  
#  Bilder -- Abbildungen

Logo vgl. abb.
  
![Logo](images/logo.eps){width=60%}

Abbildung-Bsp vgl. abb.
  
![Abbildung-Bsp](images/Chili-1.pdf){width=60%}
  
#  Tabelle

Tabelle-Bsp vgl. tab.
  
|**Nr.**|**Begriffe**|**Erklärung**|
|------:|:-----------|:------------|
| 1     | a1         | a2		   |
| 2     | b1         | b2		   |
| 3     | c1         | c2		   |
| 4     | a1         | a2		   |
  
  
#  Mathe
  
$[ V ] = [ \Omega ] \cdot [ A ]$ o. $U = R \cdot I$ o. $R = \frac{U}{I}$

$800~cm$

$100^\circ\text{C} \, 5~\Omega$ 
  
**Matheumgebung:**
  
\begin{align*}
	\sum_{i=1}^5 a_i = a_1 + a_2 + a_3 + a_4 + a_5
\end{align*}
  
#  Texthervorhebung
  
**Fett** oder *Kursiv*
  
#  Code 

HalloWelt vgl. code.
  
```
// hallowelt.c
#include <stdio.h>
int main(void) {
    printf("Hallo Welt!\n");
    return 0;
}
```
  
#  Links 
  
<https://google.de> oder [Google](https://google.de )

Fussnote [^1]       

[^1]: <https://bw-ju.de/>


#  Absätze 
  
Dies hier ist ein Blindtext zum Testen von Textausgaben. Wer diesen Text liest, ist selbst schuld. Der Text gibt lediglich den Grauwert der Schrift an. Ist das wirklich so? Ist es gleichgültig, ob ich schreibe: "Dies ist ein Blindtext" oder "Huardest gefburn"? Kjift - mitnichten! Ein Blindtext bietet mir wichtige Informationen. An ihm messe ich die Lesbarkeit einer Schrift, ihre Anmutung, wie harmonisch die Figuren zueinander stehen und prüfe, wie breit oder schmal sie läuft. Ein Blindtext sollte möglichst viele verschiedene Buchstaben enthalten und in der Originalsprache gesetzt sein. Er muss keinen Sinn ergeben, sollte aber lesbar sein.

Fremdsprachige Texte wie "Lorem ipsum" dienen nicht dem eigentlichen Zweck, da sie eine falsche Anmutung vermitteln.
  
<!--# Literatur-->