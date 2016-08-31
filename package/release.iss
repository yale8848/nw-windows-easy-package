; �ű��� Inno Setup �ű��� ���ɣ�
; �йش��� Inno Setup �ű��ļ�����ϸ��������İ����ĵ���

#define RELEASE_DIR "release"
#define MyAppName "Demo"
#define MyAppVersion "1.1.1.1"
#define MyAppPublisher "XXX���޹�˾"
#define MyAppURL "http://www.Demo.com/"
#define MyAppExeName "Demo.exe"

[Setup]
; ע: AppId��ֵΪ������ʶ��Ӧ�ó���
; ��ҪΪ������װ����ʹ����ͬ��AppIdֵ��
; (�����µ�GUID����� ����|��IDE������GUID��)
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
;SetupIconFile=favicon.ico  ;��װ����ͼ��
Compression=lzma
SolidCompression=yes


;add by yale
VersionInfoCompany=http://www.Demo.com  
VersionInfoDescription=Demo  
VersionInfoVersion={#MyAppVersion}
VersionInfoCopyright=Copyright (C) XXX

;��װЭ�� 
; LicenseFile=SetupFile\LicenseFile.txt  
;��װǰ�鿴���ı��ļ�  
;InfoBeforeFile=SetupFile\InfoBeforeFile.txt
;��װ��鿴�ı��ļ�  
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
; ע��: ��Ҫ���κι���ϵͳ�ļ���ʹ�á�Flags: ignoreversion��

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
    if MsgBox('��װ�����⵽���Ӧ�ó����������С�' #13#13 '�������ȹر���Ȼ�󵥻����ǡ�������װ���򰴡����˳���', mbConfirmation, MB_YESNO) = idNO then
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
    MsgBox('ж�س����⵽���Ӧ�ó����������С�' #13#13 '�����˳����Ӧ�ó���Ȼ���ٽ���ж�أ�', mbError, MB_OK);
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
     MsgBox('������װ�������������ж���ϰ汾��', mbInformation, MB_OK);
     Exec(ResultStr,'','',SW_SHOWNORMAL, ewWaitUntilTerminated,ResultCode);
     end;
   end;