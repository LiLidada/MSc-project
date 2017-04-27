function varargout = trainNN1(varargin)

% Last Modified by GUIDE v2.5 27-Jul-2016 08:45:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trainNN1_OpeningFcn, ...
                   'gui_OutputFcn',  @trainNN1_OutputFcn, ...
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


% --- Executes just before trainNN1 is made visible.
function trainNN1_OpeningFcn(hObject, eventdata, handles, varargin)

axes(handles.axes1)
imshow('NN1.png')
newFeatures = getappdata(0, 'app_newFeatures');
[handles.numInput, ~] = size(newFeatures); 
handles.numHidden = getappdata(0,'app_numHidden');

% Choose default command line output for trainNN1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trainNN1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trainNN1_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

if get(handles.radiobutton1,'Value') == 1
    disp('*** range of random values [-1, 1]');
    handles.WeightIH = rand(handles.numHidden,handles.numInput+1)*2-1;
    setappdata(0,'app_WeightIH',handles.WeightIH);
    close   
else
    close
end

% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)

rangeSelection = get(hObject,'String');

% Fill 'WeightIH' with Uniformly distributed random numbers
switch rangeSelection
    case '[-1, 1]'
        disp('*** range of random values [-1, 1]');
        handles.WeightIH = rand(handles.numHidden,handles.numInput+1)*2-1;
    case '[-0.1, 0.1]'
        disp('*** range of random values [-0.1, 0.1]');
        handles.WeightIH = (rand(handles.numHidden,handles.numInput+1)*2-1)/10;
    case '[-0.01, 0.01]'
        disp('*** range of random values [-0.01, 0.01]');
        handles.WeightIH = (rand(handles.numHidden,handles.numInput+1)*2-1)/100;
    case '[-10, 10]'
        disp('*** range of random values [-10, 10]');
        handles.WeightIH = (rand(handles.numHidden,handles.numInput+1)*2-1)*10;
    case '[-100, 100]'
        disp('*** range of random values [-100, 100]')
        handles.WeightIH = (rand(handles.numHidden,handles.numInput+1)*2-1)*100;
end

setappdata(0,'app_WeightIH',handles.WeightIH);
