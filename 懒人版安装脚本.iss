#define Version GetDateTimeString('yyyy.mm.dd', '.', '')

[Setup]
VersionInfoVersion={#Version}
AppName=NVDA 懒人版
AppVerName=NVDA 懒人版-{#Version}
AppPublisher=NVDACN
AppPublisherURL=https://www.nvdacn.com/
AppSupportURL=https://github.com/nvdacn/NVDA_Lazy_Edition
AppUpdatesURL=https://github.com/nvdacn/NVDA_Lazy_Edition/releases
DefaultDirName={userappdata}\NVDA
AllowNoIcons=yes
OutputDir=Output
OutputBaseFilename=NVDA 懒人版
Compression=lzma
DisableDirPage=Yes
DisableProgramGroupPage=yes
AppendDefaultDirName=No
DirExistsWarning=No
Uninstallable=No
LicenseFile=Temp\NVDA\documentation\copying.txt
SetupIconFile=Temp\NVDA\images\nvda.ico
InfoBeforeFile=Output\说明.txt
MinVersion=6.03
ArchitecturesInstallIn64BitMode=x64 ia64 arm64
AllowCancelDuringInstall=No
AlwaysShowComponentsList=No
ShowComponentSizes=No
ShowTasksTreeLines=Yes
RestartIfNeededByRun=no
ShowLanguageDialog=No

[Languages]
Name: "english"; MessagesFile: "compiler:Languages\English.isl"
Name: "chinesesimp"; MessagesFile: "compiler:Default.isl"

[Messages]
ReadyLabel2a=单击“安装”以开始安装进程。
FinishedHeadingLabel=[name] 安装向导完成，请手动启动 NVDA 已开始使用

[Types]
Name: "default"; Description: "默认安装"
Name: "compact"; Description: "最小安装"
Name: Full; Description: "完整安装"
Name: "custom"; Description: "自定义安装"; Flags: iscustom

[Components]
Name: "Settings"; Types: Full default compact custom; Description: "修改部分 NVDA 设置"; Check: not FileExists(ExpandConstant('{userappdata}\NVDA\nvda.ini'))
Name: "Settings"; Description: "修改部分 NVDA 设置"; Check: FileExists(ExpandConstant('{userappdata}\NVDA\nvda.ini'))
Name: "Voices"; Types: Full default custom; Description: "语音引擎";
Name: "Voices\VVTTS"; Types: Full default custom; Description: "VVTTS 语音引擎"
Name: "Voices\VVTTS\IBMTTS"; Types: Full default custom; Description: "IBMTTS 语音引擎（VVTTS 插件版）"
Name: "Voices\AiSound5"; Types: Full custom; Description: "AiSound5 语音引擎"
Name: "Voices\WorldVoice"; Types: Full default custom; Description: "WorldVoice （Vocalizer Expressive 语音）"
Name: "Addons"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "可选插件"
Name: "Addons\Access8Math"; Types: Full custom; Flags: disablenouninstallwarning; Description: "Access8Math"

Name: "Addons\addonsHelp"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "插件文档"
Name: "Addons\addonsTools"; Types: Full custom; Flags: disablenouninstallwarning; Description: "插件管理工具箱"
Name: "Addons\addonUpdater"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "插件更新器"
Name: "Addons\audioManager"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "音频管理器"; MinVersion: 10.0
Name: "Addons\baiduTranslation"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "百度翻译"
Name: "Addons\clipboardEnhancement"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "剪贴板朗读增强"
Name: "Addons\DragAndDrop"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "DragAndDrop （对象拖放）"
Name: "Addons\enhancedTouchGestures"; Types: Full custom; Flags: disablenouninstallwarning; Description: "触摸手势增强"
Name: "Addons\goldenCursor"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "金色光标"
Name: "Addons\imeExpressive"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "中文输入法支持"
Name: "Addons\inputLock"; Types: Full custom; Flags: disablenouninstallwarning; Description: "输入锁"
Name: "Addons\MSEdgeDiscardAnnouncements"; Types: Full custom; Flags: disablenouninstallwarning; Description: "禁止 Microsoft Edge UIA 通知"
Name: "Addons\NumberProcessing"; Types: Full custom; Flags: disablenouninstallwarning; Description: "数字处理"
Name: "Addons\NVDACNMirror"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "NVDA 中文社区更新镜像源"
Name: "Addons\QQEnhancement"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "PC QQ增强"
Name: "Addons\remote"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "远程支持"
Name: "Addons\resourceMonitor"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "资源监控器"
Name: "Addons\unmute"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "取消系统静音"
Name: "Addons\WakeSpeaker"; Types: Full custom; Flags: disablenouninstallwarning; Description: "唤醒扬声器"
Name: "Addons\WeChatEnhancement"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "PC微信增强"
Name: "Addons\wintenApps"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "Windows 应用增强"; MinVersion: 10.0
Name: "Addons\xyOCR"; Types: Full default custom; Flags: disablenouninstallwarning; Description: "新翼OCR"

[Tasks]
Name: "StartOnLogon"; Description: "在欢迎界面启用 NVDA"
Name: "Voices"; Description: "语音合成器设置"; Components: Settings; OnlyBelowVersion: 10.0
Name: "Voices"; Description: "语音合成器设置"; Components: Settings and Voices; Flags: Unchecked; MinVersion: 10.0
Name: "Voices\WorldVoice"; Description: "切换语音合成器到 WorldVoice"; Components: Voices\WorldVoice; Flags: exclusive Unchecked
Name: "Voices\AiSound5"; Description: "切换语音合成器到 AiSound5"; Components: Voices\AiSound5; Flags: exclusive Unchecked
Name: "Voices\IBMTTS"; Description: "切换语音合成器到 IBMTTS"; Components: Voices\VVTTS\IBMTTS; Flags: exclusive Unchecked
Name: "Voices\sapi4"; Description: "切换语音合成器到 Microsoft Speech API version 4 已使用 VVTTS 引擎"; Components: Voices\VVTTS; Flags: exclusive Unchecked
Name: "Voices\sapi5"; Description: "切换语音合成器到 Microsoft Speech API version 5"; OnlyBelowVersion: 10.0; Components: Settings; Flags: exclusive
Name: "VVTTSDicts"; Description: "导入 VVTTS 语音字典（仅用于 SAPI4）"; Components: Settings and Voices\VVTTS; Check: not FileExists(ExpandConstant('{userappdata}\NVDA\speechDicts\voiceDicts.v1\sapi4\sapi4-中文-简体_ Default (SimplifiedChinese) - IBM ViaVoice Text-to-Speech.dic'))
Name: "VVTTSDicts"; Description: "导入 VVTTS 语音字典（仅用于 SAPI4）"; Components: Settings and Voices\VVTTS; Flags: Unchecked; Check: FileExists(ExpandConstant('{userappdata}\NVDA\speechDicts\voiceDicts.v1\sapi4\sapi4-中文-简体_ Default (SimplifiedChinese) - IBM ViaVoice Text-to-Speech.dic'))
Name: "DragAndDropGestures"; Description: "修改 DragAndDrop 插件的台式机快捷键与笔记本键盘方案相同"; Components: "Addons\DragAndDrop"
Name: "DeleteProfile"; Description: "清空用户配置文件夹"; Check: FileExists(ExpandConstant('{userappdata}\NVDA\nvda.ini')); Flags: Unchecked
Name: "DeleteProfile\Backup"; Description: "备份现有 NVDA 配置"; Flags: exclusive
Name: "DeleteProfile\NoBackup"; Description: "不备份现有 NVDA 配置"; Flags: exclusive Unchecked

[code]
var
ResultCode: Integer;
procedure BackupNVDAProfile();
begin
ExtractTemporaryFile(ExtractFileName(ExpandConstant('{tmp}\7z.dll')));
ExtractTemporaryFile(ExtractFileName(ExpandConstant('{tmp}\7z.exe')));
Exec(ExpandConstant('{tmp}\7z.exe'), ' a -y -tzip "'+ ExpandConstant('{userdocs}')+ '\NVDABackup\NVDABackup.zip" "'+ ExpandConstant('{userappdata}\NVDA')+'\*"', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
end;
function ENUI: Boolean;
begin
  if MsgBox('Welcome to NVDA Lazy Edition.' #13#13 'The program has detected that the current system''s display language is not Simplified Chinese.' #13#13 'This program will not install personalized features such as settings and add-ons customized for Simplified Chinese users.' #13#13 'Click "OK" to start the NVDA original installer, or click "Cancel" to exit this program.', mbError, MB_OKCANCEL)= IDOK then
  begin
    Exec(ExpandConstant('{tmp}\Application\NVDA.exe'), '--launcher', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
  end;
  Result := False;
end;
function CHSUI: Boolean;
begin
  If not FileExists(ExpandConstant('{userappdata}\NVDA\nvda.ini')) Then
  begin
    ResultCode := SuppressibleMsgBox('欢迎使用 NVDA 懒人版。' #13#13 '本程序可自动为您安装 NVDA 主程序及部分常用插件。' #13#13 '程序检测到您未安装 NVDA 或尚未对其进行配置，您可选择快速安装模式以自动安装和配置 NVDA。' #13#13 '您要执行快速安装吗？' #13#13 '单击“是”执行快速安装，单击“否”执行高级安装，单击“取消”退出本程序。', mbConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON1, IDNO)
  end else begin
    ResultCode := SuppressibleMsgBox('欢迎使用 NVDA 懒人版。' #13#13 '本程序可自动为您安装 NVDA 主程序及部分常用插件。' #13#13 '程序检测到您的 NVDA 配置文件夹中存在 NVDA配置文件，保留该配置继续安装，某些文件可能不会被替换。' #13#13 '您要清除该配置吗？' #13#13 '单击“是”清空 NVDA 配置文件夹，单击“否”保留配置并执行高级安装，单击“取消”退出本程序。', mbConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON1, IDNO)
    If ResultCode=IDYES Then
    begin
      ResultCode := SuppressibleMsgBox('您要备份现有的 NVDA 配置吗？' #13#13 '备份的文件将被存储在 '+ ExpandConstant('{userdocs}\NVDABackup')+ ' 文件夹中。' #13#13 '单击“是”备份并清空现有配置文件夹，单击“否”直接清空现有配置文件夹，单击“取消”保留配置并执行高级安装。', mbConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON1, IDYES)
      If ResultCode=IDCANCEL Then
      begin
        ResultCode := IDNO;
      end else begin
        If ResultCode=IDYES Then
        begin
BackupNVDAProfile();
        end;
        DelTree(ExpandConstant('{userappdata}\NVDA'), True, True, True);
        ResultCode := SuppressibleMsgBox('程序已清空您现有的 NVDA 配置文件夹，现在您可选择快速安装模式以自动安装和配置 NVDA。' #13#13 '您要执行快速安装吗？' #13#13 '单击“是”执行快速安装，单击“否”执行高级安装，单击“取消”退出本程序。', mbConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON1, IDNO)
      end;
    end;
  end;
  If ResultCode=IDCANCEL Then
  begin
    Result := False;
  end else begin
    Result := True;
  end;
end;
function InitializeSetup: Boolean;
begin
  ExtractTemporaryFile(ExtractFileName(ExpandConstant('{tmp}\Application.exe')));
  if Exec(ExpandConstant('{tmp}\Application.exe'), '/VERYSILENT /NORESTART', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode) then
  begin
  if GetUILanguage = 2052 then
  begin
    result := CHSUI;
  end else begin
    Result := ENUI
  end;
  end;
end;
function ShouldSkipPage(PageID: Integer): Boolean;
begin
  If ResultCode=IDYES Then
  begin
    if PageID = wpFinished then
    begin
      result := False;
    end else begin
      result := true;
    end;
  end;
end;
procedure InitializeWizard();
begin
WizardForm.LICENSEACCEPTEDRADIO.Checked := true;
end;
procedure DeinitializeSetup();
begin
  if Exec(ExpandConstant('{tmp}\Application\NVDA.exe'), '-q', '', SW_SHOWNORMAL, ewNoWait, ResultCode) then
end;
procedure VVTTSINI();
begin
  If FileExists(ExpandConstant('{pf}\ViaVoiceTTS\ibmeci.dll')) Then
  begin
    SetIniString('ibmeci', '	dllName ', 'ibmeci.dll', ExpandConstant('{userappdata}\NVDA\nvda.ini'));
    SetIniString('ibmeci', '	TTSPath ', ExpandConstant('{pf}\ViaVoiceTTS'), ExpandConstant('{userappdata}\NVDA\nvda.ini'));
  end;
end;

[ini]
FileName: "{tmp}\Application\locale\zh_CN\gestures.ini"; Section: "globalPlugins.DragAndDrop.GlobalPlugin"; Key: "None"; String: "kb(desktop):numpad9+nvda, kb(desktop):.+nvda"; Tasks: DragAndDropGestures
FileName: "{tmp}\Application\locale\zh_CN\gestures.ini"; Section: "globalPlugins.DragAndDrop.GlobalPlugin"; Key: "mouseCursorInfo"; String: """kb:,+control+nvda"""; Tasks: DragAndDropGestures
FileName: "{tmp}\Application\locale\zh_CN\gestures.ini"; Section: "globalPlugins.DragAndDrop.GlobalPlugin"; Key: "dragAndDrop"; String: """kb:,+nvda+shift"""; Tasks: DragAndDropGestures
FileName: "{app}\NVDA.ini"; Section: "speech"; Key: "	synth "; String: " aisound"; Tasks: "Voices\AiSound5"
FileName: "{app}\NVDA.ini"; Section: "speech"; Key: "	synth "; String: " sapi4"; Tasks: "Voices\sapi4"
FileName: "{app}\NVDA.ini"; Section: "speech"; Key: "	synth "; String: " sapi5"; Tasks: "Voices\sapi5"
FileName: "{app}\NVDA.ini"; Section: "speech"; Key: "	synth "; String: " WorldVoice"; Tasks: "Voices\WorldVoice"
FileName: "{app}\NVDA.ini"; Section: "speech"; Key: "	synth "; String: " ibmeci"; Tasks: "Voices\IBMTTS"

[InstallDelete]
Type: filesandordirs; Name: "{userappdata}\NVDA\*"; Tasks: DeleteProfile\Backup; BeforeInstall: BackupNVDAProfile();
Type: filesandordirs; Name: "{userappdata}\NVDA\*"; Tasks: DeleteProfile\NoBackup
Type: filesandordirs; Name: "{app}\Addons\AiSound5"; Tasks: "not DeleteProfile"; Components: "Voices\AiSound5"
Type: filesandordirs; Name: "{app}\Addons\IBMTTS"; Tasks: "not DeleteProfile"; Components: "Voices\VVTTS\IBMTTS"
Type: filesandordirs; Name: "{app}\Addons\WorldVoice"; Tasks: "not DeleteProfile"; Components: "Voices\WorldVoice"
Type: filesandordirs; Name: "{app}\Addons\Access8Math"; Tasks: "not DeleteProfile"; Components: "Addons\Access8Math"
Type: filesandordirs; Name: "{app}\Addons\addonsHelp"; Tasks: "not DeleteProfile"; Components: "Addons\addonsHelp"
Type: filesandordirs; Name: "{app}\Addons\addonsTools"; Tasks: "not DeleteProfile"; Components: "Addons\addonsTools"
Type: filesandordirs; Name: "{app}\Addons\addonUpdater"; Tasks: "not DeleteProfile"; Components: "Addons\addonUpdater"
Type: filesandordirs; Name: "{app}\Addons\audioManager"; Tasks: "not DeleteProfile"; Components: "Addons\audioManager"
Type: filesandordirs; Name: "{app}\Addons\AudioControl"; Tasks: "not DeleteProfile"; Components: "Addons\audioManager"
Type: filesandordirs; Name: "{app}\Addons\baiduTranslation"; Tasks: "not DeleteProfile"; Components: "Addons\baiduTranslation"
Type: filesandordirs; Name: "{app}\Addons\bluetoothaudio"; Tasks: "not DeleteProfile"; Components: "Addons\WakeSpeaker"
Type: filesandordirs; Name: "{app}\Addons\WakeSpeaker"; Tasks: "not DeleteProfile"; Components: "Addons\WakeSpeaker"
Type: filesandordirs; Name: "{app}\Addons\clipboardEnhancement"; Tasks: "not DeleteProfile"; Components: "Addons\clipboardEnhancement"
Type: filesandordirs; Name: "{app}\Addons\DragAndDrop"; Tasks: "not DeleteProfile"; Components: "Addons\DragAndDrop"
Type: filesandordirs; Name: "{app}\Addons\enhancedTouchGestures"; Tasks: "not DeleteProfile"; Components: "Addons\enhancedTouchGestures"
Type: filesandordirs; Name: "{app}\Addons\goldenCursor\__pycache__"; Tasks: "not DeleteProfile"; Components: "Addons\goldenCursor"
Type: filesandordirs; Name: "{app}\Addons\goldenCursor\doc"; Tasks: "not DeleteProfile"; Components: "Addons\goldenCursor"
Type: filesandordirs; Name: "{app}\Addons\goldenCursor\globalPlugins"; Tasks: "not DeleteProfile"; Components: "Addons\goldenCursor"
Type: filesandordirs; Name: "{app}\Addons\goldenCursor\locale"; Tasks: "not DeleteProfile"; Components: "Addons\goldenCursor"
Type: files; Name: "{app}\Addons\goldenCursor\installTasks.py"; Tasks: "not DeleteProfile"; Components: "Addons\goldenCursor"
Type: files; Name: "{app}\Addons\goldenCursor\manifest.ini"; Tasks: "not DeleteProfile"; Components: "Addons\goldenCursor"
Type: filesandordirs; Name: "{app}\Addons\ime_expressive"; Tasks: "not DeleteProfile"; Components: "Addons\imeExpressive"
Type: filesandordirs; Name: "{app}\Addons\inputLock"; Tasks: "not DeleteProfile"; Components: "Addons\inputLock"
Type: filesandordirs; Name: "{app}\Addons\MSEdgeDiscardAnnouncements"; Tasks: "not DeleteProfile"; Components: "Addons\MSEdgeDiscardAnnouncements"
Type: filesandordirs; Name: "{app}\Addons\numberProcessing"; Tasks: "not DeleteProfile"; Components: "Addons\numberProcessing"
Type: filesandordirs; Name: "{app}\Addons\QQEnhancement"; Tasks: "not DeleteProfile"; Components: "Addons\QQEnhancement"
Type: filesandordirs; Name: "{app}\Addons\remote"; Tasks: "not DeleteProfile"; Components: "Addons\remote"
Type: filesandordirs; Name: "{app}\Addons\resourceMonitor"; Tasks: "not DeleteProfile"; Components: "Addons\resourceMonitor"
Type: filesandordirs; Name: "{app}\Addons\unmute"; Tasks: "not DeleteProfile"; Components: "Addons\unmute"
Type: filesandordirs; Name: "{app}\Addons\NVDACNMirror"; Tasks: "not DeleteProfile"; Components: "Addons\NVDACNMirror"
Type: filesandordirs; Name: "{app}\Addons\viyfMirror"; Tasks: "not DeleteProfile"; Components: "Addons\NVDACNMirror"
Type: filesandordirs; Name: "{app}\Addons\WeChatEnhancement"; Tasks: "not DeleteProfile"; Components: "Addons\WeChatEnhancement"
Type: filesandordirs; Name: "{app}\Addons\wintenApps"; Tasks: "not DeleteProfile"; Components: "Addons\wintenApps"
Type: filesandordirs; Name: "{app}\Addons\xyOCR"; Tasks: "not DeleteProfile"; Components: "Addons\xyOCR"
Type: files; Name: "{app}\Addons\AiSound5.json"; Tasks: "not DeleteProfile"; Components: "Voices\AiSound5"
Type: files; Name: "{app}\Addons\IBMTTS.json"; Tasks: "not DeleteProfile"; Components: "Voices\VVTTS\IBMTTS"
Type: files; Name: "{app}\Addons\WorldVoice.json"; Tasks: "not DeleteProfile"; Components: "Voices\WorldVoice"
Type: files; Name: "{app}\Addons\Access8Math.json"; Tasks: "not DeleteProfile"; Components: "Addons\Access8Math"
Type: files; Name: "{app}\Addons\addonsHelp.json"; Tasks: "not DeleteProfile"; Components: "Addons\addonsHelp"
Type: files; Name: "{app}\Addons\addonsTools.json"; Tasks: "not DeleteProfile"; Components: "Addons\addonsTools"
Type: files; Name: "{app}\Addons\addonUpdater.json"; Tasks: "not DeleteProfile"; Components: "Addons\addonUpdater"
Type: files; Name: "{app}\Addons\audioManager.json"; Tasks: "not DeleteProfile"; Components: "Addons\audioManager"
Type: files; Name: "{app}\Addons\baiduTranslation.json"; Tasks: "not DeleteProfile"; Components: "Addons\baiduTranslation"
Type: files; Name: "{app}\Addons\bluetoothaudio.json"; Tasks: "not DeleteProfile"; Components: "Addons\WakeSpeaker"
Type: files; Name: "{app}\Addons\WakeSpeaker.json"; Tasks: "not DeleteProfile"; Components: "Addons\WakeSpeaker"
Type: files; Name: "{app}\Addons\clipboardEnhancement.json"; Tasks: "not DeleteProfile"; Components: "Addons\clipboardEnhancement"
Type: files; Name: "{app}\Addons\DragAndDrop.json"; Tasks: "not DeleteProfile"; Components: "Addons\DragAndDrop"
Type: files; Name: "{app}\Addons\enhancedTouchGestures.json"; Tasks: "not DeleteProfile"; Components: "Addons\enhancedTouchGestures"
Type: files; Name: "{app}\Addons\goldenCursor.json"; Tasks: "not DeleteProfile"; Components: "Addons\goldenCursor"
Type: files; Name: "{app}\Addons\ime_expressive.json"; Tasks: "not DeleteProfile"; Components: "Addons\imeExpressive"
Type: files; Name: "{app}\Addons\inputLock.json"; Tasks: "not DeleteProfile"; Components: "Addons\inputLock"
Type: files; Name: "{app}\Addons\MSEdgeDiscardAnnouncements.json"; Tasks: "not DeleteProfile"; Components: "Addons\MSEdgeDiscardAnnouncements"
Type: files; Name: "{app}\Addons\numberProcessing.json"; Tasks: "not DeleteProfile"; Components: "Addons\numberProcessing"
Type: files; Name: "{app}\Addons\QQEnhancement.json"; Tasks: "not DeleteProfile"; Components: "Addons\QQEnhancement"
Type: files; Name: "{app}\Addons\remote.json"; Tasks: "not DeleteProfile"; Components: "Addons\remote"
Type: files; Name: "{app}\Addons\resourceMonitor.json"; Tasks: "not DeleteProfile"; Components: "Addons\resourceMonitor"
Type: files; Name: "{app}\Addons\unmute.json"; Tasks: "not DeleteProfile"; Components: "Addons\unmute"
Type: files; Name: "{app}\Addons\NVDACNMirror.json"; Tasks: "not DeleteProfile"; Components: "Addons\NVDACNMirror"
Type: files; Name: "{app}\Addons\WeChatEnhancement.json"; Tasks: "not DeleteProfile"; Components: "Addons\WeChatEnhancement"
Type: files; Name: "{app}\Addons\wintenApps.json"; Tasks: "not DeleteProfile"; Components: "Addons\wintenApps"
Type: files; Name: "{app}\Addons\xyOCR.json"; Tasks: "not DeleteProfile"; Components: "Addons\xyOCR"

[Run]
Filename: "{tmp}\Application\nvda"; Parameters: "-m --install-silent --enable-start-on-logon=True"; Tasks: "StartOnLogon"
Filename: "{tmp}\Application\nvda"; Parameters: "-m --install-silent --enable-start-on-logon=False"; Tasks: "not StartOnLogon"
Filename: "{tmp}\Application\nvda"; Parameters: "-m -s"; Flags: nowait
Filename: "{tmp}\VVTTS"; Parameters: "/S"; Components: "Voices\VVTTS and Settings"; AfterInstall: VVTTSINI();
Filename: "{tmp}\VVTTS"; Parameters: "/S"; Components: "Voices\VVTTS and not Settings"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\AiSound5*"" -aoa -o""{app}\Addons\AiSound5"""; Components: "Voices\AiSound5"
Filename: "{tmp}\7z"; Parameters: "x ""aisound.zip"" -aoa -o""{app}\Addons\AiSound5\synthDrivers"""; Components: "Voices\AiSound5"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\IBMTTS*"" -aoa -o""{app}\Addons\IBMTTS"""; Components: "Voices\VVTTS\IBMTTS"
Filename: "{tmp}\vcredist_x86"; Parameters: "/install /quiet /norestart"; Components: "Voices\WorldVoice"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\WorldVoice*"" -aoa -o""{app}\Addons\WorldVoice"""; Components: "Voices\WorldVoice"
Filename: "{tmp}\7z"; Parameters: "x ""aisound.zip"" -aoa -o""{app}\WorldVoice-workspace\aisound"""; Components: "Voices\WorldVoice"
Filename: "{tmp}\7z"; Parameters: "x ""VE.zip"" -aoa -o""{app}\WorldVoice-workspace\VE"""; Components: "Voices\WorldVoice"
Filename: "{tmp}\7z"; Parameters: "x ""voice.zip"" -aoa -o""{app}\WorldVoice-workspace"""; Components: "Voices\WorldVoice"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\Access8Math*"" -aoa -o""{app}\Addons\Access8Math"""; Components: "Addons\Access8Math"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\addonsHelp*"" -aoa -o""{app}\Addons\addonsHelp"""; Components: "Addons\addonsHelp"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\addonsTools*"" -aoa -o""{app}\Addons\addonsTools"""; Components: "Addons\addonsTools"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\addonUpdater*"" -aoa -o""{app}\Addons\addonUpdater"""; Components: "Addons\addonUpdater"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\audioManager*"" -aoa -o""{app}\Addons\audioManager"""; Components: "Addons\audioManager"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\baiduTranslation*"" -aoa -o""{app}\Addons\baiduTranslation"""; Components: "Addons\baiduTranslation"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\WakeSpeaker*"" -aoa -o""{app}\Addons\WakeSpeaker"""; Components: "Addons\WakeSpeaker"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\clipboardEnhancement*"" -aoa -o""{app}\Addons\clipboardEnhancement"""; Components: "Addons\clipboardEnhancement"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\DragAndDrop*"" -aoa -o""{app}\Addons\DragAndDrop"""; Components: "Addons\DragAndDrop"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\enhancedTouchGestures*"" -aoa -o""{app}\Addons\enhancedTouchGestures"""; Components: "Addons\enhancedTouchGestures"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\goldenCursor*"" -aoa -o""{app}\Addons\goldenCursor"""; Components: "Addons\goldenCursor"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\ime_expressive*"" -aoa -o""{app}\Addons\ime_expressive"""; Components: "Addons\imeExpressive"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\inputLock*"" -aoa -o""{app}\Addons\inputLock"""; Components: "Addons\inputLock"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\MSEdgeDiscardAnnouncements*"" -aoa -o""{app}\Addons\MSEdgeDiscardAnnouncements"""; Components: "Addons\MSEdgeDiscardAnnouncements"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\numberProcessing*"" -aoa -o""{app}\Addons\numberProcessing"""; Components: "Addons\numberProcessing"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\QQEnhancement*"" -aoa -o""{app}\Addons\QQEnhancement"""; Components: "Addons\QQEnhancement"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\remote*"" -aoa -o""{app}\Addons\remote"""; Components: "Addons\remote"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\resourceMonitor*"" -aoa -o""{app}\Addons\resourceMonitor"""; Components: "Addons\resourceMonitor"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\unmute*"" -aoa -o""{app}\Addons\unmute"""; Components: "Addons\unmute"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\NVDACNMirror*"" -aoa -o""{app}\Addons\NVDACNMirror"""; Components: "Addons\NVDACNMirror"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\WeChatEnhancement*"" -aoa -o""{app}\Addons\WeChatEnhancement"""; Components: "Addons\WeChatEnhancement"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\wintenApps*"" -aoa -o""{app}\Addons\wintenApps"""; Components: "Addons\wintenApps"
Filename: "{tmp}\7z"; Parameters: "x ""Addons\xyOCR*"" -aoa -o""{app}\Addons\xyOCR"""; Components: "Addons\xyOCR"

[Files]
Source: "Temp\Application.exe"; DestDir: "{tmp}"; Flags: dontcopy deleteafterinstall
Source: "Tools\7Zip\7z.dll"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion
Source: "Tools\7Zip\7z.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion
Source: "userConfig\nvda.ini"; DestDir: "{app}"; Components: "Settings"; Flags: ignoreversion
Source: "userConfig\sapi4-中文-简体_ Default (SimplifiedChinese) - IBM ViaVoice Text-to-Speech.dic"; DestDir: "{app}\speechDicts\voiceDicts.v1\sapi4"; Tasks: "VVTTSDicts"; Flags: ignoreversion
Source: "Resource\speech\IBM_ViaVoice_TTS_Runtime-V6.405.exe"; DestDir: "{tmp}"; DestName: "VVTTS.exe"; Flags: deleteafterinstall ignoreversion; Components: "Voices\VVTTS"
Source: "Resource\speech\aisound.zip"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion; Components: "Voices\AiSound5 or Voices\WorldVoice"
Source: "Resource\vcredist_x86.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion; Components: "Voices\WorldVoice"
Source: "Resource\speech\VE.zip"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion; Components: "Voices\WorldVoice"
Source: "Resource\speech\voice.zip"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion; Components: "Voices\WorldVoice"
Source: "Resource\Addons\AiSound5*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Voices\AiSound5"
Source: "Resource\Addons\IBMTTS*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Voices\VVTTS\IBMTTS"
Source: "Resource\Addons\WorldVoice*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Voices\WorldVoice"
Source: "Resource\Addons\Access8Math*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\Access8Math"
Source: "Resource\Addons\addonsHelp*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\addonsHelp"
Source: "Resource\Addons\addonsTools*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\addonsTools"
Source: "userConfig\nvda3208.pickle"; DestDir: "{app}"; Components: "Settings and Addons\addonUpdater"; Flags: ignoreversion
Source: "Resource\Addons\addonUpdater*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\addonUpdater"
Source: "Resource\Addons\audioManager*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\audioManager"
Source: "Resource\Addons\baiduTranslation*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\baiduTranslation"
Source: "Resource\Addons\WakeSpeaker*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\WakeSpeaker"
Source: "Resource\Addons\clipboardEnhancement*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\clipboardEnhancement"
Source: "Resource\Addons\DragAndDrop*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\DragAndDrop"
Source: "Resource\Addons\enhancedTouchGestures*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\enhancedTouchGestures"
Source: "Resource\Addons\goldenCursor*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\goldenCursor"
Source: "Resource\Addons\ime_expressive*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\imeExpressive"
Source: "Resource\Addons\inputLock*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\inputLock"
Source: "Resource\Addons\MSEdgeDiscardAnnouncements*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\MSEdgeDiscardAnnouncements"
Source: "Resource\Addons\numberProcessing*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\numberProcessing"
Source: "Resource\Addons\QQEnhancement*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\QQEnhancement"
Source: "Resource\Addons\remote*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\remote"
Source: "Resource\Addons\resourceMonitor*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\resourceMonitor"
Source: "Resource\Addons\unmute*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\unmute"
Source: "Resource\Addons\NVDACNMirror*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\NVDACNMirror"
Source: "Resource\Addons\WeChatEnhancement*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\WeChatEnhancement"
Source: "Resource\Addons\wintenApps*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\wintenApps"
Source: "Resource\Addons\xyOCR*"; DestDir: "{tmp}\Addons"; Flags: deleteafterinstall ignoreversion; Components: "Addons\xyOCR"
