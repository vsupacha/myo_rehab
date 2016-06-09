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

% Last Modified by GUIDE v2.5 08-Jun-2016 12:19:11

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

%Init Graphs
x = 1:10;
y = 0;
        axes(handles.plotInterEmg1);
        plot(x,y,'r');
        axes(handles.plotInterEmg2);
        plot(x,y,'r');
        axes(handles.plotInterEmg3);
        plot(x,y,'r');
        axes(handles.plotInterEmg4);
        plot(x,y,'r');
        axes(handles.plotInterEmg5);
        plot(x,y,'r');
        axes(handles.plotInterEmg6);
        plot(x,y,'r');
        axes(handles.plotInterEmg7);
        plot(x,y,'r');
        axes(handles.plotInterEmg8);
        plot(x,y,'r');
%---

%Read Directories
run( 'ReadDirectories.m' );
%---

%Run 'MyoConnect.exe'
system( strcat (Directory_MyoConnect,'\MyoConnect.exe &') );
pause(3);
%---

% UIWAIT makes Myo_Capture wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Myo_Capture_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cmdRun.
function cmdRun_Callback(hObject, eventdata, handles)
% hObject    handle to cmdRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Delete Temporary file. If we do not save, temporary file stays, and
%program does not know which 'emg-...' is the good one.
run('DeleteTemporaryFile.m');
%---

%Read Directories
run( 'ReadDirectories.m' );
%---

%Change directory to save temporary files
cd ( Directory_MyoCapture )
%---

%Just in case 'MyoConnect.exe' crash after openning 'MyoCapture.m'
%Run 'MyoConnect.exe'
system( strcat (Directory_MyoConnect,'\MyoConnect.exe &') );
pause(0.5);
%---

%Run 'MyoDataCapture.exe'
system( strcat (Directory_MyoCapture,'\MyoDataCapture.exe &') );
pause(0.8);
%---

%Note that this method could be used with a shortcut 'MyoConnect.lnk'
%placed into the 'MyoDataCapture.exe' folder
%But at least, it will not be an universal application because shortcut
%is not here if we do not place it.
%So lets use the 'MyoConnect.exe'

%'&' is to use a consol to run the .exe in order to not stop the MatLab
%code


%Find the data file created by 'MyoDataCapture.exe'
run( 'FindCreatedFile.m' );
%---

%Go back to the MatLab application's directory
cd ( Directory_Application );
%---

%Run Plotting Function
function_acquisition( FileName , handles ); %Directory_MyoCapture, FileName, 
%---


% --- Executes on button press in cmdStop.
function cmdStop_Callback(hObject, eventdata, handles)
% hObject    handle to cmdStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Kill 'MyoDataCapture.exe
system( 'taskkill /im MyoDataCapture.exe /F' ); %Have to rename the 'Myo Data Capture.exe' without spaces
%Kill 'MyoConnect.exe'
system( 'taskkill /im MyoConnect.exe /F' );     %Have to rename the 'Myo Connect.exe' without spaces
%---

% --- Executes on button press in cmdReset.
function cmdReset_Callback(hObject, eventdata, handles)
% hObject    handle to cmdReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Delete Temporary Files
run( 'DeleteTemporaryFile.m' );
%---
%Clear Graphs
x = 1:10;
y = 0;
        axes(handles.plotInterEmg1);
        plot(x,y,'r');
        axes(handles.plotInterEmg2);
        plot(x,y,'r');
        axes(handles.plotInterEmg3);
        plot(x,y,'r');
        axes(handles.plotInterEmg4);
        plot(x,y,'r');
        axes(handles.plotInterEmg5);
        plot(x,y,'r');
        axes(handles.plotInterEmg6);
        plot(x,y,'r');
        axes(handles.plotInterEmg7);
        plot(x,y,'r');
        axes(handles.plotInterEmg8);
        plot(x,y,'r');
%---

%After 'cmdReset_Callback', function_acquisition stop run because of a bug, not a bad thing but
%may be find a better way to stop it at the end of 'cmdStop' button code.


function editSaveName_Callback(hObject, eventdata, handles)
% hObject    handle to editSaveName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSaveName as text
%        str2double(get(hObject,'String')) returns contents of editSaveName as a double


% --- Executes during object creation, after setting all properties.
function editSaveName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSaveName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cmdSave.
function cmdSave_Callback(hObject, eventdata, handles)
% hObject    handle to cmdSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%In case no event on Stop Button before Save Button
%Kill 'MyoDataCapture.exe
system( 'taskkill /im MyoDataCapture.exe /F' ); %Have to rename the 'Myo Data Capture.exe' without spaces
%---

%Choose with which name we want to save the file
SaveName = get(handles.editSaveName,'string');
%---

%Verification Name is not empty
Comparaison = strcmp( 'SaveName' , '' );
%---

%If empty, break, else, continue code
if Comparaison == 1
    printf( 'Choose a name' );
    return
end
%---

%Find again the data file created by 'MyoDataCapture.exe'
%Because the FileName variable is deleted after the execution of 'cmdRun_Callback' function
%Find the .csv File
run( 'FindCreatedFile.m' );
%---

%Get Directory
Directory_SaveFile = uigetdir( Directory_RootSave, 'Choose which folder you want for saving data' );
%---

%Path File
PathFile = strcat( Directory_MyoCapture , '\' , FileName );
%---
%Path Rename Saved File
PathSaveFile = strcat( Directory_SaveFile , '\' , SaveName , '.csv' );
%---

%Move record and rename it :
cmd = ['move' , ' ' , PathFile , ' ' , PathSaveFile ]
system ( cmd );
%---
%Find the way to rename the file with de string in the edit. If nothing in
%the edt, do not rename.

%Delete all temporary files.
run( 'DeleteTemporaryFile.m' );

%After 'cmdSave_Callback', function_acquisition stop run because of a bug, not a bad thing but
%may be find a better way to stop it at the end of 'cmdStop' button code.


% --- Executes on button press in cmdSetting.
function cmdSetting_Callback(hObject, eventdata, handles)
% hObject    handle to cmdSetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

run('Setting.m');


function cmdGUI_Callback(hObject, eventdata, handles)
% hObject    handle to cmdGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Kill 'MyoDataCapture.exe
system( 'taskkill /im MyoDataCapture.exe /F' ); %Have to rename the 'Myo Data Capture.exe' without spaces
%Kill 'MyoConnect.exe'
system( 'taskkill /im MyoConnect.exe /F' );     %Have to rename the 'Myo Connect.exe' without spaces
%---

close( 'Myo_Capture' );
run( 'Analy_GUI.m' );
