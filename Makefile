# Default Config Settings

THISPATH=$(shell pwd)
BASEPATH=$(THISPATH)/source

SECTIONSFILE=_SECTIONS.txt
BUILDNAME=example
BUILDPATH=build
# Optionally pass a different config file location on the command line
# e.g., $ CFGFILE=myspecialconfig.txt make
# _CONFIG.txt is the default configuration file
CFGFILE?=_CONFIG.txt

# Include the config file
include $(CFGFILE)

# This combines all the filepaths in SECTIONS_FILEPATH file
SECTIONS := $(shell cat $(SECTIONSFILE) | tr '\n\r' ' ' | tr '\n' ' ' )

SECTIONS := $(addprefix $(BASEPATH)/, $(SECTIONS))

ifdef DOCX_TEMPLATE
	PANDOC_OPTIONS := --reference-docx $(DOCX_TEMPLATE)
endif
ifdef ODT_TEMPLATE
	PANDOC_OPTIONS := --reference-odt $(ODT_TEMPLATE)
endif
ifdef REFS
	PANDOC_OPTIONS := --bibliography=$(REFS) $(PANDOC_OPTIONS)
endif

ifdef CSL
	PANDOC_OPTIONS := --csl=$(CSL).csl $(PANDOC_OPTIONS)
endif


.DEFAULT_GOAL := pdf
.PHONY: all clean html pdf epub embed viewpdf viewhtml

.PHONY: pre
pre:
	@echo Using config: $(MDCFG)
	@mkdir -p $(BUILDPATH)

.PHONY: post
post:
	@echo "Finished compiling all targets"

.PHONY: clean
clean:
	rm -rf $(BUILDPATH)

.PHONY: all
all: clean pdf latex html docx odt embed epub post viewpdf viewhtml

.PHONY: pdf
# Reason for `&&\` : http://stackoverflow.com/questions/1789594/how-to-write-cd-command-in-makefile

pdf: pre
	pandoc -o $(BUILDPATH)/$(BUILDNAME).pdf --template=$(TEMPLATE) $(PANDOC_OPTIONS) $(SECTIONS)
	#@open $(BUILDPATH)/$(BUILDNAME).pdf

.PHONY: pdfsafemode
pdfsafemode: pre
	pandoc -o $(BUILDPATH)/$(BUILDNAME).pdf $(PANDOC_OPTIONS) $(SECTIONS)
	#@open $(BUILDPATH)/$(BUILDNAME).pdf

.PHONY: docx
docx: pre
	pandoc -o $(BUILDPATH)/$(BUILDNAME).docx $(DOCX_TEMPLATE) $(PANDOC_OPTIONS) $(SECTIONS)

.PHONY: odt
odt: pre
	pandoc -o $(BUILDPATH)/$(BUILDNAME).odt $(ODT_TEMPLATE) $(SECTIONS)

.PHONY: latex
	pandoc -o $(BUILDPATH)/$(BUILDNAME).pdf --csl=./csl/$(CSL).csl $(SECTIONS)
	#open ./build/$(BUILDNAME).pdf
	
latex: pre
	[ -d "$(BASEPATH)/images" ] && ln -s $(BASEPATH)/images $(BUILDPATH)/
	pandoc -s -o $(BUILDPATH)/$(BUILDNAME).tex --template=$(TEMPLATE) $(PANDOC_OPTIONS) $(SECTIONS)

.PHONY: html
html: pre
	pandoc -s --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -o $(BUILDPATH)/$(BUILDNAME).html -t html5 $(PANDOC_OPTIONS) $(SECTIONS)

.PHONY: embed
embed: pre
	pandoc --reference-links --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -o $(BUILDPATH)/embed.html -t html5 --normalize $(PANDOC_OPTIONS) $(SECTIONS)

.PHONY: epub
epub: pre
	pandoc -s --biblatex -o $(BUILDPATH)/$(BUILDNAME).epub -t epub $(PANDOC_OPTIONS) $(SECTIONS)

# open files that were rendered

viewpdf:
		open $(BUILDPATH)/$(BUILDNAME).pdf

viewhtml:
		open $(BUILDPATH)/$(BUILDNAME).html

# vim: set ft=make:
