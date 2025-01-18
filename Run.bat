@echo off

chcp 65001

Rem 为避免出现编码错误，请在行末是中文字符的行尾添加两个空格  
Rem GitHub Actions 流程  
if "%1" == "GITHUB_ACTIONS" (
  set CLI=Build
  set InnoSetup="%~dp0Tools\InnoSetup\ISCC" /Q
  set NVDA=Off
  set VersionDate=%date:~-4%.%date:~-10,2%.%date:~-7,2%
  goto Build
) else (
  set InnoSetup="%~dp0Tools\InnoSetup\Compil32" /cc
  set NVDA=On
  set VersionDate=%date:~3,4%.%date:~8,2%.%date:~11,2%
)

Rem 判断是否从命令行传入参数  
if not "%1"=="" (
  set CLI=%1
  goto goto
)

Rem 打印可用命令  
cls
echo 欢迎使用NVDA 懒人版构建脚本，请输入要运行的命令，按回车键执行。  
echo BR：运行懒人版程序依赖文件构建流程；  
echo BL：运行懒人版程序构建流程；  
echo Build：运行完整构建流程；  
echo 其他命令：退出此脚本。  
echo 上述选项还可通过命令行直接传入。  

Rem 等待用户输入并跳转到用户输入的命令  
set /p CLI=
:goto
goto %CLI%

:Build
:BR
Rem 删除已经存在的懒人版相关文件  
IF EXIST "%~dp0Build" (rd /s /q "%~dp0Build")

Rem 创建便携版 NVDA
for /r "%~dp0Resource" %%i in (nvda_20*.exe) do (
  "%%i" --create-portable-silent --portable-path="%~dp0Build\Temp\NVDA"
)

Rem 运行 NVDA
if /i %NVDA% == On (
  if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
    Start /D  "%ProgramFiles%\NVDA" NVDA
  ) else (
    Start /D  "%ProgramFiles(x86)%\NVDA" NVDA
  )
)

Rem 生成文档的 txt 版本  
COPY /B /V /Y "%~dp0documentation\changes.md" "%~dp0Build\更新日志.txt"
COPY /B /V /Y "%~dp0documentation\ReadMe.md" "%~dp0Build\说明.txt"

Rem 删除aisound.dll
for /r "%~dp0Resource\Addons" %%i in (AISound*.nvda-addon) do (
  "%~dp0Tools\7Zip\7z.exe" d -sccUTF-8 -y "%%i" "synthDrivers\aisound.dll"
)

Rem 构建 NVDA 便携版和配置恢复工具  
%InnoSetup% "%~dp0Scripts\Portable.iss"
%InnoSetup% "%~dp0Scripts\RestoreNVDAConfiguration.iss"
if /I %CLI% == BR (Exit)

:BL
IF NOT EXIST "%~dp0Build\Temp\NVDAPortable.exe" (goto Error)
IF NOT EXIST "%~dp0Build\Temp\NVDA\documentation\copying.txt" (goto Error)
IF NOT EXIST "%~dp0Build\说明.txt" (goto Error)
%InnoSetup% "%~dp0Scripts\NVDALazyEdition.iss"
if /I %CLI% == BL (Exit)

Rem 生成程序压缩包  
"%~dp0Tools\7Zip\7z.exe" a -sccUTF-8 -y -tzip "%~dp0Build\Archive\NVDA_Lazy_Edition_%VersionDate%.zip" "%~dp0Build\NVDA 懒人版.exe" "%~dp0Build\更新日志.txt" "%~dp0Build\说明.txt" "%~dp0Build\NVDA 配置恢复工具.exe"
"%~dp0Tools\7Zip\7z.exe" a -sccUTF-8 -y -tzip "%~dp0Build\Archive\Source_Code_And_Dependency_Files_%VersionDate%.zip" "%~dp0documentation" "%~dp0Resource" "%~dp0Scripts" "%~dp0Tools" "%~dp0userConfig" "%~dp0Run.bat"
Exit

:Error
mshta "javascript:new ActiveXObject('wscript.shell').popup('请使用 BR 命令重新运行该脚本后再使用此命令。',5,'缺失必要文件');window.close();"
Exit
