function varargout = main_elm_adv(varargin)

% Last Modified by GUIDE v2.5 11-Sep-2016 15:35:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_elm_adv_OpeningFcn, ...
                   'gui_OutputFcn',  @main_elm_adv_OutputFcn, ...
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


% --- Executes just before main_elm_adv is made visible.
function main_elm_adv_OpeningFcn(hObject, eventdata, handles, varargin)
                      

% Choose default command line output for main_elm_adv
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_elm_adv wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_elm_adv_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'app_loadTrain',0);
setappdata(0,'app_preprocessing',0);
setappdata(0,'app_loadTest',0);

window_load_train_data
setappdata(0,'app_loadTrain',1)
disp('******************** load train data ************************************')


function edit2_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

if getappdata(0,'app_loadTrain') == 0
    errordlg('Please load train data (.txt or .mat)!','File Error');
elseif getappdata(0,'app_preprocessing') == 0
    errordlg('Please choose a preprocessing method!','Error');
elseif getappdata(0,'app_loadTest') == 0
    errordlg('Please load test data (.txt or .mat)!','File Error');
else
    run = 0;
  
    if isempty(get(handles.edit1, 'String'))
        errordlg('Please enter a list of hidden unit numbers!','Error');
    elseif isempty(get(handles.edit2, 'String'))
        errordlg('Please enter how many times the network will be trained!','Error');
    else
        run = 1;
    end
 
    
    if run == 1
        numHiddenList = str2num(get(handles.edit1, 'String'));
        numTrain = str2num(get(handles.edit2, 'String'));
        newFeatures = getappdata(0,'app_newFeatures');
        newFeatures_test = getappdata(0,'app_newFeatures_test');

        [~,numnewPatterns] = size(newFeatures);
        [~,numnewPatterns_test] = size(newFeatures_test);

        trainAccuracyList = zeros(length(numHiddenList),numTrain);
        testAccuracyList = zeros(length(numHiddenList),numTrain);
        tarLabels = getappdata(0,'app_tarLabels');
        tarLabels_vec = getappdata(0,'app_tarLabels_vec');
        tarLabels_vec_test = getappdata(0,'app_tarLabels_vec_test');

        rangSel = getappdata(0,'app_rangSel');
        acSel = getappdata(0,'app_acSel_adv');

        for j = 1:numTrain
            for i = 1:length(numHiddenList)
                %%%
                disp(rangSel)
                [Output_train,~,WeightIH,WeightHO] = ELM(newFeatures,tarLabels,numHiddenList(i),tarLabels_vec,rangSel, acSel);
               
                [Output_test,~] = ELM_test(newFeatures_test,WeightIH,WeightHO,tarLabels_vec_test,acSel);

                trainAccuracyList(i,j) = sum(Output_train == tarLabels_vec,1)/numnewPatterns;

                testAccuracyList(i,j) = sum(Output_test == tarLabels_vec_test,1)/numnewPatterns_test;
            end
        end

        avgTrainAccuracyList = sum(trainAccuracyList,2)/numTrain;
        avgTestAccuracyList = sum(testAccuracyList,2)/numTrain;

        stdTrain = std(trainAccuracyList,1,2);
        stdTest = std(testAccuracyList,1,2);

        [maxTrain, indTrain] = max(avgTrainAccuracyList);
        [maxTest, indTest] = max(avgTestAccuracyList);

        % Plot
        figure
        errorbar(numHiddenList,nonzeros(avgTrainAccuracyList),stdTrain,...
            '--bs', 'LineWidth',2,'MarkerSize',5,'MarkerEdgeColor','b');hold on
        errorbar(numHiddenList,nonzeros(avgTestAccuracyList),stdTest,...
            '--rs', 'LineWidth',2,'MarkerSize',5,'MarkerEdgeColor','r');    
        set(gca,'FontSize',25);
        str1=sprintf('Best train accuracy = %.2f%s when numHidden = %d',maxTrain*100,'%',numHiddenList(indTrain));
        str2 = sprintf('Best test accuracy = %.2f%s when numHidden = %d',maxTest*100,'%',numHiddenList(indTest));
        title({str1,str2});
        xlabel('Number of hidden units');
        ylabel('Accuracy');
        legend('TrainAccuracy','TestAccuracy');
    end
    
end




% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rangeSelection = get(hObject,'String');

% Fill 'WeightIH' with Uniformly distributed random numbers
switch rangeSelection
    case '[-1, 1]'
        rangSel = 1;
    case '[-0.1, 0.1]'
        rangSel = 2;
    case '[-0.01, 0.01]'
        rangSel = 3;
    case '[-10, 10]'
        rangSel = 4;
    case '[-100, 100]'
        rangSel = 5;
end
setappdata(0,'app_rangSel',rangSel);


function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)

acSelection = get(hObject,'String');

switch acSelection
    case 'sigmoid'
        acSel = 1;
    case 'sine'
        acSel = 2; 
    case 'hardlim'
        acSel = 3;
    case 'tribas'
        acSel = 4;
    case 'radbas'
        acSel = 5;
end
setappdata(0,'app_acSel_adv',acSel);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
if getappdata(0,'app_loadTrain') == 0
    errordlg('Please load train data (.txt or .mat)!','File Error');
else
    window_preprocessing
end
setappdata(0,'app_preprocessing',1);
disp('******************** data preprocessing ************************************')

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
if getappdata(0,'app_loadTrain') == 0
    errordlg('Please load data (.txt or .mat)!','File Error');
elseif getappdata(0,'app_preprocessing') == 0
    errordlg('Please choose a preprocessing method!','Error');
else
    window_load_test_data
end
setappdata(0,'app_loadTest',1);
disp('******************** load test data ************************************')


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close