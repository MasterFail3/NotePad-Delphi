unit unitNotes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonNew: TButton;
    ButtonSave: TButton;
    ButtonDelete: TButton;
    FileBox: TListBox;
    Label1: TLabel;
    TextBox: TMemo;
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonNewClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure OnCreate(Sender: TObject);


  private

  public

  end;

var
  MainWindow: TForm1;




implementation

{$R *.lfm}

{ TForm1 }



end.

