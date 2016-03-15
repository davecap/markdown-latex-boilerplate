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

ifdef DOCX_TEMPLATE
	DOCX_TEMPLATE:=--reference-docx $(DOCX_TEMPLATE)
endif

ifdef ODT_TEMPLATE
	ODT_TEMPLATE:=--reference-docx $(ODT_TEMPLATE)
endif

# cat := $(if $(filter $(OS),Windows_NT),type,cat)
# SECTIONS := $(shell $(cat) $(SECTIONS_FILEPATH) )


# Perform task
.DEFAULT_GOAL := pdf

.PHONY: pre
pre:
	@echo $(DOCX_TEMPLATE)
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
	pandoc --toc --bibliography=$(REFS) -o $(BUILD_PATH)/$(BUILDNAME).pdf --csl=./csl/$(CSL).csl --template=$(TEMPLATE) $(PANDOC_OPTIONS) $(SECTIONS) $(METADATA)
	@open $(BUILD_PATH)/$(BUILDNAME).pdf

.PHONY: pdfsafemode
pdfsafemode: pre
	pandoc --toc --bibliography=$(REFS) -o $(BUILD_PATH)/$(BUILDNAME).pdf --csl=./csl/$(CSL).csl $(PANDOC_OPTIONS) $(SECTIONS) $(METADATA)
	@open $(BUILD_PATH)/$(BUILDNAME).pdf

.PHONY: docx
docx: pre
	pandoc -S --toc --bibliography=$(REFS) -o $(BUILD_PATH)/$(BUILDNAME).docx --csl=./csl/$(CSL).csl $(DOCX_TEMPLATE) $(PANDOC_OPTIONS) $(SECTIONS) $(METADATA)

.PHONY: odt
odt: pre
	pandoc -S --toc --bibliography=$(REFS) -o $(BUILD_PATH)/$(BUILDNAME).odt --csl=./csl/$(CSL).csl $(ODT_TEMPLATE) $(PANDOC_OPTIONS) $(SECTIONS) $(METADATA)

.PHONY: latex
latex: pre
	ln -sf ../figures $(BUILD_PATH)/
	pandoc --toc --bibliography=$(REFS) -o $(BUILD_PATH)/$(BUILDNAME).tex --csl=./csl/$(CSL).csl --template=$(TEMPLATE) $(PANDOC_OPTIONS) $(SECTIONS) $(METADATA)

.PHONY: html
html: pre
	pandoc -S --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -s --toc --bibliography=$(REFS) --csl=./csl/$(CSL).csl -o $(BUILD_PATH)/$(BUILDNAME).html -t html5 --normalize $(PANDOC_OPTIONS) $(SECTIONS) $(METADATA)

.PHONY: embed
embed: pre
	pandoc -S --reference-links --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs --bibliography=$(REFS) --csl=./csl/$(CSL).csl -o $(BUILD_PATH)/embed.html -t html --normalize $(PANDOC_OPTIONS) $(SECTIONS) $(METADATA)

.PHONY: epub
epub: pre
	pandoc -S -s --biblatex --toc --bibliography=$(REFS) -o $(BUILD_PATH)/$(BUILDNAME).epub -t epub --normalize $(PANDOC_OPTIONS) $(SECTIONS) $(METADATA)

