# Default Config Settings

SECTIONS_DIR=sections
SECTIONS_LIST=example.md references.md
BUILDNAME=example
BUILD_PATH=build
REFS=references.bib
TEMPLATE=templates/template.tex
DOCX_TEMPLATE=
ODT_TEMPLATE=
METADATA=metadata.yml
CSL=chicago-fullnote-bibliography
PANDOC_OPTIONS=
MDCFG?=config.txt

# Check for environment var for config
include $(MDCFG)

# ideally, SECTIONS is defined by the config file, otherwise build the list
# ourselves
ifndef SECTIONS
  SECTIONS=$(addprefix $(SECTIONS_DIR)/, $(SECTIONS_LIST))
endif

MKLIST=$(METADATA) $(SECTIONS)

ifdef DOCX_TEMPLATE
  DOCX_TEMPLATE:=--reference-docx $(DOCX_TEMPLATE)
endif

ifdef ODT_TEMPLATE
  ODT_TEMPLATE:=--reference-docx $(ODT_TEMPLATE)
endif

PANDOC_OPTIONS:=--toc --smart --bibliography=$(REFS) --csl=csl/$(CSL).csl $(PANDOC_OPTIONS) 

# cat := $(if $(filter $(OS),Windows_NT),type,cat)
# SECTIONS := $(shell $(cat) $(SECTIONS_FILEPATH) )


# Perform task
.DEFAULT_GOAL := pdf

.PHONY: pre
pre:
	@echo Using config: $(MDCFG)
	@mkdir -p $(BUILD_PATH)

.PHONY: post
post:
	@echo "Finished compiling all targets"

.PHONY: clean
clean:
	rm -rf $(BUILD_PATH)

.PHONY: all
all: clean pdf latex html docx odt embed epub post

.PHONY: pdf
pdf: pre
	pandoc -o $(BUILD_PATH)/$(BUILDNAME).pdf --template=$(TEMPLATE) $(PANDOC_OPTIONS) $(MKLIST)
	@open $(BUILD_PATH)/$(BUILDNAME).pdf

.PHONY: pdfxe
pdfxe: pre
	pandoc -o $(BUILD_PATH)/$(BUILDNAME).pdf --latex-engine=xelatex --template=$(TEMPLATE) $(PANDOC_OPTIONS) $(MKLIST)
	@open $(BUILD_PATH)/$(BUILDNAME).pdf

.PHONY: pdfsafemode
pdfsafemode: pre
	pandoc -o $(BUILD_PATH)/$(BUILDNAME).pdf $(PANDOC_OPTIONS) $(MKLIST)
	@open $(BUILD_PATH)/$(BUILDNAME).pdf


.PHONY: docx
docx: pre
	pandoc -o $(BUILD_PATH)/$(BUILDNAME).docx $(DOCX_TEMPLATE) $(PANDOC_OPTIONS) $(MKLIST)

.PHONY: odt
odt: pre
	pandoc -o $(BUILD_PATH)/$(BUILDNAME).odt $(ODT_TEMPLATE) $(PANDOC_OPTIONS) $(MKLIST)

.PHONY: latex
latex: pre
	if [ -d "$(BASE_DIR)/images" ]; then cp -r $(BASE_DIR)/images $(BUILD_PATH)/; fi
	pandoc -s -o $(BUILD_PATH)/$(BUILDNAME).tex --template=$(TEMPLATE) $(PANDOC_OPTIONS) $(MKLIST)

.PHONY: html
html: pre
	pandoc -s --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -o $(BUILD_PATH)/$(BUILDNAME).html -t html5 --normalize $(PANDOC_OPTIONS) $(MKLIST)

.PHONY: embed
embed: pre
	pandoc --reference-links --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -o $(BUILD_PATH)/embed.html -t html --normalize $(PANDOC_OPTIONS) $(MKLIST)

.PHONY: epub
epub: pre
	pandoc -s --biblatex -o $(BUILD_PATH)/$(BUILDNAME).epub -t epub --normalize $(PANDOC_OPTIONS) $(MKLIST)

