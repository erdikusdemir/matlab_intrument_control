function varargout = InstrumentReset(varargin)
% INSTRUMENTRESET MATLAB code for InstrumentReset.fig
%      INSTRUMENTRESET, by itself, creates a new INSTRUMENTRESET or raises the existing
%      singleton*.
%
%      H = INSTRUMENTRESET returns the handle to a new INSTRUMENTRESET or the handle to
%      the existing singleton*.
%
%      INSTRUMENTRESET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INSTRUMENTRESET.M with the given input arguments.
%
%      INSTRUMENTRESET('Property','Value',...) creates a new INSTRUMENTRESET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before InstrumentReset_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to InstrumentReset_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help InstrumentReset

% Last Modified by GUIDE v2.5 06-Mar-2015 10:04:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InstrumentReset_OpeningFcn, ...
                   'gui_OutputFcn',  @InstrumentReset_OutputFcn, ...
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


% --- Executes just before InstrumentReset is made visible.
function InstrumentReset_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to InstrumentReset (see VARARGIN)

% Choose default command line output for InstrumentReset
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes InstrumentReset wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = InstrumentReset_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
instrreset;
