unit steganofrafi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, formWriteMsg_u,
  formReadMsg_u;

type
  TFormMenu = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    BtnWriteMessage: TButton;
    BtnReadMessage: TButton;
    BtnExit: TButton;
    procedure BtnWriteMessageClick(Sender: TObject);
    procedure BtnReadMessageClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Type
  DataPixel = Array [0 .. 1000, 0 .. 1000] of integer;

var
  FormMenu: TFormMenu;

implementation

{$R *.dfm}

procedure TFormMenu.BtnExitClick(Sender: TObject);
var
  TombolMessageDlg: word;
begin
  TombolMessageDlg := MessageDlg('Keluar dari Aplikasi ?', mtConfirmation,
    [mbYes, mbNo], 0);
  if TombolMessageDlg = mrYes then
    Application.Terminate;
end;

procedure TFormMenu.BtnReadMessageClick(Sender: TObject);
begin
  FormReadMsg.Show;
  with FormReadMsg do
  begin
    Image.Picture.Bitmap := nil;
    MenuReadMsg.Enabled := False;
    MenuSave.Enabled := False;
    MenuCut.Enabled := False;
    MenuCopy.Enabled := False;
    MenuPaste.Enabled := False;
    BtnReadMsg.Enabled := False;
    BtnImgCheck.Enabled := False;
    MemoMsg.Visible := False;
    MemoMsg.Lines.Clear;
    EditMax.Enabled := False;
    EditMax.Color := clSilver;
    EditMax.Clear;
    EditUsed.Enabled := False;
    EditUsed.Color := clSilver;
    EditUsed.Clear;
    EditRemains.Enabled := False;
    EditRemains.Color := clSilver;
    EditRemains.Clear;
  end;
end;

procedure TFormMenu.BtnWriteMessageClick(Sender: TObject);
begin
  FormWriteMsg.Show;

  with FormWriteMsg do
  begin
    Image.Picture.Bitmap := nil;
    MenuWriteMsg.Enabled := False;
    MenuReadMsg.Enabled := True;
    MenuNew.Enabled := True;
    MenuOpen.Enabled := True;
    MenuSave.Enabled := False;
    MenuCut.Enabled := False;
    MenuCopy.Enabled := False;
    MenuPaste.Enabled := False;
    BtnWriteMsg.Enabled := False;
    BtnCancel.Enabled := False;
    BtnImgCheck.Enabled := False;
    MemoMsg.Visible := False;
    MemoMsg.Lines.Clear;
    EditMax.Enabled := False;
    EditMax.Color := clSilver;
    EditMax.Clear;
    EditRemains.Enabled := False;
    EditRemains.Color := clSilver;
    EditRemains.Clear;
  end;
end;

end.
