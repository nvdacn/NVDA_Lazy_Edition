@echo off
Rem 修改下一行等号后面的值为NVDA源程序文件名即可成功生成，生成的文件位于 Output 文件夹中。
set nvda=nvda_2024.1rc1

Rem 删除已经存在的懒人版相关文件
IF EXIST "%~dp0Application" (rd /s /q "%~dp0Application")
IF EXIST "%~dp0Output" (rd /s /q "%~dp0Output")
IF EXIST "%~dp0Application.exe" (del /f /q "%~dp0Application.exe")
IF EXIST "%~dp0NVDA 懒人版.exe" (del /f /q "%~dp0NVDA 懒人版.exe")
IF EXIST "%~dp0NVDA 配置恢复工具.exe" (del /f /q "%~dp0NVDA 配置恢复工具.exe")
IF EXIST "%~dp0ReadMe.txt" (del /f /q "%~dp0ReadMe.txt")

Rem 创建便携版 NVDA
"%~dp0%nvda%.exe" --create-portable-silent --portable-path="%~dp0Application"
if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
Start /D  "%ProgramFiles%\NVDA" NVDA
) else (
Start /D  "%ProgramFiles(x86)%\NVDA" NVDA
)

Rem 开始生成
COPY /B /V  /Y "%~dp0ReadMe.md" "%~dp0ReadMe.txt"
"%~dp0InnoSetup\Compil32" /cc "%~dp0便携版安装脚本.iss"
"%~dp0InnoSetup\Compil32" /cc "%~dp0懒人版安装脚本.iss"
"%~dp0InnoSetup\Compil32" /cc "%~dp0恢复备份的 NVDA 配置.iss"
"%~dp0Others\7z.exe" a -y -tzip "%~dp0Output\NVDA_Lazy_Edition_%date:~0,4%.%date:~5,2%.%date:~8,2%.zip" "%~dp0NVDA 懒人版.exe" "%~dp0ReadMe.txt" "%~dp0NVDA 配置恢复工具.exe"
"%~dp0Others\7z.exe" a -y -tzip "%~dp0Output\Source_Code_And_Dependency_Files_%date:~0,4%.%date:~5,2%.%date:~8,2%.zip" "%~dp0Addons" "%~dp0InnoSetup" "%~dp0Others" "%~dp0userConfig" "%~dp0NVDA 懒人版.iss" "%~dp0%nvda%.exe" "%~dp0ReadMe.md" "%~dp0NVDA 便携版.iss" "%~dp0恢复备份的 NVDA 配置.iss" "%~dp0执行脚本.bat"

Rem 清理临时文件
IF EXIST "%~dp0Application" (rd /s /q "%~dp0Application")
IF EXIST "%~dp0Application.exe" (del /f /q "%~dp0Application.exe")
IF EXIST "%~dp0ReadMe.txt" (del /f /q "%~dp0ReadMe.txt")

Exit