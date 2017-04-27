function varargout = main_bp_adv(varargin)

% Edit the above text to modify the response to help main_bp_adv

% Last Modified by GUIDE v2.5 11-Sep-2016 15:36:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_bp_adv_OpeningFcn, ...
                   'gui_OutputFcn',  @main_bp_adv_OutputFcn, ...
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


% --- Executes just before main_bp_adv is made visible.
function main_bp_adv_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for main_bp_adv
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_bp_adv wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_bp_adv_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
setappdata(0,'app_loadTrain',0);
setappdata(0,'app_preprocessing',0);
setappdata(0,'app_loadTest',0);

window_load_train_data
setappdata(0,'app_loadTrain',1)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
if getappdata(0,'app_loadTrain') == 0
    errordlg('Please load train data (.txt or .mat)!','File Error');
else
    window_preprocessing
end
setappdata(0,'app_preprocessing',1);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
if getappdata(0,'app_loadTrain') == 0
    errordlg('Please load train data (.txt or .mat)!','File Error');
elseif getappdata(0,'app_preprocessing') == 0
    errordlg('Please choose a preprocessing method!','Error');
else
    window_load_test_data
end
setappdata(0,'app_loadTest',1);



function edit1_Callback(hObject, eventdata, handles)


% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)


% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)


% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)


% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)


% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)


% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

set(handles.text8, 'String', '');

if getappdata(0,'app_loadTrain') == 0
    errordlg('Please load train data (.txt or .mat)!','File Error');
elseif getappdata(0,'app_preprocessing') == 0
    errordlg('Please choose a preprocessing method!','Error');
elseif getappdata(0,'app_loadTest') == 0
    errordlg('Please load test data (.txt or .mat)!','File Error');
else
    run = 0;
    
    if isempty(get(handles.edit1, 'String'))
        errordlg('Please enter number of total epoch!','Error');
    elseif isempty(get(handles.edit2, 'String'))
        errordlg('Please enter number of hidden units!','Error');
        elseif isempty(get(handles.edit3, 'String'))
        errordlg('Please enter smallwt!','Error');
        elseif isempty(get(handles.edit4, 'String'))
        errordlg('Please enter eta!','Error');
        elseif isempty(get(handles.edit5, 'String'))
        errordlg('Please enter alpha!','Error');
        elseif isempty(get(handles.edit6, 'String'))
        errordlg('Please enter k!','Error');
    else
        run = 1;
    end
    
    if run == 1
    
        k_fold = str2num(get(handles.edit6, 'String'));
        totalEpoch = str2num(get(handles.edit1, 'String'));
        numHidden = str2num(get(handles.edit2, 'String'));
        smallwt = str2num(get(handles.edit3, 'String'));
        eta = str2num(get(handles.edit4, 'String'));
        alpha = str2num(get(handles.edit5, 'String'));

        features = getappdata(0,'app_newFeatures');
        features_test = getappdata(0,'app_newFeatures_test');

        tarLabels = getappdata(0, 'app_tarLabels');
        tarLabels_test = getappdata(0, 'app_tarLabels_test');

        tarLabels_vec = getappdata(0,'app_tarLabels_vec');
        tarLabels_vec_test = getappdata(0,'app_tarLabels_vec_test');

        indices_cross_validation = crossvalind('kfold',tarLabels_vec,k_fold);
        trainResults = struct('bestWeightIH','','bestWeightHO','','minValidErr','','index','');

        minValidErrList = zeros(1,k_fold);


        for cs = 1:k_fold % k fold cross validation

            validation = (indices_cross_validation == cs);
            training = ~validation;
            Input_train = features(:,training);
            Input_valid = features(:,validation);
            Target_train = tarLabels(:,training);
            Target_valid = tarLabels(:,validation);
            vecLabel = tarLabels_vec';
            Target_train_vec = vecLabel(:,training);
            Target_valid_vec = vecLabel(:,validation);

            [bestWeightIH,bestWeightHO,minValidErr,index] = back_propagation(Input_train...
                ,Input_valid,Target_train,Target_valid,Target_train_vec,Target_valid_vec,...
                totalEpoch,numHidden,smallwt,eta,alpha);

            trainResults(cs).bestWeightIH = bestWeightIH;
            trainResults(cs).bestWeightHO = bestWeightHO;
            trainResults(cs).minValidErr = minValidErr;
            trainResults(cs).index = index;

            minValidErrList(1,cs) = minValidErr;

        end

        save optdigits.trainResults.mat trainResults numHidden smallwt eta alpha

        [numOutput, patterns] = size(tarLabels_test);

        SumH = zeros(numHidden,patterns);
        Hidden = zeros(numHidden,patterns);
        SumO = zeros(numOutput,patterns);
        Output = zeros(numOutput,patterns);
        predictedLabel = zeros(patterns,1);
        predictedLabel_k = struct('predictedLabel','');

        for i = 1:k_fold
            WeightIH = trainResults(i).bestWeightIH;
            WeightHO = trainResults(i).bestWeightHO;
            
            % Calculate test error (the rate of misclassified labels)
            for p = 1:patterns

                % j loop computes hidden unit activations
                for j = 1:numHidden 
                    % Add in weighted contribution from each input unit 
                    SumH(j,p) = WeightIH(1,j) + nansum(features_test(:,p) .* WeightIH(2:end,j));      
                    Hidden(j,p) = 1/(1 + exp(-SumH(j,p))); % compute sigmoid to give activation        
                end

                % k loop computes output unit activations
                for k = 1:numOutput 
                    SumO(k,p) = WeightHO(1,k) + nansum(Hidden(:,p) .* WeightHO(2:end,k));
                    Output(k,p) = 1/(1 + exp(-SumO(k,p)));
                    [~,predictedLabel(p,1)] = max(Output(:,p));
                end 

            end
            
            predictedLabel_k(i).predictedLabel = predictedLabel;
        end
        
        correctRate_list = zeros(1,k);
        
        for ii = 1:k

        % Original labels have 0 value, thus when convert label from vector to
        % matrix, if the label of an example is L, then the (L+1)th column is
        % 1. Therefore, here we need to minus 1 to each predicted label
        predictedLabel = predictedLabel_k(ii).predictedLabel - 1; 
        correctRate_list(1,ii) = sum(predictedLabel==tarLabels_vec_test)/patterns;
    
        end

        % find the test set performance for each fold and compute the mean and standard deviation.
        mean_correctRate = mean(correctRate_list);
        std_correctRate = std(correctRate_list);
        disp(correctRate_list)
    
        set(handles.text8, 'String', sprintf('Mean of test correct rate: %f %s',mean_correctRate*100,'%'));
        set(handles.text9, 'String', sprintf('Standard deviation test correct rate: %f',std_correctRate));
    end
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
