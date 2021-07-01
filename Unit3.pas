unit Unit3;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Math, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series,
  VCLTee.TeeProcs, VCLTee.Chart;
type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Edit1: TEdit;
    Edit10: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    c: TLabel;
    Label10: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Memo1: TMemo;
    Button1: TButton;
    Memo2: TMemo;
    Button2: TButton;
    Memo3: TMemo;
    Button3: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  ma=array [0..100] of real;
  matr=array [1..100,1..100] of real;
var
  Form3: TForm3;
  i,j,k,Metod,Vid,n,stepen:byte;
  h,cc, q,dt,dt1,Summa,d,r,g: real;
  Xi,Yi,Met1,Met2,Met3,Fi,b,Ai,Sum,KoefFi: ma;
  Kij,Hij,a,HijOBR,rez:matr;
  str: string;
implementation
{$R *.dfm}
procedure TForm3.Button1Click(Sender: TObject);
begin
   ///��������� ������
    Memo1.Clear;
    for i:=1 to N do begin
        Yi[i]:=0;
        Ai[i]:=0;
        Xi[i]:=0;
        Fi[i]:=0;
        Sum[i]:=0;
        Met1[i]:=0;
        end;
     for i:=1 to N do begin
         for j:=1 to N do begin
           Kij[i,j]:=0;
           Hij[i,j]:=0;
         end;
       end;
   ///���� ������
   q:=StrToFloat(Edit1.Text);
   cc:=StrToFloat(Edit2.Text);
   d:=StrToFloat(Edit3.Text);
   KoefFi[0]:=StrToFloat(Edit4.Text);
   KoefFi[1]:=StrToFloat(Edit5.Text);
   KoefFi[2]:=StrToFloat(Edit6.Text);
   KoefFi[3]:=StrToFloat(Edit7.Text);
   KoefFi[4]:=StrToFloat(Edit8.Text);
   KoefFi[5]:=StrToFloat(Edit9.Text);
    n:=StrToInt(Edit10.Text);
   ///������ h
  h:=(D-cc)/(N-1);
   ///������� Xi � Fi
   for i:=1 to N do begin
          Xi[i]:=cc+h*(i-1);
          for j:=0 to 6 do begin
          Fi[i]:=Fi[i]+KoefFi[j]*Power(Xi[i],j);
          end;
        end;
   ///������������ �����. �i
       for i:=1 to N do begin
       Ai[i]:=h;
       end;
   ///������������ ������� ����� Kij
   for i:=1 to N do begin
         for j:=1 to N do begin
           Kij[i,j]:=1;
         end;
       end;
   ///������������ ������� ����� Hij
   for i:=1 to N do begin
    for j:=1 to N do begin
      Hij[i,j]:=Ai[j]*Kij[i,j];
    end;
   end;
   ///������� ����
   for i:=1 to N do begin
    for j:=1 to N do begin
      if (j<i) then begin
         Sum[i]:= Sum[i]+Ai[j]*Kij[i,j]*Yi[j];
      end;
      Yi[i]:=(-Fi[i]-q*Sum[i])/(1-q*Ai[i]*Kij[i,i]);
    end;
   end;
   ///���������� ���������� ��� �������
  for i:=1 to n do begin
       Met1[i]:=Yi[i];
    end;
   ///������������ ���������� �������
  for i:=1 to n do begin
       rez[i,1]:=i;
       rez[i,2]:=Xi[i];
       rez[i,3]:=Yi[i];
    end;
 ///����� �����������
  Memo1.Lines.Add('    i          x[i]          y[i]');
  Memo1.Lines.Add('');
 if n<10 then begin
  for i:=1 to n do begin
     Str:='   ';
      Str:=Str+FloatToStrF(rez[i,1], ffFixed, 8, 0)+'      ';
      for j:=2 to 3 do begin
        Str:=Str+FloatToStrF(rez[i,j], ffFixed, 8, 4)+'      ';
        end;
      Memo1.Lines.Add(Str);
      Memo1.Lines.Add(' ');
  end;
 end;
 if n>9 then begin
 for i:=1 to 9 do
    begin
     Str:='   ';
      Str:=Str+FloatToStrF(rez[i,1], ffFixed, 8, 0)+'      ';
      for j:=2 to 3 do begin
        Str:=Str+FloatToStrF(rez[i,j], ffFixed, 8, 4)+'      ';
        end;
      Memo1.Lines.Add(Str);
      Memo1.Lines.Add(' ');
    end;
 for i:=10 to n do
    begin
     Str:='   ';
      Str:=Str+FloatToStrF(rez[i,1], ffFixed, 8, 0)+'    ';
      for j:=2 to 3 do begin
        Str:=Str+FloatToStrF(rez[i,j], ffFixed, 8, 4)+'      ';
        end;
      Memo1.Lines.Add(Str);
      Memo1.Lines.Add(' ');
    end;
 end;
end;
procedure TForm3.Button2Click(Sender: TObject);
begin
  ///��������� ������
    Memo2.Clear;
    for i:=1 to N do begin
        Yi[i]:=0;
        Ai[i]:=0;
        Xi[i]:=0;
        Fi[i]:=0;
        Sum[i]:=0;
        Met2[i]:=0;
        end;
     for i:=1 to N do begin
         for j:=1 to N do begin
           Kij[i,j]:=0;
           Hij[i,j]:=0;
         end;
       end;
   ///���� ������
   q:=StrToFloat(Edit1.Text);
   cc:=StrToFloat(Edit2.Text);
   d:=StrToFloat(Edit3.Text);
   KoefFi[0]:=StrToFloat(Edit4.Text);
   KoefFi[1]:=StrToFloat(Edit5.Text);
   KoefFi[2]:=StrToFloat(Edit6.Text);
   KoefFi[3]:=StrToFloat(Edit7.Text);
   KoefFi[4]:=StrToFloat(Edit8.Text);
   KoefFi[5]:=StrToFloat(Edit9.Text);
    n:=StrToInt(Edit10.Text);
   ///������ h
  h:=(D-cc)/(N-1);
   ///������� Xi � Fi
   for i:=1 to N do begin
          Xi[i]:=cc+h*(i-1);
          for j:=0 to 6 do begin
          Fi[i]:=Fi[i]+KoefFi[j]*Power(Xi[i],j);
          end;
        end;
   ///������������ �����. �i
       Ai[1]:=h/2;
       Ai[n]:=h/2;
       for i:=2 to N-1 do begin
       Ai[i]:=h;
       end;
   ///������������ ������� ����� Kij
   for i:=1 to N do begin
         for j:=1 to N do begin
           Kij[i,j]:=1;
         end;
       end;
   ///������������ ������� ����� Hij
   for i:=1 to N do begin
    for j:=1 to N do begin
      Hij[i,j]:=Ai[j]*Kij[i,j];
    end;
   end;
   ///������� ����
   for i:=1 to N do begin
    for j:=1 to N do begin
      if (j<i) then begin
         Sum[i]:= Sum[i]+Ai[j]*Kij[i,j]*Yi[j];
      end;
      Yi[i]:=(-Fi[i]-q*Sum[i])/(1-q*Ai[i]*Kij[i,i]);
    end;
   end;
   ///���������� ���������� ��� �������
  for i:=1 to n do begin
       Met2[i]:=Yi[i];
    end;
   ///������������ ���������� �������
  for i:=1 to n do begin
       rez[i,1]:=i;
       rez[i,2]:=Xi[i];
       rez[i,3]:=Yi[i];
    end;
   ///����� �����������
  Memo2.Lines.Add('    i          x[i]          y[i]');
  Memo2.Lines.Add('');
 if n<10 then begin
  for i:=1 to n do begin
     Str:='   ';
      Str:=Str+FloatToStrF(rez[i,1], ffFixed, 8, 0)+'      ';
      for j:=2 to 3 do begin
        Str:=Str+FloatToStrF(rez[i,j], ffFixed, 8, 4)+'      ';
        end;
      Memo2.Lines.Add(Str);
      Memo2.Lines.Add('');
  end;
 end;
 if n>9 then begin
 for i:=1 to 9 do
    begin
     Str:='   ';
      Str:=Str+FloatToStrF(rez[i,1], ffFixed, 8, 0)+'      ';
      for j:=2 to 3 do begin
        Str:=Str+FloatToStrF(rez[i,j], ffFixed, 8, 4)+'      ';
        end;
      Memo2.Lines.Add(Str);
      Memo2.Lines.Add('');
    end;
 for i:=10 to n do
    begin
     Str:='   ';
      Str:=Str+FloatToStrF(rez[i,1], ffFixed, 8, 0)+'    ';
      for j:=2 to 3 do begin
        Str:=Str+FloatToStrF(rez[i,j], ffFixed, 8, 4)+'      ';
        end;
      Memo2.Lines.Add(Str);
      Memo2.Lines.Add('');
    end;
 end;
end;
procedure TForm3.Button3Click(Sender: TObject);
begin
   ///��������� ������
    Memo3.Clear;
    for i:=1 to N do begin
        Yi[i]:=0;
        Ai[i]:=0;
        Xi[i]:=0;
        Fi[i]:=0;
        Sum[i]:=0;
        Met3[i]:=0;
        end;
     for i:=1 to N do begin
         for j:=1 to N do begin
           Kij[i,j]:=0;
           Hij[i,j]:=0;
         end;
       end;
   ///���� ������
   q:=StrToFloat(Edit1.Text);
   cc:=StrToFloat(Edit2.Text);
   d:=StrToFloat(Edit3.Text);
   KoefFi[0]:=StrToFloat(Edit4.Text);
   KoefFi[1]:=StrToFloat(Edit5.Text);
   KoefFi[2]:=StrToFloat(Edit6.Text);
   KoefFi[3]:=StrToFloat(Edit7.Text);
   KoefFi[4]:=StrToFloat(Edit8.Text);
   KoefFi[5]:=StrToFloat(Edit9.Text);
    n:=StrToInt(Edit10.Text);
   ///������ h
  h:=(D-cc)/(N-1);
   ///������� Xi � Fi
   for i:=1 to N do begin
          Xi[i]:=cc+h*(i-1);
          for j:=0 to 6 do begin
          Fi[i]:=Fi[i]+KoefFi[j]*Power(Xi[i],j);
          end;
        end;
   ///������������ �����. �i
       Ai[1]:=h/3;
       Ai[n]:=h/3;
       for i:=2 to n-1 do begin
         if (i mod 2)=0 then
         Ai[i]:=4*h/3;
       end;
       for i:=3 to n-2 do begin
         if (i mod 2)=1 then
         Ai[i]:=2*h/3;
       end;
   ///������������ ������� ����� Kij
   for i:=1 to N do begin
         for j:=1 to N do begin
           Kij[i,j]:=1;
         end;
       end;
   ///������������ ������� ����� Hij
   for i:=1 to N do begin
    for j:=1 to N do begin
      Hij[i,j]:=Ai[j]*Kij[i,j];
    end;
   end;
   ///������� ����
   for i:=1 to N do begin
    for j:=1 to N do begin
      if (j<i) then begin
         Sum[i]:= Sum[i]+Ai[j]*Kij[i,j]*Yi[j];
      end;
      Yi[i]:=(-Fi[i]-q*Sum[i])/(1-q*Ai[i]*Kij[i,i]);
    end;
   end;
   ///���������� ���������� ��� �������
  for i:=1 to n do begin
       Met3[i]:=Yi[i];
    end;
   ///������������ ���������� �������
  for i:=1 to n do begin
       rez[i,1]:=i;
       rez[i,2]:=Xi[i];
       rez[i,3]:=Yi[i];
    end;
   ///����� �����������
  Memo3.Lines.Add('    i          x[i]          y[i]');
  Memo3.Lines.Add('');
 if n<10 then begin
  for i:=1 to n do begin
     Str:='   ';
      Str:=Str+FloatToStrF(rez[i,1], ffFixed, 8, 0)+'      ';
      for j:=2 to 3 do begin
        Str:=Str+FloatToStrF(rez[i,j], ffFixed, 8, 4)+'      ';
        end;
      Memo3.Lines.Add(Str);
      Memo3.Lines.Add('');
  end;
 end;
 if n>9 then begin
 for i:=1 to 9 do
    begin
     Str:='   ';
      Str:=Str+FloatToStrF(rez[i,1], ffFixed, 8, 0)+'      ';
      for j:=2 to 3 do begin
        Str:=Str+FloatToStrF(rez[i,j], ffFixed, 8, 4)+'      ';
        end;
      Memo3.Lines.Add(Str);
      Memo3.Lines.Add('');
    end;
 for i:=10 to n do
    begin
     Str:='   ';
      Str:=Str+FloatToStrF(rez[i,1], ffFixed, 8, 0)+'    ';
      for j:=2 to 3 do begin
        Str:=Str+FloatToStrF(rez[i,j], ffFixed, 8, 4)+'      ';
        end;
      Memo3.Lines.Add(Str);
      Memo3.Lines.Add('');
    end;
 end;
end;
procedure TForm3.Button4Click(Sender: TObject);
begin
Series1.clear;
Series2.clear;
Series3.clear;
for i:=1 to n do
 begin
  Series1.AddXY(Xi[i],Met1[i],'');
  Series2.AddXY(Xi[i],Met2[i],'');
  Series3.AddXY(Xi[i],Met3[i],'');
end;
end;
procedure TForm3.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
 if WheelDelta<0
  then Form3.VertScrollBar.Position:=Form3.VertScrollBar.Position+30
  else Form3.VertScrollBar.Position:=Form3.VertScrollBar.Position-30
end;
end.
