@echo off
set word=%1
set file=%2
if ""%file%""=="""" set file=*.sql,*.java,*.jsp,*.js,*.txt
rem -GKEY=    ����������
rem -GFILE=   �����Ώۂ̃t�@�C��
rem -GFOLDER= �����Ώۂ̃t�H���_
rem -GCODE=   �����R�[�h 99�i�������ʁj
rem -GOPT=    �������� S�i�T�u�t�H���_����������j
sakura -GREPMODE -GKEY=%word% -GFILE=%file% -GFOLDER=%cd% -GCODE=99 -GOPT=SP
