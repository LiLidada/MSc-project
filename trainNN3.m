function varargout = trainNN3(varargin)

% Last Modified by GUIDE v2.5 11-Sep-2016 14:51:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trainNN3_OpeningFcn, ...
                   'gui_OutputFcn',  @trainNN3_OutputFcn, ...
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


% --- Executes just before trainNN3 is made visible.
function trainNN3_OpeningFcn(hObject, eventdata, handles, varargin)

axes(handles.axes1)
imshow('NN3.png')

Input = getappdata(0,'app_newFeatures');
WeightIH = getappdata(0,'app_WeightIH');
[~, numPatterns] = size(Input);
% Input bias unit value is 1
Input = cat(1,ones(1,numPatterns),Input);

% Add in weighted contribution from each input unit
handles.SumH = WeightIH * Input;

% Choose default command line output for trainNN3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trainNN3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trainNN3_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

if get(handles.radiobutton1,'Value') == 1
    handles.Hidden = 1 ./ (1 + exp(-handles.SumH));
    disp('*** activation function: sigmoid');
    setappdata(0,'app_acSel_intro',1);
    setappdata(0,'app_Hidden',handles.Hidden);
    
    close
    
else
    close
    
end


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)

acSelection = get(hObject,'String');

switch acSelection
    case 'sigmoid'
        disp('*** activation function: sigmoid');
        acSel = 1;
        handles.Hidden = 1 ./ (1 + exp(-handles.SumH));
    case 'sine'
        disp('*** activation function: sine');
        acSel = 2;
        handles.Hidden = sin(handles.SumH); 
    case 'hardlim'
        disp('*** activation function: hardlim');
        acSel = 3;
        handles.Hidden = double(hardlim(handles.SumH));
    case 'tribas'
        disp('*** activation function: tribas');
        acSel = 4;
        handles.Hidden = tribas(handles.SumH);
    case 'radbas'
        disp('*** activation function: radbas');
        acSel = 5;
        handles.Hidden = radbas(handles.SumH);
end
setappdata(0,'app_acSel_intro',acSel);
setappdata(0,'app_Hidden',handles.Hidden);
