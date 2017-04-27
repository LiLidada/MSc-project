function varargout = main(varargin)


% Last Modified by GUIDE v2.5 25-Aug-2016 01:20:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)


% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.mainFigure);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 


% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

main_elm_intro


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

train_bp0


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)

setappdata(0,'app_loadTrain',0);
setappdata(0,'app_preprocessing',0);
setappdata(0,'app_loadTest',0);

main_elm_adv

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
setappdata(0,'app_loadTrain',0);
setappdata(0,'app_preprocessing',0);
setappdata(0,'app_loadTest',0);

main_bp_adv


% --- Executes during object creation, after setting all properties.
function mainFigure_CreateFcn(hObject, eventdata, handles)


% Center the main window
movegui('center')


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)

close
% remove all appdata stored on root
appdata = get(0,'ApplicationData');
fns = fieldnames(appdata);
for ii = 1:numel(fns)
  rmappdata(0,fns{ii});
end


