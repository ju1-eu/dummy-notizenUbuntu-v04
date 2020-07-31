# [WARNING] Could not convert image svg > pdf   rsvg-convert

TARGETDIR = build
#TARGET = book
#SRC = Writing-Markdown.md meta-markdown.md \ 
#      README.md titlepage.md  titlepage2.md  
SRC1 = Latex-install-Ubuntu
SRC2 = Spickzettel-Markdown
#SRC3 = beamer
CSS = ../design.css
BIB_1="literatur.bib"
BIB_2="literatur-kfz.bib"
BIB_3="literatur-sport.bib"
CSL = zitierstil-number.csl
TEMPLATE = pandoc.latex
HTMLOPTIONS = -s -t html5 --from markdown+smart --bibliography $(BIB_1) --bibliography $(BIB_2) --bibliography $(BIB_3) --filter pandoc-citeproc --csl $(CSL) --mathjax --strip-comments --toc -c $(CSS)
PDFOPTIONS = --number-sections --from markdown --template $(TEMPLATE) --listings --bibliography $(BIB_1) --bibliography $(BIB_2) --bibliography $(BIB_3) --filter pandoc-citeproc --csl $(CSL) 
BEAMER = --to beamer
all: pdf html docx
	@echo "Alles erledigt!"

pdf: $(TARGETDIR)
	pandoc $(PDFOPTIONS) $(SRC1).md -o $(TARGETDIR)/$(SRC1).pdf
	pandoc $(PDFOPTIONS) $(SRC2).md -o $(TARGETDIR)/$(SRC2).pdf
	#pandoc $(BEAMER) $(PDFOPTIONS) $(SRC3).md -o $(TARGETDIR)/$(SRC3).pdf

html: $(TARGETDIR)
	pandoc $(HTMLOPTIONS) $(SRC1).md -o $(TARGETDIR)/$(SRC1).html
	pandoc $(HTMLOPTIONS) $(SRC2).md -o $(TARGETDIR)/$(SRC2).html

docx: $(TARGETDIR)
	pandoc $(SRC1).md -o $(TARGETDIR)/$(SRC1).docx
	pandoc $(SRC2).md -o $(TARGETDIR)/$(SRC2).docx

.PHONY: clean

clean:
	rm $(TARGETDIR)/$(SRC1).pdf 
	rm $(TARGETDIR)/$(SRC2).pdf 
	rm $(TARGETDIR)/$(SRC1).html 
	rm $(TARGETDIR)/$(SRC2).html 	
	rm $(TARGETDIR)/$(SRC1).docx 
	rm $(TARGETDIR)/$(SRC2).docx 	

rebuild: clean all

$(TARGETDIR):
	mkdir build