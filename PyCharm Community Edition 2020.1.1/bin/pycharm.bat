@ECHO OFF

::----------------------------------------------------------------------
:: PyCharm startup script.
::----------------------------------------------------------------------

:: ---------------------------------------------------------------------
:: Ensure IDE_HOME points to the directory where the IDE is installed.
:: ---------------------------------------------------------------------
SET IDE_BIN_DIR=%~dp0
FOR /F "delims=" %%i in ("%IDE_BIN_DIR%\..") DO SET IDE_HOME=%%~fi

:: ---------------------------------------------------------------------
:: Locate a JDK installation directory which will be used to run the IDE.
:: Try (in order): PYCHARM_JDK, pycharm%BITS%.exe.jdk, ..\jre, JDK_HOME, JAVA_HOME.
:: ---------------------------------------------------------------------
SET JDK=

IF EXIST "%PYCHARM_JDK%" SET JDK=%PYCHARM_JDK%
IF EXIST "%JDK%" GOTO check

SET BITS=64
SET USER_JDK64_FILE=%APPDATA%\JetBrains\PyCharmCE2020.1\pycharm%BITS%.exe.jdk
SET BITS=
SET USER_JDK_FILE=%APPDATA%\JetBrains\PyCharmCE2020.1\pycharm%BITS%.exe.jdk
IF EXIST "%USER_JDK64_FILE%" (
  SET /P JDK=<%USER_JDK64_FILE%
) ELSE (
  IF EXIST "%USER_JDK_FILE%" SET /P JDK=<%USER_JDK_FILE%
)
IF NOT "%JDK%" == "" (
  IF NOT EXIST "%JDK%" SET JDK="%IDE_HOME%\%JDK%"
  IF EXIST "%JDK%" GOTO check
)

IF "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
  IF EXIST "%IDE_HOME%\jbr" SET JDK=%IDE_HOME%\jbr
  IF EXIST "%JDK%" GOTO check
)
IF EXIST "%IDE_HOME%\jbr-x86" SET JDK=%IDE_HOME%\jbr-x86
IF EXIST "%JDK%" GOTO check

IF EXIST "%JDK_HOME%" SET JDK=%JDK_HOME%
IF EXIST "%JDK%" GOTO check

IF EXIST "%JAVA_HOME%" SET JDK=%JAVA_HOME%

:check
SET JAVA_EXE=%JDK%\bin\java.exe
IF NOT EXIST "%JAVA_EXE%" SET JAVA_EXE=%JDK%\jre\bin\java.exe
IF NOT EXIST "%JAVA_EXE%" (
  ECHO ERROR: cannot start PyCharm.
  ECHO No JDK found. Please validate either PYCHARM_JDK, JDK_HOME or JAVA_HOME points to valid JDK installation.
  EXIT /B
)

SET JRE=%JDK%
IF EXIST "%JRE%\jre" SET JRE=%JDK%\jre
IF EXIST "%JRE%\lib\amd64" (
  SET BITS=64
) ELSE (
  IF EXIST "%JRE%\bin\windowsaccessbridge-64.dll" SET BITS=64
)

:: ---------------------------------------------------------------------
:: Collect JVM options and properties.
:: ---------------------------------------------------------------------
IF NOT "%PYCHARM_PROPERTIES%" == "" SET IDE_PROPERTIES_PROPERTY="-Didea.properties.file=%PYCHARM_PROPERTIES%"

:: explicit
SET VM_OPTIONS_FILE=%PYCHARM_VM_OPTIONS%
IF NOT EXIST "%VM_OPTIONS_FILE%" (
  :: Toolbox
  SET VM_OPTIONS_FILE=%IDE_HOME%.vmoptions
)
IF NOT EXIST "%VM_OPTIONS_FILE%" (
  :: user-overridden
  SET VM_OPTIONS_FILE=%APPDATA%\JetBrains\PyCharmCE2020.1\pycharm%BITS%.exe.vmoptions
)
IF NOT EXIST "%VM_OPTIONS_FILE%" (
  :: default, standard installation
  SET VM_OPTIONS_FILE=%IDE_BIN_DIR%\pycharm%BITS%.exe.vmoptions
)
IF NOT EXIST "%VM_OPTIONS_FILE%" (
  :: default, universal package
  SET VM_OPTIONS_FILE=%IDE_BIN_DIR%\win\pycharm%BITS%.exe.vmoptions
)
IF NOT EXIST "%VM_OPTIONS_FILE%" (
  ECHO ERROR: cannot find VM options file.
)

SET ACC=
FOR /F "eol=# usebackq delims=" %%i IN ("%VM_OPTIONS_FILE%") DO CALL "%IDE_BIN_DIR%\append.bat" "%%i"
IF EXIST "%VM_OPTIONS_FILE%" SET ACC=%ACC% -Djb.vmOptionsFile="%VM_OPTIONS_FILE%"

SET COMMON_JVM_ARGS="-XX:ErrorFile=%USERPROFILE%\java_error_in_PYCHARM_%%p.log" "-XX:HeapDumpPath=%USERPROFILE%\java_error_in_PYCHARM.hprof" -Didea.paths.selector=PyCharmCE2020.1 %IDE_PROPERTIES_PROPERTY%
SET IDE_JVM_ARGS=-Didea.platform.prefix=PyCharmCore
SET ALL_JVM_ARGS=%ACC% %COMMON_JVM_ARGS% %IDE_JVM_ARGS%

SET CLASS_PATH=%IDE_HOME%\lib\bootstrap.jar
SET CLASS_PATH=%CLASS_PATH%;%IDE_HOME%\lib\extensions.jar
SET CLASS_PATH=%CLASS_PATH%;%IDE_HOME%\lib\util.jar
SET CLASS_PATH=%CLASS_PATH%;%IDE_HOME%\lib\jdom.jar
SET CLASS_PATH=%CLASS_PATH%;%IDE_HOME%\lib\log4j.jar
SET CLASS_PATH=%CLASS_PATH%;%IDE_HOME%\lib\trove4j.jar
SET CLASS_PATH=%CLASS_PATH%;%IDE_HOME%\lib\jna.jar
IF NOT "%PYCHARM_CLASS_PATH%" == "" SET CLASS_PATH=%CLASS_PATH%;%PYCHARM_CLASS_PATH%

:: ---------------------------------------------------------------------
:: Run the IDE.
:: ---------------------------------------------------------------------
SET OLD_PATH=%PATH%
SET PATH=%IDE_BIN_DIR%;%PATH%

"%JAVA_EXE%" %ALL_JVM_ARGS% -cp "%CLASS_PATH%" com.intellij.idea.Main %*

SET PATH=%OLD_PATH%
