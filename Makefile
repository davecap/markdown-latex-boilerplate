

# Default Config Settings

SECTIONS_FILEPATH=sections.txt
BUILDNAME=example
BUILD_PATH=build
REFS=references.bib
TEMPLATE=templates/template.tex
METADATA='metadata.yml'
CSL=chicago-fullnote-bibliography


# Load in new config settings
include config.txt
cat := $(if $(filter $(OS),Windows_NT),type,cat)
SECTIONS := $(shell $(cat) $(SECTIONS_FILEPATH) )


# Perform task
.DEFAULT_GOAL := pdf

.PHONY: pre
pre:
	mkdir -p $(BUILD_PATH)

.PHONY: post
post:
	@echo POST

.PHONY: clean
clean:
	rm -rf build

.PHONY: pdf
pdf: pre
	pandoc --toc -N --bibliography=$(REFS) -o ./$(BUILD_PATH)/$(BUILDNAME).pdf --csl=./csl/$(CSL).csl --template=$(TEMPLATE) $(SECTIONS) $(METADATA)
	open ./$(BUILD_PATH)/$(BUILDNAME).pdf

.PHONY: pdfsafemode
pdfsafemode: pre
	pandoc --toc -N --bibliography=$(REFS) -o ./$(BUILD_PATH)/$(BUILDNAME).pdf --csl=./csl/$(CSL).csl $(SECTIONS) $(METADATA)
	open ./$(BUILD_PATH)/$(BUILDNAME).pdf
	
.PHONY: latex
latex: pre
	ln -s ../figures ./$(BUILD_PATH)/
	pandoc --toc -N --bibliography=$(REFS) -o ./$(BUILD_PATH)/$(BUILDNAME).tex --csl=./csl/$(CSL).csl --template=$(TEMPLATE) $(SECTIONS) $(METADATA)

.PHONY: html
html: pre
	pandoc -S -5 --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -s --biblatex --toc -N --bibliography=$(REFS) -o ./$(BUILD_PATH)/$(BUILDNAME).html -t html --normalize $(SECTIONS) $(METADATA)

.PHONY: embed
embed: pre
	pandoc -S --reference-links --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -N --bibliography=$(REFS) --csl=./csl/$(CSL).csl -o ./$(BUILD_PATH)/embed.html -t html --normalize $(SECTIONS) $(METADATA)

.PHONY: epub
epub: pre
	pandoc -S -s --biblatex --toc -N --bibliography=$(REFS) -o ./$(BUILD_PATH)/$(BUILDNAME).epub -t epub --normalize $(SECTIONS) $(METADATA)

