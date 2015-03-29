markdown-latex-boilerplate
==========================

Use this to write a paper in Markdown and render it as PDF.

    Step 1: edit the template.tex to your liking
    Step 2: edit the example.md with your text
    Step 3: make pdf
    Step 4: enjoy pdf

## CSL: Citation Style Language

The CSL files are located in the csl submodule.

======

# Building

## Config

in config text file, you may have these default entries

	SECTIONS=sections.txt
	REFERENCES=references.bib
	TEMPLATE=template.tex
	CSL=elsevier-with-titles

This is what it means

	SECTIONS=
		Holds a link to a file
		that contains a list
		of pages to join
	
	REFERENCES=
		Links to pandoc reference file
		for the biography 
		
	TEMPLATE=
		Links to template file use by LaTeX
		
	CSL=
		Choose from a list of Citation Style Language
		files found in ./CSL/ e.g. IEEE style.

( So far only supported for the windows build file version.
Linux makefile is hardcoded in it's makefile )
	
## Linux

---

	make pre

Create build folder

**This is always done before outputting a new build**

---

	make post

@echo POST

---

	make clean
	
Remove build folder

---

	make pdf

Create pdf `markdown2pdf --toc -N --bibliography=$(REFS) -o ./build/example.pdf --csl=./csl/$(CSL).csl --template=$(TEMPLATE) $(SECTIONS)

---

	make latex

Create latex `pandoc --toc -N --bibliography=$(REFS) -o ./build/example.tex --csl=./csl/$(CSL).csl --template=$(TEMPLATE) $(SECTIONS)`

---

	make html

Create html `pandoc -S -5 --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -s --biblatex --toc -N --bibliography=$(REFS) -o ./build/example.html -t html --normalize $(SECTIONS)`

---

	make embed

Create embedded html `pandoc -S --reference-links --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -N --bibliography=$(REFS) --csl=./csl/$(CSL).csl -o ./build/embed.html -t html --normalize $(SECTIONS)`

---

	make epub

Create epub format `pandoc -S -s --biblatex --toc -N --bibliography=$(REFS) -o ./build/example.epub -t epub --normalize $(SECTIONS)`

---

	make

Falls back to pdf behaviour

=====

## Windows

	winmake clean

Removes the build folder

---

	winmake pdf
	
Builds a pdf file to ./build/ folder. Requires LaTeX.
	
---
	
	winmake epub
	
Builds a epub file to ./build/ folder 
	
---

	winmake html
	
Builds a html file to ./build/ folder 

---
	
	winmake

Default to html output.