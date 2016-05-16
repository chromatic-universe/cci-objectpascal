unit pretty_progress;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls;

type

  { Tpretty_status }

  Tpretty_status = class(TForm)
    pretty_progress: TProgressBar;
    standby_timer: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure standby_timerTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  pretty_status: Tpretty_status;

implementation

{$R *.lfm}

{ Tpretty_status }

procedure Tpretty_status.FormActivate(Sender: TObject);
begin

end;

procedure Tpretty_status.standby_timerTimer(Sender: TObject);
var
   pos : integer;
begin
     pos := pretty_progress.Position + pretty_progress.Step;
     if  pos >= pretty_progress.Max then pos := 0;
     pretty_progress.Position := pos;

end;

end.

