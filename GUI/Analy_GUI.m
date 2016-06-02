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

% Last Modified by GUIDE v2.5 13-May-2016 17:47:43

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
    
    %Init variables 'ploter2.m'
    handles.current_data = 0;
    handles.s1 = 0;
    handles.s2 = 0;
    handles.s3 = 0;
    handles.s4 = 0;
    handles.s5 = 0;
    handles.s6 = 0;
    handles.s7 = 0;
    handles.s8 = 0;
    handles.s9 = 0;
    
    %Init variables 'ploter.m'
    handles.current_data2 = 0;
    handles.state1 = 0;
    handles.state2 = 0;
    handles.state3 = 0;
    handles.state4 = 0;
    handles.state5 = 0;
    handles.state6 = 0;
    handles.state7 = 0;
    handles.state8 = 0;
    handles.state9 = 0;
    
guidata(hObject, handles);

% UIWAIT makes Analy_GUI wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Analy_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output; %Comment to make available : close('Analy_GUI')

% --- Executes on selection change in popupChoice.
function popupChoice_Callback(hObject, eventdata, handles)
% hObject    handle to popupChoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupChoice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupChoice

Choice = get(hObject,'Value');      %Get the value of the popup menu

if Choice == 1
    % Get and Read the file.
    %Get FileName, PathName, and FilterIndex of the choosen File.
    [FileName,PathName,FilterIndex] = uigetfile({'*.csv';'*.txt'},'Select the record'); %FilterIndex is not useful for now but maybe later
    set(handles.txtFileName,'string',FileName);     %Write the name of the file into the textbox
    Path = strcat(PathName,FileName);               %Concatenate Path & FileName
    emg = readtable(Path);                          %Read the Table contain into the file
    %Work the same way as : 
    %emg =
    %readtable(Path,'ReadVariableNames',true,'Format','%d%d%d%d%d%d%d%d%d','Delimiter',',');
    length = height(emg);                           %Calculate the numer of 'samples' (NB : 200Hz = 200 samples/s
    set(handles.txtFileLength,'string',length);     %Write number of 'samples' into the textbox
    
    % Put data from the table to 8 different variables
    emg1 = double(table2array(emg(:,2)));   %Begin in data 2, because the first one is the given name of the file by acquisition program
    emg2 = double(table2array(emg(:,3)));  
    emg3 = double(table2array(emg(:,4)));
    emg4 = double(table2array(emg(:,5)));
    emg5 = double(table2array(emg(:,6)));
    emg6 = double(table2array(emg(:,7)));
    emg7 = double(table2array(emg(:,8)));
    emg8 = double(table2array(emg(:,9)));
    emgdata = [emg1,emg2,emg3,emg4,emg5,emg6,emg7,emg8];    %Put each variable into a matrix(8,NumberOfSamples)
    setappdata(0,'emgdata',emgdata);    %Same as handles.emgdata= at previous line, maybe change in future.
    
    % Calculate RMS
    RMS_EMG = rms(emgdata,200);         %Calculate rms using emgdata matrix and the frequency : 200Hz
    setappdata(0,'RMS_EMG',RMS_EMG);    %Same as handles.RMS_EMG= at previous line, maybe change in future.
    
     % Not used anymore
%     total_RMS = 0;                      %Initialisation
%     for i =1:8
%         total_RMS = total_RMS+RMS_EMG(:,i);
%         %total_env = total_env+env_EMG(:,i);
%     end
    
    % Calculating enveloppe detection using function 'env_detector' -> Hilbert
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

elseif Choice == 2
    % Open Interactive Interface
    close('Analy_GUI');
    run('Myo_Capture.m');
        
end

% --- Executes during object creation, after setting all properties.
function popupChoice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupChoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Choice of which raw data we want to plot (Raw / RMS)
% --- Executes on selection change in rawDataChoice.
function rawDataChoice_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');
switch str{val};
case 'RAW DATA' 
    emgdata = getappdata(0,'emgdata');
    handles.current_data = emgdata;
    handles.s9 = 1;
    ploter2(handles);
    handles.pro = ploter2(handles);
%     axes(handles.rawDataPlot)
%     ylim([-150 150])
%     cla(handles.rawDataPlot)
case 'RMS DATA' 
    RMS_EMG = getappdata(0,'RMS_EMG');
    handles.current_data = RMS_EMG;
    handles.s9 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
%     axes(handles.rawDataPlot)
%     ylim([0 150])
%     cla(handles.rawDataPlot)
end
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function rawDataChoice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rawDataChoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Plotting each raw signals depending of buttons which are on.
% --- Executes on selection change in rawSignal_1.
function rawSignal_1_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in rawSignal_2.
function rawSignal_2_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in rawSignal_3.
function rawSignal_3_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in rawSignal_4.
function rawSignal_4_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in rawSignal_5.
function rawSignal_5_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in rawSignal_6.
function rawSignal_6_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in rawSignal_7.
function rawSignal_7_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in rawSignal_8.
function rawSignal_8_Callback(hObject, eventdata, handles)
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

% Plotting all raw signal if button is on
% --- Executes on selection change in rawSignal_All.
function rawSignal_All_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    handles.s1 = 1;
    handles.s2 = 1;
    handles.s3 = 1;
    handles.s4 = 1;
    handles.s5 = 1;
    handles.s6 = 1;
    handles.s7 = 1;
    handles.s8 = 1;
    handles.s9 = 1;
    handles.current_data2 = 1;
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
    handles.s9 = 0;
    handles.current_data2 = 0;
    ploter2(handles);
    handles.pro = ploter2(handles);
end
guidata(hObject,handles)


% Plotting each analysed signals depending of buttons which are on.
% --- Executes on selection change in analySignal_1.
function analySignal_1_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in analySignal_2.
function analySignal_2_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in analySignal_3.
function analySignal_3_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in analySignal_4.
function analySignal_4_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in analySignal_5.
function analySignal_5_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in analySignal_6.
function analySignal_6_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in analySignal_7.
function analySignal_7_Callback(hObject, eventdata, handles)
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

% --- Executes on selection change in analySignal_8.
function analySignal_8_Callback(hObject, eventdata, handles)
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

% Plotting all analysed signal if button is on
% --- Executes on selection change in analySignal_All.
function analySignal_All_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.state1 = 1;
    handles.state2 = 1;
    handles.state3 = 1;
    handles.state4 = 1;
    handles.state5 = 1;
    handles.state6 = 1;
    handles.state7 = 1;
    handles.state8 = 1;
    handles.state9 = 1;
    handles.current_data = 1;
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
    handles.state9 = 0;
    handles.current_data = 0;
    ploter(handles);
    handles.pro2 = ploter(handles);
end
guidata(hObject,handles)

% Choice of which analyse we want
% --- Executes on selection change in analyDataChoice.
function analyDataChoice_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');
switch str{val};
case 'Sum RAW DATA' 
    emgdata = getappdata(0,'emgdata');
    handles.current_data2 = emgdata;
    handles.state9 = 2;
    ploter(handles);
    handles.pro2 = ploter(handles);
%     axes(handles.processedDataPlot)
%     ylim([-150 150])
%     cla(handles.processedDataPlot)
case 'Sum RMS DATA' 
    RMS_EMG = getappdata(0,'RMS_EMG');
    handles.current_data2 = RMS_EMG;
    handles.state9 = 3;
    ploter(handles);
    handles.pro2 = ploter(handles);
%     axes(handles.processedDataPlot)
%     ylim([0 150])
%     cla(handles.processedDataPlot)
case 'Envelope detector' 
    Thres = getappdata(0,'Thres');
    env_EMG = getappdata(0,'env_EMG');
    handles.current_data2 = env_EMG;
    handles.current_thres = Thres;
    handles.state9 = 1;
    ploter(handles);
    handles.pro2 = ploter(handles);
%     axes(handles.processedDataPlot)
%     ylim([0 150])
%     cla(handles.processedDataPlot)
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function analyDataChoice_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Horizontal moving. Works with selection of data range to plot. 
% --- Executes on selection change in dataOffsetSelect.
function dataOffsetSelect_Callback(hObject, eventdata, handles)
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
    axes(handles.processedDataPlot);
    plot(EL);
    ylim([-10 150]);
elseif (handles.state9 == 2)
    EL =  handles.pro2((minSli*L2):(maxSli*L2));
    axes(handles.processedDataPlot);
    plot(EL);
    ylim([-150 150]);
elseif (handles.state9 == 3)
    EL =  handles.pro2((minSli*L2):(maxSli*L2));
    axes(handles.processedDataPlot);
    plot(EL);
    ylim([-10 150]);
end

if (handles.s9 == 1)
    axes(handles.rawDataPlot);
    plot(EE);
    ylim([-150 150]);
elseif (handles.s9 == 0)
    axes(handles.rawDataPlot);
    plot(EE);
    ylim([-10 150]);
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function dataOffsetSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataOffsetSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% Zoom on plotting data. Works with selection of data range to plot. 
% --- Executes on selection change in dataLengthSelect.
function dataLengthSelect_Callback(hObject, eventdata, handles)
slider_adj = get(hObject,'Value');
if slider_adj <0.01
    handles.gap = 0.01;
else
    handles.gap = slider_adj;
end
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function dataLengthSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataLengthSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% Open setting screen.
% --- Executes on button press in cmdSetting.
function cmdSetting_Callback(hObject, eventdata, handles)
% hObject    handle to cmdSetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

run('Setting.m');