unit ListDisplay;

interface

uses
  System.SysUtils, System.Classes, IniFiles, Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls, Types, Vcl.Dialogs;

type
  TListDisplay = class(TComponent)
  private
    FMasterForm: TForm;
    FCursorHidden: Boolean;
    FElementText: string;
    FLeft: Integer;
    FTop: Integer;
    FWidth: Integer;
    FHeight: Integer;
    FMax: Integer;
    FBlack: Integer;
    FWhite: Integer;
    FBlue: Integer;

    procedure SetWidth(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetMax(const Value: Integer);
    procedure DisplayShapes(FLeft, FTop: Integer);
    procedure DisplayText(j, Scroll: Integer);
    procedure CreateFrame();

  public
    FShapes1: TList;
    FLabels1: TList;
    FShapes2: TList;
    FLabels2: TList;
    FPosition: Integer;
    FCounter: Integer;

    MyIni: TIniFile;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddElement(ElementText1: string; Id, Column: Integer);
    procedure Delete(Id, Column: Integer);
    procedure Select(Id: Integer);
    procedure Clear(Column: Integer);
    function Items(Id: Integer): string;
    procedure Exchange(i, j, Column: Integer);
    procedure Reverse(Column: Integer);
    procedure AssignStringsToColumn(ElementStrings: TStrings; Column: Integer);
    

  published
    property Left: Integer read FLeft write SetLeft;
    property Top: Integer read FTop write SetTop;
    property Width: Integer read FWidth write SetWidth;
    property Height: Integer read FHeight write SetHeight default 20;
    property Max: Integer read FMax write SetMax default 14;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MDabrowski', [TListDisplay]);
end;

constructor TListDisplay.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FMasterForm := TForm(Owner as TCustomForm);
  FCursorHidden := False;
  FElementText := '';
  FHeight := 20;
  FWidth := 100;
  FBlack := $000E0E12;
  FWhite := $00FBFBFB;
  FBlue := $00CD794B;

  FShapes1 := TList.Create;
  FShapes2 := TList.Create;
  FLabels1 := TList.Create;
  FLabels2:= TList.Create;

  FPosition := 0;
  FCounter := 0;

  if not (csDesigning in ComponentState) then
  begin
    MyIni := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  end;
end;

destructor TListDisplay.Destroy;
begin
  // Zwalnianie TShape przed zniszczeniem komponentu
  FreeAndNil(FShapes1);
  FreeAndNil(FShapes2);
  FreeAndNil(FLabels1);
  FreeAndNil(FLabels2);

  if not (csDesigning in ComponentState) then
  begin
    FreeAndNil(MyIni);
  end;

  inherited Destroy;
end;

procedure TListDisplay.CreateFrame();
var
  NewShape: TShape;
  i: Integer;
begin
  for i := 0 to FMax do
  begin
    // Tworzenie kształtów dla kolumny 0 (pierwszej od lewej)
    NewShape := TShape.Create(Self);
    NewShape.Parent := FMasterForm;
    NewShape.Shape := stRectangle;
    NewShape.Brush.Color := FBlack;
    NewShape.Pen.Color := FBlack;

    FShapes1.Insert(i, NewShape);

    // Tworzenie kształtów dla kolumny 1 (drugiej od lewej)
    NewShape := TShape.Create(Self);
    NewShape.Parent := FMasterForm;
    NewShape.Shape := stRectangle;
    NewShape.Brush.Color := FBlack;
    NewShape.Pen.Color := FBlack;

    FShapes2.Insert(i, NewShape);
  end;

  DisplayShapes(FLeft, FTop);
end;

procedure TListDisplay.AddElement(ElementText1: string; Id, Column: Integer);
var
  NewLabel: TLabel;
  Scroll: Integer;
begin
  if (Id < FMax + 1) then
  begin
    if Column = 0 then
    begin
      NewLabel := TLabel.Create(Self);
      NewLabel.Parent := FMasterForm;
      NewLabel.Caption := ElementText1;
      NewLabel.Alignment := taCenter;
      NewLabel.Font.Color := FWhite;

      FLabels1.Insert(Id, NewLabel);
      DisplayText(Column, 0);
    end
    else if Column = 1 then
    begin
      NewLabel := TLabel.Create(Self);
      NewLabel.Parent := FMasterForm;
      NewLabel.Caption := ElementText1;
      NewLabel.Alignment := taCenter;
      NewLabel.Font.Color := FWhite;

      FLabels2.Insert(Id, NewLabel);
      DisplayText(Column, 0);
    end;
  end
  else
  begin
    if Column = 0 then
    begin
      NewLabel := TLabel.Create(Self);
      NewLabel.Parent := FMasterForm;
      NewLabel.Caption := ElementText1;
      NewLabel.Alignment := taCenter;
      NewLabel.Font.Color := FWhite;

      FLabels1.Insert(Id, NewLabel);

      Scroll := Id - (FMax - 8);

      DisplayText(0, Scroll);
      DisplayText(1, Scroll);
    end
    else if Column = 1 then
    begin
      NewLabel := TLabel.Create(Self);
      NewLabel.Parent := FMasterForm;
      NewLabel.Caption := ElementText1;
      NewLabel.Alignment := taCenter;
      NewLabel.Font.Color := FWhite;

      FLabels2.Insert(Id, NewLabel);
      Scroll := Id - (FMax - 8);

      DisplayText(0, Scroll);
      DisplayText(1, Scroll);
    // ShowMessage('Osiągnięto maksymalną ilość elementów.');
    end;
  end;
end;


procedure TListDisplay.DisplayShapes(FLeft, FTop: Integer);
var
  i: Integer;
begin
  // 1st column, tło, ID:0
  if FShapes1.Count > 0 then
  begin
    for i := 0 to FShapes1.Count - 1 do
    begin
      TShape(FShapes1[i]).Left := FLeft;
      TShape(FShapes1[i]).Top := FTop + (FHeight * i) + 5;
      TShape(FShapes1[i]).Width := FWidth;
      TShape(FShapes1[i]).Height := FHeight;
    end;
    // ShowMessage('wyświetlono tło column 0, Wysokość: ' + IntToStr(FHeight)+ ' Szerokość: '+ IntToStr(FWidth)+ ' Top: ' + IntToStr(FTop) + ' Left: ' + IntToStr(TShape(FShapes2[0]).Left));
  end;

  // 2nd column tło, ID:1
  if FShapes2.Count > 0 then
  begin
    for i := 0 to FShapes2.Count - 1 do
    begin
      TShape(FShapes2[i]).Left := FLeft + FWidth + 2;
      TShape(FShapes2[i]).Top := FTop + (FHeight * i) + 5;
      TShape(FShapes2[i]).Width := FWidth;
      TShape(FShapes2[i]).Height := FHeight;
    end;
    // ShowMessage('wyświetlono tło column 1, Wysokość: ' + IntToStr(FHeight)+ ' Szerokość: '+ IntToStr(FWidth)+ ' Top: ' + IntToStr(FTop)+ ' Left: ' + IntToStr(TShape(FShapes2[0]).Left));
  end;
end;

procedure TListDisplay.DisplayText(j, Scroll: Integer);
var
  i: Integer;
begin
  if Scroll > 0 then
  begin
    for i := 0 to Scroll-1 do
    begin
      TLabel(FLabels1[i]).Visible := False;
      TLabel(FLabels2[i]).Visible := False;
    end;
  end;
  // Iterate through the labels in each column
  if (j = 0) and (FLabels1.Count > 0) then
  begin
    for i := Scroll to FLabels1.Count - 1 do
    begin
      if i < FMax + 1 + Scroll then
      begin
        TLabel(FLabels1[i]).Left := FLeft;
        TLabel(FLabels1[i]).Top := FTop + (FHeight * (i-Scroll)) + 7;
        TLabel(FLabels1[i]).Width := FWidth;
        TLabel(FLabels1[i]).Height := FHeight;
        TLabel(FLabels1[i]).Visible := True;
      end
      else
      begin
        TLabel(FLabels1[i]).Visible := False;
      end;
    end;
  end
  else if (j = 1) and (FLabels2.Count > 0) then
  begin
    if Scroll > 0 then
    begin
      for i := 0 to Scroll-1 do
      begin
        TLabel(FLabels1[i]).Visible := False;
      end;
    end;
    for i := Scroll to FLabels2.Count - 1 do
    begin
      if i < FMax + 1 + Scroll then
      begin
        TLabel(FLabels2[i]).Left := FLeft + FWidth + 2;
        TLabel(FLabels2[i]).Top := FTop + (FHeight * (i-Scroll)) + 7;
        TLabel(FLabels2[i]).Width := FWidth;
        TLabel(FLabels2[i]).Height := FHeight;
        TLabel(FLabels2[i]).Visible := True;
      end
      else
      begin
        TLabel(FLabels2[i]).Visible := False;
      end;
    end;
  end;
end;

procedure TListDisplay.Delete(Id, Column: Integer);
var Scroll: Integer;
begin
  if Id >= 0 then
  begin
    if column = 0 then 
    begin
      TLabel(Flabels1[Id]).Free;
      Flabels1.Delete(Id);
    end
    else
    begin
      Tlabel(Flabels2[Id]).Free;
      FLabels2.Delete(Id);
    end;
    if (Id < FMax - 8) then
      DisplayText(Column, 0)
    else
      Scroll := Id - (FMax - 8);
      DisplayText(0, Scroll);
      DisplayText(1, Scroll);
  end;
end;

function TListDisplay.Items(Id: Integer): string;
var
  CaptionValue: string;
begin
  Result := '';
  CaptionValue := Tlabel(Flabels2[Id]).Caption;
  Result := CaptionValue;
  // ShowMessage('Sprawdzone' + IntToStr(Id));
end;

procedure TListDisplay.Select(Id: Integer);
  var i, Scroll: Integer;
begin
  if Id < FMax - 8  then
  begin
    for i := 0 to FShapes1.Count - 1 do
    begin
      TShape(FShapes1[i]).Brush.Color := FBlack;
      TShape(FShapes2[i]).Brush.Color := FBlack;
    end;

    TShape(FShapes1[Id]).Brush.Color := FBlue;
    TShape(FShapes2[Id]).Brush.Color := FBlue;

    DisplayText(0, 0);
    DisplayText(1, 0);

    end
  else
  begin
    Scroll := Id - (FMax - 8);
    // ShowMessage(IntToStr(Scroll));

    DisplayText(0, Scroll);
    DisplayText(1, Scroll);

    for i := 0 to FShapes1.Count - 1 do
    begin
      TShape(FShapes1[i]).Brush.Color := FBlack;
      TShape(FShapes2[i]).Brush.Color := FBlack;
    end;

    TShape(FShapes1[Id- Scroll]).Brush.Color := FBlue;
    TShape(FShapes2[Id - Scroll]).Brush.Color := FBlue;
  end;
end;

procedure TListDisplay.Clear(Column: Integer);
var
 i: Integer;
begin
  if Column = 0 then
  begin
    for i := 0 to FLabels1.Count - 1 do
    begin
        TLabel(FLabels1[i]).Free;
    end;
    FLabels1.Clear;
  end
  else
  begin
    for i := 0 to FLabels2.Count - 1 do
    begin
        TLabel(FLabels2[i]).Free;
    end;
    FLabels2.Clear;

    FCounter := 0;
  end;
end;

procedure TListDisplay.Exchange(i, j, Column: Integer);
var
 tempLabel: TLabel;
begin
  if Column = 0 then
  begin
    if (i >= 0) and (i < FLabels1.Count) and (j >= 0) and (j < FLabels1.Count) then
    begin
      tempLabel := TLabel(FLabels1[i]);
      FLabels1[i] := FLabels1[j];
      FLabels1[j] := tempLabel;
    end;
  end
  else
    if (i >= 0) and (i < FLabels2.Count) and (j >= 0) and (j < FLabels2.Count) then
    begin
      tempLabel := TLabel(FLabels2[i]);
      FLabels2[i] := FLabels2[j];
      FLabels2[j] := tempLabel;
    end;
end;

procedure TListDisplay.Reverse(Column: Integer);
var
 tempLabel: TLabel;
 i, j: Integer;
begin
 if Column = 0 then
 begin
    i := 0;
    j := FLabels1.Count - 1;
    while i < j do
    begin
      tempLabel := TLabel(FLabels1[i]);
      FLabels1[i] := FLabels1[j];
      FLabels1[j] := tempLabel;

      Inc(i);
      Dec(j);
    end;
 end
 else
 begin
    i := 0;
    j := FLabels2.Count - 1;
    while i < j do
    begin
      tempLabel := TLabel(FLabels2[i]);
      FLabels2[i] := FLabels2[j];
      FLabels2[j] := tempLabel;

      Inc(i);
      Dec(j);
    end;
 end;
end;

procedure TListDisplay.AssignStringsToColumn(ElementStrings: TStrings; Column: Integer);
var
  i: Integer;
begin
  // Sprawdź czy kolumna istnieje
  if FLabels1.Count > 0 then
  begin
    Clear(Column);
  end;

  // Dodaj nowe etykiety z ElementStrings
  for i := 0 to ElementStrings.Count - 1 do
  begin
    AddElement(ElementStrings[i], i, Column);
  end;
end;

procedure TListDisplay.SetLeft(const Value: Integer);
begin
  if Left <> Value then
  begin
    FLeft := Value;
  end;
end;

procedure TListDisplay.SetTop(const Value: Integer);
begin
  if Top <> Value then
  begin
    FTop := Value;
  end;
end;

procedure TListDisplay.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
  end;
end;

procedure TListDisplay.SetHeight(const Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
  end;
end;

procedure TListDisplay.SetMax(const Value: Integer);
begin
  if FMax <> Value then
  begin
    FMax := Value;
    createFrame();
  end;
end;


end.

// to do:
// 1. zrobić zaznaczenie.
