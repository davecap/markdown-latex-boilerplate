ECHO OFF
ECHO Windows Makefile alternative for markdown-latex-boilerplate
ECHO Command List: "winmake pdf","winmake epub","winmake html": default html

REM 
SET COMMAND=%1%
ECHO "COMMAND: %COMMAND%"

for /f %%i in (config.txt) do (
    for /f "tokens=1,2 delims==" %%a IN ("%%i") DO SET "%%a=%%b"
)

ECHO Reading in files in section
set /p SECTIONS=<%SECTIONS_FILEPATH% 

IF "%COMMAND%"=="clean" goto cleanOnly
goto pre

:cleanOnly
ECHO remove build folder
rmdir build /S /q
goto exit

:pre
rmdir build /S /q
mkdir build

REM Menu settings here
IF "%COMMAND%"=="pdf" goto pdf
IF "%COMMAND%"=="pdf-safemode" goto pdfsafemode
IF "%COMMAND%"=="epub" goto epub
IF "%COMMAND%"=="html" goto html

ECHO Default is HTML
goto html

:pdf
REM If something goes wrong as in "Undefined control sequence". It usually imply that there is something wrong with the latex template. Use safemode
pandoc --toc -N --bibliography=%REFERENCES% -o ./build/%BUILDNAME%.pdf --csl=./csl/%CSL%.csl --template=%TEMPLATE% %SECTIONS%
goto exit

:pdfsafemode
REM Same as pdf mode, but without the template.
pandoc --toc -N --bibliography=%REFERENCES% -o ./build/%BUILDNAME%.pdf --csl=./csl/%CSL%.csl %SECTIONS%
goto exit

:epub
pandoc -S -s --biblatex --toc -N --bibliography=%REFS% -o ./build/%BUILDNAME%.epub -t epub --normalize %SECTIONS%
goto exit

:html
pandoc -S --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js" --section-divs -s --biblatex --toc -N --bibliography=%REFERENCES% -o ./build/%BUILDNAME%.html -t html --normalize %SECTIONS%
goto exit

:exit
ECHO All Done!
PAUSE
