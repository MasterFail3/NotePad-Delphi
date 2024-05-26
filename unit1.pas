unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    ButtonNew: TButton;
    ButtonSave: TButton;
    ButtonDelete: TButton;
    Label1: TLabel;
    FileBox: TListBox;
    TextBox: TMemo;
    procedure ButtonNewClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure FileBoxSelectionChange(Sender: TObject; User: boolean);
    procedure FormCreate(Sender: TObject);

  private

  public

  end;

var
  MainWindow: TMainWindow;
  searchResult: TSearchRec;



implementation

{$R *.lfm}

{ TMainWindow }

procedure TMainWindow.ButtonNewClick(Sender: TObject);
var
  fileName: String;
begin
   fileName := '';
   repeat
         if not InputQuery('Создать заметку', 'Введите название заметки', fileName) then exit;
         if (FileBox.Items.IndexOf(fileName) > -1)then
         ShowMessage('Такой файл уже существует');
   until(not FileBox.Items.IndexOf(fileName) > -1);
   FileBox.Items.Add(fileName);
   TextBox.Clear;
   TextBox.Lines.SaveToFile(fileName + '.note');
   FileBox.ItemIndex:=FileBox.Items.IndexOf(fileName);
end;

procedure TMainWindow.ButtonSaveClick(Sender: TObject);
var
   fileName: String;
begin
   fileName := FileBox.Items[FileBox.ItemIndex];
   TextBox.Lines.SaveToFile(fileName + '.note');

end;

procedure DeleteNote(FileBox: TListBox);
var
   fileName: String;
begin
   fileName := FileBox.Items[FileBox.ItemIndex];
   DeleteFile(fileName+'.note');
   FileBox.DeleteSelected;

end;

procedure TMainWindow.ButtonDeleteClick(Sender: TObject);
begin
   DeleteNote(FileBox);
   TextBox.Enabled := False;
   ButtonDelete.Enabled := False;
   ButtonSave.Enabled := False;
   TextBox.Clear;
end;

procedure TMainWindow.FileBoxSelectionChange(Sender: TObject; User: boolean);
var
   fileName: String;
begin

    if ((FileBox.Count = 0) or (FileBox.ItemIndex = -1)) then
    begin
      TextBox.Enabled := False;
      ButtonSave.Enabled := False;
      ButtonDelete.Enabled := False;
      Exit;
    end;
    TextBox.Enabled := True;
    ButtonSave.Enabled := True;
    ButtonDelete.Enabled := True;

    TextBox.Clear;
    fileName := FileBox.Items[FileBox.ItemIndex] + '.note';
    TextBox.Lines.LoadFromFile(fileName);

    //


end;

procedure TMainWindow.FormCreate(Sender: TObject);
var
   fileName: String;
begin
     textBox.Clear;
     CreateDir('Notes');
     ChDir('Notes');
     if FindFirst('*.note', faAnyFile, searchResult) = 0 then
     begin
       repeat
           fileName := searchResult.Name;
           Delete(fileName, LastDelimiter('.note', fileName) - 4, 5);
           FileBox.Items.Add(fileName);
       until FindNext(searchResult)<>0;
       FindClose(searchResult);
     end
     else
     begin
       FileBox.Items.Add('Новая заметка');
       TextBox.Lines.SaveToFile('Новая заметка.note');
     end;
end;


{ TMainWindow }


end.

