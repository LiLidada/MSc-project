function varargout = window_check_data2_feature_missing(varargin)

% Last Modified by GUIDE v2.5 19-Aug-2016 01:44:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @window_check_data2_feature_missing_OpeningFcn, ...
                   'gui_OutputFcn',  @window_check_data2_feature_missing_OutputFcn, ...
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


% --- Executes just before window_check_data2_feature_missing is made visible.
function window_check_data2_feature_missing_OpeningFcn(hObject, eventdata, handles, varargin)

messyData = getappdata(0,'app_data_dataset');

% Delete last variable that has all "NaN" values, this happens when
% there're space after last data in each row in '.txt' file
try 
    all(isnan(messyData.(messyData.Properties.VarNames{end})) == 1);
    messyData.(messyData.Properties.VarNames{end}) = [];
    
    % Find observations with missing values.
    ix = ismissing(messyData,'StringTreatAsMissing',{'NaN','.','NA'});           

    % all patterns that have messy data
    messy_cell = messyData(any(ix,2),any(ix,1)); 
    
    set(handles.uitable1, 'Data', cellstr(messy_cell));

    % Create a dataset array with complete observations.
    completeData = messyData(~any(ix,2),:);
    export(completeData,'file','new_data.txt','WriteVarNames',false);
    
catch

    % Find observations with missing values.
    ix = ismissing(messyData,'StringTreatAsMissing',{'NaN','.','NA'});           

    % all patterns that have messy data
    messy_cell = messyData(any(ix,2),any(ix,1)); % has double and strings, cannot use 'cellstr'

    set(handles.uitable1, 'Data', cellstr(messy_cell));

    % Create a dataset array with complete observations.
    completeData = messyData(~any(ix,2),:);
    export(completeData,'file','new_data.txt','WriteVarNames',false);
end


% Choose default command line output for window_check_data2_feature_missing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes window_check_data2_feature_missing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = window_check_data2_feature_missing_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

close
