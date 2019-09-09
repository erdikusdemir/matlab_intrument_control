function varargout = GatePotential(varargin)
% GATEPOTENTIAL MATLAB code for GatePotential.fig
%      GATEPOTENTIAL, by itself, creates a new GATEPOTENTIAL or raises the existing
%      singleton*.
%
%      H = GATEPOTENTIAL returns the handle to a new GATEPOTENTIAL or the handle to
%      the existing singleton*.
%
%      GATEPOTENTIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GATEPOTENTIAL.M with the given input arguments.
%
%      GATEPOTENTIAL('Property','Value',...) creates a new GATEPOTENTIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GatePotential_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GatePotential_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GatePotential

% Last Modified by GUIDE v2.5 02-Sep-2014 21:41:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GatePotential_OpeningFcn, ...
                   'gui_OutputFcn',  @GatePotential_OutputFcn, ...
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


% --- Executes just before GatePotential is made visible.
function GatePotential_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GatePotential (see VARARGIN)

% Choose default command line output for GatePotential
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GatePotential wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GatePotential_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Title.
function Title_Callback(hObject, eventdata, handles)
% hObject    handle to Title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Data_GatePotential_Callback(hObject, eventdata, handles)
% hObject    handle to Data_GatePotential (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_GatePotential as text
%        str2double(get(hObject,'String')) returns contents of Data_GatePotential as a double


% --- Executes during object creation, after setting all properties.
function Data_GatePotential_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_GatePotential (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Configure.
function Configure_Callback(hObject, eventdata, handles)
% hObject    handle to Configure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GateSource=visa('ni','GPIB0::18::INSTR');
    fopen(GateSource);
    fprintf(GateSource,'K0X');
    fprintf(GateSource,'F0,0X');
    
    fprintf(GateSource,'P0X');
    fprintf(GateSource,'I+2');
    fprintf(GateSource,'V+12');
    fprintf(GateSource,'F1X');
    fprintf(GateSource,'F0X');
    delete(GateSource);
    

% --- Executes on button press in Abort.
function Abort_Callback(hObject, eventdata, handles)
% hObject    handle to Abort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
