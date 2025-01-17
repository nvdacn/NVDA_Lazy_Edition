@echo off
chcp 65001

Rem 删除已经存在的懒人版相关文件
IF EXIST "%~dp0Build" (rd /s /q "%~dp0Build")
IF EXIST "%~dp0Build\Temp" (rd /s /q "%~dp0Build\Temp")

Rem 创建便携版 NVDA
for /r "%~dp0Resource" %%i in (nvda_20*.exe) do (
  "%%i" --create-portable-silent --portable-path="%~dp0Build\Temp\NVDA"
)

Rem 生成文档的 txt 版本
MKDir "%~dp0Build"
COPY /B /V /Y "%~dp0documentation\changes.md" "%~dp0Build\更新日志.txt"
COPY /B /V /Y "%~dp0documentation\ReadMe.md" "%~dp0Build\说明.txt"

if "%1" == "GITHUB_ACTIONS" (
  @echo on
  GOTO GitHub
) else (
  GOTO Local
)

Rem GitHub Actions 构建流程
:GitHub
Rem 删除aisound.dll
for /r "%~dp0Resource\Addons" %%i in (AISound*.nvda-addon) do (
  "%~dp0Tools\7Zip\7z.exe" d -sccUTF-8 -y "%%i" "synthDrivers\aisound.dll"
)

Rem 开始生成
set VersionDate=%date:~-4%.%date:~-10,2%.%date:~-7,2%
"%~dp0Tools\InnoSetup\ISCC" /Q "%~dp0Scripts\Portable.iss"
"%~dp0Tools\InnoSetup\ISCC" /Q "%~dp0Scripts\NVDALazyEdition.iss"
"%~dp0Tools\InnoSetup\ISCC" /Q "%~dp0Scripts\RestoreNVDAConfiguration.iss"
GOTO Archive

Rem 本地构建流程
:Local
Rem 运行 NVDA
if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
  Start /D  "%ProgramFiles%\NVDA" NVDA
) else (
  Start /D  "%ProgramFiles(x86)%\NVDA" NVDA
)

Rem 开始生成
set VersionDate=%date:~3,4%.%date:~8,2%.%date:~11,2%
"%~dp0Tools\InnoSetup\Compil32" /cc "%~dp0Scripts\Portable.iss"
"%~dp0Tools\InnoSetup\Compil32" /cc "%~dp0Scripts\NVDALazyEdition.iss"
"%~dp0Tools\InnoSetup\Compil32" /cc "%~dp0Scripts\RestoreNVDAConfiguration.iss"

:Archive
Rem 生成程序压缩文件
"%~dp0Tools\7Zip\7z.exe" a -sccUTF-8 -y -tzip "%~dp0Build\Archive\NVDA_Lazy_Edition_%VersionDate%.zip" "%~dp0Build\NVDA 懒人版.exe" "%~dp0Build\更新日志.txt" "%~dp0Build\说明.txt" "%~dp0Build\NVDA 配置恢复工具.exe"
"%~dp0Tools\7Zip\7z.exe" a -sccUTF-8 -y -tzip "%~dp0Build\Archive\Source_Code_And_Dependency_Files_%VersionDate%.zip" "%~dp0documentation" "%~dp0Resource" "%~dp0Scripts" "%~dp0Tools" "%~dp0userConfig" "%~dp0ReadMe.md" "%~dp0执行脚本.bat"

Exit