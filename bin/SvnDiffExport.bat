@if (0)==(1) /*
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
COLOR 0A
REM �����ݒ�
SET SVNPATH=
SET REVISION_FROM=2801
SET REVISION_TO=2831

SET FILENAME_ADD=ADD_SOURCE.bat
SET FILENAME_MOD=MOD_SOURCE.bat
SET FILENAME_MOD_BF=MOD_SOURCE_BF.bat
SET FILENAME_DEL=DEL_SOURCE.txt
SET FILENAME_DIR=DIR_SOURCE.txt
SET FILENAME_HISTORY=�ύX����.txt

REM ���\��
svn info %SVNPATH%> %FILENAME_HISTORY%
ECHO ���|�W�g���F%SVNPATH%
ECHO ���r�W����%REVISION_FROM%����%REVISION_TO%�܂ł̍������Y���擾���܂��B
SET N=%REVISION_FROM%
PAUSE

REM �O��t�@�C���폜
ECHO �O��t�@�C�����폜���܂�...
IF EXIST %FILENAME_DEL% (DEL %FILENAME_DEL%)
IF EXIST %FILENAME_DIR% (DEL %FILENAME_DIR%)

REM �o�b�`�쐬��������
ECHO @echo off>%FILENAME_ADD%
ECHO COLOR 0C>>%FILENAME_ADD%
ECHO @echo off>%FILENAME_MOD%
ECHO COLOR 0E>>%FILENAME_MOD%
ECHO @echo off>%FILENAME_MOD_BF%
ECHO COLOR 0D>>%FILENAME_MOD_BF%

REM ���C���������[�v
ECHO ���Y�擾�p�o�b�`���쐬���܂�...
:LOOP
 SET /a N2=N+1
 ECHO ���r�W�����F%N2%���擾���܂�
 svn log -r %N2% %SVNPATH%>> %FILENAME_HISTORY%
 FOR /F "delims=" %%a IN ('svn diff -r %N%:%N2% --summarize %SVNPATH%') DO (
  SET LINE=%%a
  call :EXPORT
 )
 IF %N%==%REVISION_TO% (GOTO EXEC)
 SET /a N=N+1
GOTO LOOP
REM **************************************************************************************
REM �������s
REM **************************************************************************************
:EXEC
ECHO �ǉ����Y���擾���܂�...
CALL %FILENAME_ADD%
ECHO �C�����Y���擾���܂�...
CALL %FILENAME_MOD%
ECHO �������I�����܂���
PAUSE
GOTO :EOF

REM **************************************************************************************
REM �t�@�C���o��
REM **************************************************************************************
:EXPORT
SET INITIAL=%LINE: =F%
SET INITIAL=%INITIAL:~0,1%
SET URL=%LINE:~8%
IF %INITIAL%==F (GOTO :DIRECTORY)
IF %INITIAL%==D (GOTO :DELETE)

REM URL�ҏW
FOR /F %%i IN ('CScript //Nologo //E:JScript "%~f0" "%URL%"') DO (
 SET VBSRESULT=%%i
 call :SEPARATE
)
SET DIRECTORY=!DIRECTORY:%SVNPATH%=!
SET DIRECTORY=%DIRECTORY:/=\%
ECHO %INITIAL% %DIRECTORY%\%FILE%>> %FILENAME_HISTORY%
SET FNUM=0

ECHO �E%FILE%
IF %INITIAL%==A (GOTO :ADD)
IF %INITIAL%==M (GOTO :MODIFY)

GOTO :EOF
REM **************************************************************************************
REM ��������
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
REM �t�H���_
REM **************************************************************************************
:DIRECTORY
ECHO %URL%>> %FILENAME_DIR%
GOTO :EOF
REM **************************************************************************************
REM �ǉ����Y���o��
REM **************************************************************************************
:ADD
ECHO svn export -r%N2% %URL%>> %FILENAME_ADD%
ECHO mkdir AF\%DIRECTORY%>> %FILENAME_ADD%
ECHO move /Y %FILE% AF\%DIRECTORY%>> %FILENAME_ADD%
GOTO :EOF
REM **************************************************************************************
REM �ύX���Y���o��
REM **************************************************************************************
:MODIFY
REM IF /i %EXTENSION%==xls GOTO :EOF
ECHO svn export --force -r%N2% %URL%>> %FILENAME_MOD%
ECHO mkdir AF\%DIRECTORY%>> %FILENAME_MOD%
ECHO move /Y %FILE% AF\%DIRECTORY%>> %FILENAME_MOD%
REM �ύX�O�擾�p
ECHO svn export -r%N% %URL%>> %FILENAME_MOD_BF%
ECHO mkdir BF\%DIRECTORY%>> %FILENAME_MOD_BF%
ECHO move %FILE% BF\%DIRECTORY%>> %FILENAME_MOD_BF%
GOTO :EOF
REM **************************************************************************************
REM �폜���Y�ꗗ�o��
REM **************************************************************************************
:DELETE
ECHO %URL%>> %FILENAME_DEL%
GOTO :EOF
rem */
@end
/** ========================================================
  *  JavaScript ����
  * ========================================================
 **/
// �又���̌Ăяo��
WScript.quit(main());

// �又��
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