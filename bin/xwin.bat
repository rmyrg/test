@echo off
setlocal ENABLEDELAYEDEXPANSION

set TODAY=%date:~0,4%%date:~5,2%%date:~8,2%

rem --------------------------------------------
:init
set dpath=%~dp0
set path_l=C:\
cd %dpath%
cd ../../
goto :clear
rem --------------------------------------------
:back
cd ../
goto :clear
rem --------------------------------------------
:clear
cls
set /a i=1
rem --------------------------------------------
:directory
color 0f
cls
set /a i=1
echo ----------------------------------------------------
cd
echo ----------------------------------------------------
for /f "delims=" %%a in ('dir /b/ad') do (
 set Arr=%%a
 call :display
)
call :manual
goto :input_d
rem --------------------------------------------
:file
color 0e
cls
set /a i=1
echo ----------------------------------------------------
cd
echo ----------------------------------------------------
for /f "delims=" %%a in ('dir /b/a-d') do (
 set Arr=%%a
 call :display
)
call :manual
goto :input_f
rem --------------------------------------------
:all
color 0c
cls
set /a i=1
echo ----------------------------------------------------
cd
echo ----------------------------------------------------
for /f "delims=" %%a in ('dir /b/a') do (
 set Arr=%%a
 call :display
)
goto :manual
goto :input_d
rem --------------------------------------------
:manual
echo ----------------------------------------------------
echo i:home / k:file / e:explore / f:back / m:clone
echo xx+command
goto :eof
rem --------------------------------------------
:input_d
echo ----------------------------------------------------
set /p input=
if defined input set num=%input:"=%
rem "
call :shortcut
goto :main_d
goto :eof
rem --------------------------------------------
:input_f
echo --------------------------
set /p input=
if defined input set num=%input:"=%
rem "
call :shortcut
goto :main_f
goto :eof
rem --------------------------------------------
:shortcut
rem i:初期表示 / b:前に戻る / d:ディレクトリ表示 / f:ファイル表示
rem e:エクスプローラ / s:サクラエディタ
if /i %num% leq 999 goto :eof
if /i %num%==i goto :init
if /i %num%==k goto :file
if /i %num%==a goto :all
if /i %num%==d goto :directory
if /i %num%==f goto :back
if /i %num%==e goto :explore
if /i %num%==s goto :sakura
if /i %num%==m goto :Duplication
if /i %num%==0 goto :end
rem if /i %num%==ex goto :excel
rem if /i %num%==ob goto :ob
if /i %num%==gd goto :gdrive
if /i %num%==in goto :index
if /i %num%==edit goto :edit
if /i %num%==memo goto :memo
if /i %num%==day goto :day
for /l %%n in (1,1,%i%) do (
 set n2=%%n
 call :shortcut_id
)
if /i %num% leq 999 goto :eof
goto :exe
goto :eof
rem --------------------------------------------
:shortcut_id
if /i %num%==!id2[%n2%]! set num=%n2%
goto :eof
rem --------------------------------------------
:display
set Arr[%i%]=%Arr%
set id=  %i%
set id=%id:~-3%
set id2[%i%]=%Arr:~0,3%
echo  %id% : !Arr[%i%]!  
set /a i=i+1
goto :eof
rem --------------------------------------------
:main_d
set Arr=Arr[%num%]
cd !%Arr%!
rem set bat=!%Arr%!.bat
rem call %bat%
goto :directory
rem --------------------------------------------
:main_f
set Arr=Arr[%num%]
start !%Arr%!
goto :input_f
rem --------------------------------------------
rem --------------------------------------------
rem --------------------------------------------
rem --------------------------------------------
rem --------------------------------------------
:gdrive
start explorer %path_g%
goto :clear
rem --------------------------------------------
:explore
start explorer %cd%
goto :clear
rem --------------------------------------------
rem sakura editor
rem --------------------------------------------
:sakura
start sakura
goto :clear
rem --------------------------------------------
rem Duplication
rem --------------------------------------------
:Duplication
start %dpath%xwin.bat
goto :clear
rem --------------------------------------------
rem Excel
rem --------------------------------------------
:excel
start excel
goto :clear
rem --------------------------------------------
rem OB
rem --------------------------------------------
:ob
start ob.lnk
goto :clear
rem --------------------------------------------
rem index
rem --------------------------------------------
:index
start sakura index.txt
goto :clear
rem --------------------------------------------
rem edit
rem --------------------------------------------
:edit
start sakura %~f0
goto :clear
rem --------------------------------------------
rem memo
rem --------------------------------------------
:memo
start sakura %~dp0\memo.txt
goto :clear
rem --------------------------------------------
rem day
rem --------------------------------------------
:day
start sakura %path_l%Work\%TODAY%.txt
goto :clear
rem --------------------------------------------
rem exe
rem --------------------------------------------
:exe
if /i %num:~0,6%==sqlexe goto :sqlexe
rem if exist %num%.bat cmd | %num%
if /i %num:~0,2%==xx (
start %num:~2%
) else if /i %num:~0,2%==gg (
%num:~2%
) else (
 if !%num%:~-1!==\ (
  cd %path_l%!%num%!
  goto :directory
 ) else (
  %num%
  goto :input_d
 )
)
goto :input_d
rem --------------------------------------------
rem sqlexe
rem --------------------------------------------
:sqlexe
echo sqlexe %num:~6%
pause
goto :clear
rem --------------------------------------------
:end
exit