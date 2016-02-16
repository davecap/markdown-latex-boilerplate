# Default Config Settings

SECTIONS_DIR=sections
SECTIONS_LIST=example.md references.md
BUILDNAME=example
BUILD_PATH=build
REFS=references.bib
TEMPLATE=templates/template.tex
METADATA=metadata.yml
CSL=chicago-fullnote-bibliography
MDCFG?=config.txt

# Check for environment var for config
include $(MDCFG)

# ideally, SECTIONS is defined by the config file, otherwise build the list
# ourselves
ifndef SECTIONS
	SECTIONS=$(addprefix $(SECTIONS_DIR)/, $(SECTIONS_LIST))
endif

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
all: clean pdf latex html embed epub post

.PHONY: pdf
pdf: pre
	pandoc --toc -N --bibliography=$(REFS) -o $(BUILD_PATH)/$(BUILDNAME).pdf --csl=./csl/$(CSL).csl --template=$(TEMPLATE) $(SECTIONS) $(METADATA)
	@open $(BUILD_PATH)/$(BUILDNAME).pdf

.PHONY: pdfsafemode
pdfsafemode: pre
	pandoc --toc -N --bibliography=$(REFS) -o $(BUILD_PATH)/$(BUILDNAME).pdf --csl=./csl/$(CSL).csl $(SECTIONS) $(METADATA)
	@open $(BUILD_PATH)/$(BUILDNAME).pdf
	
.PHONY: latex
latex: pre
	ln -sf ../figures ./$(BUILD_PATH)/
	pandoc --toc -N --bibliography=$(REFS) -o $(BUILD_PATH)/$(BUILDNAME).tex --csl=./csl/$(CSL).csl --template=$(TEMPLATE) $(SECTIONS) $(METADATA)

.PHONY: html
html: pre
	pandoc -S -5 --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -s --biblatex --toc -N --bibliography=$(REFS) -o $(BUILD_PATH)/$(BUILDNAME).html -t html --normalize $(SECTIONS) $(METADATA)

.PHONY: embed
embed: pre
	pandoc -S --reference-links --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -N --bibliography=$(REFS) --csl=./csl/$(CSL).csl -o $(BUILD_PATH)/embed.html -t html --normalize $(SECTIONS) $(METADATA)

.PHONY: epub
epub: pre
	pandoc -S -s --biblatex --toc -N --bibliography=$(REFS) -o $(BUILD_PATH)/$(BUILDNAME).epub -t epub --normalize $(SECTIONS) $(METADATA)

