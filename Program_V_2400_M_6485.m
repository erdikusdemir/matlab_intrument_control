function varargout = Program_V_2400_M_6485(varargin)
% PROGRAM_V_2400_M_6485 MATLAB code for Program_V_2400_M_6485.fig
%      PROGRAM_V_2400_M_6485, by itself, creates a new PROGRAM_V_2400_M_6485 or raises the existing
%      singleton*.
%
%      H = PROGRAM_V_2400_M_6485 returns the handle to a new PROGRAM_V_2400_M_6485 or the handle to
%      the existing singleton*.
%
%      PROGRAM_V_2400_M_6485('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRAM_V_2400_M_6485.M with the given input arguments.
%
%      PROGRAM_V_2400_M_6485('Property','Value',...) creates a new PROGRAM_V_2400_M_6485 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Program_V_2400_M_6485_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Program_V_2400_M_6485_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Program_V_2400_M_6485

% Last Modified by GUIDE v2.5 21-Jul-2015 15:42:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Program_V_2400_M_6485_OpeningFcn, ...
                   'gui_OutputFcn',  @Program_V_2400_M_6485_OutputFcn, ...
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


% --- Executes just before Program_V_2400_M_6485 is made visible.
function Program_V_2400_M_6485_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Program_V_2400_M_6485 (see VARARGIN)

% Choose default command line output for Program_V_2400_M_6485
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Program_V_2400_M_6485 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Program_V_2400_M_6485_OutputFcn(hObject, eventdata, handles) 
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
global Measure6485;
global Measure;

Measure= [];

Source2400=visa('ni','GPIB0::4::INSTR');
Measure6485=visa('ni','GPIB0::3::INSTR');
fopen(Measure6485);
fopen(Source2400);
fprintf(Source2400,'*RST');
fprintf(Source2400,':SOUR:FUNC VOLT');
fprintf(Source2400,':SOUR:VOLT:MODE FIX');
fprintf(Source2400,':ROUT:TERM REAR');
%fprintf(Source2400,':SENS:CURR:RANG:AUTO ON');
%fprintf(Source2400,':SENS:CURR:PROT 1e-4');
%fprintf(Source2400,':SOUR:VOLT 0.1')
fprintf(Source2400,':SOUR:DEL 0')

fprintf(Measure6485,'*RST');
fprintf(Measure6485,'FORM:ELEM READ');
fprintf(Measure6485,'SYST:ZCH ON');
fprintf(Measure6485,'CURR:RANG:AUTO OFF');
fprintf(Measure6485,'CURR:RANG 2e-5');
%fprintf(Measure6485,'CURR:RANG:AUTO ON');
fprintf(Measure6485,'DISP:ENAB OFF');

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
From=100;
To=200;
StepSize=2;
StepDuration=1;
DataperStep=1;



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
global Measure6485;
global Measure;


int8 NumberofStep ;
NumberofStep=((To-From)/StepSize)+1;

StepDivitionTime=StepDuration/(DataperStep+1);

fprintf(Source2400,':OUTP ON');
pause(3);

        fprintf(Measure6485,'INIT');
        fprintf(Measure6485,'SYST:ZCOR:ACQ');
        fprintf(Measure6485,'SYST:ZCOR ON');
        fprintf(Measure6485,'SYST:ZCH OFF');
        
pause(3);

for i=1:NumberofStep
tic
    AppliedPotential=From+(i-1)*StepSize;
    SendPot=sprintf(':SOUR:VOLT %f',AppliedPotential);
    fprintf(Source2400,SendPot);
    

    MeasuredCurrent=0;
    for j=1:DataperStep
        pause(StepDivitionTime);
       % fprintf(Source2400,':INIT');
        fprintf(Measure6485,'READ?');
        %fprintf(Source2400,':FETC?');
        ScannedData=scanstr(Measure6485,',','%f');
        MeasuredCurrent=ScannedData+MeasuredCurrent;
    end
    MeasuredCurrent=MeasuredCurrent/DataperStep;

    set(handles.AppliedPotential,'String',AppliedPotential);
    set(handles.MeasuredPotential,'String',MeasuredCurrent);
   % Resistance=AppliedPotential/MeasuredCurrent;
   % set(handles.Resistance,'String',Resistance);
    Measure(i,1)=AppliedPotential;
    Measure(i,2)=MeasuredCurrent;
    plot(handles.Graph1,Measure(:,1),Measure(:,2),'-r','LineWidth',0.5)
    grid(handles.Graph1)
    xlabel('Voltage (V)'),ylabel('Current (A)')
    pause (StepDuration-toc);
%toc
end

fprintf(Source2400,':OUTP OFF');

display('Experiment is Done!');
fprintf(Source2400,':SYST:BEEP:IMM 2e3,1');
fprintf(Measure6485,'DISP:ENAB ON');
instrreset;


% --- Executes on button press in Abort.
function Abort_Callback(hObject, eventdata, handles)
% hObject    handle to Abort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Abort
global Source2400;
global Measure6485;

fprintf(Measure6485,':SENS:VOLT:REF:STAT OFF');
fprintf(Source2400,':ABOR')
fprintf(Source2400,':OUTP OFF')
fprintf(Measure6485,'DISP:ENAB ON');
fclose(Source2400);
fclose(Measure6485);

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
