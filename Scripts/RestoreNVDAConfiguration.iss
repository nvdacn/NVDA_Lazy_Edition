﻿[Setup]
AppName=NVDA 配置恢复工具
AppVersion=1.1
VersionInfoVersion=1.1
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
ArchitecturesInstallIn64BitMode=x64 ia64 arm64
AllowCancelDuringInstall=No
AlwaysShowComponentsList=No
ShowComponentSizes=No
ShowTasksTreeLines=Yes
RestartIfNeededByRun=no
ShowLanguageDialog=No

[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Default.isl"

[code]
procedure RestoreNVDAConfiguration ();
var
  ResultCode: Integer;
begin
  if MsgBox('本程序将恢复您在 NVDA 懒人版安装程序所备份的配置到 NVDA 配置文件夹。' #13#13 '备份的配置文件成功恢复后将会被删除。' #13#13 '恢复过程需重启您的 NVDA，您要现在恢复吗？', mbConfirmation, MB_YESNO)= IDYES then
  begin
    ShellExec('', ExpandConstant('{commonpf32}\NVDA\nvda.exe'), '-q', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
    DelTree(ExpandConstant('{userappdata}\NVDA'), True, True, True);
    ExtractTemporaryFile(ExtractFileName(ExpandConstant('{tmp}\7z.dll')));
    ExtractTemporaryFile(ExtractFileName(ExpandConstant('{tmp}\7z.exe')));
    Exec(ExpandConstant('{tmp}\7z.exe'), 'x "'+ ExpandConstant('{userdocs}\NVDABackup\NVDABackup.zip')+'" -aoa -o"'+ ExpandConstant('{userappdata}\NVDA')+'"', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
    DelTree(ExpandConstant('{userdocs}\NVDABackup'), True, True, True);
    ShellExec('', ExpandConstant('{commonpf32}\NVDA\nvda.exe'), '', '', SW_SHOW, ewNoWait, ResultCode);
    MsgBox('恭喜，操作成功!', mbInformation, MB_OK);
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
Source: "..\Tools\7Zip\*"; DestDir: "{app}"; Flags: deleteafterinstall ignoreversion recursesubdirs createallsubdirs
