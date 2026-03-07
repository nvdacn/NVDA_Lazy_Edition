@echo off

chcp 65001>Nul

Rem 为避免出现编码错误，请在行末是中文字符的行尾添加两个空格  
Rem 设置变量  
Rem 确定运行环境  
if /I "%GITHUB_ACTIONS%" == "true" (
  set "Tool-7Zip="7z.exe""
  set "InnoSetup="ISCC.exe" /Q"
  set "StartNVDA=Off"
) else (
  set "Tool-7Zip="%~dp0Tools\7Zip\7z.exe""
  set "InnoSetup="%~dp0Tools\InnoSetup\Compil32" /cc"
  set "StartNVDA=On"
)
Rem 设置懒人版主程序文件名  
if defined NVDAVersion (
  set "LazyEditionFilename=NVDA_%NVDAVersion% 懒人版"
) else (
  set "LazyEditionFilename=NVDA 懒人版"
)
Rem 设置懒人版压缩包版本号  
for /f "usebackq" %%i in (
  `powershell.exe -Command "Get-Date -Format 'yyyy.MM.dd'"`
) do (
  set "VersionDate=%%i"
)
if /i "%BetaVersion%" == "True" (
  set "Version=%VersionDate%_beta"
) else (
  set "Version=%VersionDate%"
)

Rem 判断是否从命令行传入参数  
if not "%1"=="" (
  set "CLI=%1"
  goto goto
)

Rem 打印可用命令  
cls
echo 欢迎使用NVDA 懒人版构建脚本，请输入要运行的命令，按回车键执行。  
echo BR：运行懒人版程序依赖文件构建流程；  
echo BL：运行懒人版程序构建流程；  
echo Build：运行完整构建流程；  
echo UPL：上传发布版本到 GitCode；  
echo 其他命令：退出此脚本。  
echo 上述选项还可通过命令行直接传入。  

Rem 等待用户输入并跳转到用户输入的命令  
set /p "CLI="
:goto
cls
goto %CLI% >Nul
Exit

:Build
:BR
Rem 检查必要文件是否存在  
IF NOT EXIST "%~dp0Resource" (goto BRError)

Rem 删除已经存在的懒人版相关文件  
IF EXIST "%~dp0Build" (rd /s /q "%~dp0Build")

Rem 创建便携版 NVDA
for /r "%~dp0Resource" %%i in (nvda_20*.exe) do (
  "%%i" --create-portable-silent --portable-path="%~dp0Build\Temp\NVDA"
)

Rem 运行 NVDA
if /i "%StartNVDA%" == "On" (
  Start /D  "%ProgramData%\Microsoft\Windows\Start Menu\Programs\NVDA" NVDA
)

Rem 生成文档的 txt 版本  
COPY /B /V /Y "%~dp0documentation\changes.md" "%~dp0Build\更新日志.txt"
COPY /B /V /Y "%~dp0documentation\ReadMe.md" "%~dp0Build\说明.txt"

Rem 删除aisound.dll
for /r "%~dp0Resource\Addons" %%i in (AISound*.nvda-addon) do (
  %Tool-7Zip% d -sccUTF-8 -y "%%i" "synthDrivers\aisound.dll"
)

Rem 构建 NVDA 便携版  
%InnoSetup% "%~dp0Scripts\Portable.iss"
IF NOT EXIST "%~dp0Build\Temp\NVDAPortable.exe" (
  echo Portable.iss build failed.
  exit /b 1
)

Rem 构建 NVDA 配置恢复工具  
%InnoSetup% "%~dp0Scripts\RestoreNVDAConfiguration.iss"
IF NOT EXIST "%~dp0Build\NVDA 配置恢复工具.exe" (
  echo RestoreNVDAConfiguration.iss build failed.
  exit /b 1
)
if /I "%CLI%" == "BR" (Exit)

:BL
Rem 检查必要文件是否存在  
for %%f in (
  "%~dp0Build\Temp\NVDAPortable.exe"
  "%~dp0Build\Temp\NVDA\documentation\copying.txt"
  "%~dp0Build\说明.txt"
) do (
  if not exist %%f (goto BLError)
)

Rem 构建 NVDA 懒人版主程序  
%InnoSetup% "%~dp0Scripts\NVDALazyEdition.iss"
IF NOT EXIST "%~dp0Build\%LazyEditionFilename%.exe" (
  echo NVDALazyEdition.iss build failed.
  exit /b 1
)
if /I "%CLI%" == "BL" (Exit)

Rem 生成压缩包  
if /I not "%CreateArchive%" == "False" (
  %Tool-7Zip% a -sccUTF-8 -y -tzip "%~dp0Build\Archive\NVDA_Lazy_Edition_%Version%.zip" "%~dp0Build\%LazyEditionFilename%.exe" "%~dp0Build\更新日志.txt" "%~dp0Build\说明.txt" "%~dp0Build\NVDA 配置恢复工具.exe"
  %Tool-7Zip% a -sccUTF-8 -y -tzip "%~dp0Build\Archive\Source_Code_And_Dependency_Files_%Version%.zip" "%~dp0documentation" "%~dp0Resource" "%~dp0Scripts" "%~dp0Tools" "%~dp0userConfig" "%~dp0Run.bat"
) else (
  echo Non-release version, skip creating NVDA_Lazy_Edition_%Version%.zip, Source_Code_And_Dependency_Files_%Version%.zip
)
Exit

:UPL
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0Scripts\UploadToGitCode.ps1"
if %errorlevel% neq 0 (
  mshta "javascript:new ActiveXObject('wscript.shell').popup('执行失败，有关详细信息，请查看命令窗口。',5,'错误');window.close();"
  echo 请按任意键退出...
  Pause>Nul
)
Exit

:BLError
mshta "javascript:new ActiveXObject('wscript.shell').popup('请使用 BR 命令重新运行该脚本后再使用此命令。',5,'缺失必要文件');window.close();"
Exit

:BRError
mshta "javascript:new ActiveXObject('wscript.shell').popup('请获取 必须 Resource 文件后重试。',5,'缺失必要文件');window.close();"
Exit
