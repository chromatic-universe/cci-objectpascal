unit vtree_impl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls , unix, strutils, Process,
  baseunix;

const
  is_file : byte = 8;
  is_directory : byte = 4;
  is_symbolic : byte = 10;

type
  PPrettyRec = ^TPrettyRec;
  TPrettyRec = record
    Caption: string;
    Path : string;
    is_populated : boolean;
end;


 function process_directory( var tree : TTreeView; dir : string; node : TTreeNode ) : integer;
 function process_files( dir : string; node : TTreeNode; var lst : TListBox ) : integer;
 function item_is_file( path : string ) : boolean;
 function delete_directory_files( directory : string ) : integer;
 function grab_num_files( directory_str : string ) : integer;

implementation

{$R *.lfm}

function grab_num_files( directory_str : string ) : integer;
var
  directory_ptr : PDir;
  ADirent : PDirent;
  entry : Longint;
  count : integer;
  begin
        count := 0;
        directory_ptr := fpopendir( directory_str );
        if directory_ptr = nil then exit;

        try
          repeat
            entry := TellDir( directory_ptr );
            ADirent:= fpreaddir ( directory_ptr^ );
            if ADirent <> nil then
            begin
               inc( count );
            end;
          until ADirent = nil;
        finally
           if directory_ptr <> nil then fpclosedir( directory_ptr^ );
        end;

        grab_num_files := count;
end;

function delete_directory_files( directory : string ) : integer;
var
  directory_ptr : PDir;
  dirent : PDirent;
  entry : integer;
  typ : byte;
  path : string;
  count : integer;
  i : integer;
begin
     count := 0;
     try
         try
            directory_ptr := fpopendir( directory );
            if directory_ptr = nil then exit;

            repeat
                entry := TellDir(  directory_ptr );
                dirent := fpreaddir (  directory_ptr^ );
                if dirent <> nil then
                begin
                 inc( count );
                 path := directory + '/' + dirent^.d_name;
                 typ := dirent^.d_type;
                 if ( typ = is_file ) or ( typ = is_symbolic ) then
                 begin
                      path := directory + '/' + dirent^.d_name;
                      DeleteFile( path );
                 end;
                 for i := 0 to Screen.FormCount - 1 do
                 begin
                     if Screen.Forms[i].Caption = path then
                     begin
                         Screen.Forms[i].Close;
                     end;
                 end;
                end;
            until dirent = nil ;
         except
             ShowMessage( 'Could not delete file ' + path );
         end;
     finally
        if directory_ptr <> nil then fpclosedir( directory_ptr^ );
     end;

     delete_directory_files := count;
end;


function item_is_file( path : string ) : boolean;
var
     directory_ptr : PDir;
     dirent : PDirent;
     b_ret : boolean;
begin
     try
        directory_ptr := fpopendir( path );
        if directory_ptr = nil then result := true else result := false;
     finally
         if directory_ptr <> nil then fpclosedir( directory_ptr^ );
     end;
end;

function process_files( dir : string; node : TTreeNode; var lst : TListBox ) : integer;
var
  directory_ptr : PDir;
  dirent : PDirent;
  entry : Longint;
  count : integer;
  next_node : TTreeNode;
  typ : integer;
  lv : TListItem;
begin
     try
      count := 0;
      directory_ptr := fpopendir( dir );
      if directory_ptr = nil then exit;

      lst.Items.Clear;
      repeat
        entry := TellDir( directory_ptr );
        dirent := fpreaddir ( directory_ptr^ );
        if dirent <> nil then
        begin
          inc( count );
          typ := dirent^.d_type;
          if ( typ = is_file ) or ( typ = is_symbolic ) then
          begin
                lst.Items.Add( dirent^.d_name );
          end;
         end;
      until dirent = nil;
     finally
       if directory_ptr <> nil then fpclosedir( directory_ptr^ );
     end;

     process_files := count;
end;


function process_directory( var tree : TTreeView; dir : string; node : TTreeNode ) : integer;
var
  directory_ptr : PDir;
  dirent : PDirent;
  entry : Longint;
  count : integer;
  next_node : TTreeNode;
  idx : integer;
  jdx : integer;
  lst : TStringList;
begin
      try
        try
            lst := TStringList.Create;
            lst.Sorted := true;
            count := 0;
            directory_ptr := fpopendir( dir );
            if directory_ptr = nil then exit;

            repeat
              entry := TellDir( directory_ptr );
              dirent := fpreaddir ( directory_ptr^ );

              if dirent <> nil then
              begin
                inc( count );
                if  dirent^.d_type = is_directory then
                begin
                  if ( dirent^.d_name = '.' ) or
                      ( dirent^.d_name = '..' ) then continue
                  else
                    begin
                      lst.Add( dirent^.d_name );
                    end;
                  end;
              end;
            until dirent = nil;
            for idx := 0 to lst.Count - 1 do
            begin
                   next_node := tree.Items.AddChild( node , lst[idx] );
                   next_node.ImageIndex := 5;
                   tree.FullExpand;
            end;
            tree.MakeSelectionVisible;
            process_directory := count;
        except
             ShowMessage( 'Could not process directory ' + dir );
        end;
      finally
        lst.Free;
        if directory_ptr <> nil then fpclosedir( directory_ptr^ );
      end;

end;






end.
