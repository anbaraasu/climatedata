@echo off
setlocal

set DIRNAME=%~dp0
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%

if exist "%APP_HOME%\%APP_BASE_NAME%.jar" (
  set SCRIPT="%APP_HOME%\%APP_BASE_NAME%.jar"
) else (
  echo The file %APP_HOME%\%APP_BASE_NAME%.jar does not exist.
  exit /B 1
)

set JAVA_EXE=java
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java
goto findJavaFromPath

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%\bin\java.exe
if exist "%JAVA_EXE%" goto init

echo The JAVA_HOME environment variable is not defined correctly
echo This environment variable is needed to run this program
exit /B 1

:findJavaFromPath
set JAVA_EXE=java
:init

"%JAVA_EXE%" -jar %SCRIPT% %*