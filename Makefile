

# Default Config Settings

SECTIONS_FILEPATH=_SECTIONS.txt
BUILDNAME=example
REFERENCES=references.bib
TEMPLATE=template.tex
# TEMPLATE=ut-thesis.tex
CSL=elsevier-with-titles


# Load in new config settings
include _CONFIG.txt
cat := $(if $(filter $(OS),Windows_NT),type,cat)
SECTIONS := $(shell $(cat) $(SECTIONS_FILEPATH) | tr '\n' ' ')


# Perform task
.PHONY: all clean html pdf epub embed

pre:
	mkdir -p build
	cd ./source/

post:
	@echo POST

clean:
	rm -rf build

pdf: pre
	pandoc --toc -N --bibliography=../$(REFS) -o ../build/$(BUILDNAME).pdf --csl=../csl/$(CSL).csl --template=../$(TEMPLATE) $(SECTIONS)
	#open ./build/$(BUILDNAME).pdf

pdfsafemode: pre
	pandoc --toc -N --bibliography=../$(REFS) -o ../build/$(BUILDNAME).pdf --csl=../csl/$(CSL).csl $(SECTIONS)
	#open ./build/$(BUILDNAME).pdf

latex: pre
	ln -s ../figures ./build/
	pandoc --toc -N --bibliography=../$(REFS) -o ../build/$(BUILDNAME).tex --csl=../csl/$(CSL).csl --template=$(TEMPLATE) $(SECTIONS)

html: pre
	pandoc -S -5 --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -s --biblatex --toc -N --bibliography=../$(REFS) -o ../build/$(BUILDNAME).html -t html --normalize $(SECTIONS)

embed: pre
	pandoc -S --reference-links --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -N --bibliography=../$(REFS) --csl=../csl/$(CSL).csl -o ../build/embed.html -t html --normalize $(SECTIONS)

epub: pre
	pandoc -S -s --biblatex --toc -N --bibliography=../$(REFS) -o ../build/$(BUILDNAME).epub -t epub --normalize $(SECTIONS)

default: pdf
