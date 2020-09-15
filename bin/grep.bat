@echo off
set word=%1
set file=%2
if ""%file%""=="""" set file=*.sql,*.java,*.jsp,*.js,*.txt
rem -GKEY=    検索文字列
rem -GFILE=   検索対象のファイル
rem -GFOLDER= 検索対象のフォルダ
rem -GCODE=   文字コード 99（自動判別）
rem -GOPT=    検索条件 S（サブフォルダからも検索）
sakura -GREPMODE -GKEY=%word% -GFILE=%file% -GFOLDER=%cd% -GCODE=99 -GOPT=SP
