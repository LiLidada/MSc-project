function varargout = trainNN5(varargin)

% Last Modified by GUIDE v2.5 16-Aug-2016 09:24:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trainNN5_OpeningFcn, ...
                   'gui_OutputFcn',  @trainNN5_OutputFcn, ...
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


% --- Executes just before trainNN5 is made visible.
function trainNN5_OpeningFcn(hObject, eventdata, handles, varargin)

axes(handles.axes1)
imshow('NN5.png')

Hidden = getappdata(0,'app_Hidden');
handles.Target = getappdata(0,'app_tarLabels');
% Moore-Penrose pseudoinverse 
WeightHO = handles.Target * pinv(Hidden);

setappdata(0,'app_WeightHO',WeightHO);

% Add in weighted contribution from each hidden unit
SumO = WeightHO * Hidden;

set(handles.uitable1, 'Data',SumO);

[~,Output] = max(SumO,[],1);
handles.tarLabels_vec = getappdata(0,'app_tarLabels_vec');
if min(handles.tarLabels_vec) == 0
    Output = (Output - 1);
end

set(handles.uitable2, 'Data',Output);

handles.numPatterns = numel(handles.tarLabels_vec);
disp(handles.tarLabels_vec);
trainAccuracy = sum(Output' == handles.tarLabels_vec,1)/handles.numPatterns;
set(handles.text5,'String', sprintf('Train accuracy: %f %s',trainAccuracy*100,'%'));
setappdata(0, 'app_trainAccuracy', trainAccuracy);


% Choose default command line output for trainNN5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trainNN5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trainNN5_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

close
