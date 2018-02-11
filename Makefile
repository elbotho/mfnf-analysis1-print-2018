# Makefile for creating a PDF from a LaTeX project
LATEX = lualatex
LATEXFLAGS = -halt-on-error -no-shell-escape
LATEXMK = latexmk
LATEXMKFLAGS = -f

FIGURES  = $(patsubst %.svg,%.pdf,$(wildcard *.svg)) \
           $(patsubst %.jpg,%.pdf,$(wildcard *.jpg)) \
           $(patsubst %.png,%.pdf,$(wildcard *.png))

.PHONY: all
all: ${FIGURES}
	$(LATEXMK) $(LATEXMKFLAGS) -pdflatex="$(LATEX) $(LATEXFLAGS) %O %S" \
		-pdf "analysis1"

%.pdf: %.svg
	inkscape --without-gui --export-area-page --export-text-to-path \
		--export-ignore-filters --export-pdf=$@ $<

%.pdf: %.jpg
	convert $< $@

%.pdf: %.png
	convert $< $@
