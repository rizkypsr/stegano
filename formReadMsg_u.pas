unit formReadMsg_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtDlgs,
  Vcl.ExtCtrls, System.UITypes, formWriteMsg_u;

type
  TFormReadMsg = class(TForm)
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
    BtnImgCheck: TButton;
    BtnReadMsg: TButton;
    Label1: TLabel;
    EditMax: TEdit;
    Label2: TLabel;
    EditRemains: TEdit;
    GroupBox2: TGroupBox;
    Image: TImage;
    OpenPictureDialog: TOpenPictureDialog;
    MenuNew: TMenuItem;
    MemoMsg: TMemo;
    Label3: TLabel;
    EditUsed: TEdit;
    SavePictureDialog: TSavePictureDialog;
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
    procedure BtnReadMsgClick(Sender: TObject);
    procedure BtnImgCheckClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure MemoMsgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormReadMsg: TFormReadMsg;
  TextLength: Integer;

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

function binary16(num: Word): String;
var
  a, sisa: Integer;
  car: String[1];
  results: String[16];
begin
  results := '0000000000000000';
  a := 0;
  if num <> 0 then
  begin
    while num <> 1 do
    begin
      sisa := num mod 2;
      str(sisa, car);
      results[16 - a] := car[1];
      num := trunc(num / 2);
      inc(a);
    end;
    str(num, car);
    results[16 - a] := car[1];
  end;
  binary16 := results;
end;

function power(x, y: Integer): Integer;
var
  i, results: Integer;
begin
  results := 1;

  if y = 0 then
    results := 1;

  for i := 1 to y do
    results := results * x;
  power := results;
end;

function decimal(bnr: String): Integer;
var
  results, bnrLength, x: Integer;
begin
  results := 0;
  bnrLength := Length(bnr);

  for x := 1 to bnrLength do
    if bnr[x] = '1' then
      results := results + power(2, bnrLength - x);
  decimal := results;
end;

{$R *.dfm}

procedure TFormReadMsg.BtnCancelClick(Sender: TObject);
begin
  Image.Picture.Bitmap := nil;
  MenuWriteMsg.Enabled := False;
  MenuReadMsg.Enabled := True;
  MemoMsg.Lines.Clear;
  MemoMsg.Visible := False;
  EditMax.Clear;
  EditRemains.Clear;
end;

procedure TFormReadMsg.BtnReadMsgClick(Sender: TObject);
var
  i, merah, hijau, biru, n, j, z, InfoBaris, InfoKolom, total, lebar, tinggi, x,
    TextMaks, sisa, KonvNMaks, KonvNPakai: Integer;
  fleck, BinerMerah, BinerHijau, BinerBiru, CekBiner, BinerPesan, huruf1,
    huruf2, huruf3, BinerBaris, BinerKolom, pesan, AmbilNMaks,
    AmbilNPakai: string;
begin
  Image.Height := Image.Picture.Height;
  Image.Width := Image.Picture.Width;
  tinggi := Image.Height;
  lebar := Image.Width;
  BtnReadMsg.Enabled := True;
  BtnImgCheck.Enabled := True;

  for i := 0 to 7 do
  begin
    merah := GetRValue(getpixel(Image.Canvas.Handle, i, 0));
    hijau := GetGValue(getpixel(Image.Canvas.Handle, i, 0));
    biru := GetBValue(getpixel(Image.Canvas.Handle, i, 0));
    CekBiner := CekBiner + (binary(biru))[8] + (binary(hijau))[8] +
      (binary(merah))[8];
  end;

  huruf1 := chr(decimal(copy(CekBiner, 1, 8)));
  huruf2 := chr(decimal(copy(CekBiner, 9, 8)));
  huruf3 := chr(decimal(copy(CekBiner, 17, 8)));
  fleck := huruf1 + huruf2 + huruf3;

  if fleck = '@#$' then
  begin
    // ambil info baris
    BinerBaris := '';
    for i := 8 to 15 do
    begin
      merah := GetRValue(getpixel(Image.Canvas.Handle, i, 0));
      hijau := GetGValue(getpixel(Image.Canvas.Handle, i, 0));
      BinerBaris := BinerBaris + (binary(hijau))[8] + (binary(merah))[8];
    end;
    InfoBaris := decimal(BinerBaris);
    // ambil info kolom
    BinerKolom := '';
    for i := 16 to 23 do
    begin
      merah := GetRValue(getpixel(Image.Canvas.Handle, i, 0));
      hijau := GetGValue(getpixel(Image.Canvas.Handle, i, 0));
      BinerKolom := BinerKolom + (binary(hijau))[8] + (binary(merah))[8];
    end;
    InfoKolom := decimal(BinerKolom);
    // ambil pesan dari gambar
    BinerPesan := '';
    begin
      total := (Image.Width * (InfoBaris - 1)) + InfoKolom + 1;
      for j := 1 to Image.Height - 1 do
      begin
        for i := 0 to Image.Width - 1 do
        begin
          inc(z);
          biru := GetBValue(getpixel(Image.Canvas.Handle, i, j));
          hijau := GetGValue(getpixel(Image.Canvas.Handle, i, j));
          merah := GetRValue(getpixel(Image.Canvas.Handle, i, j));
          BinerBiru := binary(biru);
          BinerHijau := binary(hijau);
          BinerMerah := binary(merah);
          BinerPesan := BinerPesan + copy(BinerBiru, 8, 1) +
            copy(BinerHijau, 8, 1) + copy(BinerMerah, 8, 1);
          if (j = InfoBaris) and (i = InfoKolom) then
            break;
        end;

        if (j = InfoBaris) and (i = InfoKolom) then
          break;
      end;
      n := 1;
      pesan := '';

      for i := 1 to (round(Length(BinerPesan) / 8)) do
      begin
        inc(z);
        pesan := pesan + chr(decimal(copy(BinerPesan, n, 8)));
        n := n + 8;
      end;
      MenuReadMsg.Enabled := False;
      MenuWriteMsg.Enabled := True;
      MemoMsg.Visible := True;
      MemoMsg.Lines.Text := pesan;
      Screen.Cursor := crdefault;
    end;
    TextMaks := (lebar * (tinggi - 1) * 3) div 8;
    MemoMsg.MaxLength := TextMaks;
    EditMax.Text := IntToStr(TextMaks);
    x := Length(MemoMsg.Lines.Text);
    EditUsed.Text := IntToStr(x);
    AmbilNMaks := EditMax.Text;
    AmbilNPakai := EditUsed.Text;
    KonvNMaks := StrToInt(AmbilNMaks);
    KonvNPakai := StrToInt(AmbilNPakai);
    sisa := KonvNMaks - KonvNPakai;
    EditRemains.Text := IntToStr(sisa);
  end
  else
  begin
    MessageDlg('File gambar tidak berisi pesan, cari file yang lain!', mtError,
      [mbOK], 0);
    Image.Picture.Bitmap := nil;
    exit;
    MenuReadMsg.Enabled := False;
    MenuWriteMsg.Enabled := True;
  end

end;

procedure TFormReadMsg.BtnImgCheckClick(Sender: TObject);
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
  Word1 := chr(decimal(copy(BinaryCheck, 1, 8)));
  Word2 := chr(decimal(copy(BinaryCheck, 9, 8)));
  Word3 := chr(decimal(copy(BinaryCheck, 17, 8)));
  fleck := Word1 + Word2 + Word3;

  if fleck = '@#$' then
  begin
    MessageDlg('File gambar sudah berisi pesan, cari file gambar lain !',
      mtError, [mbOK], 0);
    Image.Picture.Bitmap := nil;
    MenuWriteMsg.Enabled := False;
    MenuReadMsg.Enabled := True;
    MenuSave.Enabled := False;
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

procedure TFormReadMsg.MemoMsgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  TextRemains, x: Integer;
begin
  EditRemains.Text := EditMax.Text;
  x := Length(MemoMsg.Lines.Text) + 1;
  TextRemains := MemoMsg.MaxLength - x;
  EditRemains.Text := IntToStr(TextRemains);
end;

procedure TFormReadMsg.MenuAboutClick(Sender: TObject);
begin
  // todo add form about
end;

procedure TFormReadMsg.MenuCopyClick(Sender: TObject);
begin
  MemoMsg.CopyToClipboard;
end;

procedure TFormReadMsg.MenuCutClick(Sender: TObject);
begin
  MemoMsg.CutToClipboard;
end;

procedure TFormReadMsg.MenuExitClick(Sender: TObject);
var
  BtnMesgDlg: Word;
begin
  BtnMesgDlg := MessageDlg('Keluar dari form Tulis Pesan ?', mtConfirmation,
    [mbYes, mbNo], 0);
  if BtnMesgDlg = mrYes then
    FormReadMsg.Close;
end;

procedure TFormReadMsg.MenuNewClick(Sender: TObject);
begin
  Image.Picture.Bitmap := nil;
  MenuOpen.Enabled := True;
  MenuWriteMsg.Enabled := False;
  MenuSave.Enabled := False;
  BtnImgCheck.Enabled := False;
  BtnReadMsg.Enabled := False;
  MemoMsg.Lines.Clear;
  MemoMsg.Visible := False;
  EditMax.Clear;
  EditRemains.Clear;
end;

procedure TFormReadMsg.MenuOpenClick(Sender: TObject);
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
      BtnImgCheck.Enabled := False;
      MemoMsg.Visible := False;
      MemoMsg.Lines.Clear;
      EditMax.Clear;
      EditRemains.Clear;
      exit;
    end;
    BtnImgCheck.Enabled := True;
    BtnReadMsg.Enabled := True;
    MenuReadMsg.Enabled := False;
    MemoMsg.Visible := True;
    MemoMsg.Lines.Clear;
    MaxText := (Width * (Height - 1) * 3) div 8;
    MemoMsg.MaxLength := MaxText;
    EditMax.Text := IntToStr(MaxText);
    EditRemains.Text := IntToStr(MaxText);
  end;

end;

procedure TFormReadMsg.MenuPasteClick(Sender: TObject);
begin
  MemoMsg.PasteFromClipboard;
end;

procedure TFormReadMsg.MenuReadMsgClick(Sender: TObject);
var
  BtnMsgDlg: Word;
begin
  MenuReadMsg.Enabled := False;
end;

procedure TFormReadMsg.MenuSaveClick(Sender: TObject);
var
  Cansave: Boolean;
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
      Cansave := True
    else
      Cansave := MessageDlg('File' + Filename + 'sudah ada, tetap simpan ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    if Cansave then
    begin
      Image.Picture.SaveToFile(Filename);
      BtnReadMsg.Enabled := False;
      Image.Picture.Bitmap := nil;
      MenuReadMsg.Enabled := True;
      MenuOpen.Enabled := True;
      MenuSave.Enabled := False;
    end
    else
      MenuSave.Enabled := True;
  end;
end;

procedure TFormReadMsg.MenuWriteMsgClick(Sender: TObject);
var
  TombolMessageDlg: Word;
begin
  TombolMessageDlg := MessageDlg('Berpindah ke form Tulis Pesan?',
    mtConfirmation, [mbYes, mbNo], 0);
  if TombolMessageDlg = mrYes then
  begin
    FormWriteMsg.Show;
    with FormWriteMsg do
    begin
      Image.Picture.Bitmap := nil;
      MenuReadMsg.Enabled := False;
      MenuSave.Enabled := False;
      MenuCut.Enabled := False;
      MenuCopy.Enabled := False;
      MenuPaste.Enabled := False;
      BtnReadMsg.Enabled := False;
      BtnCancel.Enabled := False;
      BtnImgCheck.Enabled := False;
      MemoMsg.Visible := False;
      EditMax.Enabled := False;
      EditMax.Color := clSilver;
      EditMax.Enabled := False;
      EditMax.Color := clSilver;
      FormReadMsg.Close;
    end;
  end
  else
    FormReadMsg.Show;
  Image.Picture.Bitmap := nil;
  MenuReadMsg.Enabled := False;
  MenuSave.Enabled := False;
  MenuCut.Enabled := False;
  MenuCopy.Enabled := False;
  MenuPaste.Enabled := False;
  BtnReadMsg.Enabled := False;
  BtnImgCheck.Enabled := False;
  EditMax.Clear;
  EditUsed.Clear;
  EditRemains.Clear;
end;

end.
