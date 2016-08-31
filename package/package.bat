@echo off
echo ######################################
echo create by Yale Ren 2016-7-1
echo ######################################

echo zip dir

set EXENAME=Demo
set APP_DIR=..\app
set NWEXE_DIR=..\nwjs-v0.12.3-win-ia32\nw.exe


7za.exe a -tzip %EXENAME%.zip %APP_DIR%\*

echo generate main exe

copy /b %NWEXE_DIR%+%EXENAME%.zip %EXENAME%.exe

del %EXENAME%.zip


echo ######################################
echo realse package

set SRC_DIR=..\nwjs-v0.12.3-win-ia32
set DEST_DIR=release
set NWEXE_NAME=nw.exe

rd /Q /S %DEST_DIR%
mkdir %DEST_DIR%

xcopy %SRC_DIR%\*  %DEST_DIR%\ /y

del %DEST_DIR%\%NWEXE_NAME%
xcopy %EXENAME%.exe  %DEST_DIR%\ /y

del %EXENAME%.exe

echo finish
@pause