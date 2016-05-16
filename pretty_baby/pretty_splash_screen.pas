unit pretty_splash_screen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { Tpretty_splash }

  Tpretty_splash = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  pretty_splash: Tpretty_splash;

implementation

{$R *.lfm}

{ Tpretty_splash }

procedure Tpretty_splash.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
     CloseAction := caFree;
end;

end.

