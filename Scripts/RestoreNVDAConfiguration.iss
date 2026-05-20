#include "common_defines.iss"
#define BaseVersion "1.2"
#define DotCount Len(BaseVersion) - Len(StringChange(BaseVersion, ".", ""))
#define FinalVersion BaseVersion + (DotCount == 1 ? ".0" : "") + (BuildNumber != "" ? "." + BuildNumber : "")

[Setup]
AppName=NVDA 配置恢复工具
AppVersion={#BaseVersion}
VersionInfoVersion={#FinalVersion}
AppVerName=NVDA 配置恢复工具
AppPublisher=NVDACN
AppPublisherURL=https://www.nvdacn.com/
AppSupportURL=https://github.com/nvdacn/NVDA_Lazy_Edition
AppUpdatesURL=https://github.com/nvdacn/NVDA_Lazy_Edition/releases
DefaultDirName={userappdata}\NVDA
AllowNoIcons=yes
OutputDir=..\Build
OutputBaseFilename=NVDA 配置恢复工具
Compression=none
DisableDirPage=Yes
DisableProgramGroupPage=yes
AppendDefaultDirName=No
DirExistsWarning=No
Uninstallable=No
MinVersion=10.0
ArchitecturesAllowed=x64 arm64
ArchitecturesInstallIn64BitMode=x64 arm64
AllowCancelDuringInstall=No
AlwaysShowComponentsList=No
ShowComponentSizes=No
ShowTasksTreeLines=Yes
RestartIfNeededByRun=no
ShowLanguageDialog=No

[Languages]
Name: "chinesesimp"; MessagesFile: {#ChineseSimplifiedMessages}

[code]
function NVDA: string;
begin
  Result := ExpandConstant('{commonpf32}\NVDA\nvda.exe');
  if not FileExists(Result) then
  begin
    Result := ExpandConstant('{commonpf}\NVDA\nvda.exe');
  end;
end;
procedure RestoreNVDAConfiguration ();
var
  ResultCode: Integer;
begin
  if MsgBox('本程序将恢复您在 NVDA 懒人版安装程序所备份的配置到 NVDA 配置文件夹。' #13#13 '恢复过程需重启您的 NVDA，您要现在恢复吗？', mbConfirmation, MB_YESNO)= IDYES then
  begin
    ShellExec('', NVDA, '--quit', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
    DelTree(ExpandConstant('{userappdata}\NVDA'), True, True, True);
    ExtractTemporaryFile(ExtractFileName(ExpandConstant('{tmp}\7z.dll')));
    ExtractTemporaryFile(ExtractFileName(ExpandConstant('{tmp}\7z.exe')));
    Exec(ExpandConstant('{tmp}\7z.exe'), 'x "'+ ExpandConstant('{userdocs}\NVDABackup\NVDABackup.zip')+'" -aoa -o"'+ ExpandConstant('{userappdata}\NVDA')+'"', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
    ShellExec('', NVDA, '', '', SW_SHOW, ewNoWait, ResultCode);
    if MsgBox('此前备份的配置已成功恢复。是否删除备份文件夹？', mbConfirmation, MB_YESNO or MB_DEFBUTTON2)= IDYES then
  begin
      DelTree(ExpandConstant('{userdocs}\NVDABackup'), True, True, True);
    end;
  end;
end;
function InitializeSetup: Boolean;
begin
  if FileExists(ExpandConstant('{userdocs}\NVDABackup\NVDABackup.zip')) = True then
  begin
    RestoreNVDAConfiguration ();
  end else begin
    MsgBox('未检测到配置备份文件，无法恢复!', mbCriticalError, MB_OK)
  end;
  Result := False;
end;

[Files]
Source: {#SevenZipDll}; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion
Source: {#SevenZipExe}; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion
