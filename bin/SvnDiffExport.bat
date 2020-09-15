@if (0)==(1) /*
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
COLOR 0A
REM 初期設定
SET SVNPATH=
SET REVISION_FROM=2801
SET REVISION_TO=2831

SET FILENAME_ADD=ADD_SOURCE.bat
SET FILENAME_MOD=MOD_SOURCE.bat
SET FILENAME_MOD_BF=MOD_SOURCE_BF.bat
SET FILENAME_DEL=DEL_SOURCE.txt
SET FILENAME_DIR=DIR_SOURCE.txt
SET FILENAME_HISTORY=変更履歴.txt

REM 情報表示
svn info %SVNPATH%> %FILENAME_HISTORY%
ECHO リポジトリ：%SVNPATH%
ECHO リビジョン%REVISION_FROM%から%REVISION_TO%までの差分資産を取得します。
SET N=%REVISION_FROM%
PAUSE

REM 前回ファイル削除
ECHO 前回ファイルを削除します...
IF EXIST %FILENAME_DEL% (DEL %FILENAME_DEL%)
IF EXIST %FILENAME_DIR% (DEL %FILENAME_DIR%)

REM バッチ作成初期処理
ECHO @echo off>%FILENAME_ADD%
ECHO COLOR 0C>>%FILENAME_ADD%
ECHO @echo off>%FILENAME_MOD%
ECHO COLOR 0E>>%FILENAME_MOD%
ECHO @echo off>%FILENAME_MOD_BF%
ECHO COLOR 0D>>%FILENAME_MOD_BF%

REM メイン処理ループ
ECHO 資産取得用バッチを作成します...
:LOOP
 SET /a N2=N+1
 ECHO リビジョン：%N2%を取得します
 svn log -r %N2% %SVNPATH%>> %FILENAME_HISTORY%
 FOR /F "delims=" %%a IN ('svn diff -r %N%:%N2% --summarize %SVNPATH%') DO (
  SET LINE=%%a
  call :EXPORT
 )
 IF %N%==%REVISION_TO% (GOTO EXEC)
 SET /a N=N+1
GOTO LOOP
REM **************************************************************************************
REM 処理実行
REM **************************************************************************************
:EXEC
ECHO 追加資産を取得します...
CALL %FILENAME_ADD%
ECHO 修正資産を取得します...
CALL %FILENAME_MOD%
ECHO 処理が終了しました
PAUSE
GOTO :EOF

REM **************************************************************************************
REM ファイル出力
REM **************************************************************************************
:EXPORT
SET INITIAL=%LINE: =F%
SET INITIAL=%INITIAL:~0,1%
SET URL=%LINE:~8%
IF %INITIAL%==F (GOTO :DIRECTORY)
IF %INITIAL%==D (GOTO :DELETE)

REM URL編集
FOR /F %%i IN ('CScript //Nologo //E:JScript "%~f0" "%URL%"') DO (
 SET VBSRESULT=%%i
 call :SEPARATE
)
SET DIRECTORY=!DIRECTORY:%SVNPATH%=!
SET DIRECTORY=%DIRECTORY:/=\%
ECHO %INITIAL% %DIRECTORY%\%FILE%>> %FILENAME_HISTORY%
SET FNUM=0

ECHO ・%FILE%
IF %INITIAL%==A (GOTO :ADD)
IF %INITIAL%==M (GOTO :MODIFY)

GOTO :EOF
REM **************************************************************************************
REM 文字分割
REM **************************************************************************************
:SEPARATE
SET /a FNUM=%FNUM%+1
SET VBSRESULT=%VBSRESULT:PACKAGE_BODY="PACKAGE BODY"%
IF %FNUM%==1 SET URL=%VBSRESULT%
IF %FNUM%==2 SET DIRECTORY=%VBSRESULT%
IF %FNUM%==3 SET FILE=%VBSRESULT%
IF %FNUM%==4 SET EXTENSION=%VBSRESULT%
GOTO :EOF

REM **************************************************************************************
REM フォルダ
REM **************************************************************************************
:DIRECTORY
ECHO %URL%>> %FILENAME_DIR%
GOTO :EOF
REM **************************************************************************************
REM 追加資産分出力
REM **************************************************************************************
:ADD
ECHO svn export -r%N2% %URL%>> %FILENAME_ADD%
ECHO mkdir AF\%DIRECTORY%>> %FILENAME_ADD%
ECHO move /Y %FILE% AF\%DIRECTORY%>> %FILENAME_ADD%
GOTO :EOF
REM **************************************************************************************
REM 変更資産分出力
REM **************************************************************************************
:MODIFY
REM IF /i %EXTENSION%==xls GOTO :EOF
ECHO svn export --force -r%N2% %URL%>> %FILENAME_MOD%
ECHO mkdir AF\%DIRECTORY%>> %FILENAME_MOD%
ECHO move /Y %FILE% AF\%DIRECTORY%>> %FILENAME_MOD%
REM 変更前取得用
ECHO svn export -r%N% %URL%>> %FILENAME_MOD_BF%
ECHO mkdir BF\%DIRECTORY%>> %FILENAME_MOD_BF%
ECHO move %FILE% BF\%DIRECTORY%>> %FILENAME_MOD_BF%
GOTO :EOF
REM **************************************************************************************
REM 削除資産一覧出力
REM **************************************************************************************
:DELETE
ECHO %URL%>> %FILENAME_DEL%
GOTO :EOF
rem */
@end
/** ========================================================
  *  JavaScript 処理
  * ========================================================
 **/
// 主処理の呼び出し
WScript.quit(main());

// 主処理
function main() {
    var url        = WScript.Arguments.Item(0);
    url            = decodeURI(url);
    url            = url.replace(/\ /ig,"_")
    
    var inFile     = url.lastIndexOf ("/");
    var directory  = url.substr(0, inFile);
    var file       = url.substr(inFile + 1);
    
    var inExt      = url.lastIndexOf (".");
    var extension  = url.substr(inExt + 1);
    
    WScript.echo(url);
    WScript.echo(directory);
    WScript.echo(file);
    WScript.echo(extension);
}