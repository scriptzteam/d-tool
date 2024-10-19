library Rushmirc;

{

Example about using invoke:

/ftprushinfo {
  %ftpdown = $dll(rushmirc.dll,Invoke,RushApp.TotalDownloadSize)
  %ftpup = $dll(rushmirc.dll,Invoke,RushApp.TotalUploadSize)
  %ftpfxp = $dll(rushmirc.dll,Invoke,RushApp.TotalFXPSize)
  %ftpdownc = $dll(rushmirc.dll,Invoke,RushApp.CurDownloadSize)
  %ftpupc = $dll(rushmirc.dll,Invoke,RushApp.CurUploadSize)
  %ftpfxpc = $dll(rushmirc.dll,Invoke,RushApp.CurFXPSize)
  %ftpstart = $dll(rushmirc.dll,Invoke,RushApp.StartDate)
  %ftpday = $dll(rushmirc.dll,Invoke,RushApp.DayCount)
  %rushver = $dll(rushmirc.dll,Invoke,RushApp.Version)
  %rushpool = $dll(rushmirc.dll,Invoke,RushApp.PoolInfo)
  %rushcontainer = $dll(rushmirc.dll,Invoke,RushApp.Containers.ContainerCount);
  %rushconn = $dll(rushmirc.dll,Invoke,RushApp.Containers.ConnectedSiteCount);
  %rushtran = $dll(rushmirc.dll,Invoke,RushApp.Containers.TransferSiteCount);
  %rushbwu = $dll(rushmirc.dll,Invoke,RushApp.UploadBW);
  %rushbwd = $dll(rushmirc.dll,Invoke,RushApp.DownloadBW);

  echo %rushver
  echo Thread Pool: %rushpool
  echo BandWidth_up: %rushbwu kbps, Bandwidth_dn: %rushbwd kbps
  echo Container: %rushcontainer , Connected: %rushconn , Transfering: %rushtran
  echo from %ftpstart , total %ftpday day. I downloaded %ftpdown MB, uploaded %ftpup MB, FXPed %ftpfxp MB
  echo This Session I downloaded %ftpdownc MB, Uploaded %ftpupc MB, FXPed %ftpfxpc MB
}

uses
  SysUtils, Messages,
  Windows,
  Classes,
  Forms;

{$R *.RES}
type
  TLoadInfo = packed record
    mVersion: DWORD;
    mHwnd: HWND;
    mKeep: Boolean;
  end;
  PLoadInfo = ^TLoadInfo;

  TCallbackWindow = class
  private
    fWindowHandle: HWnd;
    fIrcHandle: HWnd;

    fhIrcFileMap: THandle;
    fpIrcFileMapData: pchar;
  protected
    procedure WndProc(var Msg: TMessage);
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  SaveExit                              : Pointer;

  hFileView                             : PChar;
  hFileMap                              : THandle;

  wCallbackWindow                       : TCallbackWindow;

  bEnableCallback                       : boolean;

  //begin tmuk change
  MircCmd                               : string;
  //end tmuk change

const
  WM_EXCHANGE                           = WM_USER + 300;

procedure LoadDll(LoadInfo: PLoadInfo); stdcall; export;
begin
  // Tells mIRC to keep our DLL loaded
  LoadInfo.mKeep := TRUE;
  hFileMap := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, 4096, 'FTPRush');
  hFileView := MapViewOfFile(hFileMap, FILE_MAP_ALL_ACCESS, 0, 0, 0);

  wCallbackWindow := TCallbackWindow.Create;

  bEnableCallback := TRUE;
  MircCmd := '/echo -a';
end;

function UnloadDll(mTimeOut: integer): Integer; stdcall; export;
begin
  if mTimeout = 1 then
  begin
    Result := 0;
    exit;
  end;
  UnmapViewOfFile(hFileView);
  CloseHandle(hFileMap);
  FreeAndNil(wCallbackWindow);
  Result := 1;
end;

function Invoke(mWnd: hWnd; aWnd: hWnd; Data: PChar; Parms: PChar;
  Show: Boolean; NoPause: Boolean): Integer; export; stdcall;
var
  TargetWindow                          : THandle;
begin
  TargetWindow := FindWindow('TfmRush', nil);
  if IsWindow(TargetWindow) then
  begin
    StrCopy(hFileview, Data);
    SendMessage(TargetWindow, WM_EXCHANGE, 0, 0);
    StrCopy(Data, hFileView);
    Result := 3;
  end else
    Result := 1;
end;

function RushScript(mWnd: hWnd; aWnd: hWnd; Data: PChar; Parms: PChar;
  Show: Boolean; NoPause: Boolean): Integer; export; stdcall;
var
  CopyDataStruct                        : TCopyDataStruct;
  TargetWindow                          : THandle;
begin
  TargetWindow := FindWindow('TfmRush', nil);
  if IsWindow(TargetWindow) then
  begin
    CopyDataStruct.dwData := 1000;
    CopyDataStruct.cbData := strlen(Data) + 1;
    CopyDataStruct.lpData := Data;
    wCallbackWindow.fIrcHandle := mWnd;
    if bEnableCallback then
      SendMessage(TargetWindow, WM_COPYDATA, wCallbackWindow.fWindowHandle, LParam(@CopyDataStruct))
    else
      SendMessage(TargetWindow, WM_COPYDATA, 0, LParam(@CopyDataStruct));
  end;
  Result := 1;
end;

function EnableCallback(mWnd: hWnd; aWnd: hWnd; Data: PChar; Parms: PChar;
  Show: Boolean; NoPause: Boolean): Integer; export; stdcall;
begin
  bEnableCallback := True;
  Result := 1;
end;

function DisableCallback(mWnd: hWnd; aWnd: hWnd; Data: PChar; Parms: PChar;
  Show: Boolean; NoPause: Boolean): Integer; export; stdcall;
begin
  bEnableCallback := False;
  Result := 1;
end;

function RushCommand(mWnd: hWnd; aWnd: hWnd; Data: PChar; Parms: PChar;
  Show: Boolean; NoPause: Boolean): Integer; export; stdcall;
var
  CopyDataStruct                        : TCopyDataStruct;
  TargetWindow                          : THandle;
begin
  TargetWindow := FindWindow('TfmRush', nil);
  if IsWindow(TargetWindow) then
  begin
    CopyDataStruct.dwData := 1001;
    CopyDataStruct.cbData := strlen(Data) + 1;
    CopyDataStruct.lpData := Data;
    SendMessage(TargetWindow, WM_COPYDATA, 0, LParam(@CopyDataStruct));
  end;
  Result := 1;
end;

function SetMircCmd(mWnd: hWnd; aWnd: hWnd; Data: PChar; Parms: PChar;
  Show: Boolean; NoPause: Boolean): Integer; export; stdcall;
begin
  MircCmd := Data;
  Result := 1;
end;


procedure LibExit;
begin
  ExitProc := SaveExit; // restore exit procedure chain
end;

exports
  LoadDll,
  UnloadDll,
  RushScript,
  RushCommand,
  Invoke,
  SetMircCmd,
  EnableCallback,
  DisableCallback;
{ TCallbackWindow }

constructor TCallbackWindow.Create;
begin
  fWindowHandle := AllocateHWnd(WndProc);

  FhIrcFileMap := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, 4096, 'mIRC');
  FpIrcFileMapData := MapViewOfFile(FhIrcFileMap, FILE_MAP_ALL_ACCESS, 0, 0, 0);
end;

destructor TCallbackWindow.Destroy;
begin
  DeallocateHWnd(fWindowHandle);
  UnmapViewOfFile(FpIrcFileMapData);
  CloseHandle(FhIrcFileMap);
  inherited;
end;

const {Store at WM_COPYDATA Message: wParam}
  FTPRUSH_CALLBACK_RAWCOMMAND           = 888; //THIS IS FROM FTP.RAW

const {Store at WM_COPYDATA Struct : dwData}
  CALLBACK_SUCCESS                      = 1;
  CALLBACK_FAILED                       = 0;

const
  ctrlLink                              = #10; // link
  ctrlb                                 = #2; // bold
  ctrlc                                 = #3; // color
  ctrld                                 = #4; // bersirc (RGB) color
  ctrlo                                 = #15; // normal
  ctrlq                                 = #17; // fixed width font
  ctrlr                                 = #18; // switch fg/bg
  ctrlv                                 = #22; // italics
  ctrl_                                 = #31; // underline

procedure TCallbackWindow.WndProc(var Msg: TMessage);
var
  pCopyDataStruct                       : ^CopyDataStruct;
  LLines                                : TStringList;
  LSiteName                             : string;
  LRawCommand                           : string;
  I                                     : Integer;

  procedure SendMessageTomIRC(const AMessageLine: string);
  begin
    StrPCopy(FpIrcFileMapData, AMessageLine);
    SendMessage(fIrcHandle, WM_USER + 200, 1, 0);
  end;
begin
  case Msg.Msg of //
    WM_COPYDATA:
      begin
        LLines := TStringList.Create;
        try

          case Msg.WParam of //
            FTPRUSH_CALLBACK_RAWCOMMAND:
              begin
                pCopyDataStruct := pointer(Msg.LParam);
                LLines.Text := PChar(pCopyDataStruct^.lpData);

                if pCopyDataStruct^.dwData = CALLBACK_SUCCESS then
                begin
                  { When Success,
                    first line is sitename,
                    second line is the raw command,
                    other lines are FTP raw command result
                  }
                  if LLines.Count > 0 then
                  begin
                    LSiteName := LLines.Strings[0];
                    if LLines.Count > 1 then
                      LRawCommand := LLines.Strings[1];

                    //Send Command to mirc
                    SendMessageTomIRC(MircCmd + ' ' + Format('(%s) '#2'%s', [LSiteName, LRawCommand]));

                    for I := 2 to LLines.Count - 1 do
                      SendMessageTomIRC(MircCmd + ' ' + Format('(%s) %s', [LSiteName, LLines.Strings[I]]));

                  end;

                end;
              end;
          end; // case

        finally
          LLines.Free;
        end;
      end;
  end; // case
  Msg.Result := 1;
end;

begin
  SaveExit := ExitProc; // save exit procedure chain
  ExitProc := @LibExit; // install LibExit exit procedure
end.

