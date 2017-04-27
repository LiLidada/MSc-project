function varargout = window_check_data3_feature_string(varargin)

% Last Modified by GUIDE v2.5 15-Aug-2016 22:09:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @window_check_data3_feature_string_OpeningFcn, ...
                   'gui_OutputFcn',  @window_check_data3_feature_string_OutputFcn, ...
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


% --- Executes just before window_check_data3_feature_string is made visible.
function window_check_data3_feature_string_OpeningFcn(hObject, eventdata, handles, varargin)

messyData = getappdata(0,'app_data_dataset');

% Messy data including strings in data 
[~, numCols] = size(messyData);
str_cols_ind = zeros(1,numCols);

for j = 1:numCols
    try 
        double(messyData(:,j)); % this feature only has numerical numbers if this works
    catch
        str_cols_ind(1,j) = 1;
    end
end

str_cols = cellstr(messyData(:,str_cols_ind == 1)); % only has strings thus can use cellstr

set(handles.uitable1, 'Data', str_cols);

% Delete string features
cleanData = messyData(:,str_cols_ind == 0);

export(cleanData,'file','new_data.txt','WriteVarNames',false);



% Choose default command line output for window_check_data3_feature_string
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes window_check_data3_feature_string wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = window_check_data3_feature_string_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

close
