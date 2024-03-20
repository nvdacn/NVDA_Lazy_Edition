[Setup]
;修改下两行等号后面的值为NVDA安装程序对应的版本号
VersionInfoVersion=2023.3.0.29780
AppVersion=2023.3
AppName=NVDA
AppVerName=NVDA
DefaultDirName={src}\Application
AllowNoIcons=yes
OutputDir=.
OutputBaseFilename=Application
Compression=lzma
SolidCompression=yes
MinVersion=6.03
DisableDirPage=Yes
DisableProgramGroupPage=yes
DisableFinishedPage=Yes
DisableReadyPage=yes
AppendDefaultDirName=No
DirExistsWarning=No
Uninstallable=No
LicenseFile=Application\documentation\copying.txt
SetupIconFile=Application\images\nvda.ico
AllowCancelDuringInstall=No
ShowLanguageDialog=No

[code]
procedure InitializeWizard();
begin
WizardForm.LICENSEACCEPTEDRADIO.Checked := true;
end;
procedure CancelButtonClick ( CurPageID : Integer; var Cancel, Confirm: Boolean); 
begin
Confirm:=false
end;
function UILanguage(): Boolean;
begin
  if GetUILanguage = 2052 then
  begin
    Result := True;
  end else begin
    Result := False;
  end;
end;

[Languages]
Name: "english"; MessagesFile: "compiler:Languages\English.isl"
Name: "chinesesimp"; MessagesFile: "compiler:Default.isl"

[Run]
Filename: "{app}\nvda"; Parameters: "-m -s"; Flags: nowait

[ini]
FileName: "{app}\userConfig\NVDA.ini"; Section: "speech"; Key: "	synth "; String: " sapi5"; MinVersion: 6.01; OnlyBelowVersion: 6.04; Check: UILanguage
FileName: "{app}\userConfig\NVDA.ini"; Section: "speech"; Key: "	synth "; String: " oneCore"; MinVersion: 6.04; Check: UILanguage
FileName: "{app}\userConfig\NVDA.ini"; Section: "keyboard"; Key: "	useCapsLockAsNVDAModifierKey "; String: " True"; Check: UILanguage

[Files]
Source: "Application\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "userConfig\nvda.ini"; DestDir: "{app}\userConfig"; Flags: ignoreversion; Check: UILanguage
