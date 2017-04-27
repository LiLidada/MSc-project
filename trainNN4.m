function varargout = trainNN4(varargin)

% Last Modified by GUIDE v2.5 27-Jul-2016 08:51:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trainNN4_OpeningFcn, ...
                   'gui_OutputFcn',  @trainNN4_OutputFcn, ...
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


% --- Executes just before trainNN4 is made visible.
function trainNN4_OpeningFcn(hObject, eventdata, handles, varargin)

axes(handles.axes1)
imshow('NN4.png')

% Choose default command line output for trainNN4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trainNN4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trainNN4_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

close
