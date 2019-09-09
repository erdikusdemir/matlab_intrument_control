function varargout = Program_I_6220_M_2182a_G_2400(varargin)
% PROGRAM_I_6220_M_2182A_G_2400 MATLAB code for Program_I_6220_M_2182a_G_2400.fig
%      PROGRAM_I_6220_M_2182A_G_2400, by itself, creates a new PROGRAM_I_6220_M_2182A_G_2400 or raises the existing
%      singleton*.
%
%      H = PROGRAM_I_6220_M_2182A_G_2400 returns the handle to a new PROGRAM_I_6220_M_2182A_G_2400 or the handle to
%      the existing singleton*.
%
%      PROGRAM_I_6220_M_2182A_G_2400('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRAM_I_6220_M_2182A_G_2400.M with the given input arguments.
%
%      PROGRAM_I_6220_M_2182A_G_2400('Property','Value',...) creates a new PROGRAM_I_6220_M_2182A_G_2400 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Program_I_6220_M_2182a_G_2400_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Program_I_6220_M_2182a_G_2400_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Program_I_6220_M_2182a_G_2400

% Last Modified by GUIDE v2.5 04-Dec-2014 11:55:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Program_I_6220_M_2182a_G_2400_OpeningFcn, ...
                   'gui_OutputFcn',  @Program_I_6220_M_2182a_G_2400_OutputFcn, ...
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


% --- Executes just before Program_I_6220_M_2182a_G_2400 is made visible.
function Program_I_6220_M_2182a_G_2400_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Program_I_6220_M_2182a_G_2400 (see VARARGIN)

% Choose default command line output for Program_I_6220_M_2182a_G_2400
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Program_I_6220_M_2182a_G_2400 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Program_I_6220_M_2182a_G_2400_OutputFcn(hObject, eventdata, handles) 
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
global Measure2182A;
global Source6220;

global Measure;
Measure= [];

Source6220=visa('ni','GPIB0::2::INSTR'); 
fopen(Source6220);

Measure2182A=visa('ni','GPIB0::1::INSTR');
fopen(Measure2182A);

Source2400=visa('ni','GPIB0::4::INSTR');
fopen(Source2400);

fprintf(Source6220,'*RST');
fprintf(Source6220,':SOUR:CURR:FILT 1');
% fprintf(Source6220,':SOUR:CURR:RANG 1e-7');
% fprintf(Source6220,':SOUR:CURR:AMPL 1e-7');
fprintf(Source6220,':SOUR:CURR:COMP 10');

fprintf(Measure2182A,':VOLT:RANG 5')
fprintf(Measure2182A,':SENS:VOLT:NPLC 5')
fprintf(Measure2182A,':TRIG:DEL 0')
%fprintf(NVM,':DISP:ENAB OFF')
fprintf(Measure2182A,':INIT:CONT ON');
fprintf(Measure2182A,':SENS:VOLT:REF:STAT ON');

fprintf(Source2400,'*RST');
fprintf(Source2400,':SOUR:FUNC VOLT');
fprintf(Source2400,':SOUR:VOLT:MODE FIX');
fprintf(Source2400,':ROUT:TERM REAR');
%fprintf(Source2400,':SENS:CURR:RANG:AUTO ON');
fprintf(Source2400,':SENS:CURR:RANG:UPP 1.05e-4');
fprintf(Source2400,':SENS:CURR:PROT 1e-1');
%fprintf(Source2400,':SENS:CURR:NPLC 2');%#number of power line cycles 
fprintf(Source2400,':SENS:AVER:TCON REP');
fprintf(Source2400,':SENS:AVER:COUN 10');
fprintf(Source2400,':SENS:AVER ON');
fprintf(Source2400,':DISP:DIG 7');
%fprintf(Source2400,':SOUR:VOLT 0.1')
fprintf(Source2400,':SOUR:DEL 0')



global Imaster;

global From;
global To;
global StepSize;
global StepDuration;
global DataperStep;

From=-5;
To=5;
StepSize=0.1;
StepDuration=1;
DataperStep=1;
Imaster=10e-6;

% --- Executes on button press in StartProgram.
function StartProgram_Callback(hObject, eventdata, handles)
% hObject    handle to StartProgram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StartProgram
global Imaster;

global From;
global To;
global StepSize;
global StepDuration;
global DataperStep;

global Source2400;
global Measure2182A;
global Source6220;

int8 NumberofStep ;
NumberofStep=((To-From)/StepSize)+1;

%StepDivitionTime=StepDuration/(DataperStep+1);%%%%%%%%%%%%%%%%%%%%%%%%


fprintf(Source6220,':SOUR:CURR:RANG %f',Imaster);
fprintf(Source6220,':SOUR:CURR:AMPL %f',Imaster);
%fprintf(Source6220,':OUTP ON');
    
    SendPot=sprintf(':SOUR:VOLT %f',From);
    fprintf(Source2400,SendPot);
   fprintf(Source2400,':OUTP ON');
    
    %pause(5);
    
for i=1:NumberofStep
tic
    GatePotential=From+(i-1)*StepSize;
    SendPotGate=sprintf(':SOUR:VOLT %f',GatePotential);
    fprintf(Source2400,SendPotGate);

    
    MeasuredPotential=0;
    MeasuredCurrent=0;
%    for j=1:DataperStep%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %      pause(StepDivitionTime);
        fprintf(Source2400,':INIT');
        fprintf(Measure2182A,':FETC?');
        ScannedData=scanstr(Measure2182A,',','%f');
        MeasuredCurrent=ScannedData+MeasuredCurrent;
%    end
    %MeasuredPotential=MeasuredPotential/DataperStep; %%%%%%%%%%%%%%%%%%%%%
 %   MeasuredCurrent=MeasuredCurrent/DataperStep;

    set(handles.AppliedPotential,'String',GatePotential);
    set(handles.MeasuredCurrent,'String',MeasuredCurrent);
%     Resistance=AppliedPotential/MeasuredCurrent;
%     set(handles.Resistance,'String',Resistance);
    Measure(i,1)=GatePotential;
    Measure(i,2)=MeasuredCurrent;
    plot(handles.Graph1,Measure(:,1),Measure(:,2),'-r','LineWidth',0.5)
    grid(handles.Graph1)
    xlabel('Gate Voltage (V)'),ylabel('Measured Potential (V)')
    pause (StepDuration-toc);

end

fprintf(Source2400,':OUTP OFF');
fprintf(Source6220,':OUTP OFF');
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
global Source6220;

fprintf(Source2400,':ABOR')
fprintf(Source2400,':OUTP OFF')
fclose(Source2400);
fprintf(Source6220,':ABOR')
fprintf(Source6220,':OUTP OFF')
fclose(Source6220);
instrreset;

% --- Executes on button press in Title.
function Title_Callback(hObject, eventdata, handles)
% hObject    handle to Title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Data_From_Callback(hObject, eventdata, handles)
% hObject    handle to Data_From (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_From as text
%        str2double(get(hObject,'String')) returns contents of Data_From as a double

% --- Executes during object creation, after setting all properties.
function Data_From_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_From (see GCBO)
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

function Data_StepDuration_Callback(hObject, eventdata, handles)
% hObject    handle to Data_StepDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_StepDuration as text
%        str2double(get(hObject,'String')) returns contents of Data_StepDuration as a double

% --- Executes during object creation, after setting all properties.
function Data_StepDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_StepDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Data_DataperStep_Callback(hObject, eventdata, handles)
% hObject    handle to Data_DataperStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_DataperStep as text
%        str2double(get(hObject,'String')) returns contents of Data_DataperStep as a double

% --- Executes during object creation, after setting all properties.
function Data_DataperStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_DataperStep (see GCBO)
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
