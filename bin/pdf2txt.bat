rem @echo off
setlocal ENABLEDELAYEDEXPANSION

set dpath=%~dp0

:loop
for /f "delims=" %%a in ('dir /b/a-d *.pdf') do (
 set PDF_FILE=%%a
 call :pdf2txt
)
goto :eof

:pdf2txt
python .\py\pdf2txt.py %PDF_FILE%
goto :eof
