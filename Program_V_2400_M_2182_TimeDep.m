function varargout = Program_V_2400_M_2182_TimeDep(varargin)
% PROGRAM_V_2400_M_2182_TIMEDEP MATLAB code for Program_V_2400_M_2182_TimeDep.fig
%      PROGRAM_V_2400_M_2182_TIMEDEP, by itself, creates a new PROGRAM_V_2400_M_2182_TIMEDEP or raises the existing
%      singleton*.
%
%      H = PROGRAM_V_2400_M_2182_TIMEDEP returns the handle to a new PROGRAM_V_2400_M_2182_TIMEDEP or the handle to
%      the existing singleton*.
%
%      PROGRAM_V_2400_M_2182_TIMEDEP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRAM_V_2400_M_2182_TIMEDEP.M with the given input arguments.
%
%      PROGRAM_V_2400_M_2182_TIMEDEP('Property','Value',...) creates a new PROGRAM_V_2400_M_2182_TIMEDEP or raises the
%      existing singleton*.  Starting Potential the left, property value pairs are
%      applied to the GUI before Program_V_2400_M_2182_TimeDep_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Program_V_2400_M_2182_TimeDep_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Program_V_2400_M_2182_TimeDep

% Last Modified by GUIDE v2.5 08-Sep-2014 20:53:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Program_V_2400_M_2182_TimeDep_OpeningFcn, ...
                   'gui_OutputFcn',  @Program_V_2400_M_2182_TimeDep_OutputFcn, ...
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


% --- Executes just before Program_V_2400_M_2182_TimeDep is made visible.
function Program_V_2400_M_2182_TimeDep_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Program_V_2400_M_2182_TimeDep (see VARARGIN)

% Choose default command line output for Program_V_2400_M_2182_TimeDep
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Program_V_2400_M_2182_TimeDep wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs Potential this function are returned to the command line.
function varargout = Program_V_2400_M_2182_TimeDep_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output Potential handles structure
varargout{1} = handles.output;

% --- Executes on button press in Configure.
function Configure_Callback(hObject, eventdata, handles)
% hObject    handle to Configure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Source2400;
global Measure2182;
global Measure;
global ShutterSource;

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

fprintf(Measure2182,':VOLT:RANG 1e-1')
fprintf(Measure2182,':SENS:VOLT:NPLC 5')
fprintf(Measure2182,':TRIG:DEL 0')
%fprintf(NVM,':DISP:ENAB OFF')
fprintf(Measure2182,':INIT:CONT ON');
fprintf(Measure2182,':SENS:VOLT:REF:STAT ON');


global Potential;
% global To;
% global StepSize;
% global StepDuration;
% global DataperStep;
% Potential=str2double(get(handles.Data_Potential,'String'));
% To=str2double(get(handles.Data_To,'String'));
% StepSize=str2double(get(handles.Data_StepSize,'String'));
% StepDuration=str2double(get(handles.sure,'String'));
% DataperStep=str2double(get(handles.adet,'String'));

%Potential=0.1;





% --- Executes on button press in StartProgram.
function StartProgram_Callback(hObject, eventdata, handles)
% hObject    handle to StartProgram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StartProgram

global Potential;

global Source2400;
global Measure2182;
global Measure;
global ShutterSource;
int8 NumberofStep ;

sure=100000;
Potential=0.01;

    SendPot=sprintf(':SOUR:VOLT %f',Potential);
    fprintf(Source2400,SendPot);
fprintf(Source2400,':OUTP ON');

% sure=str2double(get(handles.sure,'String'));
% adet=str2double(get(handles.adet,'String'));
%     ShutterSource=visa('ni','GPIB0::17::INSTR');
%     fopen(ShutterSource);
%     fprintf(ShutterSource,'T4X');
% fprintf(ShutterSource,'F1X');

i=0;
time=0;
tic;


pause(10);

for i=1:10000
    MeasuredPotential=0;
    j=0;
    for j=1:50
        %fprintf(Source2400,':INIT');
        fprintf(Measure2182,':FETC?')
        %fprintf(Source2400,':FETC?');
        MeasuredPotential=scanstr(Measure2182,',','%f')+MeasuredPotential;
zaman=toc;
pause(0.01);
    set(handles.AppliedPotential,'String',zaman);
    set(handles.MeasuredPotential,'String',MeasuredPotential);
   % Resistance=AppliedPotential/MeasuredPotential;
   % set(handles.Resistance,'String',Resistance);
    end
    MeasuredPotential=MeasuredPotential/50;
   Measure(i,1)=zaman;
    Measure(i,2)=MeasuredPotential;
    plot(handles.Graph1,Measure(:,1),Measure(:,2),'-r','LineWidth',0.5)
    grid(handles.Graph1)
    xlabel('Time (Seconds)'),ylabel('ReferenceVoltage (V)')
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

function sure_Callback(hObject, eventdata, handles)
% hObject    handle to sure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sure as text
%        str2double(get(hObject,'String')) returns contents of sure as a double

% --- Executes during object creation, after setting all properties.
function sure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function adet_Callback(hObject, eventdata, handles)
% hObject    handle to adet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of adet as text
%        str2double(get(hObject,'String')) returns contents of adet as a double

% --- Executes during object creation, after setting all properties.
function adet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to adet (see GCBO)
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
