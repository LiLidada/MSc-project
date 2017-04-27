function varargout = window_preprocessing(varargin)

% Last Modified by GUIDE v2.5 23-Aug-2016 19:09:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @window_preprocessing_OpeningFcn, ...
                   'gui_OutputFcn',  @window_preprocessing_OutputFcn, ...
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


% --- Executes just before window_preprocessing is made visible.
function window_preprocessing_OpeningFcn(hObject, eventdata, handles, varargin)

handles.oriFeatures = getappdata(0,'app_oriFeatures');
[handles.numFeatures, handles.numPatterns] = size(handles.oriFeatures);
set(handles.uitable1, 'Data',handles.oriFeatures);
set(handles.text4,'String', sprintf('features: %d',handles.numFeatures));
set(handles.text5,'String', sprintf('patterns: %d',handles.numPatterns));


% Choose default command line output for window_preprocessing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes window_preprocessing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = window_preprocessing_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

setappdata(0,'app_newFeatures',get(handles.uitable2, 'Data'));
setappdata(0,'app_preprocessingResult',get(handles.text8,'String'));
close


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
select_None = get(hObject, 'Value');
if  select_None == 1
    disp('*** no change ***************************************')
    set(handles.checkbox2, 'Enable', 'Off');
    set(handles.checkbox3, 'Enable', 'Off');
    set(handles.checkbox4, 'Enable', 'Off');
end

set(handles.uitable2, 'Data',handles.oriFeatures);
set(handles.text6,'String', sprintf('features: %d',handles.numFeatures));
set(handles.text7,'String', sprintf('patterns: %d',handles.numPatterns));
set(handles.text8,'String', 'No changes!');
    

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
select_MN = get(hObject, 'Value');

if select_MN == 1
    disp('*** mean normalisation ***************************************')
    set(handles.checkbox1, 'Enable', 'Off');

    newFeatures = meanNormalisation(handles.oriFeatures);
    set(handles.uitable2, 'Data',newFeatures);
    [numnewFeatures, numnewPatterns] = size(newFeatures);
    set(handles.text6,'String', sprintf('features: %d',numnewFeatures));
    set(handles.text7,'String', sprintf('patterns: %d',numnewPatterns));
    set(handles.text8,'String', 'Range of values changed!');
    
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)

select_RP = get(hObject, 'Value');
select_MN = get(handles.checkbox2, 'Value');

if select_RP == 1
    set(handles.checkbox1, 'Enable', 'Off');
    set(handles.checkbox2, 'Enable', 'Off');
    set(handles.checkbox4, 'Enable', 'Off');
    if select_MN == 0 % select RP without MN
        disp('*** random projection ***************************************')
        features = handles.oriFeatures;
    else % apply MN first, then apply RP
        disp('*** mean normalisation & random projection *****************')
        features = meanNormalisation(handles.oriFeatures);
        set(handles.checkbox2, 'Enable', 'On');
    end
end

x = inputdlg('Enter numer of features left after random projection:',...
                 'Number of Features Left (RP)', [1 50]);
        
while 1
    if isempty(x) % press 'cancel'
        msgbox('Please enter how many features left do you prefer!');
        uiwait
        x = inputdlg('Enter numer of features left after random projection:',...
         'Number of Features Left (RP)', [1 50]);

    elseif isempty(x{:}) % press 'ok'
        msgbox('Please enter how many features left do you prefer!');
        uiwait
        x = inputdlg('Enter numer of features left after random projection:',...
         'Number of Features Left (RP)', [1 50]);

    else
        ranCol = str2double(x{:});
        R = randn(handles.numFeatures,ranCol)/sqrt(handles.numFeatures);
        R = R';
        ranFeatures = R * features; % New feature data set with fewer(Rcol) columns/features
        set(handles.uitable2, 'Data',ranFeatures);
        [numranFeatures, numranPatterns] = size(ranFeatures);
        set(handles.text6,'String', sprintf('features: %d',numranFeatures));
        set(handles.text7,'String', sprintf('patterns: %d',numranPatterns));
        if select_MN == 0
            set(handles.text8,'String', 'Features(Dimensionality) reduced (random projection)!');
        else
            set(handles.text8,'String', {'Range of values changed!','Features(Dimensionality) reduced (random projection)!'});
        end
        setappdata(0, 'app_ranCol', ranCol);
        break
    end
end

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)

select_PCA = get(hObject, 'Value');
select_MN = get(handles.checkbox2, 'Value');

if select_PCA == 1
    set(handles.checkbox1, 'Enable', 'Off');
    set(handles.checkbox2, 'Enable', 'Off');
    set(handles.checkbox3, 'Enable', 'Off');
    if select_MN == 0
        disp('*** pca ***************************************')
        features = handles.oriFeatures';
    else % apply mean normalisation first
        disp('*** mean normalisation & pca *****************')
        features = (meanNormalisation(handles.oriFeatures))';
        set(handles.checkbox2, 'Enable', 'On');
    end
end

[pc,~,latent] = pca(features);

% Select the minimum number of new features to cover 95% of the
% energy/variance of the original data.
energyList = cumsum(latent)./sum(latent);
leadingEigenVectors = find(energyList > 0.95);
leadingEigenVectors = leadingEigenVectors(1);

figure
plot(energyList,'LineWidth',3); hold on;
plot([0 numel(energyList)], [0.95 0.95] , '--g','LineWidth',3);
set(gca,'FontSize',25);
title('Energy (variance) of the original data covered');
xlabel('Number of features left');
ylabel('Energy');

x = inputdlg('Enter numer of features left after applying PCA:',...
                 'Number of Features Left (PCA)', [1 50]);

             
while 1
    if isempty(x) % press 'cancel'
        msgbox('Please enter how many features left do you prefer!');
        uiwait
        x = inputdlg('Enter numer of feature left after applying PCA:',...
         'Number of Features Left (PCA)', [1 50]);

    elseif isempty(x{:}) % press 'ok'
        msgbox('Please enter how many features left do you prefer!');
        uiwait
        x = inputdlg('Enter numer of feature left after applying PCA:',...
         'Number of Features Left (PCA)', [1 50]);

    elseif str2double(x{:}) < leadingEigenVectors
        warndlg('Less than 95% energy (variance) of the original data are covered','Warning')
        uiwait
        x = inputdlg('Enter numer of feature left after applying PCA:',...
         'Number of Features Left (PCA)', [1 50]);
    else    
        
        Proj_Dim = str2double(x{:});
        % Project to principal axes
        Mean_features = mean(features);
        Proj_features = (features - ones(size(features,1),1) * Mean_features) * pc(:, 1:Proj_Dim);
        Proj_features = Proj_features';

        set(handles.uitable2, 'Data',Proj_features);
        [numprojFeatures, numprojPatterns] = size(Proj_features);
        set(handles.text6,'String', sprintf('features: %d',numprojFeatures));
        set(handles.text7,'String', sprintf('patterns: %d',numprojPatterns));
        if select_MN == 0
            set(handles.text8,'String', 'Features(Dimensionality) reduced!');
        else
            set(handles.text8,'String', {'Range of values changed!','Features(Dimensionality) reduced (PCA)!'});
        end
        setappdata(0, 'app_projCol', Proj_Dim);
        
        break
    end
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
set(handles.checkbox1, 'Enable', 'On');
set(handles.checkbox1, 'Value', 0);
set(handles.checkbox2, 'Enable', 'On');
set(handles.checkbox2, 'Value', 0);
set(handles.checkbox3, 'Enable', 'On');
set(handles.checkbox3, 'Value', 0);
set(handles.checkbox4, 'Enable', 'On');
set(handles.checkbox4, 'Value', 0);

set(handles.uitable2, 'Data','');
set(handles.text6,'String', '');
set(handles.text7,'String', '');
set(handles.text8,'String', '');
drawnow;
