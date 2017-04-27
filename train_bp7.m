function varargout = train_bp7(varargin)

% Last Modified by GUIDE v2.5 24-Aug-2016 21:45:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @train_bp7_OpeningFcn, ...
                   'gui_OutputFcn',  @train_bp7_OutputFcn, ...
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


% --- Executes just before train_bp7 is made visible.
function train_bp7_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for train_bp7
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes train_bp7 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = train_bp7_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
close
train_bp6
