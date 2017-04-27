function varargout = trainNN0(varargin)

% Last Modified by GUIDE v2.5 26-Jul-2016 23:24:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trainNN0_OpeningFcn, ...
                   'gui_OutputFcn',  @trainNN0_OutputFcn, ...
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


% --- Executes just before trainNN0 is made visible.
function trainNN0_OpeningFcn(hObject, eventdata, handles, varargin)

axes(handles.axes1)
imshow('basicNN.png')

newFeatures = getappdata(0,'app_newFeatures');
[numnewFeatures,numnewPatterns] = size(newFeatures);
set(handles.text5,'String', sprintf('features: %d',numnewFeatures));
set(handles.text6,'String', sprintf('patterns: %d',numnewPatterns));

% Choose default command line output for trainNN0
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trainNN0 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trainNN0_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

numHiddenTxt = get(handles.edit1,'String');
numHidden = str2double(numHiddenTxt);
disp('******************** input numHidden ***********************************')
setappdata(0,'app_numHidden',numHidden);

if isnan(getappdata(0,'app_numHidden'))
    msgbox('Please enter number of hidden units!');
else
    close
end



function edit1_Callback(hObject, eventdata, handles)


% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
