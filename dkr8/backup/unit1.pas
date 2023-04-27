unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnClose: TBitBtn;
    btnCalculate: TButton;
    cbxCalculationType: TComboBox;
    edtPrincipal: TEdit;
    edtRate: TEdit;
    edtTime: TEdit;
    lblProcent: TLabel;
    lblPrincipal: TLabel;
    lblRate: TLabel;
    lblTime: TLabel;
    memResult: TMemo;
    procedure btnCalculateClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtPrincipalKeyPress(Sender: TObject; var Key: char);
    procedure edtRateKeyPress(Sender: TObject; var Key: char);
    procedure edtTimeKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.btnCalculateClick(Sender: TObject);
const
  MaxResult = 1.1e38; // Maximum representable positive finite value for a Double data type in Pascal
  MinResult = -1.1e38;
var
  Principal, Rate, Time, Result: Double;
begin
  if (edtPrincipal.Text = '') or (edtRate.Text = '') or (edtTime.Text = '') then
    begin
      ShowMessage('Пожалуйста, заполните все поля.');
    end
    else
begin
  try
    Principal := StrToFloat(edtPrincipal.Text);
    Rate := StrToFloat(edtRate.Text);
    Time := StrToFloat(edtTime.Text);


    case cbxCalculationType.ItemIndex of
      0: // Простые проценты
        begin
          Result := Principal * (1 + Time * (Rate / 365));
          memResult.Lines.Clear;
          if (Result <= MaxResult) and (Result >= MinResult) then
             memResult.Lines.Add('Результат: ' + FormatFloat('0.00', Result))
          else
              ShowMessage('Переполнение числа');
        end;
      1: // Сложные проценты
        begin
          Result := Principal * (1 + (Rate / 100 * Time));
          memResult.Lines.Clear;
          if (Result <= MaxResult) and (Result >= MinResult) then
             memResult.Lines.Add('Результат: ' + FloatToStr(Result))
          else
              ShowMessage('Переполнение числа');
        end;
    end;
  except
    on E: Exception do
      ShowMessage('Ошибка: ' + E.Message);
  end;
end;
end;

procedure TForm1.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.edtPrincipalKeyPress(Sender: TObject; var Key: char);
begin
     if not (Key in ['0'..'9', ',', '.', #8, #13, #27]) then
        Key := #0;
end;

procedure TForm1.edtRateKeyPress(Sender: TObject; var Key: char);
begin
    if not (Key in ['0'..'9', ',', '.', #8, #13, #27]) then
       Key := #0;
end;

procedure TForm1.edtTimeKeyPress(Sender: TObject; var Key: char);
begin
     if not (Key in ['0'..'9', ',', '.', #8, #13, #27]) then
        Key := #0;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  cbxCalculationType.Items.Add('Простые проценты');
  cbxCalculationType.Items.Add('Сложные проценты');
  cbxCalculationType.ItemIndex := 0;
end;


end.

