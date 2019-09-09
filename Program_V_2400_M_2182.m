function varargout = Program_V_2400_M_2182(varargin)
% PROGRAM_V_2400_M_2182 MATLAB code for Program_V_2400_M_2182.fig
%      PROGRAM_V_2400_M_2182, by itself, creates a new PROGRAM_V_2400_M_2182 or raises the existing
%      singleton*.
%
%      H = PROGRAM_V_2400_M_2182 returns the handle to a new PROGRAM_V_2400_M_2182 or the handle to
%      the existing singleton*.
%
%      PROGRAM_V_2400_M_2182('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRAM_V_2400_M_2182.M with the given input arguments.
%
%      PROGRAM_V_2400_M_2182('Property','Value',...) creates a new PROGRAM_V_2400_M_2182 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Program_V_2400_M_2182_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Program_V_2400_M_2182_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Program_V_2400_M_2182

% Last Modified by GUIDE v2.5 08-Sep-2014 20:44:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Program_V_2400_M_2182_OpeningFcn, ...
                   'gui_OutputFcn',  @Program_V_2400_M_2182_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Program_V_2400_M_2182 is made visible.
function Program_V_2400_M_2182_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Program_V_2400_M_2182 (see VARARGIN)

% Choose default command line output for Program_V_2400_M_2182
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Program_V_2400_M_2182 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Program_V_2400_M_2182_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Configure.
function Configure_Callback(hObject, eventdata, handles)
% hObject    handle to Configure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Source2400;
global Measure2182;
global Measure;

Measure= [];

Source2400=visa('ni','GPIB0::4::INSTR');
Measure2182=visa('ni','GPIB0::1::INSTR');
fopen(Measure2182);
fopen(Source2400);
fprintf(Source2400,'*RST');
fprintf(Source2400,':SOUR:FUNC VOLT');
fprintf(Source2400,':SOUR:VOLT:MODE FIX');
fprintf(Source2400,':ROUT:TERM REAR');
%fprintf(Source2400,':SENS:CURR:RANG:AUTO ON');
%fprintf(Source2400,':SENS:CURR:PROT 1e-4');
%fprintf(Source2400,':SOUR:VOLT 0.1')
fprintf(Source2400,':SOUR:DEL 0')

fprintf(Measure2182,':VOLT:RANG AUTO')
fprintf(Measure2182,':SENS:VOLT:NPLC 5')
fprintf(Measure2182,':TRIG:DEL 0')
%fprintf(NVM,':DISP:ENAB OFF')
fprintf(Measure2182,':INIT:CONT ON');
fprintf(Measure2182,':SENS:VOLT:REF:STAT ON');

global From;
global To;
global StepSize;
global StepDuration;
global DataperStep;
%From=str2double(get(handles.Data_Potential,'String'));
% To=str2double(get(handles.Data_To,'String'));
% StepSize=str2double(get(handles.Data_StepSize,'String'));
% StepDuration=str2double(get(handles.Data_PeriodDuration,'String'));
% DataperStep=str2double(get(handles.Data_PeriodDuration,'String'));
From=-0.01;
To=0.01;
StepSize=0.0005;
StepDuration=5;
DataperStep=3;



% --- Executes on button press in StartProgram.
function StartProgram_Callback(hObject, eventdata, handles)
% hObject    handle to StartProgram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StartProgram

global From;
global To;
global StepSize;
global StepDuration;
global DataperStep;

global Source2400;
global Measure2182;
global Measure;


int8 NumberofStep ;
NumberofStep=((To-From)/StepSize)+1;

StepDivitionTime=StepDuration/(DataperStep+1);

fprintf(Source2400,':OUTP ON');
        fprintf(Measure2182,':FETC?')
        %fprintf(Source2400,':FETC?');
        bos=scanstr(Measure2182,',','%f');
pause(3);
for i=1:NumberofStep
tic
    AppliedPotential=From+(i-1)*StepSize;
    SendPot=sprintf(':SOUR:VOLT %f',AppliedPotential);
    fprintf(Source2400,SendPot);
    
    MeasuredPotential=0;
    MeasuredPotential=0;
    for j=1:DataperStep
        pause(StepDivitionTime);
        fprintf(Source2400,':INIT');
        fprintf(Measure2182,':FETC?')
        %fprintf(Source2400,':FETC?');
        ScannedData=scanstr(Measure2182,',','%f');
        MeasuredPotential=ScannedData+MeasuredPotential;
    end
    MeasuredPotential=MeasuredPotential/DataperStep;

    set(handles.AppliedPotential,'String',AppliedPotential);
    set(handles.MeasuredPotential,'String',MeasuredPotential);
   % Resistance=AppliedPotential/MeasuredPotential;
   % set(handles.Resistance,'String',Resistance);
    Measure(i,1)=AppliedPotential;
    Measure(i,2)=MeasuredPotential;
    plot(handles.Graph1,Measure(:,1),Measure(:,2),'-r','LineWidth',0.5)
    grid(handles.Graph1)
    xlabel('Voltage (V)'),ylabel('ReferenceVoltage (V)')
    pause (StepDuration-toc);
%toc
end

fprintf(Source2400,':OUTP OFF');
fprintf(Measure2182,':SENS:VOLT:REF:STAT OFF');
display('Experiment is Done!');
fprintf(Source2400,':SYST:BEEP:IMM 2e3,1');
instrreset;


% --- Executes on button press in Abort.
function Abort_Callback(hObject, eventdata, handles)
% hObject    handle to Abort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Abort
global Source2400;
global Measure2182;

fprintf(Measure2182,':SENS:VOLT:REF:STAT OFF');
fprintf(Source2400,':ABOR')
fprintf(Source2400,':OUTP OFF')
fclose(Source2400);
fclose(Measure2182);

instrreset;

% --- Executes on button press in Title.
function Title_Callback(hObject, eventdata, handles)
% hObject    handle to Title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Data_Potential_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Potential (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_Potential as text
%        str2double(get(hObject,'String')) returns contents of Data_Potential as a double

% --- Executes during object creation, after setting all properties.
function Data_Potential_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_Potential (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Data_To_Callback(hObject, eventdata, handles)
% hObject    handle to Data_To (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_To as text
%        str2double(get(hObject,'String')) returns contents of Data_To as a double

% --- Executes during object creation, after setting all properties.
function Data_To_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_To (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Data_StepSize_Callback(hObject, eventdata, handles)
% hObject    handle to Data_StepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_StepSize as text
%        str2double(get(hObject,'String')) returns contents of Data_StepSize as a double

% --- Executes during object creation, after setting all properties.
function Data_StepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_StepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Data_PeriodDuration_Callback(hObject, eventdata, handles)
% hObject    handle to Data_PeriodDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_PeriodDuration as text
%        str2double(get(hObject,'String')) returns contents of Data_PeriodDuration as a double

% --- Executes during object creation, after setting all properties.
function Data_PeriodDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_PeriodDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Data_NumberofPeriod_Callback(hObject, eventdata, handles)
% hObject    handle to Data_NumberofPeriod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_NumberofPeriod as text
%        str2double(get(hObject,'String')) returns contents of Data_NumberofPeriod as a double

% --- Executes during object creation, after setting all properties.
function Data_NumberofPeriod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_NumberofPeriod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SavePath_Callback(hObject, eventdata, handles)
% hObject    handle to SavePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SavePath as text
%        str2double(get(hObject,'String')) returns contents of SavePath as a double


% --- Executes during object creation, after setting all properties.
function SavePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SavePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Measure;

dataname=get(handles.SavePath,'String');
data=sprintf('%s.txt',dataname);
save(data,'Measure','-ascii','-tabs');
