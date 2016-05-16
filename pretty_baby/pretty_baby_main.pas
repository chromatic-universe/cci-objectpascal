unit pretty_baby_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, thumbcontrol, Forms, Controls, Graphics, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, ShellCtrls, baseunix, Menus, Buttons,
  XMLPropStorage, threadedimageLoader, ueled, uESelector, types, unix, strutils,
  XMLConf, PropertyStorage, IniPropStorage, ExtDlgs;

type

  { Tfrm_pretty_baby_main }

  Tfrm_pretty_baby_main = class(TForm)
    current_image: TImage;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    red_picture: TImage;
    ImageList1: TImageList;
    MenuItem7: TMenuItem;
    image_pop_close: TMenuItem;
    about_pretty_baby: TMenuItem;
    Panel7: TPanel;
    pretty_list_view: TListBox;
    MenuItem4: TMenuItem;
    open_ui_config: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    save_ui_config: TMenuItem;
    phony_list: TListBox;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    image_popup: TPopupMenu;
    image_popup_new: TMenuItem;
    baskets_click: TMenuItem;
    image_bundle: TMenuItem;
    image_transmogrify: TMenuItem;
    image_close: TMenuItem;
    MenuItem3: TMenuItem;
    image_close_all: TMenuItem;
    grab_first_image: TMenuItem;
    grab_first_five: TMenuItem;
    grab_first_ten: TMenuItem;
    image_bookmark: TMenuItem;
    thumb_view: TThumbControl;
    up_one_directory_btn: TSpeedButton;
    thumb_pop_random: TMenuItem;
    thumb_bookmark: TMenuItem;
    pretty_bookmark: TMenuItem;
    thumb_grab: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    PopupMenu1: TPopupMenu;
    thumb_pop: TPopupMenu;
    pretty_maintinance: TMenuItem;
    pretty_help: TMenuItem;
    open_an_image: TMenuItem;
    menu_images: TMenuItem;
    open_images_click: TMenuItem;
    open_images: TToolButton;
    Panel6: TPanel;
    pretty_baby_tray: TTrayIcon;
    led_timer: TTimer;
    slide_led: TuELED;
    pretty_tree_view: TTreeView;
    untile_click: TMenuItem;
    tile_click: TMenuItem;
    pretty_bookmark_pop: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    pretty_images_popup: TPopupMenu;
    pretty_images: TImageList;
    openDialog: TOpenDialog;
    Panel3: TPanel;
    pretty_panel: TPanel;
    SpeedButton1: TSpeedButton;
    slide_show_start_btn: TSpeedButton;
    slide_show_stop_btn: TSpeedButton;
    slide_show_pause_btn: TSpeedButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    status_bar: TStatusBar;
    pretty_tool: TToolBar;
    open_btn: TToolButton;
    new_window_btn: TToolButton;
    slide_show_timer: TTimer;
    slide_track: TTrackBar;
    baby_basket_btn: TToolButton;
    pretty_image_toolbar: TToolBar;
    url_timer: TTimer;
    pretty_props: TXMLPropStorage;
    xml_config: TXMLConfig;
    procedure about_pretty_babyClick(Sender: TObject);
    procedure baby_basket_btnClick(Sender: TObject);
    procedure current_imageDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure current_imageDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure current_imageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure current_imageMouseEnter(Sender: TObject);
    procedure current_imageMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure current_imageMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure current_imagePaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grab_first_fiveClick(Sender: TObject);
    procedure grab_first_tenClick(Sender: TObject);
    procedure image_close_allClick(Sender: TObject);
    procedure image_pop_closeClick(Sender: TObject);
    procedure led_timerTimer(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure menu_imagesClick(Sender: TObject);
    procedure open_btnClick(Sender: TObject);
    procedure new_window_btnClick(Sender: TObject);
    procedure pretty_baby_trayDblClick(Sender: TObject);
    procedure pretty_bookmarkClick(Sender: TObject);
    procedure pretty_bookmark_popClick(Sender: TObject);
    procedure pretty_list_viewClick(Sender: TObject);
    procedure pretty_list_viewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pretty_tree_viewChange(Sender: TObject; Node: TTreeNode);
    procedure slide_show_pause_btnClick(Sender: TObject);
    procedure slide_show_timerStartTimer(Sender: TObject);
    procedure slide_show_timerStopTimer(Sender: TObject);
    procedure slide_show_timerTimer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure slide_show_start_btnClick(Sender: TObject);
    procedure slide_show_stop_btnClick(Sender: TObject);
    procedure thumb_pop_randomClick(Sender: TObject);
    procedure thumb_viewDblClick(Sender: TObject);
    procedure thumb_viewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure thumb_viewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure thumb_viewSelectItem(Sender: TObject; Item: TThreadedImage);
    procedure open_imagesClick(Sender: TObject);
    procedure tree_timerTimer(Sender: TObject);
    procedure url_timerTimer(Sender: TObject);
    procedure stop_slide_show(Sender: TObject);
    procedure image_btn_click( Sender : TObject );
    procedure image_btn_menu_images_click( Sender : TObject );
    procedure grab_images( Sender : TObject ; idx : integer );
    procedure grab_bookmark( Sender : TObject );
    procedure clear_bookmarks( Sender : TObject );
    function GetNodeByText( ATree : TTreeView;
                            AValue:String;
                            AVisible: Boolean ): TTreeNode;
    procedure pretty_propsRestoreProperties(Sender: TObject);
  private
    url_idx : integer;
    is_slide_show : boolean;
    bookmark_init : boolean;
    root_directory : string;
    current_directory : string;
  public
    image_hit : TPoint;
    image_form_idx : integer;
    thumb_idx : integer;
    thumb_count_idx : integer;
    grab_idx : integer;
    current_url : string;
    image_form_list : TStringList;
    scroll_idx : integer;
     anode : TTreeNode;
  end;

var
  frm_pretty_baby_main: Tfrm_pretty_baby_main;

implementation

 uses
  pretty_baby_basket , pretty_baby_image ,
  pretty_baby_image_list , pretty_progress ,
  vtree_impl , pretty_splash_screen,pretty_baby_image_manip;


{$R *.lfm}

{ Tfrm_pretty_baby_main }

procedure Tfrm_pretty_baby_main.stop_slide_show(Sender: TObject);
begin
     if is_slide_show = true then
     begin
        slide_show_timer.Enabled := false;
        slide_show_start_btn.Enabled := true;
        slide_show_stop_btn.Enabled := false;
        slide_show_pause_btn.Enabled := false;
        is_slide_show := false;
     end;
end;

procedure Tfrm_pretty_baby_main.open_btnClick(Sender: TObject);
var
  moniker : string;
  lvItem: TListItem;
  tvNode : TTreeNode;
begin
  if Length( pretty_tree_view.Selected.GetTextPath ) <> 0 then
    openDialog.InitialDir := pretty_tree_view.Selected.GetTextPath;

  if openDialog.Execute then
  begin
       try
          current_image.Stretch := true;
          current_image.Picture.LoadFromFile( openDialog.FileName );
          Application.ProcessMessages;
          current_image.Hint := openDialog.FileName ;
          moniker := ExtractFileDir( openDialog.FileName );
          thumb_view.Directory := moniker;
          status_bar.Panels[1].Text := moniker;
       finally
          //
       end;
  end
  else
     status_bar.Panels[0].Text :=  'Open file was cancelled';
end;

procedure Tfrm_pretty_baby_main.FormCreate(Sender: TObject);
var
   node : TTreeNode;
   str : string;
   sub_item : TMenuItem;
   i : integer;
begin
      DoubleBuffered := True;
      url_idx := 0;
      is_slide_show := false;
      OnDragDrop := @baby_basket.baby_thumbsDragDrop;
      tile_click.OnClick := @pretty_image_frm.baby_images_tileClick;
      untile_click.OnClick := @pretty_image_frm.baby_images_untileClick;
      pretty_baby_tray.Show;
      image_form_list := TStringlist.Create;
      image_form_idx := 0;
      thumb_idx := 0;
      grab_idx := 0;
      scroll_idx := 0;
      thumb_count_idx := 0;
      bookmark_init := false;


end;

procedure Tfrm_pretty_baby_main.FormResize(Sender: TObject);
var
  str : string;
begin
  if is_slide_show = true then exit;
  if baby_basket <> nil then
  begin

    baby_basket.Left := ( frm_pretty_baby_main.left + frm_pretty_baby_main.width ) - baby_basket.width;
    baby_basket.Top := ( frm_pretty_baby_main.top + frm_pretty_baby_main.height ) + baby_basket.height;


  end;
end;

procedure Tfrm_pretty_baby_main.FormShow(Sender: TObject);
var
  lst : TStringList;
  str : string;
  idx : integer;
  jdx : integer;
  count : integer;
  tn : TTreeNode;
  status : Tpretty_status;
  path : string;
begin
     str := Application.Location;
     phony_list.Items.LoadFromFile( 'pretty_baby_bookmarks' );
     pretty_bookmarkClick( Sender );
     lst := TStringList.Create;
     //screen.cursor := crHourGlass;
     try
        lst.LoadFromFile( 'pretty_baby_config' );
        str := ExpandFileName( lst[0] + '/..' );
        current_directory := str;
        anode := pretty_tree_view.Items.AddFirst( nil , str );
        anode.ImageIndex := 16;
        anode.Text := str;
        try
          // screen.Cursor := crHourglass;
           caption := str;
           try
            count := process_directory( pretty_tree_view , str , anode );
           except
              ShowMessage( 'Could not process directory ' + str );
           end;
        finally
           screen.Cursor := crDefault;
        end;
        idx := RPos( '/' , lst[0] );
        inc( idx );
        jdx := Length( lst[0] ) - idx;
        str  := MidStr( lst[0] , idx , jdx + 1 );
        tn := GetNodeByText( pretty_tree_view, str , true );
        if tn <> nil then
        begin
            //screen.cursor := crHourglass;
            try
              pretty_tree_view.SetFocus;
              tn.Selected := True;
              pretty_tree_view.Selected.Expanded := false;
              pretty_tree_view.Selected.SelectedIndex := pretty_tree_view.Selected.SelectedIndex;
              pretty_tree_view.Selected.Expanded := true;
            finally
             // screen.cursor := crDefault;
            end;
         end;
     finally
        lst.Free;
     end;

end;

procedure Tfrm_pretty_baby_main.grab_images( Sender : TObject ; idx : integer );
var
   i : integer;
   j : integer;
   cnt : integer;
   image : TThreadedImage;
begin
     cnt := 0;
     i := 0;
     for j := 0 to Screen.FormCount - 1 do
     begin
           if Screen.Forms[ j ] is Tpretty_image_frm then
              inc( cnt );
     end;
     if cnt + idx > 30 then
     begin
       ShowMessage( 'There are more than 30 open images-this could be a problem- :)' );
       exit;
     end;
     for i := 0 to idx - 1 do
     begin
          //if i + 1 = thumb_view.ImageLoaderManager.CountItems then exit;
          image := thumb_view.ImageLoaderManager.ItemFromIndex( i );
          if image <> nil then
          begin
            current_url := image.URL;
            current_image.Hint := image.URL;
            new_window_btnClick( Sender );
          end;
     end;
     //current_image.Hint := '';
     pretty_image_frm.baby_images_tileClick( Sender );
end;

procedure Tfrm_pretty_baby_main.grab_first_fiveClick(Sender: TObject);
begin
    grab_images( Sender , five );
end;

procedure Tfrm_pretty_baby_main.grab_first_tenClick(Sender: TObject);
begin
    grab_images( Sender , ten );
end;

procedure Tfrm_pretty_baby_main.image_close_allClick(Sender: TObject);
var
   i : integer;
   frm :TCustomForm;
   frm_name : string;
   str : string;
   j : integer;
   b : boolean;
begin
   try
     for i:= 0 to  frm_pretty_baby_main.image_form_list.Count - 1 do
     begin
            frm_name := frm_pretty_baby_main.image_form_list[i];
            frm := Screen.FindForm( frm_name );

            if frm <> nil then
            begin
              frm.Close;
            end;

     end;
     current_image.Picture := nil;
     current_image.Invalidate;
     current_image.Hint := '';
     current_url := '';
     if is_slide_show = true then
     begin
        slide_show_timer.Enabled := false;
        slide_show_start_btn.Enabled := true;
        slide_show_stop_btn.Enabled := false;
        slide_show_pause_btn.Enabled := false;
        is_slide_show := false;
     end;
     current_image.Stretch := false;
     current_image.Picture.LoadFromFile( Application.Location + '/' + 'blue-matreshka-inside-icon-icon.png' );
   finally
      //
   end;
end;

procedure Tfrm_pretty_baby_main.image_pop_closeClick(Sender: TObject);
begin
     current_image.Picture := nil;
     current_image.Hint := '';
     current_url := '';
     pretty_list_view.ItemIndex := -1;
     current_image.Stretch := false;
     current_image.Picture.LoadFromFile( Application.Location + '/' + 'blue-matreshka-inside-icon-icon.png' );
end;

procedure Tfrm_pretty_baby_main.led_timerTimer(Sender: TObject);
begin
       slide_led.Visible := not slide_led.Visible;
end;

procedure Tfrm_pretty_baby_main.current_imageDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
     Accept := true;
end;

procedure Tfrm_pretty_baby_main.current_imageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

    if Button = mbLeft then
      TImage( Sender ).BeginDrag( true );
end;

procedure Tfrm_pretty_baby_main.current_imageMouseEnter(Sender: TObject);
begin
    scroll_idx := 0;
end;

procedure Tfrm_pretty_baby_main.current_imageMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
   image : TThreadedImage;
   lvitem : integer;
   filename : string;
begin
    if thumb_view.ImageLoaderManager.CountItems = 0 then exit;


    if ( scroll_idx > thumb_view.ImageLoaderManager.CountItems - 1 )
     or ( thumb_view.ImageLoaderManager.ActiveItem = nil ) then
     begin
        scroll_idx := 0;
     end
     else
         scroll_idx := thumb_view.ImageLoaderManager.ActiveIndex;

    inc( scroll_idx );
    image := thumb_view.ImageLoaderManager.ItemFromIndex( scroll_idx );
    if image <> nil then
    begin
      current_image.Stretch := true;
      current_image.Picture.LoadFromFile( image.URL );
      current_image.Hint := image.URL;
      current_url := image.URL;
      sleep( 10 );
      filename := ExtractFileName( current_image.Hint );
       lvItem := pretty_list_view.Items.IndexOf( filename );
       if lvItem <> -1 then
       begin
          pretty_list_view.ItemIndex := lvItem;
       end;
       thumb_view.ImageLoaderManager.ActiveIndex := scroll_idx;
       thumb_view.Invalidate;
       thumb_view.ScrollIntoView;

    end;
    status_bar.Panels[1].Text := IntToStr( scroll_idx );
end;

procedure Tfrm_pretty_baby_main.current_imageMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
   image : TThreadedImage;
   lvitem : integer;
   filename : string;
begin

    if thumb_view.ImageLoaderManager.CountItems = 0 then exit;

    dec( scroll_idx );
    if scroll_idx < 0 then
    begin
      scroll_idx := 0
    end;

    image := thumb_view.ImageLoaderManager.ItemFromIndex( scroll_idx );
    if image <> nil then
    begin
      current_image.Stretch := true;
      current_image.Picture.LoadFromFile( image.URL );
      current_image.Hint := image.URL;
      current_url := image.URL;
      sleep( 10 );
      filename := ExtractFileName( current_image.Hint );
      lvItem := pretty_list_view.Items.IndexOf( filename );
      if lvItem <> -1 then
      begin
          pretty_list_view.ItemIndex := lvItem;
      end;
      thumb_view.ImageLoaderManager.ActiveIndex := scroll_idx;
      thumb_view.Invalidate;
      thumb_view.ScrollIntoView;
    end;

    status_bar.Panels[1].Text := IntToStr( scroll_idx );
end;

procedure Tfrm_pretty_baby_main.current_imagePaint(Sender: TObject);
var
   str : string;
   textarea: TRect;
   _canvas : TCanvas;
   textstyle: TTextStyle;
begin
     current_image.Invalidate;
     current_image.Canvas.Brush.Style := bsClear;
     current_image.Canvas.Font.Color:= clWhite;
     str := 'pretty_baby copyright 2015 William K. Johnson';
     _canvas := current_image.Canvas;
     textstyle := canvas.TextStyle;
     textstyle.Wordbreak := True;
     textstyle.SingleLine := False;
     textarea:=Rect( 0 , 0, 300 , 25 );
     _canvas.TextRect( textarea, current_image.Left , current_image.Height - textarea.Bottom , str , textstyle );
     textarea:=Rect( 0 , 0, current_image.Width , 25 );
     textstyle.Alignment := taCenter;
     _canvas.TextRect( textarea, current_image.Left , current_image.Top , current_image.Hint , textstyle );

     str := 'William K. Johnson';

end;

procedure Tfrm_pretty_baby_main.FormActivate(Sender: TObject);
begin
      phony_list.Items.LoadFromFile( 'pretty_baby_bookmarks' );
      pretty_bookmarkClick( Sender );
end;

procedure Tfrm_pretty_baby_main.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
var
   str : string;
begin
     image_form_list.Free;
     phony_list.Items.SaveToFile( 'pretty_baby_bookmarks' );
     with TStringList.Create do
     try
        str := thumb_view.Directory;
        if  thumb_view.Directory <> 'none' then str := thumb_view.Directory else
         if anode <> nil then str := anode.Text else str := '/';

      Add( str );
      SaveToFile( 'pretty_baby_config' );

      xml_config.Filename := 'pretty_baby_xml' ;        // reads the file if it already exists, but...
      xml_config.Clear ;                        // if the file already exists, clear the data, we want to start from scratch

 xml_config.SetValue ( 'pretty_baby_directory_info' , '' ) ;
 xml_config.SetValue ('pretty_baby_directory_info/last_directory_moniker', '/home/pretty_baby') ;
 xml_config.SetValue ('pretty_baby_directory_info/last_selected_image' , 'foo.jpeg' ) ;  // this will overwrite the previous value
 xml_config.Flush ;
     finally
      Free;
     end;
end;

procedure Tfrm_pretty_baby_main.current_imageDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
   img : TImage;
   moniker : string;
begin
     if Source = current_image then exit;
     if Source is TImage then
     begin
          img :=  TImage( Source );
          if img <> nil then
          begin
               current_image.Stretch := true;
               moniker := img.Parent.Caption;
               status_bar.Panels[1].Text := moniker;
               current_image.Picture.LoadFromFile( moniker );
               current_image.Hint := moniker;
               current_url := moniker;
               if pretty_list_view.SelCount <> 0 then
                 url_idx := pretty_list_view.ItemIndex;
        end;
     end;

     if Source is TShellListView then
     begin
        if TShellListView( Source ).Items.Count > 0 then
        begin
         current_image.Stretch := true;
         moniker := pretty_tree_view.Selected.GetTextPath + '/' + TShellListView( Source ).Selected.Caption;
         status_bar.Panels[1].Text := moniker;
         current_image.Picture.LoadFromFile( moniker );
         current_image.Hint := moniker;
         current_url := moniker;
         url_idx := pretty_list_view.ItemIndex;
        end;
     end;

     if Source is TThumbControl then
     begin
        if TThumbControl( Source ).Tag = 0 then
        begin
         thumb_viewDblClick( Sender );
        end
        else
            begin
              current_image.Stretch := true;
              baby_basket.baby_thumbsDblClick( Sender );
              status_bar.Panels[1].Text := baby_basket.current_baby_url;
            end;
     end;

end;

procedure Tfrm_pretty_baby_main.baby_basket_btnClick(Sender: TObject);
begin
     baby_basket.Visible := not baby_basket.Visible;
end;

procedure Tfrm_pretty_baby_main.about_pretty_babyClick(Sender: TObject);
var
  splash_screen : Tpretty_splash;
begin
     splash_screen := Tpretty_splash.Create( Application ) ;
     with splash_screen do
     begin
       FormStyle := fsStayOnTop;
       Caption := 'About';
       ShowInTaskBar := stNever;
       Show;
     end;
end;

procedure Tfrm_pretty_baby_main.MenuItem2Click(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_pretty_baby_main.MenuItem9Click(Sender: TObject);
begin
     SavePictureDialog1.FileName := ExtractFileName( current_image.Hint );
     if SavePictureDialog1.Execute then
     begin
        current_image.Picture.Bitmap.SaveToFile( SavePictureDialog1.FileName );
     end;
end;

procedure Tfrm_pretty_baby_main.menu_imagesClick(Sender: TObject);
var
   str : string;
   sub_item : TMenuItem;
   i : integer;
begin
       mainmenu1.Items[1].Items[0].Clear;
       mainmenu1.Items[1].Items[1].Clear;
       for i:= 0 to Screen.FormCount - 1 do
           begin
                if ( Screen.Forms[i] is Tpretty_image_frm ) then
                begin
                    sub_item := TMenuItem.Create(  mainmenu1.Items[1] );
                    sub_item.Caption := Tpretty_image_frm( Screen.Forms[i]).Caption;
                    sub_item.OnClick := @image_btn_menu_images_click; ;
                    sub_item.Tag := 0;
                    sub_item.ImageIndex:= 8;
                    mainmenu1.Items[1].Items[0].Add( sub_item );
                    sub_item := TMenuItem.Create(  mainmenu1.Items[1] );
                    sub_item.OnClick := @image_btn_menu_images_click; ;
                    sub_item.Caption := Tpretty_image_frm( Screen.Forms[i]).Caption;
                    sub_item.Tag := 1;
                    sub_item.ImageIndex := 7;
                    mainmenu1.Items[1].Items[1].Add( sub_item );
                  end;
           end;
end;

procedure Tfrm_pretty_baby_main.image_btn_click( Sender : TObject );
var
   i : integer;
   btn : TToolButton;
   str : string;
begin
        if Sender is TToolButton then
        begin
           btn := TToolButton( Sender );
           str := btn.Caption;
          for i:= 0 to Screen.FormCount - 1 do
            if ( Screen.Forms[i] is Tpretty_image_frm ) then
            begin
              if Tpretty_image_frm( Screen.Forms[i]  ).Caption = btn.Caption then
              begin
                   Tpretty_image_frm( Screen.Forms[i]  ).BringToFront;
              end;
            end;
        end;
end;

procedure Tfrm_pretty_baby_main.image_btn_menu_images_click( Sender : TObject );
var
   i : integer;
   j : integer;
   k : integer;
   lst : TStringList;
begin
     if Sender is TMenuItem then
     begin
          for i := 0 to Screen.FormCount - 1 do
            if ( Screen.Forms[i] is Tpretty_image_frm ) then
            begin
              if Tpretty_image_frm( Screen.Forms[i]  ).Caption = TMenuItem( Sender ).Caption  then
              begin
                case  TMenuItem( Sender ).Tag of
                  0:
                    begin
                       Tpretty_image_frm( Screen.Forms[i]  ).BringToFront;
                       exit;
                    end;
                  1:
                    begin
                       Tpretty_image_frm( Screen.Forms[i]  ).Close;
                       exit;
                    end;
                end;
              end;
           end;
       end;
end;

procedure Tfrm_pretty_baby_main.new_window_btnClick(Sender: TObject);
var
   pretty_image : Tpretty_image_frm;
   btn : TToolButton;
   lastbtnidx: integer;
   i : integer;
   j : integer;
   sub_item : TMenuItem;
   lst : TStringList;
begin

     if current_image.Hint = '' then exit;
     for i:= 0 to Screen.FormCount - 1 do
     begin
        if Screen.Forms[i]  is Tpretty_image_frm then
        begin
          if Tpretty_image_frm( Screen.Forms[i]  ).is_cycling = true then exit;
          if Tpretty_image_frm( Screen.Forms[i]  ).Caption = current_image.Hint then
          begin
             Tpretty_image_frm( Screen.Forms[i]  ).BringToFront;
             exit;
          end;
        end;
     end;
     pretty_image := Tpretty_image_frm.Create( Application );

     pretty_image_toolbar.Visible := true;
     pretty_image.Caption := current_image.Hint;
     inc( image_form_idx );
     pretty_image.Name := 'pretty_baby' + IntToStr( image_form_idx );
     image_form_list.Add( pretty_image.Name );
     btn := TToolButton.Create( pretty_image_toolbar );
     btn.caption := current_url;
     btn.Hint := current_url;
     btn.ImageIndex := 4;
     btn.OnClick :=@image_btn_click;
     lastbtnidx := pretty_image_toolbar.ButtonCount - 1;
     if lastbtnidx > -1 then
      btn.Left := pretty_image_toolbar.Buttons[lastbtnidx].Left + pretty_image_toolbar.Buttons[lastbtnidx].Width
    else
      btn.Left := 0;
    btn.Parent := pretty_image_toolbar;
    pretty_image.Show;
    begin
        lst := TStringList.Create;
        frm_image_list.image_strings.Clear;
        try
         for j := 0 to Screen.FormCount - 1 do
           begin
             if Screen.Forms[j] is Tpretty_image_frm then
             begin
                 lst.Add( Tpretty_image_frm( Screen.Forms[j] ).Caption );

                 if  Tpretty_image_frm( Screen.Forms[j] ).pretty_image_frm_pop.Items[1].Count <> 0 then
                  Tpretty_image_frm( Screen.Forms[j] ).pretty_image_frm_pop.Items[1].Clear;
                  for i := 0 to baby_basket.baby_tabs.Tabs.Count - 1  do
                  begin
                     sub_item := TMenuItem.Create( Tpretty_image_frm( Screen.Forms[j] ).pretty_image_frm_pop );
                     sub_item.Caption := baby_basket.baby_tabs.Tabs[i];
                     Tpretty_image_frm( Screen.Forms[j] ).pretty_image_frm_pop.Items[1].Add( sub_item );
                  end;
               end;

          end;
        finally
           try
            Screen.Cursor := crDefault;
           except
             //
           end;
        end;


       for j := 0 to Screen.FormCount - 1 do
       begin
           if Screen.Forms[j] is Tpretty_image_frm then
           begin
              if  Tpretty_image_frm( Screen.Forms[j] ).pretty_image_frm_pop.Items[0].Count <> 0 then
              Tpretty_image_frm( Screen.Forms[j] ).pretty_image_frm_pop.Items[0].Clear;
              frm_image_list.image_strings.Clear;
             for i := 0 to lst.Count - 1 do
             begin
              sub_item := TMenuItem.Create( Tpretty_image_frm( Screen.Forms[j] ).pretty_image_frm_pop );
              sub_item.OnClick := @image_btn_menu_images_click;
              sub_item.Caption := lst[i];
              Tpretty_image_frm( Screen.Forms[j] ).pretty_image_frm_pop.Items[0].Add( sub_item );
              frm_image_list.image_strings.Items.Add( lst[i] );
              frm_image_list.Invalidate;
             end;
           end;
       end;
    end;
end;

procedure Tfrm_pretty_baby_main.pretty_baby_trayDblClick(Sender: TObject);
begin
  Show;
end;

procedure Tfrm_pretty_baby_main.clear_bookmarks( Sender : TObject );
var
   sub_item : TMenuItem;
begin
       if MessageDlg( 'Question', 'Clear all bookmarks?', mtConfirmation,
         [mbYes, mbNo],0 ) = mrYes   then
         begin
           with sub_item do
           begin
             pretty_bookmark.Clear;
             phony_list.Items.Clear;
             pretty_props.Save;
             sub_item := TMenuItem.Create( MainMenu1 );
             Caption := '&Delete Bookmark';
             ImageIndex := 7;
             Tag := 1;
             Enabled := false;
             MainMenu1.Items[3].Add( sub_item );
             sub_item := TMenuItem.Create( MainMenu1 );
             Caption := '&Clear Bookmarks';
             ImageIndex := 10;
             Tag := 1;
             Enabled := false;
             OnClick := @clear_bookmarks;
             MainMenu1.Items[3].Add( sub_item );
           end;
         end;
end;

procedure Tfrm_pretty_baby_main.pretty_bookmarkClick(Sender: TObject);
var
  sub_item : TMenuItem;
  sub_sub_item : TMenuItem;
  i : integer;
  idx :integer;
begin
     if bookmark_init = false then
     begin
         for i := 0 to phony_list.Items.Count - 1 do
         begin
            sub_item := TMenuItem.Create( MainMenu1 );
            sub_item.Caption := phony_list.Items[i];
            sub_item.ImageIndex := 13;
            sub_item.OnClick := @grab_bookmark;
            if FileExists( phony_list.Items[i] ) = false then sub_item.Enabled := false;
            MainMenu1.Items[3].Add( sub_item );
         end;
         if phony_list.Items.Count > 0 then
         begin
           sub_item := TMenuItem.Create( MainMenu1 );
           sub_item.Caption := '-';
           MainMenu1.Items[3].Add( sub_item );
         end;
         sub_item := TMenuItem.Create( MainMenu1 );
         sub_item.Caption := '&Delete Bookmark';
         sub_item.ImageIndex := 7;
         sub_item.Tag := 1;
         sub_item.Name := 'delete_bookmark';

         MainMenu1.Items[3].Add( sub_item );
         for i := 0 to phony_list.Items.Count - 1 do
         begin
            sub_item := TMenuItem.Create( MainMenu1 );
            sub_item.Caption := phony_list.Items[i];
            sub_item.ImageIndex := 7;
            //sub_item.OnClick := @grab_bookmark;
            sub_sub_item := MainMenu1.Items[3].Items[MainMenu1.Items[3].IndexOfCaption( '&Delete Bookmark')];
            sub_sub_item.Add( sub_item );
         end;

         //sub_item.OnClick := @grab_bookmark;

         sub_item := TMenuItem.Create( MainMenu1 );
         sub_item.Caption := '&Clear Bookmarks';
         sub_item.ImageIndex := 10;
         sub_item.Tag := 1;
         sub_item.OnClick := @clear_bookmarks;
         MainMenu1.Items[3].Add( sub_item );

         bookmark_init := true;
     end;
end;

procedure Tfrm_pretty_baby_main.pretty_bookmark_popClick(Sender: TObject);
var
   image : TThreadedImage;
   sub_item : TMenuItem;
   sub_sub_item : TMenuItem;
   i : integer;
begin
     if ( Sender is TMenuItem ) and ( TMenuItem( Sender ).Tag = 1 ) then
     begin
       if thumb_view.ImageLoaderManager.CountItems > 0 then
       begin
           image := thumb_view.ItemFromPoint( image_hit );
           if image <> nil then
           begin
                for i := 0 to MainMenu1.Items[3].Count - 1 do
                begin
                     if MainMenu1.Items[3].Items[i].Caption = image.URL then exit;
                end;
                sub_item := TMenuItem.Create( MainMenu1 );
                sub_item.Caption := image.URL;
                sub_item.ImageIndex := 13;
                sub_item.OnClick := @grab_bookmark;
                MainMenu1.Items[3].Insert( 0 , sub_item );

                phony_list.Items.Add( sub_item.Caption );

                sub_item := TMenuItem.Create( MainMenu1 );
                sub_item.Caption := image.URL;
                sub_item.ImageIndex := 7;
                //sub_item.OnClick := @grab_bookmark;
                sub_sub_item := MainMenu1.Items[3].Items[MainMenu1.Items[3].IndexOfCaption( '&Delete Bookmark')];
                sub_sub_item.Add( sub_item );
           end;
       end;
     end
        else
            begin
                if current_image.Picture = nil then exit;
                for i := 0 to MainMenu1.Items[3].Count - 1 do
                begin
                     if MainMenu1.Items[3].Items[i].Caption = current_image.Hint then exit;
                end;
                sub_item := TMenuItem.Create( MainMenu1 );
                sub_item.Caption := current_image.Hint;
                sub_item.ImageIndex := 13;
                sub_item.OnClick := @grab_bookmark;
                MainMenu1.Items[3].Insert( 0 , sub_item );
                phony_list.Items.Add( sub_item.Caption );

                sub_item := TMenuItem.Create( MainMenu1 );
                sub_item.Caption := current_image.Hint;
                sub_item.ImageIndex := 7;
                //sub_item.OnClick := @grab_bookmark;
                sub_sub_item := MainMenu1.Items[3].Items[MainMenu1.Items[3].IndexOfCaption( '&Delete Bookmark')];
                sub_sub_item.Add( sub_item );
            end;
end;


procedure Tfrm_pretty_baby_main.pretty_list_viewClick(Sender: TObject);
var
  moniker :  string;
begin
    if pretty_list_view.ItemIndex <> -1 then
    begin
      current_image.Stretch := true;
      moniker  := pretty_tree_view.Selected.GetTextPath + '/' + pretty_list_view.Items[pretty_list_view.ItemIndex];
      status_bar.Panels[1].Text := moniker;
      current_image.Picture.LoadFromFile( moniker );
      current_image.Hint := moniker;
      current_url := moniker;
      url_idx := pretty_list_view.ItemIndex;
      thumb_view.ImageLoaderManager.ActiveIndex := url_idx;
      thumb_view.Invalidate;
    end;
end;

procedure Tfrm_pretty_baby_main.pretty_list_viewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
       if Button = mbLeft then
          pretty_list_view.BeginDrag( true );
end;

procedure Tfrm_pretty_baby_main.pretty_tree_viewChange(Sender: TObject;
  Node: TTreeNode);
var
  str : string;
  path : string;
begin
      try
       try
          url_idx := 0;
          screen.cursor := crHourGlass;
          if pretty_tree_view.Selected.GetTextPath = anode.Text then
          begin
            process_files( pretty_tree_view.Selected.GetTextPath , pretty_tree_view.Selected , pretty_list_view );
            thumb_view.Directory := '';
            thumb_view.Directory := pretty_tree_view.Selected.GetTextPath;
            thumb_view.Invalidate;

            exit;
          end;

          str := pretty_tree_view.Selected.GetTextPath;
          if str <> '' then
          begin
               Caption := str;

               if pretty_tree_view.Selected.HasChildren = false then
               begin
                  process_directory( pretty_tree_view , pretty_tree_view.Selected.GetTextPath , pretty_tree_view.Selected );
                  thumb_view.Directory := '';
                  thumb_view.Directory := pretty_tree_view.Selected.GetTextPath;
                  thumb_view.Invalidate;
               end
               else
                if pretty_tree_view.Selected = anode then
                begin
                  str := anode.GetTextPath;
                  //pretty_tree_view.Items.clear;
                  process_directory( pretty_tree_view , pretty_tree_view.Selected.GetTextPath , anode );
                  thumb_view.Directory := '';
                  thumb_view.Directory := pretty_tree_view.Selected.GetTextPath;
                  thumb_view.Invalidate;
                end;
             process_files( pretty_tree_view.Selected.GetTextPath , pretty_tree_view.Selected , pretty_list_view );
             pretty_tree_view.Selected.Expand( false );
          end;
       except
         //
       end;
      finally
          screen.cursor := crDefault;
      end;

end;

procedure Tfrm_pretty_baby_main.slide_show_pause_btnClick(Sender: TObject);
begin
     slide_show_timer.Interval := 1000;
     slide_show_timer.Enabled := false;
     slide_show_stop_btn.Enabled := true;
     slide_show_start_btn.Enabled := true;
     slide_show_pause_btn.Enabled := false;
     slide_led.Color := clYellow;
     baby_basket.add_basket.Enabled := false;
end;

procedure Tfrm_pretty_baby_main.slide_show_timerStartTimer(Sender: TObject);
begin
  //url_idx := 0;
end;

procedure Tfrm_pretty_baby_main.slide_show_timerStopTimer(Sender: TObject);
begin
  //url_idx := 0;
end;

procedure Tfrm_pretty_baby_main.slide_show_timerTimer(Sender: TObject);
var
  image : TThreadedImage;
  url : string;
  lvItem: integer;
  filename : string;
  picture : TPicture;
begin
        if url_idx + 1 > pretty_list_view.Items.Count then
         url_idx := 0;
        slide_show_timer.Interval := slide_track.Position * 1000;

        if pretty_list_view.Items.Count <> 0 then
        begin
             url := pretty_tree_view.Selected.GetTextPath +
                    '/' + pretty_list_view.Items[url_idx];
             thumb_view.ImageLoaderManager.ActiveIndex := url_idx;
             thumb_view.Invalidate;
             thumb_view.ScrollIntoView;
             inc( url_idx );
             status_bar.Panels[1].Text := url;
              current_image.Stretch := true;
             try
               try
                  current_image.Picture. LoadFromFile( url );
               except
                  ShowMessage( 'Invalid file link ' + url );
               end;
             finally

             end;
             current_image.Hint := url;

             filename := ExtractFileName( url );
             lvItem := pretty_list_view.Items.IndexOf( filename );
             if lvItem <> -1 then
             begin
                  pretty_list_view.ItemIndex := lvItem;
             end;

        end;
end;

procedure Tfrm_pretty_baby_main.SpeedButton1Click(Sender: TObject);
var
   count : integer;
begin
    pretty_tree_view.Items.Clear;
    anode := pretty_tree_view.Items.AddFirst( nil , '/' );
    anode.ImageIndex := 16;
    anode.Text := '/';
    try
       screen.Cursor := crHourglass;
       caption := '/';
       count := process_directory( pretty_tree_view , '/' , anode );
    finally
       screen.Cursor := crDefault;
     end;
     pretty_tree_view.FullExpand;
     current_url := '';
     pretty_list_view.Items.Clear;
     thumb_view.ImageLoaderManager.Clear;
     thumb_view.Directory := '';
     thumb_view.Invalidate;
     current_image.Picture.Clear;
     current_image.Hint := '';
     slide_show_timer.Enabled := false;
     slide_show_stop_btn.Enabled := false;
     slide_show_pause_btn.Enabled := false;
     slide_show_start_btn.Enabled := true;
     is_slide_show := false;
     led_timer.Enabled := false;
     slide_led.Color:= clRed;
     url_idx := 0;

     current_url := '';
     current_image.Stretch := false;
     current_image.Picture.LoadFromFile( Application.Location + '/' + 'blue-matreshka-inside-icon-icon.png' );
end;

procedure Tfrm_pretty_baby_main.slide_show_start_btnClick(Sender: TObject);
begin
     if thumb_view.ImageLoaderManager.CountItems = 0 then exit;
     pretty_image_frm.pretty_imageClick( Sender );
     if is_slide_show = false then
     begin
        if url_idx > ( thumb_view.ImageLoaderManager.CountItems + 1 ) then
        begin
             url_idx := 0;
        end;
     end;
     if pretty_list_view.Items.Count <> 0 then
     begin
       slide_show_timer.Interval := 1000;
       slide_show_timer.Enabled := true ;
       slide_show_stop_btn.Enabled := true;
       slide_show_pause_btn.Enabled := true;
       slide_show_start_btn.Enabled := false;
       slide_led.Color := clGreen;
       slide_led.Visible:= true;
       image_pop_close.Enabled := false;
       led_timer.Enabled := true;
       is_slide_show := true;
       baby_basket.Visible := false;
       {baby_basket.left := 0;
       baby_basket.width := pretty_list_view.Width + thumb_view.Width;
       baby_basket.add_basket.Enabled := false;}
     end;
end;

procedure Tfrm_pretty_baby_main.slide_show_stop_btnClick(Sender: TObject);
begin
     url_idx := 0;
     slide_show_timer.Enabled := false;
     slide_show_stop_btn.Enabled := false;
     slide_show_start_btn.Enabled := true;
     slide_show_pause_btn.Enabled := false;
     led_timer.Enabled := false;
     is_slide_show := false;
     slide_led.Color := clRed;
     {baby_basket.width :=  baby_basket.original_width;
     baby_basket.Left := ( frm_pretty_baby_main.left + frm_pretty_baby_main.width ) - baby_basket.width;
     baby_basket.Top := ( frm_pretty_baby_main.top + frm_pretty_baby_main.height ) + baby_basket.height; ;
     baby_basket.Visible := true;
     baby_basket.add_basket.Enabled := true; }
     slide_led.Visible := true;
end;

procedure Tfrm_pretty_baby_main.thumb_pop_randomClick(Sender: TObject);
var
   idx : integer;
   image : TThreadedImage;
   filename : string;
   lvItem: integer;
begin
    if thumb_view.ImageLoaderManager.CountItems <> 0 then
    begin

         idx := random( thumb_view.ImageLoaderManager.CountItems - 1 );
         image := thumb_view.ImageLoaderManager.ItemFromIndex( idx );
         if image <> nil then
         begin
           current_image.Stretch := true;
           thumb_idx := idx;
           current_image.Picture.LoadFromFile( image.URL );
           current_image.Hint := image.URL;
           current_url := current_image.Hint;
           thumb_view.ImageLoaderManager.ActiveIndex := idx;
           thumb_view.Invalidate;
           thumb_view.ScrollIntoView;

           filename := ExtractFileName( image.URL );
           lvItem := pretty_list_view.Items.IndexOf( filename );
           if lvItem <> -1 then
           begin
              pretty_list_view.ItemIndex := lvItem;
           end;
           if lvItem <> -1 then
           begin
              pretty_list_view.ItemIndex := lvItem;
              url_idx := lvItem;
           end;
         end;
    end;
end;

procedure Tfrm_pretty_baby_main.thumb_viewDblClick(Sender: TObject);
var
  image : TThreadedImage;
  url : string;
  filename : string;
  lvItem: integer;
begin
       try
         image := thumb_view.ItemFromPoint( image_hit );
         if image <> nil then
         begin

            current_image.Stretch := true;
            status_bar.Panels[1].Text := image.URL;
            current_image.Picture.LoadFromFile( image.URL );
            current_image.Hint := image.URL;
            current_url := image.URL;
            url_idx := thumb_view.ImageLoaderManager.ItemIndexFromPoint( image_hit );

            filename := ExtractFileName( image.URL );
            lvItem := pretty_list_view.ItemIndex;
            if lvItem <> -1 then
            begin
              pretty_list_view.ItemIndex := lvItem;
              pretty_list_view.MakeCurrentVisible;
              url_idx := lvItem;
            end;

         end;
       finally
         //
       end;
end;



procedure Tfrm_pretty_baby_main.thumb_viewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     Accept := true;
end;

procedure Tfrm_pretty_baby_main.thumb_viewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  image : TThreadedImage;
begin
     image_hit.X := X;
     image_hit.Y := Y;

     if Button = mbLeft then
          thumb_view.BeginDrag( true );
     if Button = mbRight then
     begin
       if thumb_view.ImageLoaderManager.CountItems > 0 then
       begin
           image := thumb_view.ItemFromPoint( image_hit );
           if image <> nil then
               thumb_bookmark.Enabled := true
           else
               thumb_bookmark.Enabled := false;
       end;
     end;

end;

procedure Tfrm_pretty_baby_main.thumb_viewSelectItem(Sender: TObject;
  Item: TThreadedImage);
begin
       status_bar.Panels[1].Text := Item.URL;
end;

procedure Tfrm_pretty_baby_main.open_imagesClick(Sender: TObject);
begin
    frm_image_list.image_strings.Color := clBackground;
    frm_image_list.Visible := not frm_image_list.Visible;
    if frm_image_list.Visible = true then frm_image_list.Show;
    open_images.Down := not  open_images.Down;
end;

function Tfrm_pretty_baby_main.GetNodeByText( ATree : TTreeView;
                                              AValue:String;
                                              AVisible: Boolean ): TTreeNode;
var
    node: TTreeNode;
begin
    result := nil;
    //screen.cursor := crHourglass;
    if ATree.Items.Count = 0 then exit;
    try
      node := ATree.Items[0];
      while node <> nil do
      begin
        if upperCase( node.Text) = upperCase( AValue ) then
        begin
          result := node;
          if AVisible then
            result.MakeVisible;
          break;
        end;
        node := node.GetNext;
      end;
    finally
      //screen.cursor := crDefault;
    end;
end;

procedure Tfrm_pretty_baby_main.pretty_propsRestoreProperties(Sender: TObject
  );
begin
     if current_image.Hint <> '' then current_image.Picture.LoadFromFile( current_image.Hint );
end;

procedure Tfrm_pretty_baby_main.grab_bookmark( Sender : TObject );
var
  tn : TTreeNode;
  str : string;
  dir : string;
  filename : string;
  path : string;
  parent_dir : string;
  idx : integer;
  jdx : integer;
  i : integer;
  count : integer;
begin
       try
          if Sender is TMenuItem then
          begin
           filename := TMenuItem( Sender ).Caption;
           path := TMenuItem( Sender ).Caption;
           path := ExtractFileDir( path );
           parent_dir :=  ExpandFileName( path + '/..' );
           idx := RPos( '/' , path );
           inc( idx );
           jdx := Length( path ) - idx;
           str  := MidStr( path , idx , jdx + 1 );

           //count := grab_num_files( ExtractFileDir( path ) );

           if pretty_tree_view.SelectionCount > 0 then
           begin
           //  if ( pretty_tree_view.Root = parent_dir ) and ( pretty_tree_view.Selected.Text = str )
           //    and ( thumb_view.ImageLoaderManager.ItemFromIndex( thumb_view.ImageLoaderManager.ActiveIndex ).URL = path ) then exit;
           end;
           //pretty_tree_view.Root := parent_dir;
           //pretty_tree_view.Invalidate;
           pretty_tree_view.Items.Clear;
           anode := pretty_tree_view.Items.AddFirst( nil , parent_dir );
           anode.ImageIndex := 16;
           anode.Text := parent_dir;
           process_directory( pretty_tree_view  , parent_dir , anode );

           tn := GetNodeByText( pretty_tree_view, str , true );
           if tn = nil then
           begin
             if anode.Text = dir then
             begin
                tn := anode;
             end;
           end;
           //else
            begin
              screen.cursor := crHourglass;
              try
                pretty_tree_view.SetFocus;
                tn.Selected := True;
                pretty_tree_view.Selected.Expanded := false;
                pretty_tree_view.Selected.SelectedIndex := pretty_tree_view.Selected.SelectedIndex;
                pretty_tree_view.Selected.Expanded := true;
              finally
                screen.cursor := crDefault;
                pretty_status.Visible := false;
              end;
            end;
            for i := 0 to thumb_view.ImageLoaderManager.CountItems - 1 do
            begin
                if  thumb_view.ImageLoaderManager.ItemFromIndex( i ).URL = path then
                begin
                   thumb_view.ImageLoaderManager.ActiveIndex := i;
                   thumb_view.Invalidate;
                   thumb_view.ScrollIntoView;
                end;
            end;

            current_image.Picture.LoadFromFile( filename );
            current_image.Stretch := true;
            current_image.Hint := filename;
            current_url := filename;

            filename := ExtractFileName( filename );
            pretty_list_view.ItemIndex := pretty_list_view.Items.IndexOf( filename );
            pretty_list_view.MakeCurrentVisible;
            url_idx := pretty_list_view.ItemIndex;
          end;
       finally
         //pretty_status.Visible := false;
       end;
end;

procedure Tfrm_pretty_baby_main.tree_timerTimer(Sender: TObject);
begin
     pretty_tree_view.Invalidate;
end;

procedure Tfrm_pretty_baby_main.url_timerTimer(Sender: TObject);
var
  i : integer;
  j : integer;
  sub_item : TMenuItem;
begin
     if thumb_view.ImageLoaderManager.CountItems > 0 then
     begin
        thumb_grab.Enabled := true;
        thumb_bookmark.Enabled := true;
        thumb_pop_random.Enabled := true;
        red_picture.Visible := false;
        thumb_view.Visible := true;
     end
      else
       begin
          thumb_grab.Enabled:= false;
          thumb_bookmark.Enabled := false;
          thumb_pop_random.Enabled := false;
          thumb_view.visible := false;
          red_picture.Visible := true;
       end;
     if length( current_image.Hint ) <> 0 then
     begin
        new_window_btn.Enabled := true;
        grab_first_image.Enabled := true;
        image_bookmark.Enabled := true;
        pretty_bookmark_pop.Enabled := true;
        image_popup_new.Enabled := true;
        image_pop_close.Enabled := true;
        thumb_idx := -1;
     end
     else
       begin
        new_window_btn.Enabled := false;
        grab_first_image.Enabled := false;
        image_popup_new.Enabled := false;
        tile_click.Enabled := false;
        image_close.Enabled := false ;
        image_bookmark.Enabled := false;
        image_pop_close.Enabled := false;
        pretty_bookmark_pop.Enabled := false;
        image_popup_new.Enabled := false;
       end;
      for i := 0 to Screen.FormCount - 1 do
      begin
           if Screen.Forms[i] is Tpretty_image_frm then
           begin
              image_close_all.Enabled := true;
              open_images_click.Enabled := true;
              image_close.Enabled := true;
              tile_click.Enabled := true;
              break;
           end
            else
            begin
              image_close_all.Enabled := false;
              open_images_click.Enabled := false;
              image_close.Enabled := false;
              tile_click.Enabled := false;
            end;
      end;
end;









end.

