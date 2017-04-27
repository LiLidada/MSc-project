function varargout = window_load_train_data(varargin)

% Edit the above text to modify the response to help window_load_train_data

% Last Modified by GUIDE v2.5 22-Aug-2016 20:31:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @window_load_train_data_OpeningFcn, ...
                   'gui_OutputFcn',  @window_load_train_data_OutputFcn, ...
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


% --- Executes just before window_load_train_data is made visible.
function window_load_train_data_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for window_load_train_data
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes window_load_train_data wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = window_load_train_data_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

% Get data path
[fileName,pathName] = uigetfile({'*.txt;*.mat';'MAT-files (*.mat)';...
    'Text-files (*.mat)'},'Pick a file');
fullPathName = strcat(pathName, fileName);
disp('******************** load train data ***********************************')

if isempty(fullPathName) % disable warning message when cancel loading data file
    warning('off','all'); 
    errordlg('Please load new data (.txt or .mat)!','File Error');
    disp('******************** no data ****************************************')
else % when data is ready
    try 
        data = load(fullPathName);
        disp('*** train data loaded successfully')
        
        if isstruct(data) % if our function text2mat.m is used
            data = data.M;
        end
           
        features = data(:,2:end)';
        targetLabels_vec = data(:,1);
        tarLabels = LabelVec2Mat(targetLabels_vec);       
        [numFeatures, numPatterns] = size(features);
        [patterns,labels] = hist(targetLabels_vec,unique(targetLabels_vec));
        label_table = sortrows(horzcat(labels,patterns'));    

        set(handles.uitable1,'Data',data);
        set(handles.uitable2,'Data',features);
        set(handles.uitable3,'Data',targetLabels_vec);
        set(handles.uitable4,'Data',label_table);

        set(handles.text5,'String',sprintf('Number of features: %d',numFeatures))
        set(handles.text6,'String',sprintf('Number of patterns: %d',numPatterns))

        setappdata(0,'app_label_table', label_table);
        setappdata(0,'app_tarLabels_vec',targetLabels_vec);
        setappdata(0,'app_tarLabels',tarLabels);
        setappdata(0,'app_oriFeatures',features);
       
    catch
        disp('*** invalid labels or features')
        data_dataset = dataset('File',fullPathName,'ReadVarNames',false);
        setappdata(0,'app_data_dataset',data_dataset);

        try
            label = double(data_dataset(:,1)); % check if labels are numerical numbers
            disp('*** numerical labels')
            Labels = sort(unique(label)); % sorted unique labels
            if all(diff(Labels) == 1)  % labels are consecutive numbers, then check features
                disp('*** labels are consecutive numbers')
                try
                    double(data_dataset(:, 2:end)); % features are numerical numbers if this works
                    % After check labels are consecutive numbers, and features
                    % are numerical numbers, data can be loaded successully
                catch % if features have strings or missing values
                    disp('*** features have strings or missing values')
                    ix = ismissing(data_dataset,'StringTreatAsMissing',{'NaN','','.','NA'});
                    if ~isempty(find(ix == 1, 1)) % features have missing values, delete patterns
                        window_check_data2_feature_missing
                        disp('*** features have missing values, delete patterns')
                    else % features have no missing values, but have strings, delete features
                        window_check_data3_feature_string
                        disp('*** features have no missing values, but have strings, delete features')
                    end

                end
      
            else % labels are not consecutive numbers
                disp('*** labels are not consecutive numbers')
                window_check_data1_label
            end


        catch % labels have strings or missing values
             disp('*** labels have strings or missing values')
             window_check_data1_label
        end
        
    end

end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

if isempty(get(handles.text5,'String'))
    errordlg('Please load new data (.txt or .mat)!','File Error');
    disp('******************** no data ****************************************')
else
    close
end
