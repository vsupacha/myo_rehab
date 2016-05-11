function varargout = Myo_Capture(varargin)
% MYO_CAPTURE MATLAB code for Myo_Capture.fig
%      MYO_CAPTURE, by itself, creates a new MYO_CAPTURE or raises the existing
%      singleton*.
%
%      H = MYO_CAPTURE returns the handle to a new MYO_CAPTURE or the handle to
%      the existing singleton*.
%
%      MYO_CAPTURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYO_CAPTURE.M with the given input arguments.
%
%      MYO_CAPTURE('Property','Value',...) creates a new MYO_CAPTURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Myo_Capture_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Myo_Capture_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Myo_Capture

% Last Modified by GUIDE v2.5 11-May-2016 17:13:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Myo_Capture_OpeningFcn, ...
                   'gui_OutputFcn',  @Myo_Capture_OutputFcn, ...
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


% --- Executes just before Myo_Capture is made visible.
function Myo_Capture_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Myo_Capture (see VARARGIN)

% Choose default command line output for Myo_Capture
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Myo_Capture wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Myo_Capture_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cmdSave.
function cmdSave_Callback(hObject, eventdata, handles)
% hObject    handle to cmdSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cmdGUI.
function cmdGUI_Callback(hObject, eventdata, handles)
% hObject    handle to cmdGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Analy_GUI.fig');
close('Myo_Capture');