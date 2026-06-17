; Inno Setup script - installs the "Tutorial Gain" SynthEdit module (.gmpi) into
; SynthEdit's modules folder. Built in CI by .github/workflows/build-module.yml:
;
;     ISCC.exe /DAppVersion=1.0.0 installer\windows\gain.iss
;
; A GMPI module on Windows is a single Gain.gmpi file (a renamed DLL). SynthEdit
; scans its modules folder recursively, so we install into a per-vendor subfolder.

#ifndef AppVersion
  #define AppVersion "0.0.0"
#endif
#define ModuleName "Tutorial Gain"
#define Vendor "SynthEdit Tutorial"

[Setup]
AppId={{C7A9E2F1-4B6D-4E83-9A2C-1F5E8D3B7A04}
AppName={#ModuleName} (SynthEdit module)
AppVersion={#AppVersion}
AppPublisher={#Vendor}
AppPublisherURL=https://synthedit.com/
DefaultDirName={commoncf}\SynthEdit\modules\{#Vendor}
DisableDirPage=yes
DisableProgramGroupPage=yes
UsePreviousAppDir=no
OutputDir=out
OutputBaseFilename=TutorialGain-{#AppVersion}-Windows
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
WizardStyle=modern
PrivilegesRequired=admin
LicenseFile=..\..\assets\license.txt
UninstallDisplayName={#ModuleName} module {#AppVersion}

[Files]
Source: "..\..\build\Gain\Release\Gain.gmpi"; DestDir: "{app}"; Flags: ignoreversion

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Messages]
WelcomeLabel2=This installs the {#ModuleName} module into SynthEdit's modules folder.%n%nPlease close SynthEdit before continuing.
