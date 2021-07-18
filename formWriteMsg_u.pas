unit formWriteMsg_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtDlgs,
  Vcl.ExtCtrls, System.UITypes;

type
  TFormWriteMsg = class(TForm)
    MainMenu: TMainMenu;
    MenuFile: TMenuItem;
    MenuOpen: TMenuItem;
    MenuEdit: TMenuItem;
    MenuProcess: TMenuItem;
    MenuHelp: TMenuItem;
    MenuSave: TMenuItem;
    MenuExit: TMenuItem;
    MenuCut: TMenuItem;
    MenuCopy: TMenuItem;
    MenuPaste: TMenuItem;
    MenuWriteMsg: TMenuItem;
    MenuReadMsg: TMenuItem;
    MenuAbout: TMenuItem;
    GroupBoxMsg: TGroupBox;
    GroupBox1: TGroupBox;
    BtnWriteMsg: TButton;
    BtnImgCheck: TButton;
    BtnCancel: TButton;
    Label1: TLabel;
    EditMax: TEdit;
    Label2: TLabel;
    EditRemains: TEdit;
    GroupBox2: TGroupBox;
    Image: TImage;
    OpenPictureDialog: TOpenPictureDialog;
    SavePictureDialog: TSavePictureDialog;
    MenuNew: TMenuItem;
    MemoMsg: TMemo;
    procedure MenuNewClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuSaveClick(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuCutClick(Sender: TObject);
    procedure MenuCopyClick(Sender: TObject);
    procedure MenuPasteClick(Sender: TObject);
    procedure MenuWriteMsgClick(Sender: TObject);
    procedure MenuReadMsgClick(Sender: TObject);
    procedure MenuAboutClick(Sender: TObject);
    procedure BtnImgCheckClick(Sender: TObject);
    procedure BtnWriteMsgClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure MemoMsgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWriteMsg: TFormWriteMsg;
  MaxChar, InfoRow, InfoColumn, Height, Width, TextLength: Integer;
  Filename: String;
  hdc1: HDC;
  Start, Finish: TDateTime;

implementation

function binary(angka: byte): string;
var
  a, sisa: Integer;
  car: string[1];
  hasil: string[8];
begin
  hasil := '00000000';
  a := 0;
  if angka <> 0 then
  begin
    while angka <> 1 do
    begin
      sisa := angka mod 2;
      str(sisa, car);
      hasil[8 - a] := car[1];
      angka := trunc(angka / 2);
      inc(a);
    end;
    str(angka, car);
    hasil[8 - a] := car[1];
  end;
  binary := hasil;
end;

function binary16(angka: Word): string;
var
  a, sisa: Integer;
  car: string[1];
  hasil: string[16];
begin
  hasil := '0000000000000000';
  a := 0;
  if angka <> 0 then
  begin
    while angka <> 1 do
    begin
      sisa := angka mod 2;
      str(sisa, car);
      hasil[16 - a] := car[1];
      angka := trunc(angka / 2);
      inc(a);
    end;
    str(angka, car);
    hasil[16 - a] := car[1];
  end;
  binary16 := hasil;
end;

function power(x, y: Integer): Integer;
var
  i, hasil: Integer;
begin
  hasil := 1;
  if y = 0 then
    hasil := 1;
  for i := 1 to y do
    hasil := hasil * x;
  power := hasil;
end;

function decimal(bnr: string): Integer;
var
  hasil, panjang, x: Integer;
begin
  hasil := 0;
  panjang := length(bnr);
  for x := 1 to panjang do
    if bnr[x] = '1' then
      hasil := hasil + power(2, panjang - x);
  decimal := hasil;
end;

{$R *.dfm}

procedure TFormWriteMsg.BtnCancelClick(Sender: TObject);
begin
  Image.Picture.Bitmap := nil;
  MenuWriteMsg.Enabled := False;
  MenuReadMsg.Enabled := True;
  MemoMsg.Lines.Clear;
  MemoMsg.Visible := False;
  EditMax.Clear;
  EditRemains.Clear;
end;

procedure TFormWriteMsg.BtnImgCheckClick(Sender: TObject);
var
  i, Red, Green, Blue: Integer;
  fleck, BinaryCheck, Word1, Word2, Word3: String;
begin

  for i := 0 to 7 do
  begin
    Red := GetRValue(getpixel(Image.Canvas.Handle, i, 0));
    Green := GetGValue(getpixel(Image.Canvas.Handle, i, 0));
    Blue := GetBValue(getpixel(Image.Canvas.Handle, i, 0));
    BinaryCheck := BinaryCheck + (binary(Blue))[8] + (binary(Green))[8] +
      (binary(Red))[8];
  end;
  Word1 := Chr(decimal(Copy(BinaryCheck, 1, 8)));
  Word2 := Chr(decimal(Copy(BinaryCheck, 9, 8)));
  Word3 := Chr(decimal(Copy(BinaryCheck, 17, 8)));
  fleck := Word1 + Word2 + Word3;

  if fleck = '@#$' then
  begin
    MessageDlg('File gambar sudah berisi pesan, cari file gambar lain !',
      mtError, [mbOK], 0);
    Image.Picture.Bitmap := nil;
    MenuWriteMsg.Enabled := False;
    MenuReadMsg.Enabled := True;
    MenuSave.Enabled := False;
    BtnWriteMsg.Enabled := False;
    BtnCancel.Enabled := False;
    BtnImgCheck.Enabled := False;
    MemoMsg.Visible := False;
    MemoMsg.Lines.Clear;
    EditMax.Clear;
    EditRemains.Clear;
  end
  else
  begin
    MessageDlg('File gambar belum berisi pesan!', mtConfirmation, [mbOK], 0);
  end;
end;

procedure TFormWriteMsg.BtnWriteMsgClick(Sender: TObject);
var
  i, merah, hijau, biru, MerahBaru, BiruBaru, HijauBaru, InfoKolom, InfoBaris,
    n, j, z, x: Integer;
  fleck, BinerMerah, BinerHijau, BinerBiru, CekBiner, BinerPesan, huruf1,
    huruf2, huruf3, BinerFleck, BinerBaris, BinerKolom, pesan: string;
begin
  Image.Height := Image.Picture.Height;
  Image.Width := Image.Picture.Width;
  Height := Image.Height;
  Width := Image.Width;
  if MemoMsg.Lines.Text = '' then
  begin
    MessageDlg('Pesan belum diisi !', mtError, [mbOK], 0);
    exit;
  end
  else
    BtnWriteMsg.Enabled := False;
  BtnCancel.Enabled := False;
  BtnImgCheck.Enabled := False;
  MenuReadMsg.Enabled := False;
  hdc1 := Image.Canvas.Handle;
  // cek fleck
  for i := 0 to 7 do
  begin
    merah := GetRValue(getpixel(Image.Canvas.Handle, i, 0));
    hijau := GetGValue(getpixel(Image.Canvas.Handle, i, 0));
    biru := GetBValue(getpixel(Image.Canvas.Handle, i, 0));
    CekBiner := CekBiner + (binary(biru))[8] + (binary(hijau))[8] +
      (binary(merah))[8];
  end;
  huruf1 := Chr(decimal(Copy(CekBiner, 1, 8)));
  huruf2 := Chr(decimal(Copy(CekBiner, 9, 8)));
  huruf3 := Chr(decimal(Copy(CekBiner, 17, 8)));
  fleck := huruf1 + huruf2 + huruf3;
  if fleck = '@#$' then
  begin
    MessageDlg('File gambar sudah berisi pesan, cari File yang lain!', mtError,
      [mbOK], 0);
    Image.Picture.Bitmap := nil;
    MenuWriteMsg.Enabled := False;
    MenuReadMsg.Enabled := True;
    MenuSave.Enabled := False;
    BtnWriteMsg.Enabled := False;
    BtnCancel.Enabled := False;
    BtnImgCheck.Enabled := False;
    MemoMsg.Visible := False;
    MemoMsg.Lines.Clear;
    EditMax.Clear;
    EditRemains.Clear;
    exit;
  end
  else
    // sisip fleck
    Screen.Cursor := CrHourGlass;
  fleck := '@#$';
  BinerFleck := '';
  n := 1;
  for i := 1 to 3 do
    BinerFleck := BinerFleck + binary(ord(fleck[i]));
  z := 0;
  for i := 0 to 7 do
  begin
    inc(z);
    merah := GetRValue(getpixel(Image.Canvas.Handle, i, 0));
    hijau := GetGValue(getpixel(Image.Canvas.Handle, i, 0));
    biru := GetBValue(getpixel(Image.Canvas.Handle, i, 0));
    BinerMerah := binary(merah);
    BinerHijau := binary(hijau);
    BinerBiru := binary(biru);
    delete(BinerMerah, 8, 1);
    delete(BinerHijau, 8, 1);
    delete(BinerBiru, 8, 1);
    BinerBiru := BinerBiru + BinerFleck[n];
    BinerHijau := BinerHijau + BinerFleck[n + 1];
    BinerMerah := BinerMerah + BinerFleck[n + 2];
    n := n + 3;
    MerahBaru := decimal(BinerMerah);
    HijauBaru := decimal(BinerHijau);
    BiruBaru := decimal(BinerBiru);
    setpixelV(hdc1, i, 0, RGB(MerahBaru, HijauBaru, BiruBaru));
  end;
  // sisip_pesan
  pesan := MemoMsg.Lines.Text;
  BinerPesan := '';
  TextLength := length(MemoMsg.Lines.Text);
  for i := 1 to TextLength do
  begin
    BinerPesan := BinerPesan + binary(ord(pesan[i]));
  end;
  n := 1;
  for j := 1 to Image.Height - 1 do
  begin
    for i := 0 to Image.Width - 1 do
    begin
      inc(z);
      merah := GetRValue(getpixel(Image.Canvas.Handle, i, j));
      hijau := GetGValue(getpixel(Image.Canvas.Handle, i, j));
      biru := GetGValue(getpixel(Image.Canvas.Handle, i, j));
      BinerMerah := binary(merah);
      BinerHijau := binary(hijau);
      BinerBiru := binary(biru);
      delete(BinerMerah, 8, 1);
      delete(BinerHijau, 8, 1);
      delete(BinerBiru, 8, 1);
      BinerBiru := BinerBiru + BinerPesan[n];
      BinerHijau := BinerHijau + BinerPesan[n + 1];
      BinerMerah := BinerMerah + BinerPesan[n + 2];
      n := n + 3;
      MerahBaru := decimal(BinerMerah);
      HijauBaru := decimal(BinerHijau);
      BiruBaru := decimal(BinerBiru);
      setpixelV(hdc1, i, j, RGB(MerahBaru, HijauBaru, BiruBaru));
      if n > length(BinerPesan) then
        break;
    end;
    if n > length(BinerPesan) then
      break;
  end;
  // sisip baris
  InfoBaris := j;
  BinerBaris := binary16(InfoBaris);
  n := 1;
  for x := 8 to 15 do
  begin
    inc(z);
    biru := GetBValue(getpixel(Image.Canvas.Handle, x, 0));
    hijau := GetGValue(getpixel(Image.Canvas.Handle, x, 0));
    merah := GetRValue(getpixel(Image.Canvas.Handle, x, 0));
    BinerHijau := binary(hijau);
    BinerMerah := binary(merah);
    delete(BinerHijau, 8, 1);
    delete(BinerMerah, 8, 1);
    BinerHijau := BinerHijau + BinerBaris[n];
    BinerMerah := BinerMerah + BinerBaris[n + 1];
    HijauBaru := decimal(BinerHijau);
    MerahBaru := decimal(BinerMerah);
    n := n + 2;
    setpixelV(Image.Canvas.Handle, x, 0, RGB(MerahBaru, HijauBaru, biru));
  end;
  // sisip_kolom
  InfoKolom := i;
  BinerKolom := binary16(InfoKolom);
  n := 1;
  for x := 16 to 23 do
  begin
    inc(z);
    biru := GetBValue(getpixel(Image.Canvas.Handle, x, 0));
    hijau := GetGValue(getpixel(Image.Canvas.Handle, x, 0));
    merah := GetRValue(getpixel(Image.Canvas.Handle, x, 0));
    BinerHijau := binary(hijau);
    BinerMerah := binary(merah);
    delete(BinerHijau, 8, 1);
    delete(BinerMerah, 8, 1);
    BinerHijau := BinerHijau + BinerKolom[n];
    BinerMerah := BinerMerah + BinerKolom[n + 1];
    HijauBaru := decimal(BinerHijau);
    MerahBaru := decimal(BinerMerah);
    n := n + 2;
    setpixelV(Image.Canvas.Handle, x, 0, RGB(MerahBaru, HijauBaru, biru));
  end;
  Screen.Cursor := crdefault;
  Image.Refresh;
  MenuOpen.Enabled := False;
  MenuNew.Enabled := False;
  MenuReadMsg.Enabled := False;
  MenuSave.Enabled := True;
  MemoMsg.Lines.Clear;
  EditMax.Clear;
  EditRemains.Clear;
  MemoMsg.Visible := False;
end;

procedure TFormWriteMsg.MemoMsgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  TextRemains, x: Integer;
begin
  EditRemains.Text := EditMax.Text;
  x := length(MemoMsg.Lines.Text) + 1;
  TextRemains := MemoMsg.MaxLength - x;
  EditRemains.Text := IntToStr(TextRemains);
end;

procedure TFormWriteMsg.MenuAboutClick(Sender: TObject);
begin
  // todo add form about
end;

procedure TFormWriteMsg.MenuCopyClick(Sender: TObject);
begin
  MemoMsg.CopyToClipboard;
end;

procedure TFormWriteMsg.MenuCutClick(Sender: TObject);
begin
  MemoMsg.CutToClipboard;
end;

procedure TFormWriteMsg.MenuExitClick(Sender: TObject);
var
  BtnMesgDlg: Word;
begin
  BtnMesgDlg := MessageDlg('Keluar dari form Tulis Pesan ?', mtConfirmation,
    [mbYes, mbNo], 0);
  if BtnMesgDlg = mrYes then
    FormWriteMsg.Close;
end;

procedure TFormWriteMsg.MenuNewClick(Sender: TObject);
begin
  Image.Picture.Bitmap := nil;
  MenuOpen.Enabled := True;
  MenuWriteMsg.Enabled := False;
  MenuSave.Enabled := False;
  BtnWriteMsg.Enabled := False;
  BtnCancel.Enabled := False;
  BtnImgCheck.Enabled := False;
  MemoMsg.Visible := False;
  EditMax.Clear;
  EditRemains.Clear;
end;

procedure TFormWriteMsg.MenuOpenClick(Sender: TObject);
var
  Filename: String;
  Height, Width, MaxText: Integer;
begin
  if OpenPictureDialog.Execute then
  begin
    Filename := OpenPictureDialog.Filename;
    Image.Picture.LoadFromFile(Filename);
    Image.Height := Image.Picture.Height;
    Image.Width := Image.Picture.Width;
    Height := Image.Height;
    Width := Image.Width;
    if (Width < 24) or (Height < 2) then
    begin
      MessageDlg
        ('File gambar harus lebar >= 24 & tinggi > 2, Cari File yang lain!',
        mtError, [mbOK], 0);
      Image.Picture.Bitmap := nil;
      MenuWriteMsg.Enabled := False;
      MenuReadMsg.Enabled := True;
      MenuNew.Enabled := True;
      MenuOpen.Enabled := True;
      MenuSave.Enabled := False;
      BtnWriteMsg.Enabled := False;
      BtnCancel.Enabled := False;
      BtnImgCheck.Enabled := False;
      MemoMsg.Visible := False;
      MemoMsg.Lines.Clear;
      EditMax.Clear;
      EditRemains.Clear;
      exit;
    end;
    BtnWriteMsg.Enabled := True;
    BtnCancel.Enabled := True;
    BtnImgCheck.Enabled := True;
    MenuReadMsg.Enabled := False;
    MemoMsg.Visible := True;
    MemoMsg.Lines.Clear;
    MaxText := (Width * (Height - 1) * 3) div 8;
    MemoMsg.MaxLength := MaxText;
    EditMax.Text := IntToStr(MaxText);
    EditRemains.Text := IntToStr(MaxText);
  end;

end;

procedure TFormWriteMsg.MenuPasteClick(Sender: TObject);
begin
  MemoMsg.PasteFromClipboard;
end;

procedure TFormWriteMsg.MenuReadMsgClick(Sender: TObject);
var
  CanSave: Boolean;
begin
  SavePictureDialog.DefaultExt := 'Bmp';
  Image.Height := Image.Picture.Height;
  Image.Width := Image.Picture.Width;
  Height := Image.Height;
  Width := Image.Width;
  if SavePictureDialog.Execute then
  begin
    Filename := SavePictureDialog.Filename;
    if not FileExists(SavePictureDialog.Filename) then
      CanSave := True
    else
      CanSave := MessageDlg('File' + Filename + 'sudah ada, tetap simpan ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    if CanSave then
    begin
      Image.Picture.SaveToFile(Filename);
      BtnImgCheck.Enabled := False;
      Image.Picture.Bitmap := nil;
      BtnCancel.Enabled := False;
      BtnWriteMsg.Enabled := False;
      MenuReadMsg.Enabled := True;
      MenuOpen.Enabled := True;
      MenuSave.Enabled := False;
    end
    else
      MenuSave.Enabled := True;
  end;

end;

procedure TFormWriteMsg.MenuSaveClick(Sender: TObject);
var
  CanSave: Boolean;
begin
  SavePictureDialog.DefaultExt := 'Bmp';
  Image.Height := Image.Picture.Height;
  Image.Width := Image.Picture.Width;
  Height := Image.Height;
  Width := Image.Width;

  if SavePictureDialog.Execute then
  begin
    Filename := SavePictureDialog.Filename;

    if not FileExists(SavePictureDialog.Filename) then
      CanSave := True
    else
      CanSave := MessageDlg('File' + Filename + 'sudah ada, tetap simpan ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    if CanSave then
    begin
      Image.Picture.SaveToFile(Filename);
      BtnImgCheck.Enabled := False;
      Image.Picture.Bitmap := nil;
      BtnCancel.Enabled := False;
      BtnWriteMsg.Enabled := False;
      MenuReadMsg.Enabled := True;
      MenuOpen.Enabled := True;
      MenuSave.Enabled := False;
    end
    else
      MenuSave.Enabled := True;
  end;
end;

procedure TFormWriteMsg.MenuWriteMsgClick(Sender: TObject);
begin
  MenuWriteMsg.Enabled := False;
end;

end.
