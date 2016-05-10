function varargout = Analy_GUI(varargin)
% ANALY_GUI MATLAB code for Analy_GUI.fig
%      ANALY_GUI, by itself, creates a new ANALY_GUI or raises the existing
%      singleton*.
%
%      H = ANALY_GUI returns the handle to a new ANALY_GUI or the handle to
%      the existing singleton*.
%
%      ANALY_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALY_GUI.M with the given input arguments.
%
%      ANALY_GUI('Property','Value',...) creates a new ANALY_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Analy_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Analy_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Analy_GUI

% Last Modified by GUIDE v2.5 26-Apr-2016 16:49:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Analy_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Analy_GUI_OutputFcn, ...
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


% --- Executes just before Analy_GUI is made visible.
function Analy_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Analy_GUI (see VARARGIN)

% Choose default command line output for Analy_GUI
handles.output = hObject;
    handles.s1 = 0;
    handles.s2 = 0;
    handles.s3 = 0;
    handles.s4 = 0;
    handles.s5 = 0;
    handles.s6 = 0;
    handles.s7 = 0;
    handles.s8 = 0;
    handles.state1 = 0;
    handles.state2 = 0;
    handles.state3 = 0;
    handles.state4 = 0;
    handles.state5 = 0;
    handles.state6 = 0;
    handles.state7 = 0;
    handles.state8 = 0;
guidata(hObject, handles);

% UIWAIT makes Analy_GUI wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Executes on button press in FileBro_Pushbutton.
function FileBro_Pushbutton_Callback(hObject, eventdata, handles)
[filename] = uigetfile({'*.csv';'*.txt'},'File Selector');
emg = readtable(filename,'Format','%d%d%d%d%d%d%d%d%d');
long = height(emg);
set(handles.edit1,'string',filename);
set(handles.edit2,'string',long);

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

total_RMS = 0;
for i =1:8
    total_RMS = total_RMS+RMS_EMG(:,i);
    %total_env = total_env+env_EMG(:,i);
end

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

% --- Outputs from this function are returned to the command line.
function varargout = Analy_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');
switch str{val};
case 'RAW DATA' 
    emgdata = getappdata(0,'emgdata');
    handles.current_data = emgdata;
    handles.s9 = 1;
    ploter2(handles);
    handles.pro = ploter2(handles);
%     axes(handles.axes1)
%     ylim([-150 150])
%     cla(handles.axes1)
case 'RMS DATA' 
    RMS_EMG = getappdata(0,'RMS_EMG');
    handles.current_data = RMS_EMG;
    handles.s9 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
%     axes(handles.axes1)
%     ylim([0 150])
%     cla(handles.axes1)
end
guidata(hObject,handles)

function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EMG_button1_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    handles.s1 = 1;
    ploter2(handles);
    handles.pro = ploter2(handles);
else
    handles.s1 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
end
guidata(hObject,handles)

function EMG_button2_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.s2 = 1;
    ploter2(handles);
    handles.pro = ploter2(handles);
else
    handles.s2 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
end
guidata(hObject,handles)

function EMG_button3_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.s3 = 1;
    ploter2(handles);
    handles.pro = ploter2(handles);
else
    handles.s3 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
end
guidata(hObject,handles)

function EMG_button4_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.s4 = 1;
    ploter2(handles);
    handles.pro = ploter2(handles);
else
    handles.s4 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
end
guidata(hObject,handles)

function EMG_button5_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.s5 = 1;
    ploter2(handles);
    handles.pro = ploter2(handles);
else
    handles.s5 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
end
guidata(hObject,handles)

function EMG_button6_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.s6 = 1;
    ploter2(handles);
    handles.pro = ploter2(handles);
else
    handles.s6 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
end
guidata(hObject,handles)

function EMG_button7_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.s7 = 1;
    ploter2(handles);
    handles.pro = ploter2(handles);
else
    handles.s7 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
end
guidata(hObject,handles)

function EMG_button8_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.s8 = 1;
    ploter2(handles);
    handles.pro = ploter2(handles);
else
    handles.s8 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
end
guidata(hObject,handles)

function EMG_button9_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    handles.s1 = 1;
    handles.s2 = 1;
    handles.s3 = 1;
    handles.s4 = 1;
    handles.s5 = 1;
    handles.s6 = 1;
    handles.s7 = 1;
    handles.s8 = 1;
    ploter2(handles);
    handles.pro = ploter2(handles);
else
    handles.s1 = 0;
    handles.s2 = 0;
    handles.s3 = 0;
    handles.s4 = 0;
    handles.s5 = 0;
    handles.s6 = 0;
    handles.s7 = 0;
    handles.s8 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
end
guidata(hObject,handles)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function EMG_button2_1_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.state1 = 1;
    ploter(handles);
    handles.pro2 = ploter(handles);
else
    handles.state1 = 0;
    ploter(handles);
    handles.pro2 = ploter(handles);
end
guidata(hObject,handles)

function EMG_button2_2_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.state2 = 1;
    ploter(handles);
    handles.pro2 = ploter(handles);
else
    handles.state2 = 0;
    ploter(handles);
    handles.pro2 = ploter(handles);
end
guidata(hObject,handles)

function EMG_button2_3_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.state3 = 1;
    ploter(handles);
    handles.pro2 = ploter(handles);
else
    handles.state3 = 0;
    ploter(handles);
    handles.pro2 = ploter(handles);
end
guidata(hObject,handles)

function EMG_button2_4_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.state4 = 1;
    ploter(handles);
    handles.pro2 = ploter(handles);
else
    handles.state4 = 0;
    ploter(handles);
    handles.pro2 = ploter(handles);
end
guidata(hObject,handles)

function EMG_button2_5_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.state5 = 1;
    ploter(handles);
    handles.pro2 = ploter(handles);
else
    handles.state5 = 0;
     ploter(handles);
     handles.pro2 = ploter(handles);
end
guidata(hObject,handles)

function EMG_button2_6_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.state6 = 1;
    ploter(handles);
    handles.pro2 = ploter(handles);
else
    handles.state6 = 0;
    ploter(handles);
    handles.pro2 = ploter(handles);
end
guidata(hObject,handles)

function EMG_button2_7_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.state7 = 1;
    ploter(handles);
    handles.pro2 = ploter(handles);
else
    handles.state7 = 0;
    ploter(handles);
    handles.pro2 = ploter(handles);
end
guidata(hObject,handles)

function EMG_button2_8_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.state8 = 1;
    ploter(handles);
    handles.pro2 = ploter(handles);
else
    handles.state8 = 0;
     ploter(handles);
     handles.pro2 = ploter(handles);
end
guidata(hObject,handles)

function EMG_button2_9_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.state1 = 1;
    handles.state2 = 1;
    handles.state3 = 1;
    handles.state4 = 1;
    handles.state5 = 1;
    handles.state6 = 1;
    handles.state7 = 1;
    handles.state8 = 1;
    ploter(handles);
    handles.pro2 = ploter(handles);
else
    handles.state1 = 0;
    handles.state2 = 0;
    handles.state3 = 0;
    handles.state4 = 0;
    handles.state5 = 0;
    handles.state6 = 0;
    handles.state7 = 0;
    handles.state8 = 0;
    ploter(handles);
    handles.pro2 = ploter(handles);
end
guidata(hObject,handles)

function popupmenu2_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');
switch str{val};
case 'Sum RAW DATA' 
    emgdata = getappdata(0,'emgdata');
    handles.current_data2 = emgdata;
    handles.state9 = 2;
    ploter(handles);
    handles.pro2 = ploter(handles);
%     axes(handles.axes2)
%     ylim([-150 150])
%     cla(handles.axes2)
case 'Sum RMS DATA' 
    RMS_EMG = getappdata(0,'RMS_EMG');
    handles.current_data2 = RMS_EMG;
    handles.state9 = 3;
    ploter(handles);
    handles.pro2 = ploter(handles);
%     axes(handles.axes2)
%     ylim([0 150])
%     cla(handles.axes2)
case 'Envelope detector' 
    Thres = getappdata(0,'Thres');
    env_EMG = getappdata(0,'env_EMG');
    handles.current_data2 = env_EMG;
    handles.current_thres = Thres;
    handles.state9 = 1;
    ploter(handles);
    handles.pro2 = ploter(handles);
%     axes(handles.axes2)
%     ylim([0 150])
%     cla(handles.axes2)
end

guidata(hObject,handles)

function popupmenu2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function slider1_Callback(hObject, eventdata, handles)
slider_main = get(hObject,'Value');
handles.slider_main = slider_main  ;
L = length(handles.pro(:,1));
L2 = length(handles.pro2);
if handles.slider_main> (1-handles.gap)
    minSli = (1-handles.gap);
    maxSli = 1;
elseif handles.slider_main<0.01
    minSli = 0.01;
    maxSli = handles.slider_main+handles.gap;
else
    minSli = handles.slider_main;
    maxSli = handles.slider_main+handles.gap;
end
EE =  handles.pro([round(minSli*L):round(maxSli*L)],:);
if (handles.state9 == 1)
    EL =  handles.pro2([round(minSli*L2):round(maxSli*L2)],:);
    axes(handles.axes2);
    plot(EL);
    ylim([-10 150]);
elseif (handles.state9 == 2)
    EL =  handles.pro2((minSli*L2):(maxSli*L2));
    axes(handles.axes2);
    plot(EL);
    ylim([-150 150]);
elseif (handles.state9 == 3)
    EL =  handles.pro2((minSli*L2):(maxSli*L2));
    axes(handles.axes2);
    plot(EL);
    ylim([-10 150]);
end

if (handles.s9 == 1)
    axes(handles.axes1);
    plot(EE);
    ylim([-150 150]);
elseif (handles.s9 == 0)
    axes(handles.axes1);
    plot(EE);
    ylim([-10 150]);
end

guidata(hObject,handles)


function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider4_Callback(hObject, eventdata, handles)
slider_adj = get(hObject,'Value');
if slider_adj <0.01
    handles.gap = 0.01;
else
    handles.gap = slider_adj;
end
guidata(hObject,handles)

function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
