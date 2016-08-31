; 脚本由 Inno Setup 脚本向导 生成！
; 有关创建 Inno Setup 脚本文件的详细资料请查阅帮助文档！

#define RELEASE_DIR "release"
#define MyAppName "Demo"
#define MyAppVersion "1.1.1.1"
#define MyAppPublisher "XXX有限公司"
#define MyAppURL "http://www.Demo.com/"
#define MyAppExeName "Demo.exe"

[Setup]
; 注: AppId的值为单独标识该应用程序。
; 不要为其他安装程序使用相同的AppId值。
; (生成新的GUID，点击 工具|在IDE中生成GUID。)
AppId={{xxxxxxxxxxxxxxx}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputBaseFilename=DemoSetupV{#MyAppVersion}
;SetupIconFile=favicon.ico  ;安装程序图标
Compression=lzma
SolidCompression=yes


;add by yale
VersionInfoCompany=http://www.Demo.com  
VersionInfoDescription=Demo  
VersionInfoVersion={#MyAppVersion}
VersionInfoCopyright=Copyright (C) XXX

;安装协议 
; LicenseFile=SetupFile\LicenseFile.txt  
;安装前查看的文本文件  
;InfoBeforeFile=SetupFile\InfoBeforeFile.txt
;安装后查看文本文件  
;InfoAfterFile=SetupFile\InfoAfterFile.txt

;end add

[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkablealone;
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkablealone

[Files]
Source: "{#RELEASE_DIR}\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#RELEASE_DIR}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; 注意: 不要在任何共享系统文件上使用“Flags: ignoreversion”

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent;Filename: "{app}\hanwang\setup.exe";
[registry]

Root:HKLM;Subkey:SOFTWARE\{#MyAppName};ValueType: string; ValueName:installDir;ValueData:{app};Flags: uninsdeletevalue
Root:HKLM;Subkey:SOFTWARE\{#MyAppName};ValueType: string; ValueName:mainExePath;ValueData:{app}\{#MyAppExeName};Flags: uninsdeletevalue
Root:HKLM;Subkey:SOFTWARE\{#MyAppName};ValueType: string; ValueName:uninstallExePath;ValueData:{app}\unins000.exe;Flags: uninsdeletevalue
Root:HKLM;Subkey:SOFTWARE\{#MyAppName};ValueType: string; ValueName:uploadPath;ValueData:{commondocs}\{#MyAppName}\Data;Flags: uninsdeletevalue

[dirs]
Name:"{commondocs}\{#MyAppName}\Data"
Name:"{app}\upload"

[Code]
var HasRun:HWND;

function InitializeSetup():Boolean;
begin
  Result := true;
  HasRun := FindWindowByWindowName('Demo');
  while HasRun<>0 do
  begin
    if MsgBox('安装程序检测到你的应用程序正在运行。' #13#13 '您必须先关闭它然后单击“是”继续安装，或按“否”退出！', mbConfirmation, MB_YESNO) = idNO then
    begin
      Result := false;
      HasRun := 0;
    end
    else
    begin
      Result := true;
      HasRun := FindWindowByWindowName('Demo');
    end;
  end;
end;


function InitializeUninstall(): Boolean;
begin
  HasRun := FindWindowByWindowName('Demo');
  if HasRun<>0 then
  begin
    MsgBox('卸载程序检测到你的应用程序正在运行。' #13#13 '请先退出你的应用程序，然后再进行卸载！', mbError, MB_OK);
    Result := false;
  end
  else
    Result := true;
end;


procedure InitializeWizard();
var ResultStr:String;
    ResultCode:Integer;
begin
  if RegQueryStringValue(HKLM,'SOFTWARE\Demo',
     'uninstallExePath',ResultStr) then
     begin
     ResultStr :=RemoveQuotes(ResultStr);
     MsgBox('您曾安装过本软件，即将卸载老版本！', mbInformation, MB_OK);
     Exec(ResultStr,'','',SW_SHOWNORMAL, ewWaitUntilTerminated,ResultCode);
     end;
   end;