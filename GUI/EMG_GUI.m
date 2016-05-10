function varargout = EMG_GUI(varargin)
% EMG_GUI MATLAB code for EMG_GUI.fig
%      EMG_GUI, by itself, creates a new EMG_GUI or raises the existing
%      singleton*.
%
%      H = EMG_GUI returns the handle to a new EMG_GUI or the handle to
%      the existing singleton*.
%
%      EMG_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMG_GUI.M with the given input arguments.
%
%      EMG_GUI('Property','Value',...) creates a new EMG_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EMG_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EMG_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EMG_GUI

% Last Modified by GUIDE v2.5 14-Feb-2016 20:33:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EMG_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @EMG_GUI_OutputFcn, ...
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


% --- Executes just before EMG_GUI is made visible.
function EMG_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EMG_GUI (see VARARGIN)

% Choose default command line output for EMG_GUI
handles.output = hObject;




guidata(hObject, handles);

% UIWAIT makes EMG_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EMG_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function FileBrowser_Callback(hObject, eventdata, handles)

[filename] = uigetfile({'*.csv';'*.txt'},'File Selector');
emg = readtable(filename,'Format','%d%d%d%d%d%d%d%d%d');
long = height(emg);
set(handles.dataNum,'string',long);

emg1 = double(table2array(emg(:,2)));
emg2 = double(table2array(emg(:,3)));
emg3 = double(table2array(emg(:,4)));
emg4 = double(table2array(emg(:,5)));
emg5 = double(table2array(emg(:,6)));
emg6 = double(table2array(emg(:,7)));
emg7 = double(table2array(emg(:,8)));
emg8 = double(table2array(emg(:,9)));
emgdata = [emg1,emg2,emg3,emg4,emg5,emg6,emg7,emg8];
setappdata(0,'emgdata',emgdata);

RMS_EMG = rms(emgdata,200);
setappdata(0,'RMS_EMG',RMS_EMG);

window = 20;
env_EMG1 = env_detector(emg1,window);
env_EMG2 = env_detector(emg2,window);
env_EMG3 = env_detector(emg3,window);
env_EMG4 = env_detector(emg4,window);
env_EMG5 = env_detector(emg5,window);
env_EMG6 = env_detector(emg6,window);
env_EMG7 = env_detector(emg7,window);
env_EMG8 = env_detector(emg8,window);
env_EMG = [env_EMG1,env_EMG2,env_EMG3,env_EMG4,env_EMG5,env_EMG6,env_EMG7,env_EMG8];
setappdata(0,'env_EMG',env_EMG);

axes(handles.axes1)
plot(emg1)
ylim([-150 150])

axes(handles.axes2)
plot(emg2)
ylim([-150 150])

axes(handles.axes3)
plot(emg3)
ylim([-150 150])

axes(handles.axes4)
plot(emg4)
ylim([-150 150])

axes(handles.axes5)
plot(emg5)
ylim([-150 150])

axes(handles.axes6)
plot(emg6)
ylim([-150 150])

axes(handles.axes7)
plot(emg7)
ylim([-150 150])

axes(handles.axes8)
plot(emg8)
ylim([-150 150])

axes(handles.axes9)
plot(emgdata)
ylim([-150 150])

guidata(hObject, handles);



function threshold_Callback(hObject, eventdata, handles)

RMS_EMG = getappdata(0,'RMS_EMG');
env_EMG = getappdata(0,'env_EMG');
total_RMS = 0;
%total_env = 0;
for i =1:8
    total_RMS = total_RMS+RMS_EMG(:,i);
    %total_env = total_env+env_EMG(:,i);
end
%http://blogs.mathworks.com/pick/2014/05/23/automatic-activity-detection-using-hilbert-transform/

Thres1 = envelop_hilbert_v2(RMS_EMG(:,1),20,true,20,false);
Thres2 = envelop_hilbert_v2(RMS_EMG(:,2),20,true,20,false);
Thres3 = envelop_hilbert_v2(RMS_EMG(:,3),20,true,20,false);
Thres4 = envelop_hilbert_v2(RMS_EMG(:,4),20,true,20,false);
Thres5 = envelop_hilbert_v2(RMS_EMG(:,5),20,true,20,false);
Thres6 = envelop_hilbert_v2(RMS_EMG(:,6),20,true,20,false);
Thres7 = envelop_hilbert_v2(RMS_EMG(:,7),20,true,20,false);
Thres8 = envelop_hilbert_v2(RMS_EMG(:,8),20,true,20,false);
Thres9 = envelop_hilbert_v2(total_RMS,20,true,20,false);

axes(handles.axes1)
plot(RMS_EMG(:,1))
hold on
plot(Thres1*100,'LineWidth',2)
ylim([0 150])

axes(handles.axes2)
plot(RMS_EMG(:,2))
hold on
plot(Thres2*100,'LineWidth',2)
ylim([0 150])

axes(handles.axes3)
plot(RMS_EMG(:,3))
hold on
plot(Thres3*100,'LineWidth',2)
ylim([0 150])

axes(handles.axes4)
plot(RMS_EMG(:,4))
hold on
plot(Thres4*100,'LineWidth',2)
ylim([0 150])

axes(handles.axes5)
plot(RMS_EMG(:,5))
hold on
plot(Thres5*100,'LineWidth',2)
ylim([0 150])

axes(handles.axes6)
plot(RMS_EMG(:,6))
hold on
plot(Thres6*100,'LineWidth',2)
ylim([0 150])

axes(handles.axes7)
plot(RMS_EMG(:,7))
hold on
plot(Thres7*100,'LineWidth',2)
ylim([0 150])

axes(handles.axes8)
plot(RMS_EMG(:,8))
hold on
plot(Thres8*100,'LineWidth',2)
ylim([0 150])

axes(handles.axes9)
plot(total_RMS)
hold on
plot(Thres9*600,'LineWidth',2)
ylim([0 800])

guidata(hObject, handles);

function dataNum_Callback(hObject, eventdata, handles)
% hObject    handle to dataNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dataNum as text
%        str2double(get(hObject,'String')) returns contents of dataNum as a double


% --- Executes during object creation, after setting all properties.
function dataNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RMS.
function RMS_Callback(hObject, eventdata, handles)

emgdata = getappdata(0,'emgdata');
RMS_EMG = getappdata(0,'RMS_EMG');

axes(handles.axes1)
plot(RMS_EMG(:,1))
ylim([0 150])

axes(handles.axes2)
plot(RMS_EMG(:,2))
ylim([0 150])

axes(handles.axes3)
plot(RMS_EMG(:,3))
ylim([0 150])

axes(handles.axes4)
plot(RMS_EMG(:,4))
ylim([0 150])

axes(handles.axes5)
plot(RMS_EMG(:,5))
ylim([0 150])

axes(handles.axes6)
plot(RMS_EMG(:,6))
ylim([0 150])

axes(handles.axes7)
plot(RMS_EMG(:,7))
ylim([0 150])

axes(handles.axes8)
plot(RMS_EMG(:,8))
ylim([0 150])

axes(handles.axes9)
plot(RMS_EMG)
ylim([0 150])

guidata(hObject, handles);


% --- Executes on button press in PowerSig.
function PowerSig_Callback(hObject, eventdata, handles)
% hObject    handle to PowerSig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
