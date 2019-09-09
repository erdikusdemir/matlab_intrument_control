function varargout = Shutter(varargin)
% SHUTTER MATLAB code for Shutter.fig
%      SHUTTER, by itself, creates a new SHUTTER or raises the existing
%      singleton*.
%
%      H = SHUTTER returns the handle to a new SHUTTER or the handle to
%      the existing singleton*.
%
%      SHUTTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHUTTER.M with the given input arguments.
%
%      SHUTTER('Property','Value',...) creates a new SHUTTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Shutter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Shutter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Shutter

% Last Modified by GUIDE v2.5 02-Sep-2014 14:44:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Shutter_OpeningFcn, ...
                   'gui_OutputFcn',  @Shutter_OutputFcn, ...
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


%% --- Executes just before Shutter is made visible.
function Shutter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Shutter (see VARARGIN)

% Choose default command line output for Shutter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

    
    %% initializing the Shutter Source


    %%

% UIWAIT makes Shutter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Shutter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global ShutterSource;
delete(ShutterSource);
display('output');
%%

% --- Executes on button press in Title.
function Title_Callback(hObject, eventdata, handles)
% hObject    handle to Title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% --- Executes on button press in OpenShutter.
function OpenShutter_Callback(hObject, eventdata, handles)
% hObject    handle to OpenShutter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    ShutterSource=visa('ni','GPIB0::17::INSTR');
    fopen(ShutterSource);
    fprintf(ShutterSource,'F0X');
    fprintf(ShutterSource,'K0X');
    fprintf(ShutterSource,'P0X');
    fprintf(ShutterSource,'I+2');
    fprintf(ShutterSource,'V+12');
    fprintf(ShutterSource,'F1X');
    pause(0.8);
    fprintf(ShutterSource,'F0X');
    delete(ShutterSource);
%%

%% --- Executes on button press in CloseShutter.
function CloseShutter_Callback(hObject, eventdata, handles)
% hObject    handle to CloseShutter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    ShutterSource=visa('ni','GPIB0::17::INSTR');
    fopen(ShutterSource);
    fprintf(ShutterSource,'F0X');
    fprintf(ShutterSource,'K0X');
    fprintf(ShutterSource,'P0X');
    fprintf(ShutterSource,'I+2');
    fprintf(ShutterSource,'V-12');
    fprintf(ShutterSource,'F1X');
    pause(0.7);
    fprintf(ShutterSource,'F0X');
    delete(ShutterSource);
    %%