@echo off

setlocal ENABLEDELAYEDEXPANSION
color 03
set /a i=1

:directory
for /f "delims=" %%a in ('dir /b/a-d') do (
 set Arr=%%a
 call :display
)
goto :input_d

:display
set Arr[%i%]=%Arr%
set id=  %i%
set id=%id:~-3%
echo  %id:~-3% : !Arr[%i%]!  
set /a i=i+1
goto :eof

:input_d
set /p input=
if defined input set num=%input:"=%
set num=%num:a=1%
set num=%num:s=2%
set num=%num:d=3%
set num=%num:f=4%
set num=%num:g=5%
set num=%num:h=6%
set num=%num:j=7%
set num=%num:k=8%
set num=%num:l=9%
set num=%num:;=0%
set forward=!Arr[%num%]!
endlocal && set forward=%forward%
color 02
if exist %forward% (
  start %forward%
)