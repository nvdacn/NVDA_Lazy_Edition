#define BaseVersion GetDateTimeString('yyyy.mm.dd', '.', '')
#define BuildNumber GetEnv("GITHUB_RUN_NUMBER")
#define FinalVersion BaseVersion + '.' + BuildNumber

[Setup]
VersionInfoVersion={#FinalVersion}
AppName=NVDA
AppVerName=NVDA
AppPublisher=NVDACN
AppPublisherURL=https://www.nvdacn.com/
AppSupportURL=https://github.com/nvdacn/NVDA_Lazy_Edition
AppUpdatesURL=https://github.com/nvdacn/NVDA_Lazy_Edition/releases
DefaultDirName={src}\NVDAPortable
AllowNoIcons=yes
OutputDir=..\Build\Temp
OutputBaseFilename=NVDAPortable
Compression=lzma2/max
SolidCompression=yes
MinVersion=10.0
ArchitecturesAllowed=x64 arm64
DisableDirPage=Yes
DisableProgramGroupPage=yes
DisableFinishedPage=Yes
DisableReadyPage=yes
AppendDefaultDirName=No
DirExistsWarning=No
Uninstallable=No
SetupIconFile=..\Build\Temp\NVDA\images\nvda.ico
WizardImageFile=..\userConfig\Image.bmp
WizardSmallImageFile=..\userConfig\Image.bmp
LicenseFile=..\Build\Temp\NVDA\documentation\copying.txt
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
Filename: "{app}\nvda"; Parameters: "-ms"; Flags: nowait

[ini]
FileName: "{app}\userConfig\NVDA.ini"; Section: "keyboard"; Key: "	NVDAModifierKeys "; String: " 7"; Check: UILanguage

[Files]
Source: "..\Build\Temp\NVDA\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\userConfig\nvda.ini"; DestDir: "{app}\userConfig"; Flags: ignoreversion; Check: UILanguage
