unit pretty_baby_basket;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, thumbcontrol, Forms, Controls, Graphics, Dialogs,
  ComCtrls ,  ExtCtrls, StdCtrls, ShellCtrls , baseunix , threadedimageLoader ,
  Types , Menus ,  cthreads , strutils;

type

  { Tbaby_basket }

  Tbaby_basket = class(TForm)
    baby_select: TSelectDirectoryDialog;
    baby_images: TImageList;
    image_erase: TMenuItem;
    image_clear: TMenuItem;
    dump_basket_to: TMenuItem;
    Panel1: TPanel;
    baby_tabs: TTabControl;
    baby_thumbs: TThumbControl;
    baby_tree: TShellTreeView;
    baby_basket_pop_menu: TPopupMenu;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    add_basket: TToolButton;
    left_btn: TToolButton;
    right_btn: TToolButton;
    procedure baby_pagesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure baby_tabsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure baby_thumbsDblClick(Sender: TObject);
    procedure baby_thumbsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure baby_thumbsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure baby_thumbsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure baby_thumbsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure baby_thumbsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure baby_thumbsSelectItem(Sender: TObject; Item: TThreadedImage);
    procedure baby_treeChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure baby_tabsChange(Sender: TObject);
    procedure image_clearClick(Sender: TObject);
    procedure image_eraseClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure add_basketClick(Sender: TObject);
    procedure left_btnClick(Sender: TObject);
    procedure right_btnClick(Sender: TObject);
    procedure main_view_update( Sender : TObject );
  private
    { private declarations }
  public
    current_baby_url : string;
    image_hit : TPoint;
    page_idx : integer;
    original_width : integer;

  end;

var
  baby_basket: Tbaby_basket;

implementation

uses
  pretty_baby_main , pretty_baby_image , vtree_impl;

{ Tbaby_basket }

procedure Tbaby_basket.main_view_update( Sender : TObject );
var
  str : string;
  count : integer;
  idx : integer;
  jdx : integer;
  tn : TTreeNode;
begin
      if Sender is TMenuItem then
      begin
           str := TMenuItem( Sender ).Caption;
           str := ExpandFileName( str + '/..' );
           with frm_pretty_baby_main do
           begin
             pretty_tree_view.Items.clear;
             anode := pretty_tree_view.Items.AddFirst( nil , str );
             anode.ImageIndex := 16;
             anode.Text := str;

             try
              screen.Cursor := crHourglass;
              caption := str;
               try
                  count := process_directory( pretty_tree_view , str , anode );
                  thumb_view.Directory := '';
                  thumb_view.Directory := str;
                  thumb_view.Invalidate;
                  process_files( str , anode , pretty_list_view );
                  anode.Expand( false );
                  idx := RPos( '/' , TMenuItem( Sender ).Caption );
                  inc( idx );
                  jdx := Length( TMenuItem( Sender ).Caption ) - idx;
                  str  := MidStr( TMenuItem( Sender ).Caption , idx , jdx + 1 );
                  tn := GetNodeByText( pretty_tree_view, str , true );
                  if tn <> nil then
                  begin
                    pretty_tree_view.SetFocus;
                    tn.Selected := True;
                    pretty_tree_view.Selected.Expanded := false;
                    pretty_tree_view.Selected.SelectedIndex := pretty_tree_view.Selected.SelectedIndex;
                    pretty_tree_view.Selected.Expanded := true;
                 end;
               except
                  ShowMessage( 'Could not process directory ' + str );
               end;
           finally
             screen.Cursor := crDefault;
           end;
          end;
         end;
end;

procedure Tbaby_basket.FormCreate(Sender: TObject);
var
  i : integer;
  sub_item : TMenuItem;
begin

     baby_basket.Left := Screen.Width - baby_basket.Width;//( frm_pretty_baby_main.left + frm_pretty_baby_main.Panel2.width + frm_pretty_baby_main.Panel4.width) - width;
     baby_basket.Top := Screen.Height - baby_basket.Height;//( frm_pretty_baby_main.top + frm_pretty_baby_main.height ) + height; ;
     caption := 'baby basket' + '(' + baby_thumbs.Directory + ')';
     current_baby_url := '';
     original_width := width;
     frm_pretty_baby_main.mainmenu1.Items[2].Clear;
     for i:= 0 to baby_tabs.Tabs.Count - 1 do
     begin
        sub_item := TMenuItem.Create(   frm_pretty_baby_main.mainmenu1.Items );
        sub_item.Caption := baby_basket.baby_tabs.Tabs[i];
        sub_item.ImageIndex := 9;
        sub_item.OnClick := @main_view_update;
        frm_pretty_baby_main.mainmenu1.Items[2].Add( sub_item );
     end;
end;

procedure Tbaby_basket.baby_tabsChange(Sender: TObject);
begin
      baby_thumbs.Directory := '';
      baby_thumbs.Directory := baby_tabs.Tabs[baby_tabs.TabIndex];
      baby_thumbs.Invalidate;

end;

procedure Tbaby_basket.image_clearClick(Sender: TObject);
var
  image : TThreadedImage;
  dir : string;
  i , j  : integer;
begin
     dir := baby_thumbs.Directory;
     if MessageDlg( 'Question' , 'This will clear the basket. Ok?', mtConfirmation,
        [mbYes, mbCancel] , 0) = mrYes   then
     begin
            delete_directory_files( dir );
            baby_thumbs.Directory := '';
            baby_thumbs.Directory := dir;
            baby_thumbs.Invalidate;
            if ( length( frm_pretty_baby_main.pretty_tree_view.Selected.GetTextPath ) <> 0 ) then
             frm_pretty_baby_main.pretty_tree_view.OnChange( Sender ,  frm_pretty_baby_main.pretty_tree_view.Selected );
            frm_pretty_baby_main.thumb_view.Invalidate;

            if baby_thumbs.Directory  = frm_pretty_baby_main.pretty_tree_view.Selected.GetTextPath then
                   frm_pretty_baby_main.pretty_list_view.Items.Clear;



     end;
end;

procedure Tbaby_basket.image_eraseClick(Sender: TObject);
var
  image : TThreadedImage;
  dir : string;
  dir_2 : string;
  lstview : TListBox;
  treeview : TTreeview;
  node : TTreeNode;
  idx : integer;
  i: integer;
  str_1 : string;
  str_2 : string;
begin
      dir := frm_pretty_baby_main.thumb_view.Directory;
      dir_2 := baby_thumbs.Directory;
      image := baby_thumbs.ItemFromPoint( image_hit );
      treeview := frm_pretty_baby_main.pretty_tree_view;
      lstview := frm_pretty_baby_main.pretty_list_view;
      str_2 := image.URL;;
      if image <> nil then
      begin
              for i := 0 to Screen.FormCount - 1 do
              begin
                  if Screen.Forms[i] is Tpretty_image_frm  then
                  begin
                       if Tpretty_image_frm( Screen.Forms[i] ).Caption = image.URL then
                       begin
                           Tpretty_image_frm( Screen.Forms[i] ).Close;
                           break;
                       end;
                  end;
              end;
             DeleteFile( image.URL );
             baby_thumbs.Directory := '';
             baby_thumbs.Invalidate;
             baby_thumbs.Directory := dir_2;
             baby_thumbs.Invalidate;
            with frm_pretty_baby_main do
            begin
                current_image.Picture := nil;
                current_image.Hint := '';
                current_image.Invalidate;
                if  pretty_tree_view.Selected <> nil then
                begin
                 pretty_tree_view.Selected.Expanded := false;
                 pretty_tree_view.Selected.SelectedIndex := pretty_tree_view.Selected.SelectedIndex;
                 pretty_tree_view.Selected.Expanded := true;
                end;
                pretty_list_view.Refresh;
                pretty_tree_view.Invalidate;
                thumb_view.ImageLoaderManager.Clear;
                thumb_view.ImageLoaderManager.Reload := true;
                thumb_view.Directory := '';
                thumb_view.Directory := dir;
                thumb_view.Invalidate;
                if self.baby_thumbs.Directory = pretty_tree_view.Selected.GetTextPath then
                begin
                     for i := 0 to  pretty_list_view.Items.Count - 1 do
                     begin
                         if pretty_list_view.Items[i] = ExtractFileName( str_2 ) then
                         begin
                            pretty_list_view.Items.Delete( i );
                            exit;
                         end;
                     end;
                end;

         end;

      end;
end;

procedure Tbaby_basket.Timer1Timer(Sender: TObject);
begin
     if baby_thumbs.ImageLoaderManager.CountItems = 0 then
     begin
        image_erase.Enabled :=  false ;
        image_clear.Enabled := false ;
     end
     else
       begin
        image_erase.Enabled := true;
        image_clear.Enabled := true;
       end;
end;

procedure Tbaby_basket.add_basketClick(Sender: TObject);
var
  idx : integer;
  sheet: TTabSheet;
  thumbs : TThumbControl;
  i : integer;
  j : integer;
  sub_item : TMenuItem;
  dir : string;
  main_dir : string;
begin
     dir := baby_tree.Root;
     if baby_select.Execute then
     begin
          for i := 0 to baby_tabs.Tabs.Count - 1 do
          begin
               if baby_tabs.Tabs[i] = baby_select.FileName then
                  exit;
          end;
          idx := baby_tabs.Tabs.Add( baby_select.FileName );
          baby_tabs.TabIndex := idx;
          baby_thumbs.Directory := baby_select.FileName;
          baby_thumbs.Invalidate;
          for i:= 0 to Screen.FormCount - 1 do
           begin
              if ( Screen.Forms[i] is Tpretty_image_frm ) then
              begin
                   Tpretty_image_frm( Screen.Forms[i]).pretty_image_frm_pop.Items[1].Clear;
                   for j := 0 to baby_tabs.Tabs.Count - 1 do
                   begin
                     sub_item := TMenuItem.Create( Tpretty_image_frm( Screen.Forms[i]).pretty_image_frm_pop );
                     sub_item.Caption := baby_tabs.Tabs[j];
                     sub_item.OnClick := @main_view_update;
                     Tpretty_image_frm( Screen.Forms[i]).pretty_image_frm_pop.Items[1].Add( sub_item );
                   end;
              end;
           end;
           with baby_tree do
           begin
             Root := '';
             Refresh;
             Root := dir;
             Invalidate;
           end;

     end;
end;

procedure Tbaby_basket.left_btnClick(Sender: TObject);
begin
       baby_basket.left := 0;
       baby_basket.width := frm_pretty_baby_main.pretty_list_view.Width + frm_pretty_baby_main.thumb_view.Width;
       right_btn.Enabled := true;
       left_btn.Enabled := false;
end;

procedure Tbaby_basket.right_btnClick(Sender: TObject);
begin
     baby_basket.width :=  baby_basket.original_width;
     baby_basket.Left := ( frm_pretty_baby_main.left + frm_pretty_baby_main.width ) - baby_basket.width;
     baby_basket.Top := ( frm_pretty_baby_main.top + frm_pretty_baby_main.height ) + baby_basket.height; ;
     baby_basket.Visible := true;
     right_btn.Enabled := false;
     left_btn.Enabled := true;
end;



procedure Tbaby_basket.baby_thumbsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  image : TThreadedImage;
  url : string;
begin
      image_hit.X := X;
      image_hit.Y := Y;

      image := TThumbControl( Sender ).ItemFromPoint( image_hit );
      if image <> nil then
      begin
         current_baby_url := image.URL;
      end;

      if Button = mbLeft then
          TThumbControl( Sender ).BeginDrag( true );

      if Button = mbRight then
      begin
         Timer1.Enabled := false;
         if image = nil then
         begin
            image_erase.Enabled := false;
         end
         else
             image_erase.Enabled := true;

         if  TThumbControl( Sender ).ImageLoaderManager.CountItems = 0  then
            image_clear.Enabled := false
         else
            image_clear.Enabled := true;
      end;

end;

procedure Tbaby_basket.baby_thumbsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  image : TThreadedImage;
  point : TPoint;
begin
    point.X := X;
    point.Y := Y;
    image := baby_thumbs.ImageLoaderManager.ItemFromPoint( point );
    if image <> nil then
    begin
        frm_pretty_baby_main.status_bar.Panels[1].Text := image.URL;
    end;
end;

procedure Tbaby_basket.baby_thumbsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

     Timer1.Enabled := true
end;

procedure Tbaby_basket.baby_thumbsSelectItem(Sender: TObject;
  Item: TThreadedImage);
begin
     frm_pretty_baby_main.status_bar.Panels[1].Text := Item.URL;
end;

procedure Tbaby_basket.baby_treeChange(Sender: TObject; Node: TTreeNode);
var
   idx : integer;
   i : integer;
   j : integer;
   sub_item : TMenuItem;
begin
      {if ( length( baby_tree.GetSelectedNodePath() ) <> 0 ) then
      begin
         baby_thumbs.Directory := baby_tree.GetSelectedNodePath();
         baby_thumbs.Invalidate;
         Caption := baby_tree.GetSelectedNodePath();

         for i := 0 to baby_tabs.Tabs.Count - 1 do
          begin
               if baby_tabs.Tabs[i] = baby_thumbs.Directory   then
               begin
                  baby_tabs.TabIndex := i;
                  exit;
               end;
           end;
           idx := baby_tabs.Tabs.Add( baby_thumbs.Directory );
           baby_tabs.TabIndex := idx;

           for i:= 0 to Screen.FormCount - 1 do
           begin
              if ( Screen.Forms[i] is Tpretty_image_frm ) then
              begin
                   Tpretty_image_frm( Screen.Forms[i]).pretty_image_frm_pop.Items[1].Clear;
                   for j := 0 to baby_tabs.Tabs.Count - 1 do
                   begin
                     sub_item := TMenuItem.Create( Tpretty_image_frm( Screen.Forms[i]).pretty_image_frm_pop );
                     sub_item.Caption := baby_tabs.Tabs[j];
                     Tpretty_image_frm( Screen.Forms[i]).pretty_image_frm_pop.Items[1].Add( sub_item );
                   end;
              end;
           end;
     end;

     frm_pretty_baby_main.mainmenu1.Items[2].Clear;
     for i:= 0 to baby_tabs.Tabs.Count - 1 do
     begin
        sub_item := TMenuItem.Create(   frm_pretty_baby_main.mainmenu1.Items );
        sub_item.Caption := baby_basket.baby_tabs.Tabs[i];
        sub_item.ImageIndex := 9;
        sub_item.OnClick := @main_view_update;
        frm_pretty_baby_main.mainmenu1.Items[2].Add( sub_item );
     end;   }
end;

procedure Tbaby_basket.baby_thumbsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  image : TThreadedImage;
  url : string;
  source_file : string;
  link_file : string;
  str : string;
  idx : integer;
  dir : string;
begin
     if Source is TThumbControl then
     begin
         if TThumbControl( Source ).Owner = frm_pretty_baby_main then
            image := TThumbControl( Source ).ItemFromPoint( frm_pretty_baby_main.image_hit )
         else
            image := TThumbControl( Source ).ItemFromPoint( baby_basket.image_hit );

         if image <> nil then
         begin
            str := TThumbControl( Sender ).Directory;
            TThumbControl( Sender ).Directory := '';
            source_file := ExtractFileName( image.URL );
            fpSymlink( PChar( image.URL ) ,  PChar( str + '/' + source_file ) );
            link_file := str + '/' + source_file;
            dir := ExtractFileDir( link_file );
            with TThumbControl( Sender ) do
            begin
              ImageLoaderManager.AddImage( link_file );
              Directory := str;
              Invalidate;
            end;
            current_baby_url := link_file;
         end;
     end;

     if Source is TImage then
     begin
           if TImage( Source ).Owner is Tpretty_image_frm then
           begin
                if TImage( Source ).Picture <> nil then
                begin
                   str := TThumbControl( Sender ).Directory;
                   source_file := ExtractFileName( Tpretty_image_frm( TImage( Source ).Owner ).Caption );
                   fpSymlink( PChar( Tpretty_image_frm( TImage( Source ).Owner ).Caption ) ,  PChar( str + '/' + source_file ) );
                   link_file := str + '/' + source_file;
                   with TThumbControl( Sender ) do
                   begin
                      ImageLoaderManager.AddImage( link_file );
                      Directory := str;
                      Invalidate;
                   end;
                   current_baby_url := link_file;
                end;
           end
           else
           begin
             if TImage( Source ).Picture <> nil then
             begin
              str := TThumbControl( Sender ).Directory;
              source_file := ExtractFileName( frm_pretty_baby_main.current_image.Hint );
              fpSymlink( PChar( frm_pretty_baby_main.current_image.Hint ) ,  PChar( str + '/' + source_file ) );
              link_file := str + '/' + source_file;
              with TThumbControl( Sender ) do
              begin
                ImageLoaderManager.AddImage( link_file );
                Directory := str;
                Invalidate;
              end;
              current_baby_url := link_file;
             end;
           end;
     end;

     if Source is TShellListView then
     begin
        if TShellListView( Source ).Items.Count > 0 then
        begin
         str := TShellListView( Source ).Selected.Caption;
         dir := frm_pretty_baby_main.thumb_view.Directory;
         source_file := ExtractFileName( frm_pretty_baby_main.current_url );
         frm_pretty_baby_main.status_bar.Panels[1].Text := str;

         //url_idx := frm_pretty_baby_main.pretty_list_view.Selected.Index;
        end;
     end;
end;

procedure Tbaby_basket.baby_thumbsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure Tbaby_basket.baby_pagesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     Accept := true;
end;

procedure Tbaby_basket.baby_tabsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

    if Button = mbLeft then
      TImage( Sender ).BeginDrag( true );
end;



procedure Tbaby_basket.baby_thumbsDblClick(Sender: TObject);
var
  image : TThreadedImage;
  filename : string;
begin

       try
         image := baby_thumbs.ItemFromPoint( image_hit );
         if image <> nil then
         begin

            frm_pretty_baby_main.status_bar.Panels[1].Text := image.URL;
            frm_pretty_baby_main.current_image.Picture.LoadFromFile( image.URL );
            current_baby_url := image.URL;
            frm_pretty_baby_main.current_url := current_baby_url;
            frm_pretty_baby_main.current_image.Stretch := true;
            frm_pretty_baby_main.current_image.Hint := image.URL;

         end;

       finally
         //
       end;
end;

{$R *.lfm}

end.

