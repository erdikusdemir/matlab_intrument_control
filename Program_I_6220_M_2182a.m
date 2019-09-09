function varargout = Program_I_6220_M_2182a(varargin)
% PROGRAM_I_6220_M_2182A MATLAB code for Program_I_6220_M_2182a.fig
%      PROGRAM_I_6220_M_2182A, by itself, creates a new PROGRAM_I_6220_M_2182A or raises the existing
%      singleton*.
%
%      H = PROGRAM_I_6220_M_2182A returns the handle to a new PROGRAM_I_6220_M_2182A or the handle to
%      the existing singleton*.
%
%      PROGRAM_I_6220_M_2182A('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRAM_I_6220_M_2182A.M with the given input arguments.
%
%      PROGRAM_I_6220_M_2182A('Property','Value',...) creates a new PROGRAM_I_6220_M_2182A or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Program_I_6220_M_2182a_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Program_I_6220_M_2182a_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Program_I_6220_M_2182a

% Last Modified by GUIDE v2.5 05-Dec-2014 10:30:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Program_I_6220_M_2182a_OpeningFcn, ...
                   'gui_OutputFcn',  @Program_I_6220_M_2182a_OutputFcn, ...
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


% --- Executes just before Program_I_6220_M_2182a is made visible.
function Program_I_6220_M_2182a_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Program_I_6220_M_2182a (see VARARGIN)

% Choose default command line output for Program_I_6220_M_2182a
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Program_I_6220_M_2182a wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Program_I_6220_M_2182a_OutputFcn(hObject, eventdata, handles) 
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
global Source6220;
global Measure2182A;
global Measure;

Measure= [];

Source6220=visa('ni','GPIB0::2::INSTR');
Measure2182A=visa('ni','GPIB0::1::INSTR');
fopen(Measure2182A);
fopen(Source6220);

fprintf(Source6220,'*RST');
fprintf(Source6220,':SOUR:CURR:FILT 1');
% fprintf(Source6220,':SOUR:CURR:RANG 1e-7');
 fprintf(Source6220,':SOUR:CURR:AMPL 0e-7');
fprintf(Source6220,':SOUR:CURR:COMP 50');

fprintf(Measure2182A,':VOLT:RANG AUTO')
fprintf(Measure2182A,':SENS:VOLT:NPLC 5')
fprintf(Measure2182A,':TRIG:DEL 0')
%fprintf(NVM,':DISP:ENAB OFF')
fprintf(Measure2182A,':INIT:CONT ON');
fprintf(Measure2182A,':SENS:VOLT:REF:STAT ON');

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
From=-5e-5;
To=5e-5;
StepSize=1e-6;
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

global Source6220;
global Measure2182A;
global Measure;


int8 NumberofStep ;
NumberofStep=((To-From)/StepSize)+1;

StepDivitionTime=StepDuration/(DataperStep+1);

    fprintf(Source6220,':SOUR:CURR:RANG %f',From);
fprintf(Source6220,':OUTP ON');
        fprintf(Measure2182A,':FETC?')
        %fprintf(Source2400,':FETC?');
        bos=scanstr(Measure2182A,',','%f');
pause(3);
for i=1:NumberofStep
tic
    AppliedPotential=From+(i-1)*StepSize;


fprintf(Source6220,':SOUR:CURR:AMPL %f',AppliedPotential);
    
    MeasuredPotential=0;
    MeasuredPotential=0;
    for j=1:DataperStep
        pause(StepDivitionTime);

        fprintf(Measure2182A,':FETC?')
        %fprintf(Source2400,':FETC?');
        ScannedData=scanstr(Measure2182A,',','%f');
        MeasuredPotential=ScannedData+MeasuredPotential;
    end
    MeasuredPotential=MeasuredPotential/DataperStep;

%    set(handles.AppliedPotential,'String',MeasuredPotential);
 %   set(handles.MeasuredPotential,'String',AppliedPotential);
    Resistance=MeasuredPotential/AppliedPotential;
%    set(handles.Resistance,'String',Resistance);
    Measure(i,2)=AppliedPotential;
    Measure(i,1)=MeasuredPotential;
    plot(handles.Graph1,Measure(:,1),Measure(:,2),'-r','LineWidth',0.5)
    grid(handles.Graph1)
    xlabel('Voltage (V)'),ylabel('Current (A)')
    pause (StepDuration-toc);
%toc
end

fprintf(Source6220,':OUTP OFF');
fprintf(Measure2182A,':SENS:VOLT:REF:STAT OFF');
display('Experiment is Done!');
%fprintf(Source6220,':SYST:BEEP:IMM 2e3,1');
instrreset;


% --- Executes on button press in Abort.
function Abort_Callback(hObject, eventdata, handles)
% hObject    handle to Abort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Abort
global Source6220;
global Measure2182A;

fprintf(Measure2182A,':SENS:VOLT:REF:STAT OFF');
fprintf(Source6220,':ABOR')
fprintf(Source6220,':OUTP OFF')
fclose(Source6220);
fclose(Measure2182A);

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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
