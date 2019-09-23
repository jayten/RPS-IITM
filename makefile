Style:=style
Out:=out
Tex:=tex

#bibliography syle
Bibstyle:=iitm.bst
Bibfile:=$(Style)/$(Bibstyle)
RefFolder:=reference
Citations:=$(RefFolder)/cite.bib

all: main.tex
	mkdir -p $(Out)
	pdflatex -halt-on-error -output-directory=$(Out) main
	cp $(Citations) $(Out)/; cp $(Bibfile) $(Out)/
	cd $(Out); bibtex main
	pdflatex -halt-on-error -output-directory=$(Out) main
	pdflatex -halt-on-error -output-directory=$(Out) main

# ---to update pdf when new eps is created ---
pdfs := $(patsubst %.eps, %.pdf, $(wildcard *.eps))

updatePdf: $(pdfs)

%.pdf : %.eps
	epstopdf $<

#--- end update pdf ----

#clean the directory
.PHONY: clean
clean:
	rm -rf out/
