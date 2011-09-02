SECTIONS = example.md references.md

REFS = references.bib
TEMPLATE = template.tex
CSL = elsevier-with-titles

.PHONY: all clean html pdf epub embed

pre:
	mkdir -p build

post:
	@echo POST

clean:
	rm -rf build

pdf: pre
	markdown2pdf --toc -N --bibliography=$(REFS) -o ./build/example.pdf --csl=./csl/$(CSL).csl --template=$(TEMPLATE) $(SECTIONS)
	#open ./build/example.pdf

latex: pre
	ln -s ../figures ./build/
	pandoc --toc -N --bibliography=$(REFS) -o ./build/example.tex --csl=./csl/$(CSL).csl --template=$(TEMPLATE) $(SECTIONS)

html: pre
	pandoc -S -5 --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -s --biblatex --toc -N --bibliography=$(REFS) -o ./build/example.html -t html --normalize $(SECTIONS)

embed: pre
	pandoc -S --reference-links --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -N --bibliography=$(REFS) --csl=./csl/$(CSL).csl -o ./build/embed.html -t html --normalize $(SECTIONS)

epub: pre
	pandoc -S -s --biblatex --toc -N --bibliography=$(REFS) -o ./build/example.epub -t epub --normalize $(SECTIONS)

default: pdf
