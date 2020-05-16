@ECHO OFF

::----------------------------------------------------------------------
:: PyCharm formatting script.
::----------------------------------------------------------------------

SET IDE_BIN_DIR=%~dp0
CALL "%IDE_BIN_DIR%\pycharm.bat" format %*
