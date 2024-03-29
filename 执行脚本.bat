@echo off
chcp 936

Rem ɾ���Ѿ����ڵ����˰�����ļ�
IF EXIST "%~dp0Output" (rd /s /q "%~dp0Output")
IF EXIST "%~dp0Temp" (rd /s /q "%~dp0Temp")

Rem ������Я�� NVDA
for /r "%~dp0Resource" %%i in (nvda_20*.exe) do (
  %%i --create-portable-silent --portable-path="%~dp0Temp\NVDA"
)

Rem �����ĵ��� txt �汾
MKDir "%~dp0Output"
COPY /B /V  /Y "%~dp0documentation\changes.md" "%~dp0Output\������־.txt"
COPY /B /V  /Y "%~dp0documentation\ReadMe.md" "%~dp0Output\˵��.txt"

if "%1" == "GITHUB_ACTIONS" (
  @echo on
  GOTO GitHub
) else (
  GOTO Local
)

Rem GitHub Actions ��������
:GitHub
Rem ��ʼ����
set VersionDate=%date:~-4%.%date:~-10,2%.%date:~-7,2%
"%~dp0Tools\InnoSetup\ISCC" /Q "%~dp0��Я�氲װ�ű�.iss"
"%~dp0Tools\InnoSetup\ISCC" /Q "%~dp0���˰氲װ�ű�.iss"
"%~dp0Tools\InnoSetup\ISCC" /Q "%~dp0�ָ����ݵ� NVDA ����.iss"
GOTO Archive

Rem ���ع�������
:Local
Rem ���� NVDA
if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
  Start /D  "%ProgramFiles%\NVDA" NVDA
) else (
  Start /D  "%ProgramFiles(x86)%\NVDA" NVDA
)

Rem ��ʼ����
set VersionDate=%date:~3,4%.%date:~8,2%.%date:~11,2%"%~dp0Tools\InnoSetup\Compil32" /cc "%~dp0��Я�氲װ�ű�.iss"
"%~dp0Tools\InnoSetup\Compil32" /cc "%~dp0���˰氲װ�ű�.iss"
"%~dp0Tools\InnoSetup\Compil32" /cc "%~dp0�ָ����ݵ� NVDA ����.iss"

:Archive
Rem ���ɳ���ѹ���ļ�
"%~dp0Tools\7Zip\7z.exe" a -y -tzip "%~dp0Output\Archive\NVDA_Lazy_Edition_%VersionDate%.zip" "%~dp0Output\NVDA ���˰�.exe" "%~dp0Output\������־.txt" "%~dp0Output\˵��.txt" "%~dp0Output\NVDA ���ûָ�����.exe"
"%~dp0Tools\7Zip\7z.exe" a -y -tzip "%~dp0Output\Archive\Source_Code_And_Dependency_Files_%VersionDate%.zip" "%~dp0documentation" "%~dp0Resource" "%~dp0Tools" "%~dp0userConfig" "%~dp0ReadMe.md" "%~dp0��Я�氲װ�ű�.iss" "%~dp0�ָ����ݵ� NVDA ����.iss" "%~dp0���˰氲װ�ű�.iss" "%~dp0ִ�нű�.bat"

Exit
