function varargout = LockinFFT_GPIB(varargin)
% LOCKINFFT_GPIB MATLAB code for LockinFFT_GPIB.fig
%      LOCKINFFT_GPIB, by itself, creates a new LOCKINFFT_GPIB or raises the existing
%      singleton*.
%
%      H = LOCKINFFT_GPIB returns the handle to a new LOCKINFFT_GPIB or the handle to
%      the existing singleton*.
%
%      LOCKINFFT_GPIB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOCKINFFT_GPIB.M with the given input arguments.
%
%      LOCKINFFT_GPIB('Property','Value',...) creates a new LOCKINFFT_GPIB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LockinFFT_GPIB_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LockinFFT_GPIB_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LockinFFT_GPIB

% Last Modified by GUIDE v2.5 04-Mar-2015 11:57:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LockinFFT_GPIB_OpeningFcn, ...
                   'gui_OutputFcn',  @LockinFFT_GPIB_OutputFcn, ...
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


% --- Executes just before LockinFFT_GPIB is made visible.
function LockinFFT_GPIB_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LockinFFT_GPIB (see VARARGIN)

% Choose default command line output for LockinFFT_GPIB
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LockinFFT_GPIB wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LockinFFT_GPIB_OutputFcn(hObject, eventdata, handles) 
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
global Lockin;
global Measure;
Measure= [];
Lockin=visa('ni','GPIB0::10::INSTR');
fopen(Lockin);





% --- Executes on button press in StartProgram.
function StartProgram_Callback(hObject, eventdata, handles)
% hObject    handle to StartProgram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StartProgram
global Lockin;
global Measure;
tic
for i=1:1000000000

Current=str2num(query(Lockin,'OUTP ? 1'));
zaman= toc; 
Measure(i,1)=zaman;
Measure(i,2)=Current;
pause(0.1);
set(handles.MeasuredCurrent,'String',Current);
plot(handles.Graph1,Measure(:,1),Measure(:,2),'-r','LineWidth',0.5)
    grid(handles.Graph1)
    xlabel('Time (Seconds)'),ylabel('Current (A)')
end



display('Experiment is Done!');
fclose(Lockin);
delete(Lockin);
instrreset;


% --- Executes on button press in Abort.
function Abort_Callback(hObject, eventdata, handles)
% hObject    handle to Abort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Abort
global Lockin;
fclose(Lockin);
delete(Lockin);
instrreset;

% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Measure;

dataname=get(handles.SavePath,'String');
data=sprintf('%s.txt',dataname);
save(data,'Measure','-ascii','-tabs');























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
