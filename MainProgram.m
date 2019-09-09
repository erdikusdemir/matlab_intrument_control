function varargout = MainProgram(varargin)
% MAINPROGRAM MATLAB code for MainProgram.fig
%      MAINPROGRAM, by itself, creates a new MAINPROGRAM or raises the existing
%      singleton*.
%
%      H = MAINPROGRAM returns the handle to a new MAINPROGRAM or the handle to
%      the existing singleton*.
%
%      MAINPROGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINPROGRAM.M with the given input arguments.
%
%      MAINPROGRAM('Property','Value',...) creates a new MAINPROGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainProgram_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainProgram_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainProgram

% Last Modified by GUIDE v2.5 02-Sep-2014 21:45:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainProgram_OpeningFcn, ...
                   'gui_OutputFcn',  @MainProgram_OutputFcn, ...
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


% --- Executes just before MainProgram is made visible.
function MainProgram_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainProgram (see VARARGIN)

% Choose default command line output for MainProgram
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainProgram wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainProgram_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in Prog_V_2400_M_2400.
function Prog_V_2400_M_2400_Callback(hObject, eventdata, handles)
% hObject    handle to Prog_V_2400_M_2400 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Program_V_2400_M_2400;
%instrreset------------------------------------------------------------bütün
%cihazlaarýn baðlantýsýný keser.



% --- Executes on button press in Prog_Shutter.
function Prog_Shutter_Callback(hObject, eventdata, handles)
% hObject    handle to Prog_Shutter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Shutter;


% --- Executes on button press in Prog_G_236.
function Prog_G_236_Callback(hObject, eventdata, handles)
% hObject    handle to Prog_G_236 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GatePotential;