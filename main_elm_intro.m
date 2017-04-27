function varargout = main_elm_intro(varargin)

% Last Modified by GUIDE v2.5 11-Sep-2016 14:59:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_elm_intro_OpeningFcn, ...
                   'gui_OutputFcn',  @main_elm_intro_OutputFcn, ...
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


% --- Executes just before main_elm_intro is made visible.
function main_elm_intro_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for main_elm_intro
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_elm_intro wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_elm_intro_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% when load data again, clean data records on this window
set(handles.uitable1, 'Data','');
set(handles.uitable2, 'Data','');
set(handles.text2,'String', '');
set(handles.text3,'String', '');
set(handles.text4,'String', '');
set(handles.text5,'String', '');
set(handles.text6,'String', '');
set(handles.text7,'String', '');
set(handles.text8,'String', '');
set(handles.text9,'String', '');
set(handles.text10,'String', '');

uiwait(window_load_train_data)
features = getappdata(0, 'app_oriFeatures');
[numFeatures, numPatterns] = size(features);
label_table = getappdata(0,'app_label_table');

set(handles.text2, 'String', sprintf('Original number of features: %d', numFeatures));
set(handles.text3, 'String', sprintf('Original number of patterns: %d', numPatterns));
set(handles.uitable1, 'Data', label_table);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

disp('******************** data preprocessing *******************************')
set(handles.uitable2, 'Data','');
set(handles.text4,'String', '');
set(handles.text5,'String', '');
set(handles.text6,'String', '');
set(handles.text7,'String', '');
set(handles.text8,'String', '');
set(handles.text9,'String', '');
set(handles.text10,'String', '');

uiwait(window_preprocessing)
newFeatures = getappdata(0,'app_newFeatures');
[numnewFeatures, numPatterns] = size(newFeatures);
set(handles.text4,'String', sprintf('New number of features: %d',numnewFeatures));
set(handles.text5,'String', sprintf('New number of patterns: %d',numPatterns));
set(handles.text6,'String',getappdata(0,'app_preprocessingResult'));


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
disp('******************** training *******************************')

set(handles.uitable2, 'Data','');
set(handles.text7,'String', '');
set(handles.text8,'String', '');
set(handles.text9,'String', '');
set(handles.text10,'String', '');

uiwait(trainNN0)
uiwait(trainNN1)
uiwait(trainNN2)
uiwait(trainNN3)
uiwait(trainNN4)
uiwait(trainNN5)
trainAccuracy = getappdata(0, 'app_trainAccuracy');
set(handles.text7,'String', sprintf('Train accuracy: %f %s',trainAccuracy*100,'%'));

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

if isempty(getappdata(0, 'app_trainAccuracy'))
    errordlg('Training process has not been completed!','Error');
    disp('*** need finish training first')
else

    set(handles.uitable2, 'Data','');
    set(handles.text8,'String', '');
    set(handles.text9,'String', '');
    set(handles.text10,'String', '');

    uiwait(window_load_test_data)
    [numnewFeatures_test, numnewPatterns_test] = size(getappdata(0,'app_newFeatures_test'));
    set(handles.text8,'String', sprintf('New number of features: %d',numnewFeatures_test));
    set(handles.text9,'String', sprintf('New number of patterns: %d',numnewPatterns_test));
    set(handles.uitable2, 'Data',  getappdata(0,'app_label_table_test'));

end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)

disp('******************** get test result *******************************')

WeightIH = getappdata(0,'app_WeightIH');
WeightHO = getappdata(0,'app_WeightHO');
tarLabels_vec_test = getappdata(0,'app_tarLabels_vec_test');
acFun = getappdata(0,'app_acSel_intro');
newFeatures_test = getappdata(0,'app_newFeatures_test');
[Output_test,~] = ELM_test(newFeatures_test,....
WeightIH,WeightHO,tarLabels_vec_test,acFun);


[~, numnewPatterns_test] = size(newFeatures_test);
testAccuracy = sum(Output_test == tarLabels_vec_test,1)/numnewPatterns_test;

set(handles.text10, 'String', sprintf('Test accuracy: %f %s',testAccuracy*100,'%'));


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close
