function varargout = Setting(varargin)
% SETTING MATLAB code for Setting.fig
%      SETTING, by itself, creates a new SETTING or raises the existing
%      singleton*.
%
%      H = SETTING returns the handle to a new SETTING or the handle to
%      the existing singleton*.
%
%      SETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETTING.M with the given input arguments.
%
%      SETTING('Property','Value',...) creates a new SETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Setting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Setting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Setting

% Last Modified by GUIDE v2.5 01-Jun-2016 18:28:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Setting_OpeningFcn, ...
                   'gui_OutputFcn',  @Setting_OutputFcn, ...
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


% --- Executes just before Setting is made visible.
function Setting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Setting (see VARARGIN)

% Choose default command line output for Setting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%UIWAIT makes Setting wait for user response (see UIRESUME)
%uiwait(handles.figure1);

%Read Directories
run( 'ReadDirectories.m' );
%---

%Fill in 'edit's
set(handles.editSetApplicationDirectory , 'string' , Directory_Application );
set(handles.editSetMyoConnect , 'string' , Directory_MyoConnect );
set(handles.editSetMyoCapture , 'string' , Directory_MyoCapture );
set(handles.editSetSaveDirectory , 'string' , Directory_RootSave );
%---


% --- Outputs from this function are returned to the command line.
function varargout = Setting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





%Application Param

% --- Executes on button press in cmdBrowseDirectoryApplication.
function cmdBrowseDirectoryApplication_Callback(hObject, eventdata, handles)
% hObject    handle to cmdBrowseDirectoryApplication (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Directory_Application = uigetdir( '' , 'Folder which contain MyoConnect.exe' );
set(handles.editSetApplicationDirectory , 'string' , Directory_Application);
save('Directory_Application.txt','Directory_Application','-ascii');


function editSetApplicationDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to editSetApplicationDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Directory_Application = get(hObject,'String');
save('Directory_Application.txt','Directory_Application','-ascii');


% --- Executes during object creation, after setting all properties.
function editSetApplicationDirectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSetApplicationDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%---------------



%MyoConnect Param

% --- Executes on button press in cmdBrowseMyoConnect.
function cmdBrowseMyoConnect_Callback(hObject, eventdata, handles)
% hObject    handle to cmdBrowseMyoConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Directory_MyoConnect = uigetdir( '' , 'Folder which contain MyoConnect.exe' );
set(handles.editSetMyoConnect , 'string' , Directory_MyoConnect);
save('Directory_MyoConnect.txt','Directory_MyoConnect','-ascii');


function editSetMyoConnect_Callback(hObject, eventdata, handles)
% hObject    handle to editSetMyoConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Directory_MyoConnect = get(hObject,'String');
save('Directory_MyoConnect.txt','Directory_MyoConnect','-ascii');


% --- Executes during object creation, after setting all properties.
function editSetMyoConnect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSetMyoConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%---------------



%MyoCapture Param

% --- Executes on button press in cmdBrowseMyoCapture.
function cmdBrowseMyoCapture_Callback(hObject, eventdata, handles)
% hObject    handle to cmdBrowseMyoCapture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Directory_MyoCapture = uigetdir( '' , 'Folder which contain MyoDataCapture.exe' );
set(handles.editSetMyoCapture , 'string' , Directory_MyoCapture);
save('Directory_MyoCapture.txt','Directory_MyoCapture','-ascii');


function editSetMyoCapture_Callback(hObject, eventdata, handles)
% hObject    handle to editSetMyoCapture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Directory_MyoCapture = get(hObject,'String');
save('Directory_MyoCapture.txt','Directory_MyoCapture','-ascii');


% --- Executes during object creation, after setting all properties.
function editSetMyoCapture_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSetMyoCapture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%---------------



%SaveDirectory Part

% --- Executes on button press in cmdBrowseSaveRecord.
function cmdBrowseSaveRecord_Callback(hObject, eventdata, handles)
% hObject    handle to cmdBrowseSaveRecord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Directory_RootSave = uigetdir( '' , 'Choose which folder you want for saving data' );
set(handles.editSetSaveDirectory , 'string' , Directory_RootSave);
save('Directory_RootSave.txt','Directory_RootSave','-ascii');


function editSetSaveDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to editSetSaveDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Directory_RootSave = get(hObject,'String');
save('Directory_RootSave.txt','Directory_RootSave','-ascii');


% --- Executes during object creation, after setting all properties.
function editSetSaveDirectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSetSaveDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%---------------



% --- Executes on button press in cmdApply.
function cmdApply_Callback(hObject, eventdata, handles)
% hObject    handle to cmdApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% %If putting all path in a single .txt document, we got problem avec 'dir()'
% %for the one which are not the longests.
% 
% %Get Back Paths and Directories
% Directory_MyoConnect = num2str( textread('Directory_MyoConnect.txt'), '%s' );
% Directory_MyoCapture = num2str( textread('Directory_MyoCapture.txt'), '%s' );
% Directory_RootSave = num2str( textread('Directory_RootSave.txt'), '%s' );
% 
% %Save them in a signle file
% save( 'SettingDirectories.txt' , 'Directory_MyoConnect' , 'Directory_MyoCapture' , 'Directory_RootSave' , '-ascii');



% %If delet file, errors when not modificate ALL directories before apply.

% %Delete Temporary Files for Directories
% %Let only 'SettingDirectories.txt'
% Files = dir();
% [ NumberOfFile , Var ] = size( dir() );
% for i = 3:NumberOfFile              %Begin at 3 because of '.' and '..' files
%     Comparaison = strcmp( Files(i).name , 'SettingDirectories.txt' );
%     if Comparaison == 0
%         Length = length( Files(i).name );
%         if Length > 4
%             Comparaison2 = strcmp( Files(i).name(1:9) , 'Directory');
%             Comparaison3 = strcmp( Files(i).name(end-3:end) , '.txt');
%             ResultComp = Comparaison2 & Comparaison3;
%             if ResultComp == 1
%                 delete( Files(i).name );
%             end
%         end
%     end
% end

close('Setting');



