ECHO OFF
ECHO Windows Makefile alternative for markdown-latex-boilerplate
ECHO Command List: "winmake pdf","winmake epub","winmake html": default html

SET COMMAND=%1%
ECHO "COMMAND: %COMMAND%"

for /f %%i in (config.txt) do (
    for /f "tokens=1,2 delims==" %%a IN ("%%i") DO SET "%%a=%%b"
)

rmdir build /S /q
mkdir build

IF "%COMMAND%"=="pdf" goto pdf
IF "%COMMAND%"=="epub" goto epub
IF "%COMMAND%"=="html" goto html

ECHO Default is HTML
goto html

:pdf
markdown2pdf --toc -N --bibliography=%REFERENCES% -o ./build/example.pdf --csl=./csl/%CSL%.csl --template=%TEMPLATE% %SECTIONS%
goto exit

:epub
pandoc -S -s --biblatex --toc -N --bibliography=%REFS% -o ./build/example.epub -t epub --normalize %SECTIONS%
goto exit

:html
pandoc -S --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -s --biblatex --toc -N --bibliography=%REFERENCES% -o ./build/example.html -t html --normalize %SECTIONS%
goto exit

:exit
ECHO All Done!
PAUSE