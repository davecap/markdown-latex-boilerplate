# Default Config Settings

SECTIONS_FILEPATH=_SECTIONS.txt
BUILDNAME=example
BUILDPATH=build
REFS=references.bib
TEMPLATE=templates/template.tex
DOCX_TEMPLATE=
ODT_TEMPLATE=
METADATA=metadata.yml
CSL=csl/chicago-fullnote-bibliography
PANDOC_OPTIONS=--latex-engine=xelatex --number-sections
MDCFG?=config.txt

# Check for environment var for config
include $(MDCFG)

# Load in new config settings
include _CONFIG.txt
#cat := $(if $(filter $(OS),Windows_NT),type,cat)
#SECTIONS := $(shell $(cat) $(SECTIONS_FILEPATH) | tr '\n' ' ')

# This combines all the filepaths in SECTIONS_FILEPATH file
SECTIONS := $(shell cat $(SECTIONS_FILEPATH) | tr '\n\r' ' ' | tr '\n' ' ' )

# ideally, SECTIONS is defined by the config file, otherwise build the list
# ourselves
ifndef SECTIONS
  SECTIONS := $(addprefix $(SECTIONS_DIR)/, $(SECTIONS_LIST))
endif

MKLIST=$(METADATA) $(SECTIONS)

ifdef DOCX_TEMPLATE
  DOCX_TEMPLATE:=--reference-docx $(DOCX_TEMPLATE)
endif

ifdef ODT_TEMPLATE
  ODT_TEMPLATE:=--reference-docx $(ODT_TEMPLATE)
endif

ifdef REFS
	PANDOC_OPTIONS:=--bibliography=$(REFS) $(PANDOC_OPTIONS)
endif

ifdef CSL
	PANDOC_OPTIONS:=--csl=$(CSL).csl $(PANDOC_OPTIONS)
endif



# Perform task
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
	cd ./source/ && \
	pandoc -o $(BUILDPATH)/$(BUILDNAME).pdf --template=$(TEMPLATE) $(PANDOC_OPTIONS) $(MKLIST)
	#@open $(BUILDPATH)/$(BUILDNAME).pdf

	pandoc --toc -N --bibliography=$(REFS) -o ./build/$(BUILDNAME).pdf --csl=./csl/$(CSL).csl --template=$(TEMPLATE) $(SECTIONS)
	#open ./build/$(BUILDNAME).pdf

.PHONY: pdfsafemode
pdfsafemode: pre
	cd ./source/ && \
	pandoc -o $(BUILDPATH)/$(BUILDNAME).pdf $(PANDOC_OPTIONS) $(MKLIST)
	#@open $(BUILDPATH)/$(BUILDNAME).pdf

.PHONY: docx
docx: pre
	cd ./source/ && \	
	pandoc -o $(BUILDPATH)/$(BUILDNAME).docx $(DOCX_TEMPLATE) $(PANDOC_OPTIONS) $(MKLIST)

.PHONY: odt
odt: pre
	cd ./source/ && \	
	pandoc -o $(BUILDPATH)/$(BUILDNAME).odt $(ODT_TEMPLATE) $(PANDOC_OPTIONS) $(MKLIST)

.PHONY: latex
	cd ./source/ && \	
	pandoc -o $(BUILDPATH)/$(BUILDNAME).pdf --csl=./csl/$(CSL).csl $(SECTIONS)
	#open ./build/$(BUILDNAME).pdf
	
latex: pre
	if [ -d "$(BASE_DIR)/images" ]; then ln -s $(BASE_DIR)/images $(BUILDPATH)/; fi
	cd ./source/ && \	
	pandoc -s -o $(BUILDPATH)/$(BUILDNAME).tex --template=$(TEMPLATE) $(PANDOC_OPTIONS) $(MKLIST)

.PHONY: html
html: pre
	cd ./source/ && \
	pandoc -s --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -o $(BUILDPATH)/$(BUILDNAME).html -t html5 $(PANDOC_OPTIONS) $(MKLIST)
566010def6a09b2e3

.PHONY: embed
embed: pre
	cd ./source/ && \
	pandoc --reference-links --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -o $(BUILDPATH)/embed.html -t html5 --normalize $(PANDOC_OPTIONS) $(MKLIST)

.PHONY: epub
epub: pre
	cd ./source/ && \
	pandoc -s --biblatex -o $(BUILDPATH)/$(BUILDNAME).epub -t epub $(PANDOC_OPTIONS) $(MKLIST)

# open files that were rendered

viewpdf:
		open $(BUILDPATH)/$(BUILDNAME).pdf

viewhtml:
		open $(BUILDPATH)/$(BUILDNAME).html


