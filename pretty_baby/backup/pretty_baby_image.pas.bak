unit pretty_baby_image;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, uESelector, uEKnob, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus, StdCtrls, ExtDlgs, Types, magick_wand, ImageMagick;

type

  { Tpretty_image_frm }

  Tpretty_image_frm = class(TForm)
    MenuItem1: TMenuItem;
    baby_images_tile: TMenuItem;
    baby_images_untile: TMenuItem;
    MenuItem2: TMenuItem;
    image_zoom: TMenuItem;
    cascade_cycle: TMenuItem;
    save_item: TMenuItem;
    open_image_windows: TMenuItem;
    pretty_image: TImage;
    pretty_image_frm_pop: TPopupMenu;
    SavePictureDialog1: TSavePictureDialog;
    ScrollBox1: TScrollBox;
    procedure baby_images_tileClick(Sender: TObject);
    procedure baby_images_untileClick(Sender: TObject);
    procedure cascade_cycleClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure image_zoomClick(Sender: TObject);
    procedure save_itemClick(Sender: TObject);
    procedure pretty_imageClick(Sender: TObject);
    procedure pretty_imageDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure pretty_imageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FDragging: Boolean;
    FFrom: TPoint;
    FOrgImgBounds: TRect;
  public
    last_left : integer;
    last_top : integer;
    is_cycling : boolean;
  end;

var
  pretty_image_frm: Tpretty_image_frm;

const
  five = 5;
  ten = 10;


implementation

{$R *.lfm}

uses
  pretty_baby_main , pretty_baby_basket , pretty_baby_image_list , pretty_baby_image_manip;

{ Tpretty_image_frm }

procedure Tpretty_image_frm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
var
   idx : integer;
   str : string;
   i : integer;
   frm_name : string;
begin

     str := frm_pretty_baby_main.current_image.Hint;
     for idx := 0 to frm_pretty_baby_main.pretty_image_toolbar.ButtonCount - 1 do
     begin
          if frm_pretty_baby_main.pretty_image_toolbar.Buttons[idx].Caption = Caption then
          begin
             frm_pretty_baby_main.pretty_image_toolbar.Buttons[idx].Destroy;
             frm_pretty_baby_main.pretty_image_toolbar.Invalidate;
             if frm_pretty_baby_main.pretty_image_toolbar.ButtonCount = 0 then
                frm_pretty_baby_main.pretty_image_toolbar.Visible := false;
             break;
          end;
     end;


     frm_pretty_baby_main.current_image.Hint := str;
     str := Caption;
     with frm_image_list.image_strings do
     begin
        try
           for i := 0 to Items.Count - 1 do
           begin
               if Items[i] = str then
               begin
                 idx := i;
                 break;
               end;
           end;
           if idx <> -1 then Items.Delete( idx );
          except
            //
          end;
     end;
     CloseAction := caFree;
end;

procedure Tpretty_image_frm.FormClick(Sender: TObject);
begin
   pretty_image.BoundsRect := FOrgImgBounds;
end;

procedure Tpretty_image_frm.baby_images_tileClick(Sender: TObject);
var
   i : integer;
   lft : integer;
   tp : integer;
begin
      i := 0;
      tp := 0;
      lft := 0;
      for i := 0 to Screen.FormCount - 1 do
        if ( Screen.Forms[i] is Tpretty_image_frm ) then
        begin
          with Tpretty_image_frm( Screen.Forms[i] ) do
          begin
              try
                 last_left := left;
                 last_top := top;
                 Tpretty_image_frm( Screen.Forms[i]  ).Left := ClientRect.Left + lft;
                 Tpretty_image_frm( Screen.Forms[i]  ).Top := ClientRect.Top + tp;
                 lft := lft + 25;
                 tp := tp + 15;
                 Tpretty_image_frm( Screen.Forms[i]  ).BringToFront;
                 baby_images_untile.Enabled := true;
                 frm_pretty_baby_main.untile_click.Enabled := true;
               except
                 //
              end;

          end;
        end;

end;

procedure Tpretty_image_frm.baby_images_untileClick(Sender: TObject);
var
   i : integer;
begin
       for i := 0 to Screen.FormCount - 1 do
        if ( Screen.Forms[i] is Tpretty_image_frm ) then
        begin
          with Tpretty_image_frm( Screen.Forms[i] ) do
          begin
               Tpretty_image_frm( Screen.Forms[i]  ).Left := last_left;
               Tpretty_image_frm( Screen.Forms[i]  ).Top := last_top;
               Tpretty_image_frm( Screen.Forms[i]  ).BringToFront;
               baby_images_untile.Enabled := false;
               frm_pretty_baby_main.untile_click.Enabled := false;
          end;
        end;
end;

procedure Tpretty_image_frm.cascade_cycleClick(Sender: TObject);
var
   i : integer;
begin
     frm_pretty_baby_main.slide_show_stop_btnClick( Sender );
     baby_images_tileClick( Sender );
     for i := 0 to Screen.FormCount - 1 do
         begin
               Application.ProcessMessages;
               if ( Screen.Forms[i] is Tpretty_image_frm ) then
                  Tpretty_image_frm( Screen.Forms[i] ).is_cycling := true;
         end;


      begin
           frm_pretty_baby_main.slide_led.Color := clNavy;
           frm_pretty_baby_main.led_timer.Enabled := true;
           for i := 0 to Screen.FormCount - 1 do
           begin
                 Application.ProcessMessages;
                 if ( Screen.Forms[i] is Tpretty_image_frm ) then
                 begin
                    if  Tpretty_image_frm( Screen.Forms[i] ).is_cycling = false then exit;
                    with Tpretty_image_frm( Screen.Forms[i] ) do
                    begin
                        sleep( 1500 );
                        Tpretty_image_frm( Screen.Forms[i] ).Invalidate;
                        Tpretty_image_frm( Screen.Forms[i] ).BringToFront;
                        Application.ProcessMessages;
                    end;
                 end;
           end;
           frm_pretty_baby_main.led_timer.Enabled := false;
           frm_pretty_baby_main.slide_led.Visible := false;
           pretty_imageClick( Sender );
      end;
end;

procedure Tpretty_image_frm.FormCreate(Sender: TObject);
begin

     DoubleBuffered := True;
     ScrollBox1.DoubleBuffered:= true;
     is_cycling := false;
     if length( frm_pretty_baby_main.current_image.Hint ) <> 0 then
     begin

       with pretty_image do
       begin
            Picture.LoadFromFile( frm_pretty_baby_main.current_image.Hint );
            Hint := frm_pretty_baby_main.current_image.Hint;
            Height := Round( Width * Picture.Height / Picture.Width);
            FOrgImgBounds := BoundsRect;
            Stretch := True;
       end;
       caption := frm_pretty_baby_main.current_url;
       left := 0;
       top := ClientRect.Bottom + height;


     end;
end;

procedure Tpretty_image_frm.FormDblClick(Sender: TObject);
begin
     pretty_image.BoundsRect := FOrgImgBounds;
end;

procedure Tpretty_image_frm.image_zoomClick(Sender: TObject);
var
   bmp : TBitmap;
   aWidth , aHeight , aLeft , aTop:integer;
begin
    aWidth:= 500;
    aHeight:= 500;
    aTop:=  30;
    aLeft:=  40;
    bmp:=TBitmap.Create;
    bmp.Width:=aHeight;
    bmp.Height:=aWidth;
    bmp.Canvas.CopyRect(Rect(0,0,aWidth,aHeight),pretty_image.Picture.Bitmap.Canvas,Rect(aLeft,aTop,aLeft+aWidth, aTop+aHeight));
    pretty_image.Picture.Bitmap.SetSize(pretty_image.Width,pretty_image.Height);
    pretty_image.Picture.Bitmap.Canvas.StretchDraw(Rect(0,0,pretty_image.Picture.Bitmap.Width,pretty_image.Picture.Bitmap.Height),bmp);
    bmp.free;
end;

procedure Tpretty_image_frm.save_itemClick(Sender: TObject);
begin
     SavePictureDialog1.FileName := pretty_image.Hint;
     if SavePictureDialog1.Execute then
     begin
         pretty_image.Picture.SaveToFile( SavePictureDialog1.FileName );
     end;
end;

procedure Tpretty_image_frm.pretty_imageClick(Sender: TObject);
var
   i : integer;
begin
      for i := 0 to Screen.FormCount - 1 do
         begin
               Application.ProcessMessages;
               if ( Screen.Forms[i] is Tpretty_image_frm ) then
               begin
                  Tpretty_image_frm( Screen.Forms[i] ).is_cycling := false;
               end;
         end
end;

procedure Tpretty_image_frm.pretty_imageDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

procedure Tpretty_image_frm.pretty_imageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
      if Button = mbLeft then
      begin
             TImage( Sender ).BeginDrag( true );
             frm_pretty_baby_main.current_url := Caption;
      end;
end;

end.

