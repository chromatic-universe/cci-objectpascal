unit pretty_baby_image_manip;
//*********************************************************
//* PANNING a given image through a scrollbox component:- *
//*                                                       *
//* Author: Peter Carl Barnard                            *
//* Date Written: 2006/09/04                              *
//*                                                       *
//* License: NONE                                         *
//*                                                       *
//* Written for Delphi.About.Com (Guide Zarko Gajic)      *
//*                                                       *
//* See Website Delphi.About.Com for more details of the  *
//*             Delphi programming language               *
//*                                                       *
//* Language used: Delphi 7.01 (Pro)                      *
//*                                                       *
//* Restrictions: NONE - this source code is presented as *
//* a means of helping others, and by no means implies    *
//* that the author expects any form of recognition, use  *
//* it and modify it as you wish.                         *
//*********************************************************

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, CheckLst;
  //*********************************************************
  //* Include "jpeg" to deal with both JPG's and BMP's and  *
  //* of course use you own BPL's if you're going to  be    *
  //* using customrized image formats                       *
  //*********************************************************


type
  //*********************************************************
  //* Not to worry these declarations get filled in for you *
  //* by Delphi - Nice language isn't it ;-)                *
  //*********************************************************

  { Tfrm_manip }

  Tfrm_manip = class(TForm)
    CheckListBox1: TCheckListBox;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    ScrollBox1: TScrollBox;
    procedure FormShow(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    LX: Integer;
    LY: Integer;
  end;

var
  //******************
  //* Declares frm_manip *
  //******************
  frm_manip: Tfrm_manip;
  //************************************************************
  //* Declares the starting point of movement when "MOUSEDOWN" *
  //* occurs over the image. This is the reference point from  *
  //* which all subsequent vertical/horizontal mouse movement  *
  //* is going to be measured hence (S)tart X, (S)tart Y      *
  //************************************************************
  SX: Integer;
  SY: Integer;
  //**************************************************************
  //* Virtually ALL visual controls are referenced (within their *
  //* respective containers) by a point of origin ie: upper left *
  //* corner, which (normally) at time of loading is X=0, Y=0    *
  //*                                                            *
  //* This is not true for statically (especially) design time   *
  //* controls). We put them at a static location BECAUSE we want*
  //* them to appear where they were designed to be ...on a form,*
  //* inside a group box etc.                                    *
  //*                                                            *
  //* For the purposes of this exercise however we will assume   *
  //* that an image will ALWAYS be loaded at origin X=0, Y=0     *
  //* WITHIN IT'S CONTAINER namely it's scroll box.              *
  //*                                                            *
  //* SO!!! Now we already know the upper and leftmost limits = 0*
  //* But we also need to know what the bottom and rightmost     *
  //* extremities will be...this will prevent the image being    *
  //* panned off the scroll box. We don't know at time of run-   *
  //* time (dynamic) loading what the dimensions of our image is,*
  //* we'll have to calculate (L)ast X and (L)ast Y              *
  //**************************************************************


implementation

{$R *.lfm}

uses pretty_baby_image;

procedure Tfrm_manip.FormCreate(Sender: TObject);
begin
//**************************************************************
//* This is where it all starts - the form is initiated, not   *
//* much to do here EXCEPT make sure our image does'nt flicker *
//* when it moves - here's how to do it, set the property of   *
//* the scroll box "DoubleBuffered" to true. This makes the    *
//* scroll box paint itself from an "in memory" image BEFORE   *
//* painting to it's active window...True, it's more memory    *
//* intensive...but with the capabilities of the modern day    *
//* computer, this seldom causes a problem...                  *
//**************************************************************
ScrollBox1.DoubleBuffered := True;

//*********************************************************
//* Align the picture to given (known?) true co-ordinates *
//*********************************************************
Image1.Top := 0;
Image1.Left := 0;
//****************************************************************
//* Load the given picture - here I've simply used a screen dump *
//* from my own computer...in real terms you would normally write*
//* an open dialogue to allow the user to choose which image they*
//* would like to load                                           *
//****************************************************************
Image1.Picture.LoadFromFile('/home/wiljoh/pretty_baby/snaps/yoga-pants-40.jpg');
//LX := (Image1.Width - ScrollBox1.ClientWidth) * -1;
//LY := (Image1.Height - ScrollBox1.ClientHeight) * -1;
end;

procedure Tfrm_manip.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//******************************************************************
//* When the left button of the mouse is pressed - we need to trap *
//* what the EXACT pixel point is. This gives a reference point to *
//* calculate ALL subsequent mouse movement WHILE THE LEFT MOUSE   *
//* BUTTON IS DEPRESSED. In other words we'll know by how much the *
//* mouse is moving in it's selected DRAG mode                     *
//******************************************************************
SX := X;  // X start co-ordinate
SY := Y;  // Y start co-ordinate
end;

procedure Tfrm_manip.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
//*************************************************
//* OKAY!!! This is where all the work happens!!! *
//*************************************************
//***
//***
//********************************************************************
//* First we declare two new variables. These variables hold the new *
//* calculated point of origin of the bitmap (relative to containers *
//* global X=0, Y=0) and we will only allow movement IF the new point*
//* of origin stays within a visible area within the scroll box :-)  *
//*                                                                  *
//* Yes ... you guessed right ... they are (N)ew X and (N)ew Y       *
//********************************************************************
var NX: Integer;
    NY: Integer;
begin
//*****************************************************************
//* First make sure that the left mouse button is being held down *
//* TShiftState is a set and consists of the following:-          *
//*                                                               *
//* ssShift	The Shift key is held down.                           *
//* ssAlt	The Alt key is held down.                               *
//* ssCtrl	The Ctrl key is held down.                            *
//* ssLeft	The left mouse button is held down.                   *
//* ssRight	The right mouse button is held down.                  *
//* ssMiddle	The middle mouse button is held down.               *
//* ssDouble	The mouse was double-clicked.                       *
//*                                                               *
//* NOW REMEMBER ALL THIS IS HAPPENING WHILE THE MOUSE IS MOVING!!*
//*****************************************************************
if not (ssLeft in Shift) then
  Exit;
//*********************************************************
//* Calculate what our new X, Y point of origin should be *
//*********************************************************
NX := Image1.Left + X - SX;
NY := Image1.Top + Y - SY;
//***********************************************************
//* If the range of our new calculated X point falls within *
//* 0 - width of image, and negative (image width - scroll  *
//* box width) then set new point of origin X to NX         *
//***********************************************************
if (NX < 0) and (NX > LX) then
  Image1.Left := NX;
//***********************************************************
//* If the range of our new calculated Y point falls within *
//* 0 - height of image, and negative (image height - scroll*
//* box height) then set new point of origin Y to NY        *
//***********************************************************
if (NY < 0) and (NY > LY) then
  Image1.Top := NY;
//***********************************************
//* ALL DONE!!! IMAGE HAS BEEN RE-POSITIONED!!! *
//***********************************************
end;

procedure Tfrm_manip.FormShow(Sender: TObject);
begin
  //LX := (Image1.Width - ScrollBox1.ClientWidth) * -1;
  //LY := (Image1.Height - ScrollBox1.ClientHeight) * -1;
end;

end.
