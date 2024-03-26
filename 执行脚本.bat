@echo off
chcp 65001

Rem 修改下一行等号后面的值为NVDA源程序文件名即可成功生成，生成的文件位于 Output 文件夹中。
set nvda=nvda_2024.1rc1

Rem 删除已经存在的懒人版相关文件
IF EXIST "%~dp0Output" (rd /s /q "%~dp0Output")
IF EXIST "%~dp0Temp" (rd /s /q "%~dp0Temp")

Rem 创建便携版 NVDA
"%~dp0Resource\%nvda%.exe" --create-portable-silent --portable-path="%~dp0Temp\NVDA"
if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
Start /D  "%ProgramFiles%\NVDA" NVDA
) else (
Start /D  "%ProgramFiles(x86)%\NVDA" NVDA
)

Rem 开始生成
MKDir "%~dp0Output"
COPY /B /V  /Y "%~dp0documentation\changes.md" "%~dp0Output\更新日志.txt"
COPY /B /V  /Y "%~dp0documentation\ReadMe.md" "%~dp0Output\说明.txt"
"%~dp0Tools\InnoSetup\Compil32" /cc "%~dp0便携版安装脚本.iss"
"%~dp0Tools\InnoSetup\Compil32" /cc "%~dp0懒人版安装脚本.iss"
"%~dp0Tools\InnoSetup\Compil32" /cc "%~dp0恢复备份的 NVDA 配置.iss"
"%~dp0Tools\7Zip\7z.exe" a -y -tzip "%~dp0Output\Archive\NVDA_Lazy_Edition_%date:~3,4%.%date:~8,2%.%date:~11,2%.zip" "%~dp0Output\NVDA 懒人版.exe" "%~dp0Output\更新日志.txt" "%~dp0Output\说明.txt" "%~dp0Output\NVDA 配置恢复工具.exe"
"%~dp0Tools\7Zip\7z.exe" a -y -tzip "%~dp0Output\Archive\Source_Code_And_Dependency_Files_%date:~3,4%.%date:~8,2%.%date:~11,2%.zip" "%~dp0documentation" "%~dp0Resource" "%~dp0Tools" "%~dp0userConfig" "%~dp0ReadMe.md" "%~dp0便携版安装脚本.iss" "%~dp0恢复备份的 NVDA 配置.iss" "%~dp0懒人版安装脚本.iss" "%~dp0执行脚本.bat"

Exit
