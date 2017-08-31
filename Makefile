# Default Configs

THISPATH=$(shell pwd)
BASEPATH=$(THISPATH)/source

# TIMESTAMP=$(shell date "+%Y%m%d-%H%M%S")

SECTIONSFILE=_SECTIONS.txt
BUILDNAME=dissertation
# BUILDNAME=example-$(TIMESTAMP)
OUTPUT_FOLDER=output
CSL=chicago-author-date
PANDOC_OPTIONS=--dpi=600 --latex-engine=xelatex --filter pandoc-tablenos --filter pandoc-fignos --filter pandoc-citeproc
# Optionally pass a different config file location on the command line
# e.g., $ CFGFILE=myspecialconfig.txt make
# _CONFIG.txt is the default configuration file
CFGFILE?=_CONFIG.txt

# Include the config file
include $(CFGFILE)

OUTPUTPATH=$(THISPATH)/$(OUTPUT_FOLDER)/$(BUILDNAME)
TEMPLATEPATH=$(THISPATH)/templates
TEMPLATEFILE=$(TEMPLATEPATH)/$(TEMPLATE).tex

# Load the sections from the SECTIONSFILE if they're not defined in the config file
ifndef SECTIONS
# This combines all the filepaths in SECTIONSFILE file
	SECTIONS := $(shell cat $(SECTIONSFILE) | tr '\n\r' ' ' | tr '\n' ' ' )
	SECTIONS := $(addprefix $(BASEPATH)/, $(SECTIONS))
endif

ifdef DOCX_TEMPLATE
	DOCX_TEMPLATE := --reference-docx $(TEMPLATEPATH)/$(DOCX_TEMPLATE).docx
endif
ifdef ODT_TEMPLATE
	ODT_TEMPLATE := --reference-odt $(TEMPLATEPATH)/$(ODT_TEMPLATE).odt
endif
ifdef REFS
	PANDOC_OPTIONS := --bibliography=$(BASEPATH)/$(REFS) $(PANDOC_OPTIONS)
endif

ifdef CSL
	PANDOC_OPTIONS := --csl=$(THISPATH)/csl/$(CSL).csl $(PANDOC_OPTIONS)
endif


.DEFAULT_GOAL := pdf
.PHONY: all clean html pdf epub embed viewpdf viewhtml

.PHONY: pre
pre:
	@echo Using config: $(MDCFG)
	@mkdir -p $(OUTPUT_FOLDER)

.PHONY: post
post:
	@echo "Finished compiling all targets"

.PHONY: clean
clean:
	@rm -rf $(OUTPUT_FOLDER)

.PHONY: all
all: clean pdf latex html docx odt embed epub post viewpdf viewhtml

.PHONY: pdf
pdf: pre
	cd $(BASEPATH) && \
	pandoc -o $(OUTPUTPATH).pdf --template=$(TEMPLATEFILE) $(PANDOC_OPTIONS) $(SECTIONS)

.PHONY: pdfsafemode
pdfsafemode: pre
	cd $(BASEPATH) && \
	pandoc -o $(OUTPUTPATH).pdf $(PANDOC_OPTIONS) $(SECTIONS)

.PHONY: docx
docx: pre
	cd $(BASEPATH) && \
	pandoc -o $(OUTPUTPATH).docx $(DOCX_TEMPLATE) $(PANDOC_OPTIONS) $(SECTIONS)

.PHONY: odt
odt: pre
	cd $(BASEPATH) && \
	pandoc -o $(OUTPUTPATH).odt $(ODT_TEMPLATE) $(SECTIONS)

.PHONY: latex
	cd $(BASEPATH) && \
	pandoc -o $(OUTPUTPATH).pdf --csl=./csl/$(CSL).csl $(SECTIONS)
	
latex: pre
	[ -d "$(BASEPATH)/images" ] || ln -s $(BASEPATH)/images $(OUTPUT_FOLDER)/
	cd $(BASEPATH) && \
	pandoc -s -o $(OUTPUTPATH).tex --template=$(TEMPLATEFILE) $(PANDOC_OPTIONS) $(SECTIONS)

.PHONY: html
html: pre
	cd $(BASEPATH) && \
	pandoc -s --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -o $(OUTPUTPATH).html -t html5 $(PANDOC_OPTIONS) $(SECTIONS)

.PHONY: embed
embed: pre
	cd $(BASEPATH) && \
	pandoc --reference-links --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -o $(OUTPUT_FOLDER)/embed.html -t html5 --normalize $(PANDOC_OPTIONS) $(SECTIONS)

.PHONY: epub
epub: pre
	cd $(BASEPATH) && \
	pandoc -s --biblatex -o $(OUTPUTPATH).epub -t epub $(PANDOC_OPTIONS) $(SECTIONS)

# open files that were rendered

.PHONY: viewpdf
viewpdf:
		type xdg-open >/dev/null 2>&1 && xdg-open $(OUTPUTPATH).pdf || open $(OUTPUTPATH).pdf

.PHONY: viewhtml
viewhtml:
		type xdg-open >/dev/null 2>&1 && xdg-open $(OUTPUTPATH).html || open $(OUTPUTPATH).html

# vim: set ft=make:
