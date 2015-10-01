ECHO OFF

cls

ECHO =============================================================
ECHO # Windows Makefile alternative for markdown-latex-boilerplate
ECHO =============================================================
ECHO.
ECHO Readme located in:
ECHO  * https://github.com/mofosyne/markdown-latex-boilerplate 
ECHO  * https://github.com/davecap/markdown-latex-boilerplate
ECHO.
ECHO TIP: On first install, make sure /csl/ folder has https://github.com/citation-style-language/styles else pdf won't work.
ECHO.
ECHO.


SET COMMAND=%1%


REM Default config Here:
SET SECTIONS_FILEPATH=sections.txt
SET BUILDNAME=example
SET REFERENCES=references.bib
SET TEMPLATE=template.tex
SET CSL=elsevier-with-titles

REM Set CR+LF as the newline https://en.wikipedia.org/wiki/Newline#Conversion_utilities
TYPE config.txt | MORE /P > config.temp.txt
REM Load config
for /f %%i in (config.temp.txt) do (
    for /f "tokens=1,2 delims==" %%a IN ("%%i") DO SET "%%a=%%b"
)
REM Clear the CR+LF working file
DEL config.temp.txt

REM Remove all newlines in SECTIONS
setlocal enabledelayedexpansion
set SECTIONS=
for /f %%i In (%SECTIONS_FILEPATH%) DO set SECTIONS=!SECTIONS! %%i
ECHO Sections Detected: %SECTIONS%

REM Load CSL
SET CSL_SET=--csl=./csl/%CSL%.csl
IF "%CSL%"=="" SET CSL_SET=



REM process user intention
IF "%COMMAND%"=="clean" goto cleanOnly

:pre
rmdir build /S /q
mkdir build

REM ECHO Menu settings here
:choices
IF "%COMMAND%"=="pdf" goto pdf
IF "%COMMAND%"=="pdf-safemode" goto pdfsafemode
IF "%COMMAND%"=="epub" goto epub
IF "%COMMAND%"=="html" goto html
IF "%COMMAND%"=="clean" goto cleanOnly
IF "%COMMAND%"=="help" goto help
IF "%COMMAND%"=="exit" goto exit

REM ECHO Ask user what they want
ECHO.
ECHO.
ECHO Command List: help, pdf, pdf-safemode, epub, html, clean, exit
set /p COMMAND="Type Command: "
ECHO.
ECHO.
goto choices


:help
ECHO.
ECHO # HELP: 
ECHO  *  winmake clean : Removes the build folder 
ECHO  *  winmake pdf   : Builds a pdf file to ./build/ folder. Requires LaTeX. 
ECHO  *  winmake pdf-safemode : Same as pdf but ignores template and CSL settings. 
ECHO  *  winmake epub  : Builds a epub file to ./build/ folder 
ECHO  *  winmake html  : Builds a html file to ./build/ folder 
ECHO  *  winmake       : Opens up a prompt.
ECHO.
goto exit

:cleanOnly
ECHO remove build folder
rmdir build /S /q
goto exit

:pdf
ECHO ## PDF MODE
REM If something goes wrong as in "Undefined control sequence". It usually imply that there is something wrong with the latex template. Use safemode
pandoc --toc -N --bibliography=%REFERENCES% -o ./build/%BUILDNAME%.pdf %CSL_SET% --template=%TEMPLATE% %SECTIONS%
goto exit

:pdfsafemode
ECHO ## PDF SAFEMODE
REM Same as pdf mode, but without the template. Also removed CSL since people may forget to download a CSL sheet.
pandoc --toc -N --bibliography=%REFERENCES% -o ./build/%BUILDNAME%.pdf %SECTIONS%
goto exit

:epub
ECHO ## EPUB MODE
pandoc -S -s --biblatex --toc -N --bibliography=%REFS% -o ./build/%BUILDNAME%.epub -t epub --normalize %SECTIONS%
goto exit

:html
ECHO ## HTML MODE
pandoc -S --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -s --biblatex --toc -N --bibliography=%REFERENCES% -o ./build/%BUILDNAME%.html -t html --normalize %SECTIONS%
goto exit

:exit
ECHO.
ECHO All Done!
PAUSE
