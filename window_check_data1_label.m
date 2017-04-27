function varargout = window_check_data1_label(varargin)

% Last Modified by GUIDE v2.5 14-Aug-2016 22:43:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @window_check_data1_label_OpeningFcn, ...
                   'gui_OutputFcn',  @window_check_data1_label_OutputFcn, ...
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


% --- Executes just before window_check_data1_label is made visible.
function window_check_data1_label_OpeningFcn(hObject, eventdata, handles, varargin)


data = getappdata(0,'app_data_dataset');
   
strl_abels = unique(data.Var1)';
set(handles.uitable2, 'Data', strl_abels);
[~,num] = size(strl_abels);
new_label = 1:num;
rnames = {'new_labels'};
% Create the uitable
newLabels = uitable('Data',new_label,... 
        'RowName',rnames);
% Set width and height
newLabels.Position(2) = 160;
newLabels.Position(3) = newLabels.Extent(3);
newLabels.Position(4) = newLabels.Extent(4);

new_data = data;
L = new_data.Var1;
[num_labels,~] = size(L);
if isnumeric(L) % labels are numerical numbers
    for i = 1:num
        for j = 1:num_labels
            if isequal(L(j), strl_abels(i))
                L(j) = new_label(i);
            end
        end
    end
else  % labels have strings or missing values
    for i = 1:num
        for j = 1:num_labels
            if isequal(L{j}, strl_abels{i})
                L{j} = new_label(i);
            end
        end
    end
    L = cell2mat(L);
end

new_data.Var1 = L;
export(new_data,'file','new_data.txt','WriteVarNames',false);
               
% Choose default command line output for window_check_data1_label
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes window_check_data1_label wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = window_check_data1_label_OutputFcn(hObject, eventdata, handles) 


% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

close
