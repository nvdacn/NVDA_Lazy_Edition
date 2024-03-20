@echo off
Rem 修改下一行等号后面的值为NVDA源程序文件名的版本号部分即可成功生成，生成的文件位于 Output 文件夹中。
set nvda=2023.3
IF EXIST "%~dp0Application" (rd /s /q "%~dp0Application")
IF EXIST "%~dp0Output" (rd /s /q "%~dp0Output")
IF EXIST "%~dp0Application.exe" (del /f /q "%~dp0Application.exe")
IF EXIST "%~dp0NVDA 懒人版.exe" (del /f /q "%~dp0NVDA 懒人版.exe")
IF EXIST "%~dp0ReadMe.txt" (del /f /q "%~dp0ReadMe.txt")
"%~dp0nvda_%nvda%.exe" --create-portable-silent --portable-path="%~dp0Application"
if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
Start /D  "%ProgramFiles%\NVDA" NVDA
) else (
Start /D  "%ProgramFiles(x86)%\NVDA" NVDA
)
COPY /B /V  /Y "%~dp0ReadMe.md" "%~dp0ReadMe.txt"
"%~dp0InnoSetup\Compil32" /cc "%~dp0便携版NVDA.iss"
"%~dp0InnoSetup\Compil32" /cc "%~dp0NVDA 懒人版.iss"
"%~dp0Others\7z.exe" a -y -tzip "%~dp0Output\NVDA_Lazy_Edition_%nvda%.zip" "%~dp0NVDA 懒人版.exe" "%~dp0ReadMe.txt" "%~dp0恢复备份的 NVDA 配置.exe"
"%~dp0Others\7z.exe" a -y -tzip "%~dp0Output\NVDA懒人版源代码.zip" "%~dp0Addons" "%~dp0InnoSetup" "%~dp0Others" "%~dp0userConfig" "%~dp0NVDA 懒人版.iss" "%~dp0%nvda%.exe" "%~dp0ReadMe.txt" "%~dp0便携版NVDA.iss" "%~dp0恢复备份的 NVDA 配置.exe" "%~dp0执行脚本.bat"
IF EXIST "%~dp0Application" (rd /s /q "%~dp0Application")
IF EXIST "%~dp0Application.exe" (del /f /q "%~dp0Application.exe")
IF EXIST "%~dp0ReadMe.txt" (del /f /q "%~dp0ReadMe.txt")

Exit